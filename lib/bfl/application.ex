defmodule Bfl.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Bfl.Repo,
      # Start the Telemetry supervisor
      BflWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Bfl.PubSub},
      # Start the Endpoint (http/https)
      BflWeb.Endpoint,
      # Start a worker by calling: Bfl.Worker.start_link(arg)
      # {Bfl.Worker, arg}

      Bfl.Manager
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Bfl.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    BflWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
