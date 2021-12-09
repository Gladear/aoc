crabs =
  File.read!("../input.txt")
  |> String.split([",", "\n"], trim: true)
  |> Enum.map(&String.to_integer/1)

pos =
  # the most effective position is the median
  crabs
  |> Enum.sort()
  |> Enum.at(div(length(crabs), 2))

cost = crabs |> Enum.map(fn crab -> abs(crab - pos) end) |> Enum.sum()

IO.puts(cost)
