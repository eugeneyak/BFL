defmodule BflWeb.Router do
  use BflWeb, :router

  require Ueberauth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {BflWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :secure do
    plug BflWeb.Plugs.Authenticated
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BflWeb do
    pipe_through [:browser, :secure]

    live "/", PageLive, :index
  end

  scope "/auth", BflWeb do
    pipe_through :browser

    live "/", AuthLive, :index

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
    post "/:provider/callback", AuthController, :callback
    post "/logout", AuthController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", BflWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: BflWeb.Telemetry
    end
  end
end
