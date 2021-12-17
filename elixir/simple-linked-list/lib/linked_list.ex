defmodule LinkedList do
  @opaque t :: tuple()

  @doc """
  Construct a new LinkedList
  """
  @spec new() :: t
  def new(), do: {:empty_list, {}, 0}

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(t, any()) :: t
  def push({val, _tail, size} = list, elem) do
    {elem, list, size + 1}
  end

  @doc """
  Counts the number of elements in a LinkedList
  """
  @spec count(t) :: non_neg_integer()
  def count({_val, _tail, size}), do: size

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(t) :: boolean()
  def empty?({:empty_list, {}, 0}), do: true
  def empty?({_val, _tail, _size}), do: false

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek({:empty_list, {}, 0}), do: {:error, :empty_list}
  def peek({val, _tail, _size}), do: {:ok, val}

  @doc """
  Get tail of a LinkedList
  """
  @spec tail(t) :: {:ok, t} | {:error, :empty_list}
  def tail({:empty_list, {}, 0}), do: {:error, :empty_list}
  def tail({_val, tail, _size}), do: {:ok, tail}

  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(t) :: {:ok, any(), t} | {:error, :empty_list}
  def pop({:empty_list, {}, 0}), do: {:error, :empty_list}
  def pop({val, tail, _size}), do: {:ok, val, tail}

  @doc """
  Construct a LinkedList from a stdlib List
  """
  @spec from_list(list()) :: t
  def from_list([]), do: new()

  def from_list([h | t]) do
    push(from_list(t), h)
  end

  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(t) :: list()
  def to_list({:empty_list, {}, 0}), do: []

  def to_list({val, tail, _size}) do
    [val | to_list(tail)]
  end

  @doc """
  Reverse a LinkedList
  """
  @spec reverse(t) :: t
  def reverse(list), do: do_reverse(new(), list)

  defp do_reverse(reversed, {:empty_list, {}, 0}), do: reversed

  defp do_reverse(reversed, {val, tail, _size}) do
    reversed
    |> push(val)
    |> do_reverse(tail)
  end
end
