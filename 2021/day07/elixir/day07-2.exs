crabs =
  File.read!("../input.txt")
  |> String.split([",", "\n"], trim: true)
  |> Enum.map(&String.to_integer/1)

# This can surely be improved using dichotomy,
# but it already gives the result in less than a second
# so ¯\_(ツ)_/¯
{min, max} = Enum.min_max(crabs)

min..max
|> Enum.map(fn pos ->
  Enum.reduce(crabs, 0, fn crab, acc ->
    move = abs(crab - pos)
    acc + div(move * (move + 1), 2)
  end)
end)
|> Enum.min()
|> IO.puts()
