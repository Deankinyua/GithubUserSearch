defmodule DevfinderWeb.BodyLive.Component do
  use DevfinderWeb, :live_component

  # <div></div>
  # <p></p>

  @impl true
  def render(assigns) do
    ~H"""
    <div class={"#{@is_body_hidden}"}>
      <div class="border border-blue-500 rounded-full w-2/12 h-1/6  overflow-hidden ml-8">
        <img src={@avatar_url} class="object-cover" />
      </div>
      <div class="w-3/4 shrink-0 flex flex-col px-4">
        <section class="flex justify-between mb-2">
          <p>{@name}</p>
          <p>Joined {extract_date(@created_at)}</p>
        </section>
        <section class="mb-6">@{@username}</section>
        <section class="mb-8">{@bio}</section>
        <section class="flex border border-red-400 pl-6 pr-16 py-4 mb-8 justify-between">
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
          <div class="flex flex-col border-2 border-red-400 gap-4">
            <section class="flex justify-start gap-4 items-center">
              <div><img src="assets/icon-location.svg" /></div>
              <div>{@location}</div>
            </section>
            <section class="flex justify-start gap-3 items-center">
              <div><img src="assets/icon-website.svg" /></div>
              <div>{@blog}</div>
            </section>
          </div>
          <div class="flex flex-col border-2 border-red-400 gap-4">
            <section class="flex justify-start gap-4 items-center">
              <div><img src="assets/icon-twitter.svg" /></div>
              <div>{@twitter_username}</div>
            </section>
            <section class="flex justify-start gap-4 items-center">
              <div><img src="assets/icon-company.svg" /></div>
              <div>
                {@company}
              </div>
            </section>
          </div>
        </section>
      </div>
    </div>
    """
  end

  @impl true

  def update(assigns, socket) do
    {:ok, socket |> assign(assigns)}
  end

  defp extract_date(datetime) do
    {:ok, datetime, _offset} = DateTime.from_iso8601(datetime)

    %DateTime{year: year, month: month, day: day} = datetime

    list_of_months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ]

    month_index = month - 1

    month = Enum.at(list_of_months, month_index)

    "#{day} #{month} #{year}"
  end
end
