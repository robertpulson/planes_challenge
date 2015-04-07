require_relative 'weather'

# Airport Class
class Airport
  include Weather

  DEFAULT_CAPACITY = 6

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
    fail 'Weather is not sunny. Please come back later!' unless sunny?
    fail 'Airport is full. Please come back later!' if full?
    planes << plane
  end

  def planes
    @planes ||= []
  end

  def dispatch(plane)
    fail 'Weather is not sunny. Please come back later!' unless sunny?
    planes.delete(plane)
  end

  def empty_airport
    planes.each { |plane| dispatch(plane) }
  end
end
