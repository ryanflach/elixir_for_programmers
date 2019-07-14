defmodule TextClient.Interact do
  alias TextClient.{State, Player}

  @hangman_server :"hangman@ryans-air"

  def start() do
    new_game()
    |> setup_state()
    |> Player.play()
  end

  defp setup_state(game_service) do
    %State{
      game_service: game_service,
      tally: Hangman.tally(game_service)
    }
  end

  defp new_game() do
    Node.connect(@hangman_server)
    :rpc.call(@hangman_server, Hangman, :new_game, [])
  end
end
