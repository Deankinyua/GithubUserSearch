defmodule DevfinderWeb.AvatarMobileLive.Component do
  use DevfinderWeb, :live_component

  alias DevfinderWeb.BodyLive.Component

  @impl true
  def render(assigns) do
    ~H"""
    <div class="md:hidden">
      <div class="flex gap-6">
        <section class="rounded-full border w-1/4 h-1/4 overflow-hidden">
          <img src={@avatar_url} class="object-cover" />
        </section>

        <section class="w-2/3 shrink-0 flex justify-between mb-2 flex-col">
          <p>{@name}</p>
          <p>@{@username}</p>
          <p>Joined {Component.extract_date(@created_at)}</p>
        </section>
      </div>
    </div>
    """
  end

  @impl true

  def update(assigns, socket) do
    {:ok, socket |> assign(assigns)}
  end
end
