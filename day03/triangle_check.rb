class TriangleCheck
  def initialize
    @valid_count = 0
  end

  def parse_file
    File.foreach('input.txt').each_slice(3) do |three_lines|
      parse_lines(three_lines)
    end
    puts @valid_count
  end

  def parse_lines(lines)
    matches = lines.map { |line| line.match(/(\d+)\s*(\d+)\s*(\d+)/) }
    1.upto(lines.count) do |i|
      s1, s2, s3 = matches.map { |m| m[i] }
      triangle = Triangle.new(s1, s2, s3)
      @valid_count += 1 if triangle.valid?
    end
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
