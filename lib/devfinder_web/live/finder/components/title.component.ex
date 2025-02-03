defmodule DevfinderWeb.TitleLive.Component do
  use DevfinderWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <div class="flex justify-between w-full sm:w-9/12 md:w-1/2">
      <div class="mono-semibold text-2xl">devfinder</div>
      <div class="flex items-center gap-1">
        <div>
          <.link phx-click={JS.push("dark-mode", value: %{dark: @is_dark})}>
            {@theme}
          </.link>
        </div>

        <div><img src={form_theme_icon(@theme_icon)} /></div>
      </div>
    </div>
    """
  end

  @impl true

  def update(assigns, socket) do
    {:ok, socket |> assign(assigns)}
  end

  def form_theme_icon(theme_icon) do
    "assets/#{theme_icon}"
  end
end

# <div><img src="assets/icon-moon.svg" /></div>
