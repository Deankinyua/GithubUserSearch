defmodule DevfinderWeb.TitleLive.Component do
  use DevfinderWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <div class="flex justify-between items-center w-full sm:w-9/12 md:w-11/12">
      <div class="mono-semibold text-3xl dark:text-[#FFFFFF]">devfinder</div>
      <.link phx-click={JS.push("dark-mode", value: %{dark: @is_dark})}>
        <section class="flex items-center gap-4 mono-semibold text-[#4b6a9b]">
          <div class="text-sm tracking-wider dark:text-[#FFFFFF]">
            {@theme}
          </div>

          <div><img src={form_theme_icon(@theme_icon)} /></div>
        </section>
      </.link>
    </div>
    """
  end

  @impl true

  def update(assigns, socket) do
    {:ok, socket |> assign(assigns)}
  end

  def form_theme_icon(theme_icon) do
    "images/#{theme_icon}"
  end
end

# <div><img src="assets/icon-moon.svg" /></div>
