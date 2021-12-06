import Bitwise

numbers =
  File.stream!("../input.txt")
  |> Enum.map(&(&1 |> String.trim() |> String.to_charlist() |> List.to_tuple()))

[sample | _] = numbers
number_length = tuple_size(sample)
half = numbers |> length() |> div(2)

gamma_as_list =
  for pos <- 0..(number_length - 1) do
    nb_zeroes = Enum.count_until(numbers, &(elem(&1, pos) == ?0), half + 1)
    if nb_zeroes > half, do: ?0, else: ?1
  end

gamma = List.to_integer(gamma_as_list, 2)
epsilon = bnot(gamma) &&& 2 ** number_length - 1

IO.puts(gamma * epsilon)
