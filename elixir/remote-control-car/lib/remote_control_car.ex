defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [:nickname, battery_percentage: 100, distance_driven_in_meters: 0]

  def new(nickname \\ "none") do
    %__MODULE__{nickname: nickname}
  end

  def display_distance(%__MODULE__{} = remote_car) do
    meters = remote_car.distance_driven_in_meters
    "#{meters} meters"
  end

  def display_battery(%__MODULE__{} = remote_car) do
    case remote_car.battery_percentage do
      0 ->
        "Battery empty"

      percent ->
        "Battery at #{percent}%"
    end
  end

  def drive(%__MODULE__{battery_percentage: 0} = remote_car), do: remote_car

  def drive(%__MODULE__{} = remote_car) do
    remote_car
    |> Map.update!(:battery_percentage, fn num -> num - 1 end)
    |> Map.update!(:distance_driven_in_meters, fn num -> num + 20 end)
  end
end
