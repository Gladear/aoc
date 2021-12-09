# inpspired (a lot) from https://github.com/josevalim/aoc/blob/main/2021/day-08.livemd

supersets = fn numbers, pivot ->
  numbers
  |> Enum.find_index(&match?([], pivot -- &1))
  |> then(&List.pop_at(numbers, &1))
end

almost_supersets = fn numbers, pivot ->
  numbers
  |> Enum.find_index(&match?([_], pivot -- &1))
  |> then(&List.pop_at(numbers, &1))
end

File.stream!("../input.txt")
|> Stream.map(fn line ->
  {input, output} =
    line
    |> String.split([" ", " | ", "\n"], trim: true)
    |> Stream.map(&String.to_charlist/1)
    |> Stream.map(&Enum.sort/1)
    |> Enum.split(10)

  %{
    2 => [one],
    3 => [seven],
    4 => [four],
    5 => two_three_five,
    6 => zero_six_nine,
    7 => [eight]
  } = Enum.group_by(input, &length/1)

  {nine, zero_six} = supersets.(zero_six_nine, four)
  {zero, [six]} = supersets.(zero_six, one)

  {three, two_five} = supersets.(two_three_five, seven)
  {five, [two]} = almost_supersets.(two_five, six)

  to_number = fn
    ^zero -> 0
    ^one -> 1
    ^two -> 2
    ^three -> 3
    ^four -> 4
    ^five -> 5
    ^six -> 6
    ^seven -> 7
    ^eight -> 8
    ^nine -> 9
  end

  output
  |> Enum.map(&to_number.(&1))
  |> Integer.undigits()
end)
|> Enum.sum()
|> IO.puts()
