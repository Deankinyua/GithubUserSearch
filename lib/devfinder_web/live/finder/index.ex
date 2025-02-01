defmodule DevfinderWeb.FinderLive.Index do
  use DevfinderWeb, :live_view

  alias Devfinder.RetrieveUserDetails
  alias Devfinder.UserDetails

  @impl true
  def render(assigns) do
    ~H"""
    <div class="flex flex-col border-2 border-blue-400 items-center justify-center my-20 ">
      <.live_component
        module={DevfinderWeb.TitleLive.Component}
        id="title_id"
        is_dark={@is_dark}
        theme={@theme}
        theme_icon={@theme_icon}
      >
      </.live_component>

      <div class="flex w-full sm:w-9/12 md:w-1/2 justify-between items-center">
        <div class="w-3/12 border border-blue-400">
          <img src="assets/icon-search.svg" />
        </div>

        <div class="w-9/12 border border-indigo-800">
          <.form for={@form} phx-submit="save">
            <section class="flex items-center justify-between">
              <.input
                placeholder="Search GitHub username..."
                field={@form[:username]}
                required="true"
                autocomplete="off"
              />

              <div class={"#{@errors}"}>
                No results
              </div>

              <div>
                <.button type="submit" phx-disable-with="Saving...">
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
      >
      </.live_component>
    </div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    # dbg(DateTime.utc_now())

    {:ok,
     socket
     |> assign(is_dark: false)
     |> assign(theme: "Dark")
     |> assign(errors: "hidden")
     |> assign(theme_icon: "icon-moon.svg")
     |> assign(user: %UserDetails{})
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
        socket = socket |> assign(user: user)
        {:noreply, socket}

      {:error, _reason} ->
        {:noreply,
         socket
         |> assign(user: %UserDetails{})
         |> assign(errors: "block text-red-400")}
    end
  end

  defp toggle_theme(value) do
    if value == true do
      {false, "Dark", "icon-moon.svg"}
    else
      {true, "Light", "icon-sun.svg"}
    end
  end
end
