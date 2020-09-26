defmodule BflWeb.PageLive do
  use BflWeb, :live_view

  alias Bfl.Manager
  alias Bfl.Registry.{Lookup, Collection, Bookmark}

  @impl true
  def mount(_params, %{"current_user" => user}, socket) do
    {:ok, socket |> assign(user: user, results: lookup(user))}
  end

  @impl true
  def handle_event("search", %{"q" => query}, socket) do
    {:noreply, socket |> assign(results: lookup(socket.assigns.user, query))}
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

  defp lookup(user), do: Lookup.filter(Manager.fetch(user), "")
  defp lookup(user, query), do: Lookup.filter(Manager.fetch(user), query)
end
