defmodule TextClient.Interact do
  alias Hangman.Game
  alias TextClient.State

  def start() do
    Game.new_game()
    |> setup_state()
  end

  defp setup_state(%Game{} = game) do
    %State{
      game_service: game,
      tally: Game.tally(game)
    }
  end
end
