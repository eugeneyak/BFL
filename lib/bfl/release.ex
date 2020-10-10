defmodule Bfl.Release do
  @app :bfl

  def migrate do
    load_app()

    for repo <- Application.fetch_env!(@app, :ecto_repos) do
      {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true))
    end
  end

  def rollback(repo, version) do
    load_app()
    {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :down, to: version))
  end

  def get_env(name) do
    System.get_env(name) || raise "environment variable #{name} is missing"
  end

  def get_env(name, default) do
    System.get_env(name) || default
  end

  defp load_app do
    Application.load(@app)
  end
end
