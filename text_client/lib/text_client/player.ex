defmodule TextClient.Player do
  alias TextClient.{Mover, Prompter, State, Summary}

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

  def play(%State{} = game), do: continue(game)

  defp exit_with_message(message) do
    IO.puts(message)
    exit(:normal)
  end

  defp continue_with_message(message, %State{} = game) do
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

  defp display(%State{} = game), do: Summary.display(game)
  defp prompt(%State{} = game), do: Prompter.accept_move(game)
  defp make_move(%State{} = game), do: Mover.move(game)
end
