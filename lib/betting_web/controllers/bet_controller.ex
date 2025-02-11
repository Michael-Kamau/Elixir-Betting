defmodule BettingWeb.BetController do
  use BettingWeb, :controller

  alias Betting.Bets
  alias Betting.Bets.Bet

  def index(conn, _params) do
    bets = Bets.list_bets()
    render(conn, :index, bets: bets)
  end

  def new(conn, _params) do
    changeset = Bets.change_bet(%Bet{})
    
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"bet" => bet_params}) do
    case Bets.create_bet(bet_params) do
      {:ok, bet} ->
        conn
        |> put_flash(:info, "Bet created successfully.")
        |> redirect(to: ~p"/bets/#{bet}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    bet = Bets.get_bet!(id)
    render(conn, :show, bet: bet)
  end

  def edit(conn, %{"id" => id}) do
    bet = Bets.get_bet!(id)
    changeset = Bets.change_bet(bet)
    render(conn, :edit, bet: bet, changeset: changeset)
  end

  def update(conn, %{"id" => id, "bet" => bet_params}) do
    bet = Bets.get_bet!(id)

    case Bets.update_bet(bet, bet_params) do
      {:ok, bet} ->
        conn
        |> put_flash(:info, "Bet updated successfully.")
        |> redirect(to: ~p"/bets/#{bet}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, bet: bet, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    bet = Bets.get_bet!(id)
    {:ok, _bet} = Bets.delete_bet(bet)

    conn
    |> put_flash(:info, "Bet deleted successfully.")
    |> redirect(to: ~p"/bets")
  end
end
