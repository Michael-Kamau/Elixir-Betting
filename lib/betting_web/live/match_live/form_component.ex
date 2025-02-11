defmodule BettingWeb.MatchLive.FormComponent do
  use BettingWeb, :live_component

  alias Betting.Matches

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

      <.input field={@form[:category_id]} type="select" label="Sport category" options={@categories}/>

      <div class="grid grid-cols-2 gap-x-3">
      <.input field={@form[:team_a_id]} type="select" label="Team A" options={@teams}/>
      <.input field={@form[:team_b_id]} type="select" label="Team B" options={@teams}/>
      </div>
      <div class="grid grid-cols-2 gap-x-3">
      <.input field={@form[:team_a_score]} type="number" label="Team a score" />
      <.input field={@form[:team_b_score]} type="number" label="Team b score" />
      </div>


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
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"match" => match_params}, socket) do
    save_match(socket, socket.assigns.action, match_params)
  end

  defp save_match(socket, :edit, match_params) do
    case Matches.update_match(socket.assigns.match, match_params) do
      {:ok, match} ->
        notify_parent({:saved, match})

        {:noreply,
         socket
         |> put_flash(:info, "Match updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
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

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
