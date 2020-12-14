defmodule Aoc do
  def run(1), do: Aoc.Day1.solve()
  def run(2), do: Aoc.Day2.solve()
  def run(3), do: Aoc.Day3.solve()
  def run(4), do: Aoc.Day4.solve()
  def run(5), do: Aoc.Day5.solve()
  def run(day), do: "Day#{day} not present"
end
