defmodule Betting.TeamsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Betting.Teams` context.
  """

  @doc """
  Generate a team.
  """
  def team_fixture(attrs \\ %{}) do
    {:ok, team} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Betting.Teams.create_team()

    team
  end
end
