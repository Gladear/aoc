to_int = fn string -> string |> String.trim() |> String.to_integer() end

File.stream!("../input.txt")
|> Enum.reduce({0, 0, 0}, fn
  "forward " <> x, {pos, depth, aim} ->
    {pos + to_int.(x), depth + to_int.(x) * aim, aim}

  "down " <> x, {pos, depth, aim} ->
    {pos, depth, aim + to_int.(x)}

  "up " <> x, {pos, depth, aim} ->
    {pos, depth, aim - to_int.(x)}
end)
|> then(fn {pos, depth, _aim} -> pos * depth end)
|> IO.puts()
