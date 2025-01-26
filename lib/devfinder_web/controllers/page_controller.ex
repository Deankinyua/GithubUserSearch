defmodule DevfinderWeb.PageController do
  use DevfinderWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    # ? what is this
    # * this is a phoenix app
    render(conn, :home, layout: false)
  end
end
