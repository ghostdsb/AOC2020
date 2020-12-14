defmodule Aoc.Day1 do
  alias Aoc.Utils

  def solve() do
    Utils.read_file(1)
    |> String.split("\n", trim: true)
    |> Enum.map(fn x -> String.to_integer(x) end)
    |> Enum.reduce(%{}, fn x, acc -> Map.update(acc, x, 1, &(&1 + 1)) end)
    # |> solve(2020, :part1)
    |> solve(2020, :part2)
  end

  defp solve(cost_map, sum, :part2) do
    with 1 <-
           cost_map
           |> Enum.filter(fn {k, v} -> solve(%{cost_map | k => v - 1}, sum - k, :part1) !== -1 end)
           |> Enum.reduce(1, fn {k, _f}, acc -> acc * k end) do
      nil
    end
  end

  defp solve(cost_map, sum, :part1) do
    with {cost, _frequency} <- has_sum(cost_map, sum) do
      cost * (sum - cost)
    else
      :error -> -1
    end
  end

  defp has_sum(map, sum) do
    map
    |> Enum.find(:error, fn {k, v} ->
      Map.has_key?(map, sum - k) && (2 * k !== sum || (2 * k == sum && v > 1))
    end)
  end
end
