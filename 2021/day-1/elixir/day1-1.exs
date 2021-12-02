File.stream!("../input.txt")
|> Enum.reduce({:infinity, 0}, fn
  line, {old_line, acc} ->
    cur_line = line |> String.trim() |> String.to_integer()
    {cur_line, if(cur_line > old_line, do: acc + 1, else: acc)}
end)
|> elem(1)
|> IO.puts()
