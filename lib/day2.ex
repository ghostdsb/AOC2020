defmodule Aoc.Day2 do
  use Bitwise
  alias Aoc.Utils

  def solve() do
    Utils.read_file(2)
    |> String.split("\n", trim: true)
    # |> Enum.filter(fn entry -> entry |> valid_password?(:part1) end)
    |> Enum.filter(fn entry -> entry |> valid_password?(:part2) end)
    |> Enum.count()
  end

  defp valid_password?(entry, :part2) do
    [idx1, idx2, key, password] = entry |> String.split(["-", " ", ": "])

    a =
      cond do
        String.at(password, String.to_integer(idx1) - 1) === key -> 1
        true -> 0
      end

    b =
      cond do
        String.at(password, String.to_integer(idx2) - 1) === key -> 1
        true -> 0
      end

    a ^^^ b === 1
  end

  defp valid_password?(entry, :part1) do
    [min, max, key, password] = entry |> String.split(["-", " ", ": "])

    password
    |> String.to_charlist()
    |> Enum.filter(fn c -> c === key |> to_charlist() |> hd end)
    |> Enum.count()
    |> valid_frequency?(min, max)
  end

  defp valid_frequency?(count, min, max) do
    count >= String.to_integer(min) && count <= String.to_integer(max)
  end
end
