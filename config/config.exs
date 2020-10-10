# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :bfl,
  ecto_repos: [Bfl.Repo]

# Configures the endpoint
config :bfl, BflWeb.Endpoint,
  url: [host: "localhost", port: 4000],
  http: [port: 4000],
  secret_key_base: "qSV1mzM9p7mAnitRlaI61Q2IytRMoXt/xD5nujQ2KgcqJesFSEAWbaMdflo2P6Jh",
  render_errors: [view: BflWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Bfl.PubSub,
  live_view: [signing_salt: "RQ3yKX5V"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :ueberauth, Ueberauth,
  providers: [
    github: {Ueberauth.Strategy.Github, [default_scope: "user:email"]}
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
