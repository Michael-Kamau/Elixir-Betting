defmodule BettingWeb.MatchLive.FormComponent do
  use BettingWeb, :live_component

  alias Betting.Matches
  alias Betting.Matches.MatchNotifier
  alias Betting.Bets

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage match records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="match-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input
          field={@form[:category_id]}
          type="select"
          label="Sport category"
          options={@categories}
        />

        <div class="grid grid-cols-2 gap-x-3">
          <.input field={@form[:team_a_id]} type="select" label="Team A" options={@teams} />
          <.input field={@form[:team_b_id]} type="select" label="Team B" options={@teams} />
        </div>

        <div class="flex justify-between">
          <.input field={@form[:team_a_odd]} type="number" step="0.01" label="Team A odd" />
          <.input field={@form[:draw_odd]} type="number" step="0.01" label="Draw odd" />
          <.input field={@form[:team_b_odd]} type="number" step="0.01" label="Team B odd" />
        </div>

        <div class="grid grid-cols-2 gap-x-3">
          <.input field={@form[:team_a_score]} type="number" label="Team a score" />
          <.input field={@form[:team_b_score]} type="number" label="Team b score" />
        </div>

        <.input
          field={@form[:outcome_id]}
          type="select"
          label="Outcome"
          options={[{"Select an outcome", nil} | @outcomes]}
        />
        <:actions>
          <.button phx-disable-with="Saving...">Save Match</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{match: match} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Matches.change_match(match))
     end)}
  end

  @impl true
  def handle_event("validate", %{"match" => match_params}, socket) do
    changeset = Matches.change_match(socket.assigns.match, match_params)
    dbg(changeset)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"match" => match_params}, socket) do
    save_match(socket, socket.assigns.action, match_params)
  end

  defp save_match(socket, :edit, match_params) do
    # Check if the match already has an outcome_id
    if false && socket.assigns.match.outcome_id do
      # Prevent further editing by returning an error message
      {:noreply,
       socket
       |> put_flash(:error, "You cannot edit a settled match")
       |> push_patch(to: socket.assigns.patch)}
    else
      # Proceed with the update if no outcome is set yet
      case Matches.update_match(socket.assigns.match, match_params) do
        {:ok, match} ->
          # If the outcome_id becomes present after the update, send emails
          if match.outcome_id, do: send_emails_for_outcome(match)

          notify_parent({:saved, match})

          {:noreply,
           socket
           |> put_flash(:info, "Match updated successfully")
           |> push_patch(to: socket.assigns.patch)}

        {:error, %Ecto.Changeset{} = changeset} ->
          {:noreply, assign(socket, form: to_form(changeset))}
      end
    end
  end

  defp save_match(socket, :new, match_params) do
    case Matches.create_match(match_params) do
      {:ok, match} ->
        notify_parent({:saved, match})

        {:noreply,
         socket
         |> put_flash(:info, "Match created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp send_emails_for_outcome(match) do
    bets = Bets.get_bets_by_match_id(match.id)

    Enum.each(bets, fn bet ->
      settled_amount = compute_settled_amount(bet, match)

      # Update the bet record in the database with the computed settled amount.
      case Bets.update_bet(bet, %{settled_amount: settled_amount}) do
        {:ok, updated_bet} ->
          # Now that the bet is updated, notify the user.
          MatchNotifier.bet_settled_notification(updated_bet, match)
        {:error, changeset} ->
          # Log the error so you know if any bet update fails.
          IO.puts(changeset)
      end
    end)
  end

  defp compute_settled_amount(bet, match) do
    cond do
      bet.outcome_id == match.outcome_id and bet.outcome_id == 1 ->
        Decimal.mult(bet.bet_amount, Decimal.from_float(match.team_a_odd))

      bet.outcome_id == match.outcome_id and bet.outcome_id == 2 ->
        Decimal.mult(bet.bet_amount, Decimal.from_float(match.team_b_odd))

      bet.outcome_id == match.outcome_id and bet.outcome_id == 3 ->
        Decimal.mult(bet.bet_amount, Decimal.from_float(match.draw_odd))

      true ->
        Decimal.mult(bet.bet_amount, Decimal.new(-1))
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
