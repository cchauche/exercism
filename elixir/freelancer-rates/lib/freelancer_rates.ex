defmodule FreelancerRates do
  def daily_rate(hourly_rate) do
    8.0 * hourly_rate
  end

  def apply_discount(before_discount, discount) do
    before_discount - before_discount * (discount / 100)
  end

  def monthly_rate(hourly_rate, discount) do
    hourly_rate
    |> daily_rate()
    |> base_monthly_rate()
    |> apply_discount(discount)
    |> Float.ceil()
    |> trunc()
  end

  def days_in_budget(budget, hourly_rate, discount) do
    discounted_day_rate =
      hourly_rate
      |> daily_rate()
      |> apply_discount(discount)

    Float.floor(budget / discounted_day_rate, 1)
  end

  defp base_monthly_rate(daily_rate) do
    22.0 * daily_rate
  end
end
