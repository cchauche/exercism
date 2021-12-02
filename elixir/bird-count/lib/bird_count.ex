defmodule BirdCount do
  def today([]), do: nil
  def today([today_count | _]), do: today_count

  def increment_day_count([]), do: [1]
  def increment_day_count([today_count | tail]), do: [today_count + 1 | tail]

  def has_day_without_birds?([]), do: false
  def has_day_without_birds?([count | _tail]) when count == 0, do: true
  def has_day_without_birds?([count | tail]), do: has_day_without_birds?(tail)

  def total([]), do: 0
  def total([count | tail]), do: count + total(tail)

  def busy_days([]), do: 0

  def busy_days([count | tail]) do
    cond do
      count >= 5 ->
        1 + busy_days(tail)

      true ->
        busy_days(tail)
    end
  end
end
