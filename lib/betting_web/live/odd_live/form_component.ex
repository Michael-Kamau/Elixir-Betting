defmodule BettingWeb.OddLive.FormComponent do
  use BettingWeb, :live_component

  alias Betting.Odds

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage odd records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="odd-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:outcome]} type="text" label="Outcome" />
        <.input field={@form[:value]} type="number" label="Value" step="any" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Odd</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{odd: odd} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Odds.change_odd(odd))
     end)}
  end

  @impl true
  def handle_event("validate", %{"odd" => odd_params}, socket) do
    changeset = Odds.change_odd(socket.assigns.odd, odd_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"odd" => odd_params}, socket) do
    save_odd(socket, socket.assigns.action, odd_params)
  end

  defp save_odd(socket, :edit, odd_params) do
    case Odds.update_odd(socket.assigns.odd, odd_params) do
      {:ok, odd} ->
        notify_parent({:saved, odd})

        {:noreply,
         socket
         |> put_flash(:info, "Odd updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_odd(socket, :new, odd_params) do
    case Odds.create_odd(odd_params) do
      {:ok, odd} ->
        notify_parent({:saved, odd})

        {:noreply,
         socket
         |> put_flash(:info, "Odd created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
