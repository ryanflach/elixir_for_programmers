defmodule TextClient.Summary do
  alias TextClient.State

  def display(%State{tally: tally} = game) do
    IO.puts [
      "\n",
      "Word so far: #{Enum.join(tally.letters, " ")}\n",
      "Guesses remaining: #{tally.turns_left}\n",
      "Letters guessed: #{Enum.join(tally.letters_guessed, ", ")}\n"
    ]
    game
  end
end
