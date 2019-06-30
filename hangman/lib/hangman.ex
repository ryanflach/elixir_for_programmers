defmodule Hangman do
  alias Hangman.Game
  defdelegate new_game(), to: Game
  defdelegate tally(game), to: Game

  @spec make_move(Game.t(), String.t()) :: {Game.t(), map}
  def make_move(game, guess) do
    game = Game.make_move(game, guess)
    {game, tally(game)}
  end
end
