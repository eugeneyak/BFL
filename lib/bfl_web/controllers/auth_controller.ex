defmodule BflWeb.AuthController do
  @moduledoc """
  Auth controller responsible for handling Ueberauth responses
  """

  use BflWeb, :controller

  plug Ueberauth

  alias Bfl.Accounts
  alias Ueberauth.Strategy.Helpers

  def request(conn, _params) do
    render(conn, "request.html", callback_url: Helpers.callback_url(conn))
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> clear_session()
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: %{info: info, provider: provider}}} = conn, _params) do
    case Accounts.create_oauth(provider, info) do
      {:ok, _oauth} ->
        conn
        |> put_flash(:info, "Successfully authenticated via #{provider}")
        |> put_session(:current_user, 1)
        |> configure_session(renew: true)
        |> redirect(to: "/")

      {:error, reason} ->
        conn
        |> put_flash(:error, reason)
        |> redirect(to: "/")
    end
  end
end
