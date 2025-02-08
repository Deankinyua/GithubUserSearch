defmodule DevfinderWeb.FinderLive.IndexTest do
  use DevfinderWeb.ConnCase
  import Phoenix.LiveViewTest

  # * test/3 -> test name, the testing context, the contents of the test

  test "check liveview content", %{conn: conn} do
    {:ok, _view, html} = live(conn, "/finder")

    assert html =~ "devfinder"
    assert html =~ "Search"
    assert html =~ "Repos"
    assert html =~ "Following"
    assert html =~ "Followers"
    assert html =~ "The Octocat"
    assert html =~ "github"
    assert html =~ "3938"
    assert html =~ "8"
    assert html =~ "9"
    assert html =~ "This profile has no bio"
    assert html =~ "Not Available"
    assert html =~ "octotat"
  end

  # test "has input element", %{conn: conn} do
  #   {:ok, view, _html} = live(conn, "/finder")

  #   element = element(view, ~s(input[placeholder*="Search GitHub userna"]))

  #   assert has_element?(element)
  # end
end
