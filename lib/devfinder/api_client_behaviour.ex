defmodule Devfinder.ApiClientBehaviour do
  @moduledoc """
  Any module implementing this behaviour must define a get_user_data/1 as shown below.
  """

  # * Because a mock is meant to replace a real entity, such replacement can only
  # * be effective if we explicitly define how the real entity should behave.
  @callback get_user_data(String.t()) ::
              {:ok, Devfinder.UserDetails.t()} | {:error, String.t()}
end
