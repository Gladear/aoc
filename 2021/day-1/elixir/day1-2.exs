File.stream!("../input.txt")
|> Stream.map(&String.trim/1)
|> Stream.map(&String.to_integer/1)
|> then(fn stream ->
  Stream.zip([
    stream,
    Stream.drop(stream, 1),
    Stream.drop(stream, 2)
  ])
end)
|> Enum.reduce({:infinity, 0}, fn
  window, {old_window_sum, acc} ->
    cur_window_sum = Tuple.sum(window)
    {cur_window_sum, if(cur_window_sum > old_window_sum, do: acc + 1, else: acc)}
end)
|> elem(1)
|> IO.puts()
