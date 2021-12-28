defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number) do
    do_factors_for(number, 2, [])
    |> Enum.reverse()
  end

  defp do_factors_for(1, _factor, factors), do: factors

  # Test factors up to the sqrt of number, if no factors found number is prime
  defp do_factors_for(number, factor, factors) when factor * factor > number,
    do: [number | factors]

  defp do_factors_for(number, factor, factors) do
    increment = if factor > 2, do: 2, else: 1

    case rem(number, factor) do
      0 ->
        do_factors_for(div(number, factor), factor, [factor | factors])

      _ ->
        do_factors_for(number, factor + increment, factors)
    end
  end
end
