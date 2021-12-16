defmodule Username do
  def sanitize([]), do: []

  def sanitize([char | tail]) do
    # ä becomes ae 228
    # ö becomes oe 246
    # ü becomes ue 252
    # ß becomes ss 223

    case char do
      228 ->
        'ae'

      246 ->
        'oe'

      252 ->
        'ue'

      223 ->
        'ss'

      char when (char > 96 and char < 123) or char == 95 ->
        [char]

      _ ->
        ''
    end
    |> Enum.concat(sanitize(tail))
  end
end
