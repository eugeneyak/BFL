defmodule Bfl.Registry.Collection do
  use Ecto.Schema
  import Ecto.Changeset

  schema "collections" do
    has_many :bookmarks, Bfl.Registry.Bookmark

    field :title, :string
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(collection, attrs) do
    collection
    |> cast(attrs, [:title, :user_id])
    |> validate_required([:title, :user_id])
  end
end
