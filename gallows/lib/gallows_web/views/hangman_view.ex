defmodule GallowsWeb.HangmanView do
  use GallowsWeb, :view

  import Gallows.Views.Helpers.GameStateHelper

  def new_game_button(conn) do
    button("New Game", to: Routes.hangman_path(conn, :create_game))
  end

  def game_over?(state) when state in ~w(won lost)a, do: true
  def game_over?(_state), do: false

  def word_so_far(tally), do: tally.letters |> Enum.join(" ")

  def letters_guessed(tally), do: tally.letters_guessed |> Enum.join(" ")

  def turn(remaining, target) when target >= remaining, do: "opacity: 1.0"
  def turn(_remaining, _target), do: "opacity: 0.1"
end
