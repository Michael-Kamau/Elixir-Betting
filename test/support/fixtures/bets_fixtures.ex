defmodule Betting.BetsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Betting.Bets` context.
  """

  @doc """
  Generate a bet.
  """
  def bet_fixture(attrs \\ %{}) do
    {:ok, bet} =
      attrs
      |> Enum.into(%{
        bet_amount: "120.5",
        cancelled: true,
        settled_amount: "120.5"
      })
      |> Betting.Bets.create_bet()

    bet
  end
end
