require 'plane'

describe Plane do

  plane = Plane.new

  it "should have a flying status when created" do
    expect(plane.status).to eq "flying"
  end

  it "should be able to take off" do
    plane.take_off
    expect(plane.status).to eq "flying"
  end

  it "should be able to land in an airport" do
    airport = double :airport
    plane.take_off
    expect(plane.status).to eq "flying"
    expect(airport).to receive(:receive).with(plane)
    plane.land_at(airport)
    expect(plane.status).to eq "landed"
  end

end