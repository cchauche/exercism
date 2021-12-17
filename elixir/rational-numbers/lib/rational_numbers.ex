defmodule RationalNumbers do
  @type rational :: {integer, integer}
  import Kernel, except: [abs: 1]

  @doc """
  Add two rational numbers
  """
  @spec add(a :: rational, b :: rational) :: rational
  def add({a1, b1}, {a2, b2}) do
    reduce({a1 * b2 + a2 * b1, b1 * b2})
  end

  @doc """
  Subtract two rational numbers
  """
  @spec subtract(a :: rational, b :: rational) :: rational
  def subtract({a1, b1}, {a2, b2}) do
    reduce({a1 * b2 - a2 * b1, b1 * b2})
  end

  @doc """
  Multiply two rational numbers
  """
  @spec multiply(a :: rational, b :: rational) :: rational
  def multiply({a1, b1}, {a2, b2}) do
    reduce({a1 * a2, b1 * b2})
  end

  @doc """
  Divide two rational numbers
  """
  @spec divide_by(num :: rational, den :: rational) :: rational
  def divide_by({a1, b1}, {a2, b2}) do
    reduce({a1 * b2, a2 * b1})
  end

  @doc """
  Absolute value of a rational number
  """
  @spec abs(a :: rational) :: rational
  def abs({n, d}) do
    {do_abs(n), do_abs(d)}
  end

  defp do_abs(num) when num < 0, do: -1 * num
  defp do_abs(num), do: num

  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(a :: rational, n :: integer) :: rational
  def pow_rational({a, b}, n) when n < 0 do
    n = n * -1
    reduce({b ** n, a ** n})
  end

  def pow_rational({a, b}, n) do
    reduce({a ** n, b ** n})
  end

  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(x :: integer, n :: rational) :: float
  def pow_real(x, {a, b}) do
    x ** (a / b)
  end

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(a :: rational) :: rational
  def reduce({n, d} = r) do
    gcd =
      r
      |> abs()
      |> find_gcd()

    r = abs({div(n, gcd), div(d, gcd)})

    cond do
      n * d >= 0 ->
        r

      true ->
        make_negative(r)
    end
  end

  defp make_negative({n, d}), do: {n * -1, d}

  def find_gcd({0, b}), do: b
  def find_gcd({a, 0}), do: a
  def find_gcd({a, b}) when b > a, do: find_gcd({b, a})
  def find_gcd({a, b}), do: find_gcd({b, a - b})
end
