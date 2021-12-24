defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    cond do
      a === b ->
        :equal

      sublist?(a, b) ->
        :sublist

      sublist?(b, a) ->
        :superlist

      true ->
        :unequal
    end
  end

  defp sublist?([], [_h | _t]), do: true
  defp sublist?([_h | _t], []), do: false

  defp sublist?(a, b) do
    len = length(a)

    b
    |> Enum.chunk_every(len, 1)
    |> Enum.any?(&(&1 === a))
  end
end
