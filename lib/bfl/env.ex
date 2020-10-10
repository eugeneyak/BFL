defmodule Bfl.Env do
  def get(name) do
    System.get_env(name) || raise "environment variable #{name} is missing"
  end

  def get(name, default) do
    System.get_env(name, default)
  end
end
