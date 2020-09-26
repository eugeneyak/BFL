defmodule Bfl.Manager do
  use Bfl.Cache.Cachier

  @impl true
  def data(%Bfl.Accounts.User{} = user) do
    {:ok, Bfl.Registry.list_collections(user)}
  end
end
