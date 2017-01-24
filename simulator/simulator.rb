class Robot
  attr_accessor :direction 

  def orient(direction)
    raise ArgumentError unless [:east, :west, :north, :south].include? direction
    @direction = direction
  end

  def bearing
    direction
  end

  def turn_right
    case bearing
    when :north
      self.direction = :east
    when :east
      self.direction = :south
    when :south
      self.direction = :west
    when :west
      self.direction = :north 
    end 
  end
end
