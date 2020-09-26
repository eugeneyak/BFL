defmodule Bfl.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "users" do
    field :email, :string, primary_key: true

    field :name, :string
    field :avatar, :string

    timestamps()
  end

  @doc false
  def changeset(oauth, attrs) do
    oauth
    |> cast(attrs, [:email, :name])
    |> validate_required([:email, :name])
  end
end
