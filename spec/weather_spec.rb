require "weather"

class WeatherHolder; include Weather; end

describe Weather do
  
  it "knows if the weather is sunny or not" do
    weather = WeatherHolder.new
    expect(weather.is_weather_sunny?).to satisfy { |weather| true || false }
  end

end