# In this file, we load production configuration and secrets
# from environment variables. You can also hardcode secrets,
# although such is generally not recommended and you have to
# remember to add this file to your .gitignore.
import Config

alias Bfl.Release

config :bfl, BflWeb.Endpoint,
  url: [host: Release.load("ORIGIN")],
  secret_key_base: Release.load("SECRET_KEY_BASE")

config :bfl, Bfl.Repo,
  hostname: Release.load("DB_HOST"),
  database: Release.load("DB_NAME", "bfl"),
  username: Release.load("DB_USER"),
  password: Release.load("DB_PASS"),
  port: Release.load("DB_PORT", 5432),
  show_sensitive_data_on_connection_error: true,
  pool_size: 3

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: Release.load("UEBERAUTH_GITHUB_CLIENT_ID"),
  client_secret: Release.load("UEBERAUTH_GITHUB_CLIENT_SECRET")
