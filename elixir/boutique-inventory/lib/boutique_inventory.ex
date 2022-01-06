defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    Enum.sort_by(inventory, &{&1.price})
  end

  def with_missing_price(inventory) do
    Enum.filter(inventory, &(&1.price == nil))
  end

  def increase_quantity(item, count) do
    item
    |> Map.update!(
      :quantity_by_size,
      &Map.map(&1, fn {_, qty} -> qty + count end)
    )
  end

  def total_quantity(item) do
    item
    |> Map.get(:quantity_by_size, %{})
    |> Enum.reduce(0, fn {_, qty}, sum -> qty + sum end)
  end
end
