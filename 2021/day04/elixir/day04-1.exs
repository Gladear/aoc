defmodule Grid do
  def from_2d_list(list) do
    Enum.map(list, fn row ->
      Enum.map(row, fn grid_number ->
        {false, grid_number}
      end)
    end)
  end

  def mark(grid, number) do
    Enum.map(grid, fn row ->
      Enum.map(row, fn
        {true, _n} = cell -> cell
        {false, ^number} -> {true, number}
        {false, _n} = cell -> cell
      end)
    end)
  end

  defp transpose(grid) do
    grid
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  defp are_rows_won?(grid) do
    Enum.any?(grid, fn row ->
      Enum.all?(row, fn {marked, _n} -> marked end)
    end)
  end

  defp are_cols_won?(grid) do
    grid
    |> transpose()
    |> are_rows_won?()
  end

  def is_won(grid) do
    are_rows_won?(grid) or are_cols_won?(grid)
  end

  def score(grid, number) do
    grid
    |> List.flatten()
    |> Enum.reduce(0, fn
      {true, _n}, acc -> acc
      {false, n}, acc -> acc + n
    end)
    |> Kernel.*(number)
  end
end

# read "random" numbers and grids
{_state, numbers, grid_lists} =
  File.stream!("../input.txt")
  |> Enum.reduce({:start, _numbers = [], _grids = []}, fn
    line, {:start, _numbers, grids} ->
      numbers =
        line
        |> String.split(~r/[,\n]/, trim: true)
        |> Enum.map(&String.to_integer/1)

      {:new_grid, numbers, grids}

    "\n", {:new_grid, _numbers, _grids} = acc ->
      acc

    line, {:new_grid, numbers, grids} ->
      line_numbers =
        line
        |> String.split(~r/[ \n]/, trim: true)
        |> Enum.map(&String.to_integer/1)

      {:in_grid, numbers, [[line_numbers] | grids]}

    "\n", {:in_grid, numbers, grids} ->
      {:new_grid, numbers, grids}

    line, {:in_grid, numbers, [last_grid | rest_grids]} ->
      line_numbers =
        line
        |> String.split(~r/[ \n]/, trim: true)
        |> Enum.map(&String.to_integer/1)

      {:in_grid, numbers, [last_grid ++ [line_numbers] | rest_grids]}
  end)

# get grid representation
grids = Enum.map(grid_lists, &Grid.from_2d_list/1)

numbers
|> Enum.reduce(grids, fn
  _number, [] ->
    []

  number, grids ->
    grids = Enum.map(grids, &Grid.mark(&1, number))

    case Enum.find(grids, &Grid.is_won/1) do
      nil ->
        grids

      won_grid ->
        won_grid
        |> Grid.score(number)
        |> IO.puts()

        []
    end
end)
