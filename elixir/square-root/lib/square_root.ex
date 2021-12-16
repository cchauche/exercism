defmodule SquareRoot do
  @doc """
  Calculate the integer square root of a positive integer
  """
  @spec calculate(radicand :: pos_integer) :: pos_integer
  def calculate(1), do: 1

  def calculate(radicand) do
    find_sqrt(div(radicand, 2), radicand)
  end

  defp find_sqrt(num, radicand) do
    cond do
      num * num == radicand ->
        num

      true ->
        find_sqrt(num - 1, radicand)
    end
  end
end
