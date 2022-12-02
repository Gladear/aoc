# A = Rock
# B = Paper
# C = Scissors

# X = Rock = 1
# Y = Paper = 2
# Z = Scissors = 3

defmodule Game do
  def round_score({_opponent, played} = round) do
    round_state_score =
      round
      |> round_state()
      |> round_state_score()

    shape_score = shape_score(played)

    round_state_score + shape_score
  end

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
|> Stream.map(fn <<raw_opponent::8, " ", raw_played::8, "\n">> ->
  opponent =
    case raw_opponent do
      ?A -> :rock
      ?B -> :paper
      ?C -> :scissors
    end

  played =
    case raw_played do
      ?X -> :rock
      ?Y -> :paper
      ?Z -> :scissors
    end

  Game.round_score({opponent, played})
end)
|> Enum.sum()
|> dbg()
