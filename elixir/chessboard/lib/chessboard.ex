defmodule Chessboard do
  def rank_range do
    1..8
  end

  def file_range do
    ?A..?H
  end

  def ranks do
    for i <- rank_range(), do: i
  end

  def files do
    for i <- file_range(), do: to_string([i])
  end
end
