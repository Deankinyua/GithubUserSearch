defmodule Devfinder.ApiClient do
  @moduledoc """
  This is where we send and receive data from GitHub (Our Context module)

  Contains the functions for:
   - forming the request (form_url/1, build_request/1),

   - for receiving responses (get_user_data/1)

   - and forming the return data (form_the_return_data/1)

  """

  alias Devfinder.UserDetails
  require Logger

  def form_url(username) do
    "https://api.github.com/users/" <> username
  end

  def build_request(user_url) do
    Finch.build(:get, user_url)
    |> Finch.request(Devfinder.Finch)
  end

  def get_user_data(username) do
    user_url = form_url(username)

    case build_request(user_url) do
      {:ok, %Finch.Response{status: 200, body: body}} ->
        body = Jason.decode!(body) |> form_the_return_data()

        Logger.info("User with the Username found", ansi_color: :yellow)
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

  def form_the_return_data(body) do
    body =
      Map.update!(body, "bio", fn x ->
        if x == nil do
          "This profile has no bio"
        else
          x
        end
      end)

    body =
      Map.new(
        body,
        fn {key, value} ->
          if value == "" || value == nil do
            {key, "Not Available"}
          else
            {key, value}
          end
        end
      )

    %UserDetails{
      public_repos: body["public_repos"],
      created_at: body["created_at"],
      followers: body["followers"],
      following: body["following"],
      login: body["login"],
      location: body["location"],
      company: body["company"],
      bio: body["bio"],
      avatar_url: body["avatar_url"],
      name: body["name"],
      blog: body["blog"],
      twitter_username: body["twitter_username"]
    }
  end
end
