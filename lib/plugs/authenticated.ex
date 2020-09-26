defmodule BflWeb.Plugs.Authenticated do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    case get_session(conn, "current_user") do
      %Bfl.Accounts.User{} ->
        conn

      nil ->
        conn
        |> Phoenix.Controller.redirect(to: "/auth")
        |> halt
    end
  end
end
