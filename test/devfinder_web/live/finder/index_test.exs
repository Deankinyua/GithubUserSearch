defmodule DevfinderWeb.FinderLive.IndexTest do
  use DevfinderWeb.ConnCase
  import Phoenix.LiveViewTest

  alias Devfinder.UserDetails

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
      user = get_user()

      # expect(mock, name, n \\ 1, code)
      ApiClientBehaviourMock
      |> expect(:get_user_data, fn "octocat" -> {:ok, user} end)

      {:ok, view, _html} = live(conn, "/finder")
      username = "octocat"

      html = form(view, "#search-form", %{username: username}) |> render_submit()

      assert html =~ user.name
      assert html =~ user.company
      assert html =~ user.bio
      assert html =~ user.location
    end

    test "check body content after entering a user that does not exist", %{conn: conn} do
      ApiClientBehaviourMock
      |> expect(:get_user_data, fn "deankinyuadfhhfj" -> {:error, "User Not found"} end)

      {:ok, view, _html} = live(conn, "/finder")

      username = "deankinyuadfhhfj"
      html = form(view, "#search-form", %{username: username}) |> render_submit()

      # Check if the body container has a class of hidden after not finding a user
      body_container = element(view, "#body-container")

      classes =
        body_container
        |> render()
        |> Floki.attribute("class")
        |> List.first()

      assert classes =~ "hidden"

      assert html =~ "No Results"
    end
  end

  defp get_user() do
    %UserDetails{
      name: "The Octocat",
      avatar_url: "https://avatars.githubusercontent.com/u/583231?v=4",
      company: "github",
      bio: "This profile has no bio",
      location: "San Francisco",
      blog: "https://github.blog",
      created_at: "2011-01-25T18:44:36Z",
      twitter_username: "Not Available",
      followers: 3938,
      following: 9,
      login: "octocat",
      public_repos: 8
    }
  end
end
