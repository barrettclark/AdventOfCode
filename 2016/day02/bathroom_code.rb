class BathroomCode
  KEYPAD = [
    [nil, nil,   1, nil, nil],
    [nil,   2,   3,   4, nil],
    [  5,   6,   7,   8,   9],
    [nil, "A", "B", "C", nil],
    [nil, nil, "D", nil, nil]
  ]

  def initialize
    # start at the 5 on the keypad
    # coordinate is [row index, column index]
    @coordinate = [2, 0]
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
      @code << button(row, column)
    end
    puts code
  end

  private

  def code
    @code.join
  end

  def button(_row, _column)
    KEYPAD[_row][_column]
  end

  def row
    @coordinate[0]
  end

  def column
    @coordinate[1]
  end

  def boundary?(direction)
    case direction
    when "U"; row == 0 || button(row-1, column).nil?
    when "D"; row == 4 || button(row+1, column).nil?
    when "R"; column == 4 || button(row, column+1).nil?
    when "L"; column == 0 || button(row, column-1).nil?
    end
  end

  def up!
    # column + 1
    @coordinate = [row-1, column] unless boundary?("U")
  end

  def down!
    # column - 1
    @coordinate = [row+1, column] unless boundary?("D")
  end

  def right!
    # row + 1
    @coordinate = [row, column+1] unless boundary?("R")
  end

  def left!
    # row - 1
    @coordinate = [row, column-1] unless boundary?("L")
  end
end

if __FILE__==$0
  # input = File.read('instructions_example.txt')
  input = File.read('instructions.txt')
  bathroom_code = BathroomCode.new
  bathroom_code.parse_file(input)
end
