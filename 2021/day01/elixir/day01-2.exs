File.stream!("../input.txt")
|> Stream.map(&String.trim/1)
|> Stream.map(&String.to_integer/1)
|> Stream.chunk_every(3, 1, :discard)
|> Stream.chunk_every(2, 1, :discard)
|> Enum.count(fn [w1, w2] -> Enum.sum(w2) > Enum.sum(w1) end)
|> IO.puts()