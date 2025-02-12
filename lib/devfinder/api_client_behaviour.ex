defmodule Devfinder.ApiClientBehaviour do
  @moduledoc """
  Any module implementing this behaviour must define a get_user_data/1 as shown below.
  """

  @callback get_user_data(String.t()) ::
              {:ok, Devfinder.UserDetails.t()} | {:error, String.t()}
end
