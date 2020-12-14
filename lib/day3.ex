defmodule Aoc.Day3 do
  alias Aoc.Utils

  def solve() do
    Utils.read_file(3)
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    # |> solve(:part1)
    |> solve(:part2)
  end

  defp solve(forest, :part1) do
    forest
    |> Enum.reduce(0, fn {row, index}, acc -> acc + tree_at_pos(row, index, :part1) end)
  end

  defp solve(forest, :part2) do
    forest
    |> Enum.map(fn {row, index} -> tree_at_pos(row, index, :part2) end)
    |> Utils.transpose()
    |> Enum.map(fn row -> row |> Enum.reduce(0, fn x, acc -> acc + x end) end)
    |> Enum.reduce(1, fn x, prod -> prod * x end)
  end

  defp tree_at_pos(row, index, :part1) do
    get_slope_list(:part1)
    |> Enum.reduce(0, fn {r, d}, acc -> acc + tree_at_pos(row, index, r, d) end)
  end

  defp tree_at_pos(row, index, :part2) do
    get_slope_list(:part2)
    |> Enum.map(fn {r, d} -> tree_at_pos(row, index, r, d) end)
  end

  defp tree_at_pos(row, index, r, d) do
    cond do
      String.at(row, rem(div(index * r, d), String.length(row))) === "#" && rem(index, d) === 0 ->
        1

      true ->
        0
    end
  end

  defp get_slope_list(:part1), do: [{3, 1}]
  defp get_slope_list(:part2), do: [{3, 1}, {1, 1}, {5, 1}, {7, 1}, {1, 2}]
end
