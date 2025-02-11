defmodule Betting.MatchesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Betting.Matches` context.
  """

  @doc """
  Generate a match.
  """
  def match_fixture(attrs \\ %{}) do
    {:ok, match} =
      attrs
      |> Enum.into(%{
        team_a_score: 42,
        team_b_score: 42
      })
      |> Betting.Matches.create_match()

    match
  end
end
