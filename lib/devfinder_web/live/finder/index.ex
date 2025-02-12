defmodule DevfinderWeb.FinderLive.Index do
  @moduledoc """
  The entrypoint to our LiveView.

  Consists of 3 building blocks:
  - DevfinderWeb.TitleLive.Component - renders the top section (devfinder and our theme toggle)
  - form - the middle section that contains the search icon, input and Search button
  - DevfinderWeb.BodyLive.Component - Renders the body which contains the data from the individual

  The logic for switching between dark and light modes is partly done here.

  """

  use DevfinderWeb, :live_view

  alias Devfinder.ApiClient
  alias Devfinder.UserDetails

  @impl true
  def render(assigns) do
    ~H"""
    <div class="flex flex-col mono-regular items-center justify-center center-element max-w-4xl">
      <.live_component
        module={DevfinderWeb.TitleLive.Component}
        id="title_id"
        theme={@theme}
        is_dark={@is_dark}
      />

      <div class="flex w-full sm:w-11/12 bg-white justify-between mt-8 mb-6 py-2 items-center rounded-xl hover:cursor-pointer shadow-lg hover:shadow-xl transition ease-in-out duration-500 dark:bg-[#1E2A47]">
        <div class="w-[9%] ml-3 md:ml-10 md:w-[5%]">
          <svg height="24" width="25" xmlns="http://www.w3.org/2000/svg">
            <path
              d="M10.609 0c5.85 0 10.608 4.746 10.608 10.58 0 2.609-.952 5-2.527 6.847l5.112 5.087a.87.87 0 01-1.227 1.233l-5.118-5.093a10.58 10.58 0 01-6.848 2.505C4.759 21.16 0 16.413 0 10.58 0 4.747 4.76 0 10.609 0zm0 1.74c-4.891 0-8.87 3.965-8.87 8.84 0 4.874 3.979 8.84 8.87 8.84a8.855 8.855 0 006.213-2.537l.04-.047a.881.881 0 01.058-.053 8.786 8.786 0 002.558-6.203c0-4.875-3.979-8.84-8.87-8.84z"
              fill="#0079ff"
            />
          </svg>
        </div>

        <div class="w-9/12 grow">
          <.form for={@form} phx-submit="save" id="search-form">
            <section class="flex items-center justify-between mr-2">
              <div class="w-2/3 grow">
                <.input
                  placeholder="Search GitHub username..."
                  field={@form[:username]}
                  autocomplete="off"
                />
              </div>

              <div class="text-red-400">
                {@errors}
              </div>

              <div>
                <.button
                  type="submit"
                  phx-disable-with="Searching..."
                  class="hover:cursor-pointer w-[100%] text-[#FFFFFF] bg-[#0079FF] dark:hover:bg-[#5f9ffc] transition ease-in-out duration-300"
                >
                  Search
                </.button>
              </div>
            </section>
          </.form>
        </div>
      </div>

      <.live_component
        module={DevfinderWeb.BodyLive.Component}
        id="body_id"
        name={@user.name}
        avatar_url={@user.avatar_url}
        created_at={@user.created_at}
        bio={@user.bio}
        public_repos={@user.public_repos}
        followers={@user.followers}
        following={@user.following}
        location={@user.location}
        username={@user.login}
        company={@user.company}
        twitter_username={@user.twitter_username}
        blog={@user.blog}
        is_body_hidden={@is_body_hidden}
      />
    </div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(is_dark: false)
     |> assign(theme: "DARK")
     |> assign(errors: "")
     |> assign(user: %UserDetails{})
     |> assign(is_body_hidden: "")
     |> assign(form: to_form(%{}))}
  end

  @impl true
  def handle_event("dark-mode", %{"dark" => value}, socket) do
    {is_dark, theme} = toggle_theme(value)

    socket =
      socket
      |> assign(is_dark: is_dark)
      |> assign(theme: theme)

    {:noreply, push_event(socket, "toggle-mode", %{})}
  end

  def handle_event("save", %{"username" => username}, socket) do
    username = String.trim(username)

    case ApiClient.get_user_data(username) do
      {:ok, user} ->
        {:noreply,
         socket
         |> assign(user: user)
         |> assign(errors: "")
         |> assign(is_body_hidden: "")
         |> assign(form: to_form(%{}))}

      {:error, _reason} ->
        {:noreply,
         socket
         |> assign(user: %UserDetails{})
         |> assign(errors: "No Results")
         |> assign(is_body_hidden: "hidden")
         |> assign(form: to_form(%{}))}
    end
  end

  defp toggle_theme(value) do
    if value == true do
      {false, "DARK"}
    else
      {true, "LIGHT"}
    end
  end
end
