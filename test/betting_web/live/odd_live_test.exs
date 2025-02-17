defmodule BettingWeb.OddLiveTest do
  use BettingWeb.ConnCase

  import Phoenix.LiveViewTest
  import Betting.OddsFixtures

  @create_attrs %{value: 120.5, outcome: "some outcome"}
  @update_attrs %{value: 456.7, outcome: "some updated outcome"}
  @invalid_attrs %{value: nil, outcome: nil}

  defp create_odd(_) do
    odd = odd_fixture()
    %{odd: odd}
  end

  describe "Index" do
    setup [:create_odd]

    test "lists all odds", %{conn: conn, odd: odd} do
      {:ok, _index_live, html} = live(conn, ~p"/odds")

      assert html =~ "Listing Odds"
      assert html =~ odd.outcome
    end

    test "saves new odd", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/odds")

      assert index_live |> element("a", "New Odd") |> render_click() =~
               "New Odd"

      assert_patch(index_live, ~p"/odds/new")

      assert index_live
             |> form("#odd-form", odd: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#odd-form", odd: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/odds")

      html = render(index_live)
      assert html =~ "Odd created successfully"
      assert html =~ "some outcome"
    end

    test "updates odd in listing", %{conn: conn, odd: odd} do
      {:ok, index_live, _html} = live(conn, ~p"/odds")

      assert index_live |> element("#odds-#{odd.id} a", "Edit") |> render_click() =~
               "Edit Odd"

      assert_patch(index_live, ~p"/odds/#{odd}/edit")

      assert index_live
             |> form("#odd-form", odd: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#odd-form", odd: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/odds")

      html = render(index_live)
      assert html =~ "Odd updated successfully"
      assert html =~ "some updated outcome"
    end

    test "deletes odd in listing", %{conn: conn, odd: odd} do
      {:ok, index_live, _html} = live(conn, ~p"/odds")

      assert index_live |> element("#odds-#{odd.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#odds-#{odd.id}")
    end
  end

  describe "Show" do
    setup [:create_odd]

    test "displays odd", %{conn: conn, odd: odd} do
      {:ok, _show_live, html} = live(conn, ~p"/odds/#{odd}")

      assert html =~ "Show Odd"
      assert html =~ odd.outcome
    end

    test "updates odd within modal", %{conn: conn, odd: odd} do
      {:ok, show_live, _html} = live(conn, ~p"/odds/#{odd}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Odd"

      assert_patch(show_live, ~p"/odds/#{odd}/show/edit")

      assert show_live
             |> form("#odd-form", odd: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#odd-form", odd: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/odds/#{odd}")

      html = render(show_live)
      assert html =~ "Odd updated successfully"
      assert html =~ "some updated outcome"
    end
  end
end
