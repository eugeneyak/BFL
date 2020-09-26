defmodule Bfl.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :name, :string, null: false
      add :avatar, :string

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
