defmodule BflWeb.PageLive do
  use BflWeb, :live_view

  alias Bfl.Registry.{Lookup, Collection, Bookmark}

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket |> assign(results: Lookup.filter(cache("me"), ""))}
  end

  @impl true
  def handle_event("search", %{"q" => query}, socket) do
    {:noreply, socket |> assign(results: Lookup.filter(cache("me"), query))}
  end

  @impl true
  def handle_event("commit", _, socket) do
    case socket.assigns.results do
      [%Collection{bookmarks: bookmarks} | _] ->
        case bookmarks do
          [%Bookmark{url: url} | _] -> {:noreply, socket |> redirect(external: url)}
          _ -> {:noreply, socket}
        end

      _ ->
        {:noreply, socket}
    end
  end

  defp cache(user) do
    Bfl.Cache.Manager.fetch(user, Bfl.Registry.list_collections())
  end
end
