defmodule Devfinder.RetrieveUserDetails do
  alias Devfinder.UserDetails
  require Logger

  def form_url(username) do
    "https://api.github.com/users/" <> username
  end

  def get_user_data(username) do
    user_url = form_url(username)

    case build_request(user_url) do
      {:ok, %Finch.Response{status: 200, body: body}} ->
        body = Jason.decode!(body) |> form_the_return_data()

        Logger.info("User with the Username found")
        {:ok, body}

      {:ok, %Finch.Response{status: 404}} ->
        Logger.warning("User Not found")
        {:error, "User Not found"}

      {:ok, %Finch.Response{status: 503}} ->
        Logger.warning("The service is Unavailable")
        {:error, "The Service is Unavailable"}

      {:error, reason} ->
        Logger.error("Unknown Error")
        {:error, reason}
    end
  end

  def build_request(user_url) do
    Finch.build(:get, user_url)
    |> Finch.request(Devfinder.Finch)
  end

  def form_the_return_data(body) do
    %UserDetails{
      public_repos: body["public_repos"],
      created_at: body["created_at"],
      followers: body["followers"],
      following: body["following"],
      login: body["login"],
      location: body["location"],
      company: body["company"],
      bio: body["bio"],
      profile_url: body["profile_url"],
      avatar_url: body["avatar_url"],
      name: body["name"],
      blog: body["blog"],
      twitter_username: body["twitter_username"]
    }
  end
end
