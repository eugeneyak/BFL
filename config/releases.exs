# In this file, we load production configuration and secrets
# from environment variables. You can also hardcode secrets,
# although such is generally not recommended and you have to
# remember to add this file to your .gitignore.
import Config

alias Bfl.Release

config :bfl, BflWeb.Endpoint,
  url: [host: Release.get_env("ORIGIN")],
  secret_key_base: Release.get_env("SECRET_KEY_BASE")

config :bfl, Bfl.Repo,
  hostname: Release.get_env("DB_HOST"),
  database: Release.get_env("DB_NAME", "bfl"),
  username: Release.get_env("DB_USER"),
  password: Release.get_env("DB_PASS"),
  port: Release.get_env("DB_PORT", 5432),
  show_sensitive_data_on_connection_error: true,
  pool_size: 3

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: Release.get_env("UEBERAUTH_GITHUB_CLIENT_ID"),
  client_secret: Release.get_env("UEBERAUTH_GITHUB_CLIENT_SECRET")
