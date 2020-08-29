defmodule Bfl.Repo do
  use Ecto.Repo,
    otp_app: :bfl,
    adapter: Ecto.Adapters.Postgres
end
