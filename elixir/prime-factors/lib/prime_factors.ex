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

  defp do_factors_for(number, factor, factors) do
    increment = if factor > 2, do: 2, else: 1

    case rem(number, factor) do
      0 ->
        do_factors_for(div(number, factor), factor, [factor | factors])

      _ ->
        do_factors_for(number, factor + increment, factors)
    end
  end

  def possible_primes(max) do
    do_possible_primes(max, 1, [3, 2])
    |> Enum.reverse()
  end

  defp do_possible_primes(max, i, primes) when i * 6 - 1 > max, do: primes

  defp do_possible_primes(max, i, primes) do
    num = 6 * i
    do_possible_primes(max, i + 1, [num + 1, num - 1 | primes])
  end
end
