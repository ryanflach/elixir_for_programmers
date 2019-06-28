defmodule Hangman.Game do
  defstruct(
    turns_left: 7,
    game_state: :initializing,
    letters: []
  )

  def new_game() do
    %__MODULE__{letters: Dictionary.random_word() |> String.codepoints()}
  end

  def make_move(%__MODULE__{game_state: state} = game, _guess) when state in ~w(won lost)a,
    do: {game, tally(game)}

  defp tally(_guess), do: 123

end
