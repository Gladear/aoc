File.stream!("../input.txt")
|> Stream.flat_map(fn line ->
  line
  |> String.split([" ", " | ", "\n"], trim: true)
  |> Enum.take(-4)
end)
|> Enum.map(&String.length/1)
|> Enum.count(&(&1 in [2, 4, 3, 7]))
|> IO.puts()
