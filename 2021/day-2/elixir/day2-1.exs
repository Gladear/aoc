to_int = fn string -> string |> String.trim() |> String.to_integer() end

File.stream!("../input.txt")
|> Enum.reduce({0, 0}, fn
  "forward " <> x, {pos, depth} -> {pos + to_int.(x), depth}
  "down " <> x, {pos, depth} -> {pos, depth + to_int.(x)}
  "up " <> x, {pos, depth} -> {pos, depth - to_int.(x)}
end)
|> Tuple.product()
|> IO.puts()
