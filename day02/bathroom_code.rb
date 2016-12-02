class BathroomCode
  GRID = [
    [-1,  1], # 1
    [ 0,  1], # 2
    [ 1,  1], # 3
    [-1,  0], # 4
    [ 0,  0], # 5
    [ 1,  0], # 6
    [-1, -1], # 7
    [ 0, -1], # 8
    [ 1, -1]  # 9
  ]

  def initialize
    @coordinate = [0, 0]
    @code = []
  end

  def parse_file(input)
    @lines = input.split(/\n/)
    @lines.each do |line|
      line.chars.each do |direction|
        case direction
        when "U"; up!
        when "D"; down!
        when "L"; left!
        when "R"; right!
        end
      end
      @code << GRID.index(@coordinate) + 1
    end
    p @code.join
  end

  private

  def x
    @coordinate[0]
  end

  def y
    @coordinate[1]
  end

  def up!
    # Y + 1
    @coordinate = [x, y+1] unless y == 1
  end

  def down!
    # Y - 1
    @coordinate = [x, y-1] unless y == -1
  end

  def right!
    # X + 1
    @coordinate = [x+1, y] unless x == 1
  end

  def left!
    # X - 1
    @coordinate = [x-1, y] unless x == -1
  end
end

if __FILE__==$0
  # input = File.read('instructions_example.txt')
  input = File.read('instructions.txt')
  bathroom_code = BathroomCode.new
  bathroom_code.parse_file(input)
end
