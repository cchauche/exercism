defmodule DateParser do
  @month_names ~w(January February March April May June July August September October November December)

  @day_names ~w(Monday Tuesday Wednesday Thursday Friday Saturday Sunday)

  def day() do
    "\\d{1,2}"
  end

  def month() do
    "[01]{0,1}\\d{1,1}"
  end

  def year() do
    "\\d{4,4}"
  end

  def day_names() do
    "(#{Enum.join(@day_names, "|")})"
  end

  def month_names() do
    "(#{Enum.join(@month_names, "|")})"
  end

  def capture_day() do
    "(?<day>#{day()})"
  end

  def capture_month() do
    "(?<month>#{month()})"
  end

  def capture_year() do
    "(?<year>#{year()})"
  end

  def capture_day_name() do
    "(?<day_name>#{day_names()})"
  end

  def capture_month_name() do
    "(?<month_name>#{month_names()})"
  end

  def capture_numeric_date() do
    "#{capture_day()}/#{capture_month()}/#{capture_year()}"
  end

  def capture_month_name_date() do
    "#{capture_month_name()}\s+#{capture_day()},\s+#{capture_year()}"
  end

  def capture_day_month_name_date() do
    "#{capture_day_name()},\s+#{capture_month_name_date()}"
  end

  def match_numeric_date() do
    ~r/^#{capture_numeric_date()}$/
  end

  def match_month_name_date() do
    ~r/^#{capture_month_name_date()}$/
  end

  def match_day_month_name_date() do
    ~r/^#{capture_day_month_name_date()}$/
  end
end
