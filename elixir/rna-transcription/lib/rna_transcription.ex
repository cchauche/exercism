defmodule RnaTranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RnaTranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna([head | tail]) do
    [_to_rna(head) | to_rna(tail)]
  end
  def to_rna([]), do: []

  defp _to_rna(?G), do: ?C
  defp _to_rna(?C), do: ?G
  defp _to_rna(?T), do: ?A
  defp _to_rna(?A), do: ?U
end
