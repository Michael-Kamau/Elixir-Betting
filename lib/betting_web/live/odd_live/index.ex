defmodule BettingWeb.OddLive.Index do
alias Betting.Matches
  use BettingWeb, :live_view

  alias Betting.Odds
  alias Betting.Odds.Odd

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :odds, Odds.list_odds())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Odd")
    |> assign(:odd, Odds.get_odd!(id))
  end

  defp apply_action(socket, :new, %{"id" => id}) do
    socket
    |> assign(:page_title, "New Odd")
    |> assign(:odd, %Odd{})
    |> assign(:match, Matches.get_match!(id))
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Odds")
    |> assign(:odd, nil)
  end

  @impl true
  def handle_info({BettingWeb.OddLive.FormComponent, {:saved, odd}}, socket) do
    {:noreply, stream_insert(socket, :odds, odd)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    odd = Odds.get_odd!(id)
    {:ok, _} = Odds.delete_odd(odd)

    {:noreply, stream_delete(socket, :odds, odd)}
  end
end
