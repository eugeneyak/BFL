defmodule BflWeb.AuthLive do
  use BflWeb, :live_view

  @impl true
  def render(assigns) do
    ~L"""
    <div>
      <button phx-click="authorize" phx-value-provider="github">GitHub</button>
    </div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_event("authorize", %{"provider" => provider}, socket) do
    {:noreply, redirect(socket, to: "/auth/" <> provider)}
  end
end
