defmodule BettingWeb.UserLive.Index do
  use BettingWeb, :live_view

  alias Betting.Accounts
  alias Betting.Accounts.User
  alias Betting.Roles

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :users, Accounts.list_users())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    roles = Roles.list_roles() |>Enum.map(&({&1.name, &1.id}))

    socket
    |> assign(:page_title, "Edit User")
    |> assign(:roles, roles)
    |> assign(:user, Accounts.get_user!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New User")
    |> assign(:user, %User{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Users")
    |> assign(:user, nil)
  end

  @impl true
  def handle_info({BettingWeb.UserLive.FormComponent, {:saved, user}}, socket) do
    {:noreply, stream_insert(socket, :users, user)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do

    user = Accounts.get_user!(id)

    # Fetch all bets belonging to the user
    user_bets = Betting.Bets.get_bets_by_user_id(user.id)

    # Soft delete each bet individually
    Enum.each(user_bets, fn bet ->
      Betting.Bets.delete_bet(bet)
    end)

    # Soft delete the user after all bets are deleted
    case Accounts.delete_user(user) do
      {:ok, _} -> {:noreply, stream_delete(socket, :users, user)}
      {:error, _} -> {:noreply, put_flash(socket, :error, "Failed to delete user and bets.")}
    end
    end
end
