# In this file, we load production configuration and secrets
# from environment variables. You can also hardcode secrets,
# although such is generally not recommended and you have to
# remember to add this file to your .gitignore.
import Config

config :bfl, BflWeb.Endpoint,
  url: [host: System.get_env("ORIGIN") || raise("environment variable ORIGIN is missing")],

config :bfl, Bfl.Repo,
  hostname: System.get_env("DBHOST") || raise("environment variable DBHOST is missing"),
  database: System.get_env("DBNAME") || "bfl",
  username: System.get_env("DBUSER") || raise("environment variable DBUSER is missing"),
  password: System.get_env("DBPASS") || raise("environment variable DBPASS is missing"),
  port: System.get_env("DBPORT") || 5432,
  show_sensitive_data_on_connection_error: true,
  pool_size: 3

config :bfl, BflWeb.Endpoint,
  secret_key_base:
    System.get_env("SECRET_KEY_BASE") ||
      raise("""
      environment variable SECRET_KEY_BASE is missing.
      You can generate one by calling: mix phx.gen.secret
      """)

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id:
    System.get_env("UEBERAUTH_GITHUB_CLIENT_ID") ||
      raise("environment variable UEBERAUTH_GITHUB_CLIENT_ID is missing"),
  client_secret:
    System.get_env("UEBERAUTH_GITHUB_CLIENT_SECRET") ||
      raise("environment variable UEBERAUTH_GITHUB_CLIENT_SECRET is missing")
