defmodule GameTest do
  use ExUnit.Case

  alias Hangman.Game

  test "new_game() returns structure" do
    game = Game.new_game()

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0
    assert Enum.all?(game.letters, &String.match?(&1, ~r/[a-z]/))
  end

  test "state isn't changed for :won or :lost game" do
    for state <- ~w(won lost)a do
      game = Game.new_game() |> Map.put(:game_state, state)
      assert {^game, _} = Game.make_move(game, "x")
    end
  end

  test "first occurrence of letter is not already used" do
    game = Game.new_game()
    {game, _tally} = Game.make_move(game, "x")
    refute game.game_state == :already_used
  end

  test "second occurrence of letter is not already used" do
    game = Game.new_game()
    {game, _tally} = Game.make_move(game, "x")
    refute game.game_state == :already_used
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end

  test "a good guess is recognized" do
    game = Game.new_game("test")
    {game, _tally} = Game.make_move(game, "t")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
  end

  test "a guessed word is a won game" do
    game = Game.new_game("test")
    {game, _tally} = Game.make_move(game, "t")
    {game, _tally} = Game.make_move(game, "e")
    {game, _tally} = Game.make_move(game, "s")
    {game, _tally} = Game.make_move(game, "t")
    assert game.game_state == :won
    assert game.turns_left == 7
  end
end
