# A = Rock
# B = Paper
# C = Scissors

# X = Lost
# Y = Draw
# Z = Win

defmodule Game do
  def round_score({opponent, status}) do
    played = need_to_play(opponent, status)

    round_state_score =
      {opponent, played}
      |> round_state()
      |> round_state_score()

    shape_score = shape_score(played)

    round_state_score + shape_score
  end

  defp need_to_play(shape, status)
       when {shape, status} in [{:paper, :lost}, {:rock, :draw}, {:scissors, :win}],
       do: :rock

  defp need_to_play(shape, status)
       when {shape, status} in [{:scissors, :lost}, {:paper, :draw}, {:rock, :win}],
       do: :paper

  defp need_to_play(shape, status)
       when {shape, status} in [{:rock, :lost}, {:scissors, :draw}, {:paper, :win}],
       do: :scissors

  defp shape_score(:rock), do: 1
  defp shape_score(:paper), do: 2
  defp shape_score(:scissors), do: 3

  defp round_state({shape, shape}), do: :draw
  defp round_state({:rock, :paper}), do: :won
  defp round_state({:paper, :scissors}), do: :won
  defp round_state({:scissors, :rock}), do: :won
  defp round_state({_, _} = _round), do: :lost

  defp round_state_score(:lost), do: 0
  defp round_state_score(:draw), do: 3
  defp round_state_score(:won), do: 6
end

File.stream!("./input.txt")
|> Stream.map(fn <<raw_opponent::8, " ", raw_status::8, "\n">> ->
  opponent =
    case raw_opponent do
      ?A -> :rock
      ?B -> :paper
      ?C -> :scissors
    end

  status =
    case raw_status do
      ?X -> :lost
      ?Y -> :draw
      ?Z -> :win
    end

  Game.round_score({opponent, status})
end)
|> Enum.sum()
|> dbg()
