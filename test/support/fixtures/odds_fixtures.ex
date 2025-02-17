defmodule Betting.OddsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Betting.Odds` context.
  """

  @doc """
  Generate a odd.
  """
  def odd_fixture(attrs \\ %{}) do
    {:ok, odd} =
      attrs
      |> Enum.into(%{
        outcome: "some outcome",
        value: 120.5
      })
      |> Betting.Odds.create_odd()

    odd
  end
end
