defmodule DevfinderWeb.AvatarMobileLive.Component do
  use DevfinderWeb, :live_component

  alias DevfinderWeb.BodyLive.Component

  @impl true
  def render(assigns) do
    ~H"""
    <div class="lg:hidden">
      <div class="flex gap-6">
        <section class="rounded-full border w-1/4 h-1/4 overflow-hidden dark:border-none">
          <img src={@avatar_url} class="object-cover" />
        </section>

        <section class="w-2/3 shrink-0 flex justify-between mb-2 flex-col">
          <p class="mono-semibold text-[#2b3442] text-xl dark:text-[#FFFFFF]">{@name}</p>
          <p class="text-[#0079ff]">@{@username}</p>
          <p class="text-[#697c9a] dark:text-[#FFFFFF]">
            Joined {Component.extract_date(@created_at)}
          </p>
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
