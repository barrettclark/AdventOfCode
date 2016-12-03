class TriangleCheck
  def initialize
    @valid_count = 0
  end

  def parse_file
    File.foreach('input.txt') { |line| parse_line(line) }
    puts @valid_count
  end

  def parse_line(line)
    m = line.match(/(\d+)\s*(\d+)\s*(\d+)/)
    triangle = Triangle.new(m[1], m[2], m[3])
    @valid_count += 1 if triangle.valid?
  end
end

class Triangle
  def initialize(side1, side2, side3)
    @side1 = Integer(side1)
    @side2 = Integer(side2)
    @side3 = Integer(side3)
  end

  def valid?
    two_sides = sorted_sides.take(2).reduce(0) { |sum, length| sum += length }
    two_sides > sorted_sides[2]
  end

  def sorted_sides
    [@side1, @side2, @side3].sort
  end
end

if __FILE__==$0
  triangle_check = TriangleCheck.new
  triangle_check.parse_file
end
