defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    base = String.downcase(base)

    Enum.filter(candidates, &(String.downcase(&1) |> anagram?(base)))
  end

  defp anagram?(word, word), do: false

  defp anagram?(word, base), do: sort_letters(word) == sort_letters(base)

  defp(sort_letters(str)) do
    str
    |> String.codepoints()
    |> Enum.sort()
    |> Enum.join()
  end
end
