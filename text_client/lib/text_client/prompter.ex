defmodule TextClient.Prompter do
  alias TextClient.State

  def accept_move(%State{} = game) do
    IO.gets("Your guess: ")
    |> check_input(game)
  end

  defp check_input({:error, reason}, _game),
    do: exit_with_reason("Game ended: #{reason}")

  defp check_input(:eof, _game),
    do: exit_with_reason("Looks like you gave up...")

  defp check_input(input, %State{} = game) do
    input = String.trim(input)
    cond do
      String.match?(input, ~r/\A[a-z]\z/) ->
        Map.put(game, :guess, input)
      true ->
        IO.puts "please enter a single lowercase letter"
        accept_move(game)
    end
  end

  defp exit_with_reason(reason) do
    IO.puts reason
    exit(:normal)
  end
end
