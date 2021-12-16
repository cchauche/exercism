defmodule Username do
  def sanitize([]), do: []

  def sanitize([char | tail]) do
    case char do
      ?ä ->
        'ae'

      ?ö ->
        'oe'

      ?ü ->
        'ue'

      ?ß ->
        'ss'

      ?_ ->
        '_'

      char when char >= ?a and char <= ?z ->
        [char]

      _ ->
        ''
    end
    |> Enum.concat(sanitize(tail))
  end
end
