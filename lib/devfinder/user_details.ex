defmodule Devfinder.UserDetails do
  @moduledoc """
  Our User details struct.

  acts as our Core and is the data that we need in our application

  """

  defstruct name: "The Octocat",
            avatar_url: "https://avatars.githubusercontent.com/u/583231?v=4",
            company: "github",
            bio: "This profile has no bio",
            location: "San Francisco",
            blog: "https://github.blog",
            created_at: "2011-01-25T18:44:36Z",
            twitter_username: "Not Available",
            followers: 3938,
            following: 9,
            login: "octocat",
            public_repos: 8
end
