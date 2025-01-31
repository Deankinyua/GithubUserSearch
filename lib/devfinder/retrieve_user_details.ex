defmodule Devfinder.RetrieveUserDetails do
  require Logger

  def form_url(username) do
    "https://api.github.com/users/" <> username
  end

  def get_user_data(username) do
    user_url = form_url(username)

    case build_request(user_url) do
      {:ok, %Finch.Response{status: 200, body: body}} ->
        body = Jason.decode!(body)
        Logger.info("User with the Username found")
        {:ok, body}

      {:ok, %Finch.Response{status: 404}} ->
        Logger.warning("User Not found")
        {:error, "User Not found"}

      {:ok, %Finch.Response{status: 503}} ->
        Logger.warning("The service is unavailable")
        {:error, "The service is unavailable"}

      {:error, reason} ->
        Logger.error("unknown error")
        {:error, reason}
    end
  end

  def build_request(user_url) do
    Finch.build(:get, user_url)
    |> Finch.request(Devfinder.Finch)
  end
end
