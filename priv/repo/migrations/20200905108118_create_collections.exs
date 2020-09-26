defmodule Bfl.Repo.Migrations.CreateCollections do
  use Ecto.Migration

  def change do
    create table(:collections) do
      add :title, :string
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end
  end
end
