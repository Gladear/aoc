fishs =
  File.read!("../input.txt")
  |> String.trim()
  |> String.split(",")
  |> Enum.map(&String.to_integer/1)

1..80
|> Enum.reduce(fishs, fn _, fishs ->
  Enum.flat_map(fishs, fn
    0 -> [6, 8]
    n -> [n - 1]
  end)
end)
|> Enum.count()
|> IO.puts()
