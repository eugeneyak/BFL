defmodule Bfl.Registry.Lookup do
  def filter(collections, ""), do: collections

  def filter(collections, query) do
    collections
    |> filter_by_distance(query)
    |> filter_by_count()
  end

  defp filter_by_distance(collections, query) do
    Enum.map(collections, fn collection ->
      fits =
        collection
        |> Map.get(:bookmarks)
        |> Enum.filter(fn bookmark ->
          bookmark
          |> Map.get(:title)
          |> distance(query) >= 0.5
        end)

      Map.put(collection, :bookmarks, fits)
    end)
  end

  defp filter_by_count(collections) do
    Enum.filter(collections, fn collection ->
      collection
      |> Map.get(:bookmarks)
      |> Enum.count() > 0
    end)
  end

  defp distance(candidate, query) do
    candidate
    |> String.downcase()
    |> String.slice(0, String.length(query))
    |> String.bag_distance(String.downcase(query))
  end
end
