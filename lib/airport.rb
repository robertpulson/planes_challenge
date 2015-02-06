require_relative 'weather'

class Airport

  include Weather

  DEFAULT_CAPACITY = 10

  def initialise
    
  end

  def capacity 
    @capacity ||= DEFAULT_CAPACITY
  end

  def plane_count
    planes.count
  end

  def full?
    planes.count == capacity
  end

  def receive(plane)
    raise "Weather is not sunny. Please come back later!" if is_weather_sunny == false
    raise "Airport is full. Please come back later!" if full? == true
    planes << plane
  end

  def planes
    @planes ||= []
  end

  def dispatch(plane)
    plane.take_off
    planes.delete(plane)
  end

end