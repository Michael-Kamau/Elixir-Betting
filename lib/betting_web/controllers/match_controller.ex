defmodule BettingWeb.MatchController do
  use BettingWeb, :controller

  alias Betting.Matches
  alias Betting.Matches.Match

  def index(conn, _params) do
    matches = Matches.list_matches()
    render(conn, :index, matches: matches)
  end

  def new(conn, _params) do
    changeset = Matches.change_match(%Match{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"match" => match_params}) do
    case Matches.create_match(match_params) do
      {:ok, match} ->
        conn
        |> put_flash(:info, "Match created successfully.")
        |> redirect(to: ~p"/matches/#{match}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    match = Matches.get_match!(id)
    render(conn, :show, match: match)
  end

  def edit(conn, %{"id" => id}) do
    match = Matches.get_match!(id)
    changeset = Matches.change_match(match)
    render(conn, :edit, match: match, changeset: changeset)
  end

  def update(conn, %{"id" => id, "match" => match_params}) do
    match = Matches.get_match!(id)

    case Matches.update_match(match, match_params) do
      {:ok, match} ->
        conn
        |> put_flash(:info, "Match updated successfully.")
        |> redirect(to: ~p"/matches/#{match}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, match: match, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    match = Matches.get_match!(id)
    {:ok, _match} = Matches.delete_match(match)

    conn
    |> put_flash(:info, "Match deleted successfully.")
    |> redirect(to: ~p"/matches")
  end
end
