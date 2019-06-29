defmodule Hangman.Game do
  defstruct(
    turns_left: 7,
    game_state: :initializing,
    letters: [],
    used: MapSet.new()
  )

  def new_game() do
    %__MODULE__{letters: Dictionary.random_word() |> String.codepoints()}
  end

  def make_move(%__MODULE__{game_state: state} = game, _guess) when state in ~w(won lost)a,
    do: {game, tally(game)}

  def make_move(%__MODULE__{} = game, guess) do
    game = accept_move(game, guess, MapSet.member?(game.used, guess))
    {game, tally(game)}
  end

  defp tally(_guess), do: 123

  defp accept_move(%__MODULE__{} = game, guess, _already_guessed = true) do
    game |> Map.put(:game_state, :already_used)
  end

  defp accept_move(%__MODULE__{} = game, guess, _already_guessed) do
    game |> Map.put(:used, MapSet.put(game.used, guess))
  end
end
