require 'airport'

describe Airport do
  let(:airport)      { Airport.new }
  let(:flying_plane) { double :flying_plane, status: :flying }
  let(:landed_plane) { double :landed_plane, status: :landed }

  def make_good_weather
    allow(airport).to receive(:sunny?).and_return(true)
  end

  def make_bad_weather
    allow(airport).to receive(:sunny?).and_return(false)
  end

  def receive_plane
    make_good_weather
    airport.receive(flying_plane)
  end

  def fill_station
    6.times { receive_plane }
  end

  it 'can receive a plane' do
    receive_plane
    expect(airport.planes).to eq [flying_plane]
  end

  it 'can dispatch a plane' do
    receive_plane
    airport.dispatch(flying_plane)
    expect(airport.planes).to eq []
  end

  it 'knows when its full' do
    fill_station
    expect(airport.full?). to eq true
  end

  it 'raises an error if a plane attempts to land when it is full' do
    fill_station
    expect { airport.receive(flying_plane) }
      .to raise_error('Airport is full. Please come back later!')
  end

  it "won't allow a plane to land if the weather is not sunny" do
    make_bad_weather
    expect { airport.receive(flying_plane) }
      .to raise_error('Weather is not sunny. Please come back later!')
  end

  it "won't allow a plane to take off if the weather is not sunny" do
    make_bad_weather
    expect { airport.dispatch(landed_plane) }
      .to raise_error('Weather is not sunny. Please come back later!')
  end

  it 'all planes can land and all planes can take off' do
    fill_station
    airport.empty_airport
    expect(airport.planes).to eq []
  end
end
