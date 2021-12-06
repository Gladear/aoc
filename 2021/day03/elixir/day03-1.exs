# https://stackoverflow.com/questions/23705074/is-there-a-transpose-function-in-elixir
transpose = fn rows ->
  rows
  |> Stream.zip()
  |> Stream.map(&Tuple.to_list/1)
end

cols_one_most_common =
  File.stream!("../input.txt")
  |> Stream.map(&String.trim/1)
  |> Stream.map(&String.split(&1, "", trim: true))
  |> transpose.()
  |> Enum.map(fn col ->
    Enum.count(col, &(&1 == "1")) > div(Enum.count(col), 2)
  end)

gamma =
  cols_one_most_common
  |> Stream.map(&if &1, do: "1", else: "0")
  |> Enum.join()
  |> String.to_integer(2)

epsilon =
  cols_one_most_common
  |> Stream.map(&if &1, do: "0", else: "1")
  |> Enum.join()
  |> String.to_integer(2)

IO.puts(gamma * epsilon)
