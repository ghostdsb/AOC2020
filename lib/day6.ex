defmodule Aoc.Day6 do
  alias Aoc.Utils

  def solve() do
    Utils.read_file(6)
    |> String.split("\n\n", trim: true)
    |> solve()
  end

  defp solve(group_list) do
    group_list
    |> Enum.map(fn group -> group |> yes_count(:part2) end)
    |> Enum.reduce(0, fn group_ans_count, acc -> group_ans_count+acc end)
  end

  defp yes_count(group_ans, :part1) do
    group_ans
    |> String.to_charlist()
    |> Enum.reduce(%{}, fn char, acc -> Map.update(acc, char, 1, fn x -> x+1 end) end)
    |> Map.delete('\n'|> hd)
    |> Enum.count
  end

  defp yes_count(group_ans, :part2) do
    ans_map = group_ans
    |> String.to_charlist()
    |> Enum.reduce(%{}, fn char, acc -> Map.update(acc, char, 1, fn x -> x + 1 end) end)
    |> Map.update(10, 1, &(&1+1))
    ans_map
    |> Enum.filter(fn {k,v} -> v === ans_map[10] && k !== 10 end)
    |> Enum.count
  end
end
