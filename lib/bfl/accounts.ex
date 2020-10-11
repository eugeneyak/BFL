defmodule Bfl.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false

  alias Bfl.Repo
  alias Bfl.Accounts.User

  def create_user(%Ueberauth.Auth.Info{email: email, name: name}) do
    %User{}
    |> User.changeset(%{email: email, name: name})
    |> Repo.insert(
      on_conflict: {:replace, [:name]},
      conflict_target: :email,
      returning: true
    )
  end
end
