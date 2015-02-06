require "airport"

describe Airport do
  
  let (:airport)         { Airport.new                            }
  let (:flying_plane)    { double :flying_plane, status: "flying" }
  let (:landed_plane)    { double :landed_plane, status: "landed" }

  def good_weather
    allow(airport).to receive(:is_weather_sunny) { true }
  end

  def bad_weather
    allow(airport).to receive(:is_weather_sunny) { false }
  end

  def fill_airport
    6.times { airport.receive(flying_plane) }
  end

  it "should be able to receive a plane" do
    good_weather
    airport.receive(flying_plane)
    expect(airport.planes).to eq [flying_plane]
  end

  it "should be able to dispatch a plane" do
    good_weather
    airport.receive(flying_plane)
    expect(flying_plane).to receive(:take_off)
    airport.dispatch(flying_plane)
    expect(airport.planes).to eq []
  end

  it "should know when its full" do
    good_weather
    fill_airport
    expect(airport.full?). to eq true 
  end

  it "should raise an error if a plane attempts to land when it is full" do
    good_weather
    fill_airport
    expect{ airport.receive(flying_plane) }.to raise_error("Airport is full. Please come back later!")
    expect(airport.full?).to eq true
  end

  it "should not allow a plane to land if the weather is not sunny" do
    bad_weather
    expect{ airport.receive(flying_plane) }.to raise_error("Weather is not sunny. Please come back later!")
  end

end