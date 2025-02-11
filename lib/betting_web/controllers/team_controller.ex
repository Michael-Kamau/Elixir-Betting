defmodule BettingWeb.TeamController do
  use BettingWeb, :controller

  alias Betting.Teams
  alias Betting.Teams.Team

  def index(conn, _params) do
    teams = Teams.list_teams()
    render(conn, :index, teams: teams)
  end

  def new(conn, _params) do
    changeset = Teams.change_team(%Team{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"team" => team_params}) do
    case Teams.create_team(team_params) do
      {:ok, team} ->
        conn
        |> put_flash(:info, "Team created successfully.")
        |> redirect(to: ~p"/teams/#{team}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    team = Teams.get_team!(id)
    render(conn, :show, team: team)
  end

  def edit(conn, %{"id" => id}) do
    team = Teams.get_team!(id)
    changeset = Teams.change_team(team)
    render(conn, :edit, team: team, changeset: changeset)
  end

  def update(conn, %{"id" => id, "team" => team_params}) do
    team = Teams.get_team!(id)

    case Teams.update_team(team, team_params) do
      {:ok, team} ->
        conn
        |> put_flash(:info, "Team updated successfully.")
        |> redirect(to: ~p"/teams/#{team}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, team: team, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    team = Teams.get_team!(id)
    {:ok, _team} = Teams.delete_team(team)

    conn
    |> put_flash(:info, "Team deleted successfully.")
    |> redirect(to: ~p"/teams")
  end
end
