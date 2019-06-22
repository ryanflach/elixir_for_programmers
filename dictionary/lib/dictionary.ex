defmodule Dictionary do
  def random_word() do
    Enum.random(word_list())
  end

  def word_list() do
    "assets/words.txt"
    |> File.read!
    |> String.split(~r/\n/)
  end
end
