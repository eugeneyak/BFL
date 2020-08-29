defmodule Bfl.Repo.Migrations.CreateOauth do
  use Ecto.Migration

  def change do
    create table(:oauth, primary_key: false) do
      add :email, :string, primary_key: true
      add :provider, :string, primary_key: true

      timestamps()
    end
  end
end
