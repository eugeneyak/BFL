defmodule Bfl.Accounts.OAuth do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "oauth" do
    field :email, :string, primary_key: true
    field :provider, :string, primary_key: true

    timestamps()
  end

  @doc false
  def changeset(oauth, attrs) do
    oauth
    |> cast(attrs, [:email, :provider])
    |> validate_required([:email, :provider])
  end
end
