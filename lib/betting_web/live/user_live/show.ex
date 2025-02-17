defmodule BettingWeb.UserLive.Show do
  use BettingWeb, :live_view

  alias Betting.Accounts
  alias Betting.Roles
  alias Betting.Bets

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    dbg(Accounts.get_user!(id))
    roles = Roles.list_roles() |>Enum.map(&({&1.name, &1.id}))
    bets = Bets.get_bets_by_user_id(id)

    {:noreply,
     socket
     |> assign(:roles, roles)
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:user, Accounts.get_user!(id))
     |> stream(:bets, bets)
    }
  end

  defp page_title(:show), do: "Show User"
  defp page_title(:edit), do: "Edit User"
end
