defmodule TextClient.Player do
  alias TextClient.State

  def play(%State{tally: %{game_state: :won}}),
    do: exit_with_message("You won!")

  def play(%State{tally: %{game_state: :lost}}),
    do: exit_with_message("Sorry! You lost!")

  def play(%State{tally: %{game_state: :good_guess}} = game),
    do: continue_with_message("Good guess!", game)

  def play(%State{tally: %{game_state: :bad_guess}} = game),
    do: continue_with_message("Sorry, that isn't in the word.", game)

  def play(%State{tally: %{game_state: :already_used}} = game),
    do: continue_with_message("You've already guessed that.", game)

  def play(game), do: continue(game)

  defp exit_with_message(message) do
    IO.puts(message)
    exit(:normal)
  end

  defp continue_with_message(message, game) do
    IO.puts(message)
    continue(game)
  end

  defp continue(%State{} = game) do
    game
    |> display()
    |> prompt()
    |> make_move()
    |> play()
  end

  defp display(game), do: game
  defp prompt(game), do: game
  defp make_move(game), do: game
end
