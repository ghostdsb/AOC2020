defmodule Aoc.Day5 do
  alias Aoc.Utils

  def solve() do
    Utils.read_file(5)
    |> String.split("\n", trim: true)
    |> solve
  end

  defp solve(bp_list) do
    seat_ids =
      bp_list
      |> Enum.map(fn bp -> seat_id(bp) end)

    sum = seat_ids |> Enum.sum()
    min = seat_ids |> Enum.min()
    max = seat_ids |> Enum.max()
    (max - min + 1) * (max + min) / 2 - sum
  end

  def seat_id(location_string) do
    location_string
    |> find_coordinate
    |> calc_seat_id
  end

  defp calc_seat_id({r, c}), do: r * 8 + c

  defp find_coordinate(location_string) do
    <<row::binary-7, col::binary>> = location_string
    r = find_position(row, {'B', 'F'})
    c = find_position(col, {'R', 'L'})
    {r, c}
  end

  defp find_position(location_string, {_high, low}) do
    location_string
    |> String.to_charlist()
    |> Enum.map(fn x ->
      cond do
        x === low |> hd -> 0
        true -> 1
      end
    end)
    |> Enum.with_index()
    |> Enum.reduce(0, fn {x, i}, acc ->
      acc + x * :math.pow(2, String.length(location_string) - 1 - i)
    end)
    |> floor()
  end
end
