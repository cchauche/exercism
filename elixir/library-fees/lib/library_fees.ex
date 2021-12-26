defmodule LibraryFees do
  @day_seconds 60 * 60 * 24
  def datetime_from_string(string) do
    {:ok, datetime} = NaiveDateTime.from_iso8601(string)

    datetime
  end

  def before_noon?(datetime) do
    Time.compare(datetime, ~T[12:00:00]) == :lt
  end

  def return_date(checkout_datetime) do
    days_to_return = if before_noon?(checkout_datetime), do: 28, else: 29

    checkout_datetime
    |> NaiveDateTime.add(@day_seconds * days_to_return)
    |> NaiveDateTime.to_date()
  end

  def days_late(planned_return_date, actual_return_datetime) do
    Date.diff(actual_return_datetime, planned_return_date)
    |> max(0)
  end

  def monday?(datetime) do
    1 == Date.day_of_week(datetime)
  end

  def calculate_late_fee(checkout, return, rate) do
    checkout = datetime_from_string(checkout)
    return = datetime_from_string(return)

    days =
      checkout
      |> return_date()
      |> days_late(return)

    fee = days * rate

    if monday?(return), do: div(fee, 2), else: fee
  end
end
