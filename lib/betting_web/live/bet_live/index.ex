defmodule BettingWeb.BetLive.Index do
  use BettingWeb, :live_view

  alias Betting.Bets
  alias Betting.Bets.Bet
  alias Betting.Matches
  alias Betting.Outcomes
  alias Betting.Accounts

  @impl true
  def mount(_params, session, socket) do
    user = Accounts.get_user_by_session_token(session["user_token"])
    {:ok, stream(socket, :bets, Bets.get_bets_by_user_id(user.id))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id, "match_id" => match_id}) do
    match = Matches.get_match!(match_id)
    outcomes = Outcomes.list_outcomes() |>Enum.map(&({&1.name, &1.id}))

    socket
    |> assign(:page_title, "Edit Bet")
    |> assign(:match, match)
    |> assign(:bet, Bets.get_bet!(id))
    |> assign(:outcomes, outcomes)
  end

  defp apply_action(socket, :new,%{"match_id" => match_id}) do

    match = Matches.get_match!(match_id)

    outcomes = Outcomes.list_outcomes() |>Enum.map(&({&1.name, &1.id}))

    socket
    |> assign(:page_title, "New Bet")
    |> assign(:bet, %Bet{})
    |> assign(:match, match)
    |> assign(:outcomes, outcomes)
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Bets")
    |> assign(:bet, nil)
  end

  @impl true
  def handle_info({BettingWeb.BetLive.FormComponent, {:saved, bet}}, socket) do
    {:noreply, stream_insert(socket, :bets, bet)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    bet = Bets.get_bet!(id)
    {:ok, _} = Bets.delete_bet(bet)

    {:noreply, stream_delete(socket, :bets, bet)}
  end
end
