class Plane

  def initialize
    @status = "flying"
  end

  def status
    @status
  end

  def take_off
    @status = "flying"
  end

  def land_at(airport)
    @status = "landed"
    airport.receive(self)
  end

end