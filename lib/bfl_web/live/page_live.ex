defmodule BflWeb.PageLive do
  use BflWeb, :live_view

  alias Bfl.Registry.Lookup

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket |> assign(results: Lookup.filter("", cache("me")))}
  end

  @impl true
  def handle_event("search", %{"q" => query}, socket) do
    {:noreply, socket |> assign(results: Lookup.filter(query, cache("me")))}
  end

  def cache(user) do
    Bfl.Cache.Manager.fetch(user, Bfl.Registry.list_bookmarks())
  end
end
