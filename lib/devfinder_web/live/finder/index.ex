defmodule DevfinderWeb.FinderLive.Index do
  use DevfinderWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.live_component
        module={DevfinderWeb.TitleLive.Component}
        id="title_id"
        is_dark={@is_dark}
        theme={@theme}
      >
      </.live_component>

      <div class="bg-white  dark:bg-black">bring the money</div>
    </div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(is_dark: false)
     |> assign(theme: "dark")}
  end

  @impl true
  def handle_event("dark-mode", %{"dark" => value}, socket) do
    {toggle_value, toggle_text} = toggler(value)

    socket =
      socket
      |> assign(is_dark: toggle_value)
      |> assign(theme: toggle_text)

    {:noreply, push_event(socket, "toggle-mode", %{})}
  end

  defp toggler(value) do
    if value == true do
      {false, "dark"}
    else
      {true, "light"}
    end
  end
end
