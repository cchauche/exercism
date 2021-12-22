defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count([]), do: 0

  def count([_h | t]) do
    1 + count(t)
  end

  @spec reverse(list) :: list
  def reverse(l) do
    do_reverse(l, [])
  end

  defp do_reverse([], reversed), do: reversed

  defp do_reverse([h | t], reversed) do
    do_reverse(t, [h | reversed])
  end

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    l
    |> foldl([], fn el, acc -> [f.(el) | acc] end)
    |> reverse()
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    l
    |> foldl([], fn el, acc -> if f.(el), do: [el | acc], else: acc end)
    |> reverse()
  end

  @type acc :: any
  @spec foldl(list, acc, (any, acc -> acc)) :: acc
  def foldl([], acc, f), do: acc

  def foldl([h | t], acc, f) do
    acc = f.(h, acc)
    foldl(t, acc, f)
  end

  @spec foldr(list, acc, (any, acc -> acc)) :: acc
  def foldr(l, acc, f) do
    l
    |> reverse()
    |> foldl(acc, f)
  end

  @spec append(list, list) :: list
  def append([], b), do: b
  def append(a, []), do: a

  def append([h | t], b) do
    [h | append(t, b)]
  end

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    foldl(ll, [], &append(&2, &1))
  end
end
