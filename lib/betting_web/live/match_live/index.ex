defmodule BettingWeb.MatchLive.Index do

  use BettingWeb, :live_view

  alias Betting.Teams
  alias Betting.Matches
  alias Betting.Matches.Match
  alias Betting.Categories

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:teams, Teams.list_teams() |>Enum.map(&({&1.name, &1.id})))
      |> assign(:categories, Categories.list_categories() |>Enum.map(&({&1.name, &1.id})))
      |> stream(:matches, Matches.list_matches())

    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Match")
    |> assign(:match, Matches.get_match!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Match")
    |> assign(:match, %Match{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Matches")
    |> assign(:match, nil)
  end

  @impl true
  def handle_info({BettingWeb.MatchLive.FormComponent, {:saved, match}}, socket) do
    {:noreply, stream_insert(socket, :matches, match)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    match = Matches.get_match!(id)
    {:ok, _} = Matches.delete_match(match)

    {:noreply, stream_delete(socket, :matches, match)}
  end
end
