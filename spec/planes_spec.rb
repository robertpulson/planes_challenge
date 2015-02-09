require 'plane'

describe Plane do

  let (:plane)      { Plane.new                      }
  let (:airport)    { double :airport, dispatch: nil }

  it "has a flying status when created" do
    expect(plane.status).to eq :flying
  end

  it "can take off" do
    expect(plane).to respond_to(:take_off_from)
  end

  it "changes its status to flying after taking off" do
    plane.take_off_from(airport)
    expect(plane.status).to eq :flying
  end

  it "can land in an airport" do
    expect(airport).to receive(:receive).with(plane)
    plane.land_at(airport)
    expect(plane.status).to eq :landed
  end

end