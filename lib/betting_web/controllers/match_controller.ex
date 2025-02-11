defmodule BettingWeb.MatchController do
  use BettingWeb, :controller

  alias Betting.Matches
  alias Betting.Matches.Match

  alias Betting.Teams

  def index(conn, _params) do
    matches = Matches.list_matches()
    render(conn, :index, matches: matches)
  end

  def new(conn, _params) do
    changeset = Matches.change_match(%Match{})
    teams = Teams.list_teams() |> Enum.map(&{&1.name, &1.id})

    render(conn, :new, teams: teams, changeset: changeset)
  end

  def create(conn, %{"match" => match_params}) do

    case Matches.create_match(match_params) do
      {:ok, match} ->
        conn
        |> put_flash(:info, "Match created successfully.")
        |> redirect(to: ~p"/matches/#{match}")

      {:error, %Ecto.Changeset{} = changeset} ->
        teams = Teams.list_teams() |> Enum.map(&{&1.name, &1.id})
        render(conn, :new, changeset: changeset, teams: teams)
    end
  end

  def show(conn, %{"id" => id}) do
    match = Matches.get_match!(id)
    render(conn, :show, match: match)
  end

  def edit(conn, %{"id" => id}) do
    match = Matches.get_match!(id)
    changeset = Matches.change_match(match)
    teams = Teams.list_teams() |> Enum.map(&{&1.name, &1.id})

    render(conn, :edit, match: match, teams: teams, changeset: changeset)
  end

  def update(conn, %{"id" => id, "match" => match_params}) do
    match = Matches.get_match!(id)
    teams = Teams.list_teams() |> Enum.map(&{&1.name, &1.id})


    case Matches.update_match(match, match_params) do
      {:ok, match} ->
        conn
        |> put_flash(:info, "Match updated successfully.")
        |> redirect(to: ~p"/matches/#{match}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, match: match, teams: teams, changeset: changeset)
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
