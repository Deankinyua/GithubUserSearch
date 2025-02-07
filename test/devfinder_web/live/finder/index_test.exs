defmodule DevfinderWeb.FinderLive.IndexTest do
  use DevfinderWeb.ConnCase

  import Phoenix.LiveViewTest

  # * test/3 -> test name, the testing context, the contents of the test

  test "check liveview content", %{conn: conn} do
    {:ok, view, html} = live(conn, "/finder")

    dbg(view.module)

    assert html =~ "devfinder"
    assert html =~ "Search"
  end
end
