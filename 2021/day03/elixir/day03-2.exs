defmodule Submarine do
  defp recur([number], _pos, _fun) do
    number
    |> Tuple.to_list()
    |> List.to_integer(2)
  end

  defp recur(numbers, pos, fun) do
    zero_count = Enum.count(numbers, &(elem(&1, pos) == ?0))
    one_count = length(numbers) - zero_count
    to_keep = fun.(zero_count, one_count)
    numbers = Enum.filter(numbers, &(elem(&1, pos) == to_keep))
    recur(numbers, pos + 1, fun)
  end

  def o2(numbers) do
    recur(numbers, 0, fn zero_count, one_count ->
      if one_count >= zero_count, do: ?1, else: ?0
    end)
  end

  def co2(numbers) do
    recur(numbers, 0, fn zero_count, one_count ->
      if zero_count <= one_count, do: ?0, else: ?1
    end)
  end
end


numbers = 
  File.stream!("../input.txt")
  |> Enum.map(&(&1 |> String.trim() |> String.to_charlist() |> List.to_tuple()))

Submarine.o2(numbers) * Submarine.co2(numbers)
|> IO.puts()
