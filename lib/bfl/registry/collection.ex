defmodule Bfl.Registry.Collection do
  use Ecto.Schema
  import Ecto.Changeset

  schema "collections" do
    belongs_to :user, Bfl.Accounts.User

    has_many :bookmarks, Bfl.Registry.Bookmark, on_delete: :delete_all

    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(collection, attrs) do
    collection
    |> cast(attrs, [:title, :user_id])
    |> validate_required([:title, :user_id])
  end
end
