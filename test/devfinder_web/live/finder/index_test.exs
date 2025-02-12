defmodule DevfinderWeb.FinderLive.IndexTest do
  use DevfinderWeb.ConnCase, async: true
  import Phoenix.LiveViewTest

  import Mox

  # Make sure mocks are verified when the test exits
  setup :verify_on_exit!

  # * test/3 -> test name, the testing context, the contents of the test

  describe "On Mount" do
    test "check liveview content on mount connection", %{conn: conn} do
      {:ok, view, html} = live(conn, "/finder")

      assert has_element?(view, ~s(input[placeholder*="Search GitHub username..."]))

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
      assert html =~ "@octocat"
      assert html =~ "https://github.blog"
      refute html =~ "No Results"
    end
  end

  describe "form testing" do
    test "check body content after entering a user that exists", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/finder")

      user = "Deankinyua"

      html = form(view, "#search-form", %{username: user}) |> render_submit()

      refute html =~ "The Octocat"
      refute html =~ "@octocat"
      assert html =~ "Dean Kinyua"
      # assert html =~ "Deankinyua"
    end

    test "check body content after entering a user that does not exist", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/finder")

      user = "deankinyuadfhhfj"
      html = form(view, "#search-form", %{username: user}) |> render_submit()

      # Check if the body container has a class of hidden after not finding a user
      body_container = element(view, "#body-container")
      # use pipelines
      classes =
        body_container
        |> render()
        |> Floki.attribute("class")
        |> List.first()

      assert classes =~ "hidden"

      assert html =~ "No Results"
    end
  end
end
