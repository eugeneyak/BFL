defmodule Bfl.Repo.Migrations.CreateCollections do
  use Ecto.Migration

  def change do
    create table(:collections) do
      add :title, :string
      add :user_id, :integer

      timestamps()
    end

  end
end
