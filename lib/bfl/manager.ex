defmodule Bfl.Manager do
  use Bfl.Cache.Cachier

  @impl true
  def data(_) do
    {:ok, Bfl.Registry.list_collections()}
  end
end
