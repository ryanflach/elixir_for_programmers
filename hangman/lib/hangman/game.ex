defmodule Hangman.Game do
  defstruct(
    turns_left: 7,
    game_state: :initializing,
    letters: [],
    used: MapSet.new()
  )

  def new_game(word), do: %__MODULE__{letters: word |> String.codepoints()}
  def new_game(), do: new_game(Dictionary.random_word())

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

  defp accept_move(%__MODULE__{} = game, guess, _not_already_guessed) do
    game
    |> Map.put(:used, MapSet.put(game.used, guess))
    |> score_guess(Enum.member?(game.letters, guess))
  end

  defp score_guess(%__MODULE__{} = game, _good_guess = true) do
    new_state =
      game.letters
      |> MapSet.new()
      |> MapSet.subset?(game.used)
      |> maybe_won()

    Map.put(game, :game_state, new_state)
  end

  defp score_guess(%__MODULE__{} = game, _not_good_guess) do
    # PLACEHOLDER - will need to decrement turns left and return appropriate game state
    game
  end

  defp maybe_won(true), do: :won
  defp maybe_won(_), do: :good_guess
end
