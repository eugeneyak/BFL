defmodule Bfl.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    has_many :collections, Bfl.Registry.Collection, on_delete: :delete_all

    field :email, :string

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
