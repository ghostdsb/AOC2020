defmodule Aoc.Utils do
  def read_file(day) do
    with {:ok, content} <- File.read("priv/input/day#{day}.txt") do
      content
    else
      {:error, _} -> ""
    end
  end

  def transpose(matrix) do
    transpose(matrix, [])
    |> Enum.map(fn x -> Enum.reverse(x) end)
  end

  defp transpose([], t_matrix), do: t_matrix

  defp transpose([h | t], t_matrix) do
    column = make_column(h, [], t_matrix)
    transpose(t, column)
  end

  defp make_column([], cols, []) do
    cols |> Enum.reverse()
  end

  defp make_column([h | t], [], []) do
    make_column(t, [[h]], [])
  end

  defp make_column([h | t], cols, []) do
    make_column(t, [[h] | cols], [])
  end

  defp make_column([h | t], [], [t_matrix_h | t_matrix_t]) do
    make_column(t, [[h | t_matrix_h]], t_matrix_t)
  end

  defp make_column([h | t], cols, [t_matrix_h | t_matrix_t]) do
    make_column(t, [[h | t_matrix_h] | cols], t_matrix_t)
  end
end

# def transpose([[]|_]), do: []
# def transpose(m), do: [ Enum.map(m, hd(&1)) | transpose Enum.map(m, tl(&1))]
