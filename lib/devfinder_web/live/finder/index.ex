defmodule DevfinderWeb.FinderLive.Index do
  use DevfinderWeb, :live_view

  alias Devfinder.RetrieveUserDetails
  alias Devfinder.UserDetails

  @impl true
  def render(assigns) do
    ~H"""
    <div class="flex flex-col mono-regular items-center justify-center center-element max-w-4xl">
      <.live_component
        module={DevfinderWeb.TitleLive.Component}
        id="title_id"
        is_dark={@is_dark}
        theme={@theme}
        theme_icon={@theme_icon}
      />

      <div class="flex w-full sm:w-11/12 bg-white justify-between my-6 items-center rounded-xl border border-red-400">
        <div class="w-10 mx-3 border border-blue-400">
          <svg height="24" width="25" xmlns="http://www.w3.org/2000/svg">
            <path
              d="M10.609 0c5.85 0 10.608 4.746 10.608 10.58 0 2.609-.952 5-2.527 6.847l5.112 5.087a.87.87 0 01-1.227 1.233l-5.118-5.093a10.58 10.58 0 01-6.848 2.505C4.759 21.16 0 16.413 0 10.58 0 4.747 4.76 0 10.609 0zm0 1.74c-4.891 0-8.87 3.965-8.87 8.84 0 4.874 3.979 8.84 8.87 8.84a8.855 8.855 0 006.213-2.537l.04-.047a.881.881 0 01.058-.053 8.786 8.786 0 002.558-6.203c0-4.875-3.979-8.84-8.87-8.84z"
              fill="#0079ff"
            />
          </svg>
        </div>

        <div class="w-9/12 grow">
          <.form for={@form} phx-submit="save">
            <section class="flex items-center justify-between">
              <div class="w-2/3">
                <.input
                  placeholder="Search GitHub username..."
                  field={@form[:username]}
                  required="true"
                  autocomplete="off"
                />
              </div>

              <div class={"#{@errors}"}>
                No results
              </div>

              <div>
                <.button
                  type="submit"
                  phx-disable-with="Searching..."
                  class="hover:cursor-pointer w-[100%] text-[#FFFFFF] bg-[#0079FF] hover:bg-[#66adff]  dark:hover:bg-[#5f9ffc] transition ease-in-out duration-300"
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
     |> assign(errors: "hidden")
     |> assign(theme_icon: "icon-moon.svg")
     |> assign(user: %UserDetails{})
     |> assign(
       is_body_hidden: "flex justify-between w-full rounded-2xl sm:w-11/12 py-10 bg-white"
     )
     |> assign(form: to_form(%{}))}
  end

  @impl true
  def handle_event("dark-mode", %{"dark" => value}, socket) do
    {is_dark, theme, theme_icon} = toggle_theme(value)

    socket =
      socket
      |> assign(is_dark: is_dark)
      |> assign(theme: theme)
      |> assign(theme_icon: theme_icon)

    {:noreply, push_event(socket, "toggle-mode", %{})}
  end

  def handle_event("save", %{"username" => username}, socket) do
    username = String.trim(username)

    case RetrieveUserDetails.get_user_data(username) do
      {:ok, user} ->
        {:noreply,
         socket
         |> assign(user: user)
         |> assign(errors: "hidden")
         |> assign(
           is_body_hidden: "flex justify-between w-full rounded-2xl sm:w-11/12 py-10 bg-white"
         )}

      {:error, _reason} ->
        {:noreply,
         socket
         |> assign(user: %UserDetails{})
         |> assign(errors: "block text-red-400")
         |> assign(
           is_body_hidden: "hidden flex justify-between w-full rounded-2xl sm:w-11/12  bg-white"
         )}
    end
  end

  defp toggle_theme(value) do
    if value == true do
      {false, "DARK", "icon-moon.svg"}
    else
      {true, "LIGHT", "icon-sun.svg"}
    end
  end
end
