# In this file, we load production configuration and secrets
# from environment variables. You can also hardcode secrets,
# although such is generally not recommended and you have to
# remember to add this file to your .gitignore.
import Config

alias Bfl.Env

config :bfl, BflWeb.Endpoint,
  url: [host: Env.get("ORIGIN")],
  secret_key_base: Env.get("SECRET_KEY_BASE")

config :bfl, Bfl.Repo,
  hostname: Env.get("DB_HOST"),
  database: Env.get("DB_NAME", "bfl"),
  username: Env.get("DB_USER"),
  password: Env.get("DB_PASS"),
  port: Env.get("DB_PORT", 5432),
  show_sensitive_data_on_connection_error: true,
  pool_size: 3

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: Env.get("UEBERAUTH_GITHUB_CLIENT_ID"),
  client_secret: Env.get("UEBERAUTH_GITHUB_CLIENT_SECRET"),
