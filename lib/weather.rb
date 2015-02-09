module Weather

  WEATHER_ODDS = 10

  def is_weather_sunny?
    !rand(WEATHER_ODDS) == 0
  end

end