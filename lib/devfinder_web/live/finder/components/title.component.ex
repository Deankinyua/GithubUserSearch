defmodule DevfinderWeb.TitleLive.Component do
  use DevfinderWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <div class="flex justify-between w-full sm:w-9/12 md:w-1/2">
      <div>devfinder</div>
      <div>
        <.link phx-click={JS.push("dark-mode", value: %{dark: @is_dark})}>
          {@theme}
        </.link>
      </div>
    </div>
    """
  end

  @impl true

  def update(assigns, socket) do
    {:ok, socket |> assign(assigns)}
  end
end
