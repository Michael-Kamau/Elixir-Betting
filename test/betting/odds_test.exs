defmodule Betting.OddsTest do
  use Betting.DataCase

  alias Betting.Odds

  describe "odds" do
    alias Betting.Odds.Odd

    import Betting.OddsFixtures

    @invalid_attrs %{outcome: nil, odd_value: nil}

    test "list_odds/0 returns all odds" do
      odd = odd_fixture()
      assert Odds.list_odds() == [odd]
    end

    test "get_odd!/1 returns the odd with given id" do
      odd = odd_fixture()
      assert Odds.get_odd!(odd.id) == odd
    end

    test "create_odd/1 with valid data creates a odd" do
      valid_attrs = %{outcome: "some outcome", odd_value: 120.5}

      assert {:ok, %Odd{} = odd} = Odds.create_odd(valid_attrs)
      assert odd.outcome == "some outcome"
      assert odd.odd_value == 120.5
    end

    test "create_odd/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Odds.create_odd(@invalid_attrs)
    end

    test "update_odd/2 with valid data updates the odd" do
      odd = odd_fixture()
      update_attrs = %{outcome: "some updated outcome", odd_value: 456.7}

      assert {:ok, %Odd{} = odd} = Odds.update_odd(odd, update_attrs)
      assert odd.outcome == "some updated outcome"
      assert odd.odd_value == 456.7
    end

    test "update_odd/2 with invalid data returns error changeset" do
      odd = odd_fixture()
      assert {:error, %Ecto.Changeset{}} = Odds.update_odd(odd, @invalid_attrs)
      assert odd == Odds.get_odd!(odd.id)
    end

    test "delete_odd/1 deletes the odd" do
      odd = odd_fixture()
      assert {:ok, %Odd{}} = Odds.delete_odd(odd)
      assert_raise Ecto.NoResultsError, fn -> Odds.get_odd!(odd.id) end
    end

    test "change_odd/1 returns a odd changeset" do
      odd = odd_fixture()
      assert %Ecto.Changeset{} = Odds.change_odd(odd)
    end
  end
end
