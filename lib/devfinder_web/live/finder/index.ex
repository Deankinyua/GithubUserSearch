defmodule DevfinderWeb.FinderLive.Index do
  use DevfinderWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
    <div class="flex flex-col border-2 border-blue-400 items-center justify-center my-20 ">
      <.live_component
        module={DevfinderWeb.TitleLive.Component}
        id="title_id"
        is_dark={@is_dark}
        theme={@theme}
      >
      </.live_component>

      <div class="flex w-full sm:w-9/12 md:w-1/2 justify-between">
        <div class="w-3/12">
          <img src="assets/icon-location.svg" /> search icon
        </div>

        <div>
          bar
        </div>

        <div class="w-3/12">
          Search
        </div>
      </div>

      <.live_component module={DevfinderWeb.BodyLive.Component} id="body_id"></.live_component>
    </div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(is_dark: false)
     |> assign(theme: "Dark")}
  end

  @impl true
  def handle_event("dark-mode", %{"dark" => value}, socket) do
    {is_dark, theme} = toggle_theme(value)

    socket =
      socket
      |> assign(is_dark: is_dark)
      |> assign(theme: theme)

    {:noreply, push_event(socket, "toggle-mode", %{})}
  end

  defp toggle_theme(value) do
    if value == true do
      {false, "Dark"}
    else
      {true, "Light"}
    end
  end

  # def userfinch do

  #   {:ok, response} =
  #     Finch.build(:get, "https://api.github.com/users/Deankinyua")
  #     |> Finch.request(Devfinder.Finch)

  #   %{body: value} = response
  #   dbg(Jason.decode!(value))
  # end
end
