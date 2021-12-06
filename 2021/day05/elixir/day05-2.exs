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

  def points(line)

  def points({{x1, y}, {x2, y}} = _line) do
    Enum.map(x1..x2, &{&1, y})
  end

  def points({{x, y1}, {x, y2}} = _line) do
    Enum.map(y1..y2, &{x, &1})
  end

  def points({{x1, y1}, {x2, y2}} = _line) do
    xd = if x1 < x2, do: 1, else: -1
    yd = if y1 < y2, do: 1, else: -1

    Enum.map(0..abs(x2 - x1), &{x1 + (&1 * xd) , y1 + (&1 * yd)})
  end
end

# Main entrypoint
alias Grid.Line

File.stream!("../input.txt")
|> Stream.map(&Line.from_string/1)
|> Stream.flat_map(&Line.points/1)
|> Enum.frequencies()
|> Map.filter(fn {_point, count} -> count >= 2 end)
|> Enum.count()
|> IO.puts()
