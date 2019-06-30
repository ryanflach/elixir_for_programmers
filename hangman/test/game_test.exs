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
      assert game = Game.make_move(game, "x")
    end
  end

  test "first occurrence of letter is not already used" do
    game = Game.new_game()
    game = Game.make_move(game, "x")
    refute game.game_state == :already_used
  end

  test "second occurrence of letter is not already used" do
    game = Game.new_game()
    game = Game.make_move(game, "x")
    refute game.game_state == :already_used
    game = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end

  test "a good guess is recognized" do
    game = Game.new_game("test")
    game = Game.make_move(game, "t")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
  end

  test "a guessed word is a won game" do
    game = Game.new_game("test")
    end_game = make_moves(String.codepoints("test"), game)

    assert end_game.game_state == :won
    assert end_game.turns_left == 7
  end

  test "a bad guess is recognized" do
    game = Game.new_game("word")
    game = Game.make_move(game, "x")
    assert game.game_state == :bad_guess
    assert game.turns_left == 6
  end

  test "a bad guess with 1 turn left is a lost game" do
    game = Game.new_game("seventh")
    end_game = make_moves(~w(a b c d f g i), game)

    assert end_game.game_state == :lost
  end

  defp make_moves(moves, game) do
    Enum.reduce(
      moves,
      game,
      fn(letter, game) -> Game.make_move(game, letter) end
    )
  end
end
