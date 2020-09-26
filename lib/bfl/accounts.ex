defmodule Bfl.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false

  alias Bfl.Repo
  alias Bfl.Accounts.User

  def create_user(%Ueberauth.Auth.Info{email: email, name: name, urls: %{avatar_url: avatar}}) do
    %User{}
    |> User.changeset(%{email: email, name: name, avatar: avatar})
    |> Repo.insert(
      on_conflict: {:replace, [:name, :avatar]},
      conflict_target: :email,
      returning: true
    )
  end
end
