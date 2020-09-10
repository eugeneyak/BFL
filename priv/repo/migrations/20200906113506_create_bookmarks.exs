defmodule Bfl.Repo.Migrations.CreateBookmarks do
  use Ecto.Migration

  def change do
    create table(:bookmarks) do
      add :collection_id, references(:collections, on_delete: :delete_all), null: false

      add :title, :string
      add :url, :string

      timestamps()
    end
  end
end
