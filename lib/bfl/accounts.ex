defmodule Bfl.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false

  alias Bfl.Repo
  alias Bfl.Accounts.OAuth

  @spec create_oauth(atom, Ueberauth.Auth.Info.t()) :: any
  def create_oauth(provider, attrs = %Ueberauth.Auth.Info{}) do
    %OAuth{provider: Atom.to_string(provider)}
    |> OAuth.changeset(Map.from_struct(attrs))
    |> Repo.insert(on_conflict: :nothing, returning: true)
  end

  def delete_oauth(%OAuth{} = oauth) do
    Repo.delete(oauth)
  end
end
