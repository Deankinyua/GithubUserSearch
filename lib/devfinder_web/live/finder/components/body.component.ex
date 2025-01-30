defmodule DevfinderWeb.BodyLive.Component do
  use DevfinderWeb, :live_component

  # <div></div>
  # <p></p>

  @impl true
  def render(assigns) do
    ~H"""
    <div class="flex justify-between w-full sm:w-9/12 md:w-1/2 border border-red-400">
      <div class="border rounded-full w-14 h-14">picture</div>
      <div class="w-3/4 flex flex-col">
        <section class="flex justify-between">
          <p>The Octotat</p>
          <p>Joined 2024</p>
        </section>
        <section>Octotat</section>
        <section>This Profile has no Bio</section>
        <section class="flex border border-red-400 pl-6 pr-16 justify-between">
          <div class="flex flex-col">
            <p>Repos</p>
            <p>8</p>
          </div>

          <div class="flex flex-col">
            <p>Repos</p>
            <p>8</p>
          </div>

          <div class="flex flex-col  justify-between">
            <p>Repos</p>
            <p>8</p>
          </div>
        </section>
        <section class="flex justify-between">
          <div>location</div>

          <div>twitter</div>
        </section>

        <section class="flex justify-between">
          <div>blog</div>

          <div>organization</div>
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
