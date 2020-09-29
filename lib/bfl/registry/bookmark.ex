defmodule Bfl.Registry.Bookmark do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bookmarks" do
    belongs_to :collection, Bfl.Registry.Collection

    has_many :redirects, Bfl.Registry.Redirect, on_delete: :delete_all

    field :title, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(bookmark, attrs) do
    bookmark
    |> cast(attrs, [:title, :url])
    |> validate_required([:title, :url])
  end
end
