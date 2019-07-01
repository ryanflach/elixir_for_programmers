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
    do: game

  def make_move(%__MODULE__{} = game, guess),
    do: accept_move(game, guess, MapSet.member?(game.used, guess))

  def tally(%__MODULE__{} = game) do
    %{
      game_state: game.game_state,
      turns_left: game.turns_left,
      letters: game.letters |> reveal_guessed(game.used),
      letters_guessed: game.used |> reveal_guessed(game.used)
    }
  end

  defp accept_move(%__MODULE__{} = game, _guess, _already_guessed = true) do
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

  defp score_guess(%__MODULE__{turns_left: 1} = game, _not_good_guess) do
    game
    |> Map.put(:game_state, :lost)
  end

  defp score_guess(%__MODULE__{turns_left: turns_left} = game, _not_good_guess) do
    %{
      game |
      turns_left: turns_left - 1,
      game_state: :bad_guess
    }
  end

  defp maybe_won(true), do: :won
  defp maybe_won(_), do: :good_guess

  defp reveal_guessed(letters, letters_used) do
    letters
    |> Enum.map(&reveal_letter(&1, MapSet.member?(letters_used, &1)))
  end

  defp reveal_letter(letter, _in_word = true), do: letter
  defp reveal_letter(_letter, _not_in_word), do: "_"
end
