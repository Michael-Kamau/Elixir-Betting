defmodule Betting.BetsTest do
  use Betting.DataCase

  alias Betting.Bets

  describe "bets" do
    alias Betting.Bets.Bet

    import Betting.BetsFixtures

    @invalid_attrs %{active: nil, bet_amount: nil, settled_amount: nil}

    test "list_bets/0 returns all bets" do
      bet = bet_fixture()
      assert Bets.list_bets() == [bet]
    end

    test "get_bet!/1 returns the bet with given id" do
      bet = bet_fixture()
      assert Bets.get_bet!(bet.id) == bet
    end

    test "create_bet/1 with valid data creates a bet" do
      valid_attrs = %{active: true, bet_amount: "120.5", settled_amount: "120.5"}

      assert {:ok, %Bet{} = bet} = Bets.create_bet(valid_attrs)
      assert bet.active == true
      assert bet.bet_amount == Decimal.new("120.5")
      assert bet.settled_amount == Decimal.new("120.5")
    end

    test "create_bet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Bets.create_bet(@invalid_attrs)
    end

    test "update_bet/2 with valid data updates the bet" do
      bet = bet_fixture()
      update_attrs = %{active: false, bet_amount: "456.7", settled_amount: "456.7"}

      assert {:ok, %Bet{} = bet} = Bets.update_bet(bet, update_attrs)
      assert bet.active == false
      assert bet.bet_amount == Decimal.new("456.7")
      assert bet.settled_amount == Decimal.new("456.7")
    end

    test "update_bet/2 with invalid data returns error changeset" do
      bet = bet_fixture()
      assert {:error, %Ecto.Changeset{}} = Bets.update_bet(bet, @invalid_attrs)
      assert bet == Bets.get_bet!(bet.id)
    end

    test "delete_bet/1 deletes the bet" do
      bet = bet_fixture()
      assert {:ok, %Bet{}} = Bets.delete_bet(bet)
      assert_raise Ecto.NoResultsError, fn -> Bets.get_bet!(bet.id) end
    end

    test "change_bet/1 returns a bet changeset" do
      bet = bet_fixture()
      assert %Ecto.Changeset{} = Bets.change_bet(bet)
    end
  end
end
