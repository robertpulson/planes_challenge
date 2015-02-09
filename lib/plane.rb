class Plane

  attr_reader :status

  def initialize
    @status = :flying
  end

  def take_off_from(airport)
    airport.dispatch(self)
    @status = :flying
  end

  def land_at(airport)
    airport.receive(self)
    @status = :landed
  end

end