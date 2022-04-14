defmodule Minesweeper do
  @mine "*"
  @neighbors [
    {-1, 0},
    {1, 0},
    {0, -1},
    {0, 1},
    {-1, -1},
    {1, 1},
    {-1, 1},
    {1, -1}
  ]
  @doc """
  Annotate empty spots next to mines with the number of mines next to them.
  """
  @spec annotate([String.t()]) :: [String.t()]

  def annotate(board) do
    board
    |> Enum.map(&String.codepoints/1)
    |> Enum.with_index()
    |> Enum.reduce(board, fn {row, row_num}, board ->
      row
      |> Enum.with_index()
      |> Enum.reduce(board, fn
        {"*", _}, board ->
          board

        {_space, col_num}, board ->
          count_surrounding_mines(board, row_num, col_num)
      end)
    end)
  end

  defp count_surrounding_mines(board, row_num, col_num) do
    @neighbors
    |> Enum.reduce(0, fn {row_mod, col_mod}, acc ->
      acc + check_for_mine(board, row_num + row_mod, col_num + col_mod)
    end)
    |> update_mine_count(board, row_num, col_num)
  end

  defp check_for_mine(_board, row_num, col_num) when row_num < 0 or col_num < 0, do: 0

  defp check_for_mine(board, row_num, col_num) do
    with row
         when is_bitstring(row) <- Enum.at(board, row_num),
         @mine <- String.at(row, col_num) do
      1
    else
      _ -> 0
    end
  end

  defp update_mine_count(count, board, row_num, col_num) do
    row =
      board
      |> Enum.at(row_num)
      |> String.codepoints()
      |> List.update_at(
        col_num,
        fn
          " " when count == 0 -> " "
          " " -> "#{count}"
          val -> "#{String.to_integer(val) + count}"
        end
      )
      |> Enum.join()

    board
    |> List.update_at(row_num, fn _ -> row end)
  end
end
