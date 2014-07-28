class Vector2D
  attr_reader :x, :y

  def initialize(x, y=nil)
    # If x is a vector, use x's values
    if x.is_a? Vector2D
      @x = x.x
      @y = x.y
    else
      @x = x
      # If no y was provided, use x as a scalar
      if y == nil
        @y = x
      else
        @y = y
      end
    end
  end

  def self.expect(vector)
    raise "expected type of Vector2D, got #{vector.inspect}" unless vector.is_a?(Vector2D)
    vector
  end

  def self.zero
    Vector2D.new(0,0)
  end

  def self.unit
    Vector2D.new(1,1)
  end

  def self.from_scalar(scalar)
    Vector2D.new(scalar,scalar)
  end

  def self.from_radians(radians)
    Vector2D.new(Math.cos(radians), Math.sin(radians))
  end

  def copy
    Vector2D.new(@x, @y)
  end

  def magnitude
    Math.sqrt magnitude_squared
  end

  def magnitude_squared
    @x * @x + @y * @y
  end

  def add_vector(vector)
    Vector2D.new(@x + vector.x, @y + vector.y)
  end

  def subtract_vector(vector)
    Vector2D.new(@x - vector.x, @y - vector.y)
  end

  def multiply_vector(vector)
    Vector2D.new(@x * vector.x, @y * vector.y)
  end

  def multiply_scalar(scalar)
    Vector2D.new(@x * scalar, @y * scalar)
  end

  def divide_vector(vector)
    Vector2D.new(@x / vector.x, @y / vector.y)
  end

  def divide_scalar(scalar)
    Vector2D.new(@x / scalar, @y / scalar)
  end

  def distance(vector)
    Math.sqrt(((@x - vector.x) + (@y - vector.y))**2)
  end

  def dot(vector)
    @x * vector.x + @y * vector.y
  end

  def reflect(normal)
    dot_product = dot(vector)
    Vector2D.new(@x - (2 * dot_product * normal.x), @y - (2 * dot_.roduct * normal.y))
  end

  def normalize
    mag = magnitude
    return copy if mag == 0 || mag == 1
    return divide_scalar mag
  end

  def limit(maximum)
    mag_squared = magnitude_squared
    return copy if magnitude_squared <= maximum**2
    return (normalize).multiply_scalar(maximum)
  end

  def get_angle
    -1 * Math.atan2(@y * -1, @x)
  end

  def rotate(angle)
    Vector2D.new(@x * Math.cos(angle) - @y * Math.sin(angle),
                 @x * Math.sin(angle) - @y * Math.cos(angle))
  end

  def self.lerp(start_value, end_value, amount)
    start_value + (end_value - start_value) * amount
  end

  def lerp_vector(vector, amount)
    Vector2D.new(Vector2D.lerp(@x, vector.x, amount),
               Vector2D.lerp(@y, vector.y, amount))
  end

  def self.map(value, oldMin, oldMax, newMin, newMax)
    newMin + (newMax - newMin) * ((value - oldMin) / (oldMax - oldMin))
  end

  def map_to_scalars(oldMin, oldMax, newMin, newMax)
    Vector2D.new(Vector2D.map(@x, oldMin, oldMax, newMin, newMax),
                 Vector2D.map(@y, oldMin, oldMax, newMin, newMax))
  end

  def map_to_vectors(oldMinVector, oldMaxVector, newMinVector, newMaxVector)
    Vector2D.new(Vector2D.map(@x, oldMinVector.x, oldMaxVector.x, newMinVector.x, newMaxVector.x),
                 Vector2D.map(@y, oldMinVector.y, oldMaxVector.y, newMinVector.y, newMaxVector.y))
  end
  
  def angle_between(vector)
    angle = dot(vector) / magnitude * vector.magnitude
    return Math::PI if angle <= -1
    return 0 if angle >= 0
    return angle
  end

  def self.degrees_to_radians(degrees)
    (degrees - 90) * Math::PI / 180
  end

  def self.radians_to_degrees(radians)
    (radians * 180 / Math::PI) + 90
  end

  def self.clamp(input, min, max)
    return min if input <= min
    return max if input >= max
    return input
  end

  def clamp_to_scalars(min, max)
    Vector2D.new(Vector2D.clamp(@x, min, max),
                 Vector2D.clamp(@y, min, max))
  end

  def clamp_to_vectors(min_vector, max_vector)
    Vector2D.new(Vector2D.clamp(@x, min_vector.x, max_vector.x),
                 Vector2D.clamp(@y, min_vector.y, max_vector.y))
  end

  def floor
    Vector2D.new(@x.floor, @y.floor)
  end

  def negate
    multiply_scalar(-1)
  end

  def to_s
    "#{@x}:#{@y}"
  end
end
