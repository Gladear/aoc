# Couldn't resolve by myself
# https://github.com/josevalim/aoc/blob/main/2021/day-06.livemd#part-2

defmodule Recursion2 do
  def recur({prev0, prev1, prev2, prev3, prev4, prev5, prev6, prev7, prev8}) do
    {prev1, prev2, prev3, prev4, prev5, prev6, prev7 + prev0, prev8, prev0}
  end
end

fishes =
  File.read!("../input.txt")
  |> String.trim()
  |> String.split(",")
  |> Enum.map(&String.to_integer/1)

frequencies = Enum.frequencies(fishes)
amounts = Enum.map(0..8, fn i -> frequencies[i] || 0 end) |> List.to_tuple()

1..256
|> Enum.reduce(amounts, fn _, amounts -> Recursion2.recur(amounts) end)
|> Tuple.sum()
|> IO.puts()
