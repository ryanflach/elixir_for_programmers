defmodule TextClient.Summary do
  alias TextClient.State

  def display(%State{tally: tally} = game) do
    IO.puts [
      "\n",
      "Word so far: #{Enum.join(tally.letters, " ")}\n",
      "Guesses so far: #{tally.turns_left}\n"
    ]
    game
  end
end
