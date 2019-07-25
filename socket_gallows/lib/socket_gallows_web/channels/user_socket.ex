defmodule SocketGallowsWeb.UserSocket do
  use Phoenix.Socket

  ## Channels
  channel "hangman:*", SocketGallowsWeb.HangmanChannel

  def connect(_params, socket, _connect_info) do
    {:ok, socket}
  end

  def id(_socket), do: nil
end
