defmodule BflWeb.PageLive do
  use BflWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    query = ""
    {:ok, socket |> assign(query: query, results: results("me", query))}
  end

  @impl true
  def handle_event("search", %{"q" => query}, socket) do
    {:noreply, socket |> assign(results: results("me", query))}
  end

  defp results(user, ""), do: data(user)

  defp results(user, query) do
    user
    |> data()
    |> Enum.filter(&String.starts_with?(&1.title, query))
  end

  defp data(user) do
    Bfl.Cache.Manager.fetch(user, Bfl.Registry.list_bookmarks())
  end
end
