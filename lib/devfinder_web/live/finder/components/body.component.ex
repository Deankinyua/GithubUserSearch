defmodule DevfinderWeb.BodyLive.Component do
  @moduledoc """
  Our body component.

  Holds the data fetched from GitHub api.

  Consists of 4 building blocks:
  - The avatar section - consists of 2 separate sections :
         - DevfinderWeb.AvatarMobileLive.Component for the small screen sizes
         - for big screen sizes the code is in this module

  - Bio
  - Repos, followers and following
  - Location, twitter username, blog and organization

  The logic for manipulating the last section svg fills is contained here.

  """

  use DevfinderWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <div
      class={[
        "flex justify-between shadow-xl w-full rounded-2xl py-10 bg-white dark:bg-[#1E2A47] sm:w-11/12 md:px-10 lg:px-2",
        @is_body_hidden
      ]}
      id="body-container"
    >
      <div class="rounded-full border w-2/12 h-1/6 overflow-hidden ml-8 hidden lg:block lg:ml-12 dark:border-none">
        <img src={@avatar_url} class="object-cover" />
      </div>

      <div class="w-full shrink-0 flex flex-col px-4 lg:w-3/4 lg:pl-4 lg:pr-12">
        <.live_component
          module={DevfinderWeb.AvatarMobileLive.Component}
          id="avatar_mobile_id"
          name={@name}
          avatar_url={@avatar_url}
          created_at={@created_at}
          username={@username}
        />

        <div class="hidden lg:block">
          <section class="flex justify-between mb-2">
            <p class="mono-semibold text-[#2b3442] text-xl dark:text-[#FFFFFF]">{@name}</p>
            <p class="text-[#697c9a] dark:text-[#FFFFFF]">Joined {extract_date(@created_at)}</p>
          </section>
        </div>
        <section class="mb-6 text-[#0079ff] hidden lg:block">@{@username}</section>
        <section class="my-8 text-[#4b6a9b] dark:text-[#FFFFFF]">{@bio}</section>
        <section class="flex justify-between px-6 lg:pr-16 py-4 mb-8 bg-custom-white dark:bg-[#141D2F] rounded-xl">
          <div class="flex flex-col items-center md:items-start dark:text-[#FFFFFF]">
            <p class="text-sm text-[#4b6a9b] dark:text-[#FFFFFF]">Repos</p>
            <p class="mono-semibold">{@public_repos}</p>
          </div>
          <div class="flex flex-col items-center md:items-start dark:text-[#FFFFFF]">
            <p class="text-sm text-[#4b6a9b] dark:text-[#FFFFFF]">Followers</p>
            <p class="mono-semibold">{@followers}</p>
          </div>
          <div class="flex flex-col items-center md:items-start dark:text-[#FFFFFF]">
            <p class="text-sm text-[#4b6a9b] dark:text-[#FFFFFF]">Following</p>
            <p class="mono-semibold">{@following}</p>
          </div>
        </section>

        <section class="mono-light flex flex-col justify-between gap-4 md:flex-row">
          <div class="flex flex-col gap-4">
            <section class="flex justify-start gap-3 items-center">
              <div>
                <svg height="20" width="20" xmlns="http://www.w3.org/2000/svg">
                  <path
                    d="M12.797 3.425C11.584 1.33 9.427.05 7.03.002a7.483 7.483 0 00-.308 0C4.325.05 2.17 1.33.955 3.425a6.963 6.963 0 00-.09 6.88l4.959 9.077.007.012c.218.38.609.606 1.045.606.437 0 .828-.226 1.046-.606l.007-.012 4.96-9.077a6.963 6.963 0 00-.092-6.88zm-5.92 5.638c-1.552 0-2.813-1.262-2.813-2.813s1.261-2.812 2.812-2.812S9.69 4.699 9.69 6.25 8.427 9.063 6.876 9.063z"
                    class={svg_fill(@location)}
                  />
                </svg>
              </div>
              <div class={text_color(@location)}>{@location}</div>
            </section>
            <section class="flex justify-start gap-3 items-center">
              <div>
                <svg height="20" width="20" xmlns="http://www.w3.org/2000/svg">
                  <g>
                    <path
                      d="M7.404 5.012c-2.355 2.437-1.841 6.482.857 8.273.089.06.207.048.283-.027.568-.555 1.049-1.093 1.47-1.776a.213.213 0 00-.084-.3A2.743 2.743 0 018.878 10.1a2.64 2.64 0 01-.223-1.803c.168-.815 1.043-1.573 1.711-2.274l-.004-.002 2.504-2.555a2.568 2.568 0 013.648-.019 2.6 2.6 0 01.037 3.666l-1.517 1.56a.266.266 0 00-.06.273c.35 1.012.435 2.44.201 3.519-.006.03.031.05.053.028l3.228-3.295c2.062-2.105 2.044-5.531-.04-7.615a5.416 5.416 0 00-7.691.04L7.417 4.998l-.013.014z"
                      class={svg_fill(@blog)}
                    /><path
                      d="M13.439 13.75a.401.401 0 00.006-.003c.659-1.204.788-2.586.48-3.933l-.002.002-.001-.001a5.434 5.434 0 00-2.19-3.124.3.3 0 00-.333.015c-.553.448-1.095 1.021-1.452 1.754a.243.243 0 00.096.317c.415.24.79.593 1.04 1.061h.001c.196.33.388.958.263 1.632-.116.894-1.019 1.714-1.736 2.453-.546.559-1.935 1.974-2.49 2.542a2.6 2.6 0 01-3.666.037 2.6 2.6 0 01-.038-3.666l1.521-1.564A.266.266 0 005 11.004c-.338-1.036-.43-2.432-.217-3.51.006-.03-.031-.049-.053-.027l-3.179 3.245c-2.083 2.126-2.066 5.588.04 7.693 2.125 2.083 5.57 2.048 7.653-.078.723-.81 3.821-3.678 4.195-4.577z"
                      class={svg_fill(@blog)}
                    />
                  </g>
                </svg>
              </div>
              <div class={text_color(@blog)}><span class="hover:underline">{@blog}</span></div>
            </section>
          </div>
          <div class="flex flex-col gap-4 md:pr-14 lg:pr-0">
            <section class="flex justify-start gap-3 items-center">
              <div>
                <svg height="20" width="20" xmlns="http://www.w3.org/2000/svg">
                  <path
                    d="M20 2.799a8.549 8.549 0 01-2.363.647 4.077 4.077 0 001.804-2.266 8.194 8.194 0 01-2.6.993A4.099 4.099 0 009.75 4.977c0 .324.027.637.095.934-3.409-.166-6.425-1.8-8.452-4.288a4.128 4.128 0 00-.56 2.072c0 1.42.73 2.679 1.82 3.408A4.05 4.05 0 01.8 6.598v.045a4.119 4.119 0 003.285 4.028 4.092 4.092 0 01-1.075.135c-.263 0-.528-.015-.776-.07.531 1.624 2.038 2.818 3.831 2.857A8.239 8.239 0 01.981 15.34 7.68 7.68 0 010 15.285a11.543 11.543 0 006.29 1.84c7.545 0 11.67-6.25 11.67-11.667 0-.182-.006-.357-.015-.53A8.18 8.18 0 0020 2.798z"
                    class={svg_fill(@twitter_username)}
                  />
                </svg>
              </div>
              <div class={text_color(@twitter_username)}>{@twitter_username}</div>
            </section>
            <section class="flex justify-start gap-3 items-center">
              <div>
                <svg height="20" width="20" xmlns="http://www.w3.org/2000/svg">
                  <g>
                    <path
                      d="M10.858 1.558L1.7.167A1.477 1.477 0 00.517.492 1.49 1.49 0 000 1.608v17.559c0 .458.375.833.833.833h2.709v-4.375c0-.808.65-1.458 1.458-1.458h2.083c.809 0 1.459.65 1.459 1.458V20h3.541V3a1.46 1.46 0 00-1.225-1.442zM4.583 12.292h-1.25a.625.625 0 010-1.25h1.25a.625.625 0 010 1.25zm0-2.5h-1.25a.625.625 0 010-1.25h1.25a.625.625 0 010 1.25zm0-2.5h-1.25a.625.625 0 010-1.25h1.25a.625.625 0 010 1.25zm0-2.5h-1.25a.625.625 0 010-1.25h1.25a.625.625 0 010 1.25zm4.167 7.5H7.5a.625.625 0 010-1.25h1.25a.625.625 0 010 1.25zm0-2.5H7.5a.625.625 0 010-1.25h1.25a.625.625 0 010 1.25zm0-2.5H7.5a.625.625 0 010-1.25h1.25a.625.625 0 010 1.25zm0-2.5H7.5a.625.625 0 010-1.25h1.25a.625.625 0 010 1.25zM18.85 9.035l-5.933-1.242V20h5.625A1.46 1.46 0 0020 18.542V10.46c0-.688-.47-1.274-1.15-1.425zM16.875 17.5h-1.25a.625.625 0 010-1.25h1.25a.625.625 0 010 1.25zm0-2.5h-1.25a.625.625 0 010-1.25h1.25a.625.625 0 010 1.25zm0-2.5h-1.25a.625.625 0 010-1.25h1.25a.625.625 0 010 1.25z"
                      class={svg_fill(@company)}
                    />
                  </g>
                </svg>
              </div>
              <div class={text_color(@company)}>
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

  def extract_date(datetime) do
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

  defp svg_fill(content) do
    cond do
      content == "Not Available" -> "fill-[#a3afc2]"
      true -> "fill-[#4b6a9b] dark:fill-white"
    end
  end

  defp text_color(content) do
    cond do
      content == "Not Available" -> "text-[#a3afc2]"
      true -> "text-[#4b6a9b] dark:text-[#FFFFFF]"
    end
  end
end
