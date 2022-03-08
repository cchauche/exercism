defmodule CaptainsLog do
  @planetary_classes ["D", "H", "J", "K", "L", "M", "N", "R", "T", "Y"]
  @start_date 41000.0
  @end_date 42000.0
  @registry_range 1000..9999

  def random_planet_class() do
    Enum.random(@planetary_classes)
  end

  def random_ship_registry_number() do
    "NCC-#{Enum.random(@registry_range)}"
  end

  def random_stardate() do
    (@end_date - @start_date) * :rand.uniform() + @start_date
  end

  def format_stardate(stardate) when is_float(stardate) do
    :io_lib.format("~.1f", [stardate])
    |> List.to_string()
  end

  def format_stardate(stardate) when is_integer(stardate), do: raise(ArgumentError)
end
