# defmodule Knapsack do
#   @doc """
#   Return the maximum value that a knapsack can carry.
#   """
#   @spec maximum_value(items :: [%{value: integer, weight: integer}], maximum_weight :: integer) ::
#           integer
#   def maximum_value(items, maximum_weight) do
#     # Build dp table fill with 0s for value
#     dp =
#       for i <- 0..(length(items) - 1),
#           into: %{},
#           do: {i, for(k <- 0..maximum_weight, into: %{}, do: {k, 0})}

#     Enum.with_index(items)
#     |> Enum.reduce(dp, fn {item, row_idx}, dp ->
#       row =
#         dp[row_idx]
#         |> Map.map(fn {col_idx, _val} ->
#           max(
#             take_item(dp, item, row_idx, col_idx),
#             leave_item(dp, row_idx, col_idx)
#           )
#         end)

#       dp
#       |> Map.put(row_idx, row)
#     end)
#     |> get_in([length(items) - 1, maximum_weight])
#   end

#   defp take_item(dp, item, row_idx, col_idx) do
#     case dp[row_idx - 1][col_idx - item.weight] do
#       # nil means too heavy can't take
#       nil ->
#         # In first row if weight allows take item value
#         if col_idx - item.weight >= 0, do: item.value, else: 0

#       val ->
#         item.value + val
#     end
#   end

#   defp leave_item(dp, row_idx, col_idx) do
#     case dp[row_idx - 1][col_idx] do
#       nil ->
#         0

#       val ->
#         val
#     end
#   end
# end

defmodule Knapsack do
  @doc """
  Return the maximum value that a knapsack can carry.
  """
  @spec maximum_value(items :: [%{value: integer, weight: integer}], maximum_weight :: integer) ::
          integer
  def maximum_value([], _), do: 0
  def maximum_value(_, 0), do: 0

  def maximum_value([%{weight: weight} | rest], maximum_weight) when weight > maximum_weight,
    do: maximum_value(rest, maximum_weight)

  def maximum_value([%{value: value, weight: weight} | rest], maximum_weight) do
    max(maximum_value(rest, maximum_weight - weight) + value, maximum_value(rest, maximum_weight))
  end
end
