defmodule BettingWeb.MatchLive.Show do
  use BettingWeb, :live_view

  alias Betting.Matches

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:match, Matches.get_match!(id))}
  end

  defp page_title(:show), do: "Show Match"
  defp page_title(:edit), do: "Edit Match"
end
