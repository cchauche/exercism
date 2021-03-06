defmodule SpaceAge do
  @planet_age_factor %{
    mercury: 0.2408467,
    venus: 0.61519726,
    earth: 1.0,
    mars: 1.8808158,
    jupiter: 11.862615,
    saturn: 29.447398,
    uranus: 84.016846,
    neptune: 164.79132
  }

  @earth_year_seconds 31_557_600

  @type planet ::
          :mercury
          | :venus
          | :earth
          | :mars
          | :jupiter
          | :saturn
          | :uranus
          | :neptune

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.
  """
  @spec age_on(planet, pos_integer) :: float
  def age_on(planet, seconds) do
    earth_age = seconds / @earth_year_seconds

    earth_age / @planet_age_factor[planet]
  end
end
