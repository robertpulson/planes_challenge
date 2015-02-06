require "airport"

describe Airport do
  
  let (:airport)         { Airport.new                                           }
  let (:flying_plane)    { double :flying_plane, status: "flying", take_off: nil }
  let (:landed_plane)    { double :landed_plane, status: "landed"                }

  def good_weather
    allow(airport).to receive(:is_weather_sunny) { true }
  end

  def bad_weather
    allow(airport).to receive(:is_weather_sunny) { false }
  end

  def recieve_plane
    good_weather
    airport.receive(flying_plane)
  end

  it "should be able to receive a plane" do
    recieve_plane
    expect(airport.planes).to eq [flying_plane]
  end

  it "should be able to dispatch a plane" do
    6.times { recieve_plane }
    expect(flying_plane).to receive(:take_off)
    airport.dispatch(flying_plane)
    expect(airport.planes).to eq []
  end

  it "should know when its full" do
    6.times { recieve_plane }
    expect(airport.full?). to eq true 
  end

  it "should raise an error if a plane attempts to land when it is full" do
    6.times { recieve_plane }
    expect{ airport.receive(flying_plane) }.to raise_error("Airport is full. Please come back later!")
  end

  it "should not allow a plane to land if the weather is not sunny" do
    bad_weather
    expect{ airport.receive(flying_plane) }.to raise_error("Weather is not sunny. Please come back later!")
  end

  it 'all planes can land and all planes can take off' do
    6.times { recieve_plane }
    airport.empty_airport
    expect(airport.planes).to eq []
  end

end