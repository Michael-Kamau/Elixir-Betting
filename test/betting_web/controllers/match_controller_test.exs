defmodule BettingWeb.MatchControllerTest do
  use BettingWeb.ConnCase

  import Betting.MatchesFixtures

  @create_attrs %{team_a_score: 42, team_b_score: 42}
  @update_attrs %{team_a_score: 43, team_b_score: 43}
  @invalid_attrs %{team_a_score: nil, team_b_score: nil}

  describe "index" do
    test "lists all matches", %{conn: conn} do
      conn = get(conn, ~p"/matches")
      assert html_response(conn, 200) =~ "Listing Matches"
    end
  end

  describe "new match" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/matches/new")
      assert html_response(conn, 200) =~ "New Match"
    end
  end

  describe "create match" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/matches", match: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/matches/#{id}"

      conn = get(conn, ~p"/matches/#{id}")
      assert html_response(conn, 200) =~ "Match #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/matches", match: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Match"
    end
  end

  describe "edit match" do
    setup [:create_match]

    test "renders form for editing chosen match", %{conn: conn, match: match} do
      conn = get(conn, ~p"/matches/#{match}/edit")
      assert html_response(conn, 200) =~ "Edit Match"
    end
  end

  describe "update match" do
    setup [:create_match]

    test "redirects when data is valid", %{conn: conn, match: match} do
      conn = put(conn, ~p"/matches/#{match}", match: @update_attrs)
      assert redirected_to(conn) == ~p"/matches/#{match}"

      conn = get(conn, ~p"/matches/#{match}")
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, match: match} do
      conn = put(conn, ~p"/matches/#{match}", match: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Match"
    end
  end

  describe "delete match" do
    setup [:create_match]

    test "deletes chosen match", %{conn: conn, match: match} do
      conn = delete(conn, ~p"/matches/#{match}")
      assert redirected_to(conn) == ~p"/matches"

      assert_error_sent 404, fn ->
        get(conn, ~p"/matches/#{match}")
      end
    end
  end

  defp create_match(_) do
    match = match_fixture()
    %{match: match}
  end
end
