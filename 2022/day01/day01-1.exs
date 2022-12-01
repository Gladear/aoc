File.stream!("./input.txt")
|> Stream.map(fn
  "\n" -> -1
  line -> line |> String.trim() |> String.to_integer()
end)
|> Stream.chunk_by(&(&1 == -1))
|> Stream.map(&Enum.sum/1)
|> Enum.max()
|> dbg()
