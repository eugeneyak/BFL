defmodule BflWeb.PageLive do
  use BflWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    query = ""
    {:ok, socket |> assign(query: query, results: search(query))}
  end

  @impl true
  def handle_event("search", %{"q" => _query}, socket) do
    {:noreply, socket}
  end

  defp data(user) do
    Bfl.Cache.Manager.fetch(user, Bfl.Registry.list_bookmarks())
  end

  defp search(""), do: data("me")
  defp search(_), do: data("me")
end
