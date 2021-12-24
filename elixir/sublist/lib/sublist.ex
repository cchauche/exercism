defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) when a == b, do: :equal
  # def compare(a, b) when a != b and length(a) == length(b), do: :unequal
  def compare([], [_h | _t]), do: :sublist
  def compare([_h | _t], []), do: :superlist

  def compare(a, b) do
    cond do
      sublist?(a, b) ->
        :sublist

      sublist?(b, a) ->
        :superlist

      true ->
        :unequal
    end
  end

  defp sublist?(a, b) do
    len = length(a)

    b
    |> Enum.chunk_every(len, 1)
    |> Enum.any?(&(&1 === a))
  end
end
