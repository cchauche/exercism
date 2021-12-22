defmodule ResistorColorTrio do
  @doc """
  Calculate the resistance value in ohm or kiloohm from resistor colors
  """
  @color_map %{
    black: 0,
    brown: 1,
    red: 2,
    orange: 3,
    yellow: 4,
    green: 5,
    blue: 6,
    violet: 7,
    grey: 8,
    white: 9
  }

  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms}
  def label(colors) do
    [d1, d2, pow] = Enum.map(colors, &Map.get(@color_map, &1))

    ohms = (d1 * 10 + d2) * Integer.pow(10, pow)

    cond do
      ohms >= 1_000 ->
        {div(ohms, 1000), :kiloohms}

      true ->
        {ohms, :ohms}
    end
  end
end
