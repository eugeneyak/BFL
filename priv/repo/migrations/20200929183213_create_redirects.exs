defmodule Bfl.Repo.Migrations.CreateRedirects do
  use Ecto.Migration

  def change do
    create table(:redirects) do
      add :bookmark_id, references(:bookmarks, on_delete: :delete_all), null: false

      add :interaction, :string

      timestamps()
    end
  end
end
