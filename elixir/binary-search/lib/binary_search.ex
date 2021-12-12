defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(numbers, key, lo \\ 0, hi \\ :infinity)
  def search(_, _, lo, hi) when lo > hi, do: :not_found
  def search(numbers, key, lo, :infinity), do: search(numbers, key, lo, tuple_size(numbers) - 1)

  def search(numbers, key, lo, hi) do
    # IO.inspect(numbers, label: "Numbers")
    mid = div(lo + hi, 2)
    val = elem(numbers, mid)
    # IO.inspect("Len: #{len}, Mid: #{mid}, Val: #{val}")

    cond do
      val == key ->
        {:ok, mid}

      key < val ->
        search(numbers, key, lo, mid - 1)

      true ->
        search(numbers, key, mid + 1, hi)
    end
  end
end
