# Weather module
module Weather
  WEATHER_ODDS = 10

  def sunny?
    !rand(WEATHER_ODDS) == 0
  end
end
