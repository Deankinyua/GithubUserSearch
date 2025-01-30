defmodule DevfinderWeb.BodyLive.Component do
  use DevfinderWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <div class="flex justify-between w-full sm:w-9/12 md:w-1/2 border border-red-400">
      <div>picture</div>
      <div class="w-3/4">content</div>
    </div>
    """
  end

  @impl true

  def update(assigns, socket) do
    {:ok, socket |> assign(assigns)}
  end
end
