defmodule Submarine do
  defp most_common?(col) do
    %{"0" => zero_count, "1" => one_count} = Enum.frequencies(col)
    if zero_count > one_count, do: "0", else: "1"
  end

  defp least_common?(col) do
    %{"0" => zero_count, "1" => one_count} = Enum.frequencies(col)
    if zero_count <= one_count, do: "0", else: "1"
  end

  defp get_col(rows, col_idx) do
    Enum.map(rows, &Enum.at(&1, col_idx))
  end

  defp get_internal(rows, func) do
    0..11
    |> Enum.reduce(_acc = rows, fn
      _col_idx, rows when length(rows) == 1 ->
        rows

      col_idx, rows ->
        determinant =
          rows
          |> get_col(col_idx)
          |> func.()

        Enum.filter(rows, &(Enum.at(&1, col_idx) == determinant))
    end)
    |> Enum.join("")
    |> String.to_integer(2)
  end

  def get(rows, :O2) do
    get_internal(rows, &most_common?/1)
  end

  def get(rows, :CO2) do
    get_internal(rows, &least_common?/1)
  end
end

rows =
  File.stream!("../input.txt")
  |> Stream.map(&String.trim/1)
  |> Enum.map(&String.split(&1, "", trim: true))

o2 = Submarine.get(rows, :O2)
co2 = Submarine.get(rows, :CO2)

IO.puts(o2 * co2)
