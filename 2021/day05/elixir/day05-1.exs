defmodule Grid.Point do
  def from_string(string) do
    string
    |> String.trim()
    |> String.split(",", parts: 2)
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
  end
end

defmodule Grid.Line do
  alias Grid.Point

  def from_string(line) do
      line
      |> String.split(" -> ")
      |> Enum.map(&Point.from_string/1)
      |> List.to_tuple()
  end

  def horizontal?(line)
  def horizontal?({{_x1, y}, {_x2, y}}), do: true
  def horizontal?(_line), do: false

  def vertical?(line)
  def vertical?({{x, _y1}, {x, _y2}}), do: true
  def vertical?(_line), do: false

  def hor_or_ver?(line) do
    horizontal?(line) or vertical?(line)
  end

  def points(line)
  def points({{x1, y}, {x2, y}} = _line) do
    Enum.map(x1..x2, &({&1, y}))
  end

  def points({{x, y1}, {x, y2}} = _line) do
    Enum.map(y1..y2, &({x, &1}))
  end
end

# Main entrypoint
alias Grid.Line

File.stream!("../input.txt")
|> Stream.map(&Line.from_string/1)
|> Stream.filter(&Line.hor_or_ver?/1)
|> Stream.flat_map(&Line.points/1)
|> Enum.frequencies()
|> Map.filter(fn {_point, count} -> count >= 2 end)
|> Enum.count()
|> IO.puts()
