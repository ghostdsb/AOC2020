defmodule Aoc.Day4 do
  alias Aoc.Utils

  def solve() do
    Utils.read_file(4)
    |> String.split("\n\n", trim: true)
    |> Enum.map(fn passport ->
      passport
      |> String.split([" ", "\n"])
      |> Enum.map(fn entry ->
        [k, v] = String.split(entry, ":")
        {k, v}
      end)
      |> Map.new()
    end)
    |> solve(:part1)
    |> solve(:part2)
    |> Enum.count()
  end

  defp solve(passports_map, :part2) do
    passports_map
    |> Enum.filter(fn passport_map -> byr_valid?(passport_map["byr"]) end)
    |> Enum.filter(fn passport_map -> iyr_valid?(passport_map["iyr"]) end)
    |> Enum.filter(fn passport_map -> eyr_valid?(passport_map["eyr"]) end)
    |> Enum.filter(fn passport_map -> hgt_valid?(passport_map["hgt"]) end)
    |> Enum.filter(fn passport_map -> hcl_valid?(passport_map["hcl"]) end)
    |> Enum.filter(fn passport_map -> ecl_valid?(passport_map["ecl"]) end)
    |> Enum.filter(fn passport_map -> pid_valid?(passport_map["pid"]) end)
  end

  defp solve(passports_map, :part1) do
    passports_map
    |> Enum.filter(fn passport_map -> compulsory_keys_present?(passport_map) end)
  end

  defp compulsory_keys_present?(passport_map) do
    compulsory_keys()
    |> Enum.all?(fn key -> passport_map |> Map.has_key?(key) end)
  end

  defp byr_valid?(byr), do: String.length(byr) === 4 && String.to_integer(byr) >= 1920 && String.to_integer(byr) <= 2002

  defp iyr_valid?(iyr), do: String.length(iyr) === 4 && String.to_integer(iyr) >= 2010 && String.to_integer(iyr) <= 2020

  defp eyr_valid?(eyr), do: String.length(eyr) === 4 && String.to_integer(eyr) >= 2020 && String.to_integer(eyr) <= 2030

  defp hgt_valid?(hgt) do
    hgt_tmp = String.reverse(hgt)
    <<ut::binary-2, ht::binary>> = hgt_tmp
    ht = String.reverse(ht)
    ut = String.reverse(ut)

    (ut === "cm" && String.to_integer(ht) >= 150 && String.to_integer(ht) <= 193) ||
      (ut === "in" && String.to_integer(ht) >= 59 && String.to_integer(ht) <= 76)
  end

  defp hcl_valid?(hcl), do: hcl_valid?(String.split(hcl, "#"), :c)
  defp hcl_valid?(["", hcl], :c) do
    hcl
    |> String.to_charlist()
    |> Enum.all?(fn x ->
      (x >= '0' |> hd && x <= '9' |> hd) || (x >= 'a' |> hd && x <= 'f' |> hd)
    end)
  end
  defp hcl_valid?([_, _hcl], _), do: false
  defp hcl_valid?([_hcl], _), do: false

  defp ecl_valid?(ecl) do
    ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
    |> Enum.any?(fn x -> x === ecl end)
  end

  defp pid_valid?(pid) do
    String.length(pid) === 9 &&
      pid |> String.to_charlist() |> Enum.all?(fn x -> x >= '0' |> hd && x <= '9' |> hd end)
  end

  defp compulsory_keys, do: ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
end
