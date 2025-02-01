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
          <p>{extract_date(@created_at)}</p>
        </section>
        <section>@{@username}</section>
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
