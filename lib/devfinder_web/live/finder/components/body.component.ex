defmodule DevfinderWeb.BodyLive.Component do
  use DevfinderWeb, :live_component

  # <div></div>
  # <p></p>

  @impl true
  def render(assigns) do
    ~H"""
    <div class="flex justify-between w-full sm:w-9/12 md:w-1/2 border border-red-400">
      <div class="border rounded-full w-14 h-14">
        <img src={@avatar_url} />
      </div>
      <div class="w-3/4 flex flex-col">
        <section class="flex justify-between">
          <p>{@name}</p>
          <p>{@created_at}</p>
        </section>
        <section>{@username}</section>
        <section>{@bio}</section>
        <section class="flex border border-red-400 pl-6 pr-16 justify-between">
          <div class="flex flex-col">
            <p>Repos</p>
            <p>{@public_repos}</p>
          </div>

          <div class="flex flex-col">
            <p>Followers</p>
            <p>{@followers}</p>
          </div>

          <div class="flex flex-col  justify-between">
            <p>Following</p>
            <p>{@following}</p>
          </div>
        </section>
        <section class="flex justify-between">
          <div>{@location}</div>

          <div>{@twitter_username}</div>
        </section>

        <section class="flex justify-between">
          <div>{@blog}</div>

          <div>{@company}</div>
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
