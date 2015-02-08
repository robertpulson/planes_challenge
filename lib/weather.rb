module Weather

  def is_weather_sunny?
    return false if rand(10) == 0
    return true
  end

end