require "airport"

describe Airport do
  
  let (:airport)  { Airport.new                 }
  let (:plane)    { double :plane, flying: true } 

  def good_weather
    allow(airport).to receive(:is_weather_sunny) { true }
  end

  def bad_weather
    allow(airport).to receive(:is_weather_sunny) { false }
  end

  it "should be able to receive a plane" do
    good_weather
    airport.receive(plane)
    expect(airport.planes).to eq [plane]
  end

  it "should be able to dispatch a plane" do
    plane = double :plane
    good_weather
    airport.receive(plane)
    expect(plane).to receive(:take_off)
    airport.dispatch(plane)
    expect(airport.planes).to eq []
  end

  it "should know when its full" do
    plane = double :plane
    good_weather
    10.times { airport.receive(plane) }
    expect(airport.full?). to eq true 
  end

  it "should raise an error if a plane attempts to land when it is full" do
    plane = double :plane
    good_weather
    10.times { airport.receive(plane) }
    expect{ airport.receive(plane) }.to raise_error("Airport is full. Please come back later!")
    expect(airport.plane_count).to eq 10
  end

  it "should know what the weather is" do
    good_weather
    airport.receive(plane)
  end

  it "should not allow a plane to land if the weather is not sunny" do
    bad_weather
    expect{ airport.receive(plane) }.to raise_error("Weather is not sunny. Please come back later!")
  end


end