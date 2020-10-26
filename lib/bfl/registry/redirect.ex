defmodule Bfl.Registry.Redirect do
  use Ecto.Schema
  import Ecto.Changeset

  schema "redirects" do
    belongs_to :bookmark, Bfl.Registry.Bookmark

    field :interaction, :string

    timestamps()
  end

  @doc false
  def changeset(redirect, attrs) do
    redirect
    |> cast(attrs, [:interaction])
    |> validate_required([:interaction])
  end
end
