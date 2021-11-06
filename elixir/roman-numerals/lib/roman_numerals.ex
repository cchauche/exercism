defmodule RomanNumerals do
  # @numerals %{ 1000 => "M", 500 => "D", 100 => "C", 50 => "L", 10 =>  }
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(num) when num >= 1000 do
    mult = div(num, 1000)

    String.duplicate("M", mult) <> numeral(num - mult * 1000)
  end

  def numeral(num) when num >= 900 do
    "CM" <> numeral(num - 900)
  end

  def numeral(num) when num >= 500 do
    mult = div(num - 500, 100)

    "D" <> String.duplicate("C", mult) <> numeral(num - 500 - mult * 100)
  end

  def numeral(num) when num >= 400 do
    "CD" <> numeral(num - 400)
  end

  def numeral(num) when num >= 100 do
    mult = div(num, 100)

    String.duplicate("C", mult) <> numeral(num - mult * 100)
  end

  def numeral(num) when num >= 90 do
    "XC" <> numeral(num - 90)
  end

  def numeral(num) when num >= 50 do
    mult = div(num - 50, 10)

    "L" <> String.duplicate("X", mult) <> numeral(num - 50 - mult * 10)
  end

  def numeral(num) when num >= 40 do
    "XL" <> numeral(num - 40)
  end

  def numeral(num) when num >= 10 do
    mult = div(num, 10)

    String.duplicate("X", mult) <> numeral(num - mult * 10)
  end

  def numeral(num) when num >= 9 do
    "IX" <> numeral(num - 9)
  end

  def numeral(num) when num >= 5 do
    mult = div(num - 5, 1)

    "V" <> String.duplicate("I", mult) <> numeral(num - 5 - mult * 1)
  end

  def numeral(num) when num >= 4 do
    "IV" <> numeral(num - 4)
  end

  def numeral(num) when num >= 1 do
    mult = div(num, 1)

    String.duplicate("I", mult) <> numeral(num - mult * 1)
  end

  def numeral(0), do: ""
end

# len - index
