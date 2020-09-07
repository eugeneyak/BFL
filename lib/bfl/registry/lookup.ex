defmodule Bfl.Registry.Lookup do
  def rate("", list), do: list |> Enum.map(&{&1, 1})

  def rate(query, list) do
    list
    |> Enum.map(&{&1, distance(query, &1.title)})
    |> Enum.sort_by(fn {_, rate} -> -rate end)
    |> Enum.take_while(fn {_, rate} -> rate >= 0.5 end)
  end

  def distance(query, candidate) do
    candidate
    |> String.slice(0, String.length(query))
    |> String.bag_distance(query)
  end
end
