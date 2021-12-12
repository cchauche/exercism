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
  def search({val}, key) when val != key, do: :not_found

  def search(numbers, key) do
    len = tuple_size(numbers)
    mid = div(len, 2)
    val = elem(numbers, mid)

    cond do
      val == key ->
        {:ok, mid}

      val < key ->
        numbers |> Enum.slice(0..(mid - 1)) |> search(key)

      true ->
        numbers |> Enum.slice((mid + 1)..len) |> search(key)
    end
  end
end
