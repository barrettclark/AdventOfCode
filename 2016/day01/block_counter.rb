class BlockCounter
  attr_reader :coordinates_visited

  HEADINGS = {
    :north => "+",
    :east  => "+",
    :south => "-",
    :west  => "-"
  }

  def initialize
    @heading = :north
    @coordinate = [0, 0]
    @coordinates_visited = [@coordinate]
  end

  def blocks_moved
    x, y = @coordinate
    (x + y).abs
  end

  def parse_directions(input)
    @directions = input.split(', ')
  end

  def walk!
    @directions.each { |step| move(step) }
    puts "We walked #{blocks_moved} blocks"
  end

  private

  def move(step)
    direction, count = parse_step(step)
    set_heading!(direction)
    generate_coordinates(count)
  end

  def set_heading!(direction)
    bearing     = HEADINGS.keys.index(@heading)
    new_bearing = direction == "R" ? bearing + 1 : bearing - 1
    @heading    = HEADINGS.keys[new_bearing%4]
  end

  def generate_coordinates(count)
    # coordinates
    x, y = @coordinate
    case @heading
    when :north
      # Y + step
      1.upto(count) { add_coordinate([x, y+=1]) }
    when :south
      # Y - step
      1.upto(count) { add_coordinate([x, y-=1]) }
    when :east
      # X + step
      1.upto(count) { add_coordinate([x+=1, y]) }
    when :west
      # X - step
      1.upto(count) { add_coordinate([x-=1, y]) }
    end
  end

  def add_coordinate(coordinate)
    @coordinate = coordinate
    if @coordinates_visited.include?(@coordinate)
      puts "#{coordinate} #{blocks_moved} blocks away, due #{@heading}"
    end
    @coordinates_visited << coordinate
  end

  def parse_step(step)
    steps = step.match(/(\w)(\d+)/)
    [steps[1], Integer(steps[2])]
  end
end

if __FILE__==$0
  block_counter = BlockCounter.new
  # input = "R2, L3"
  # input = "R2, R2, R2"
  # input = "R5, L5, R5, R3"
  input = File.read('input.txt')
  block_counter.parse_directions(input)
  block_counter.walk!
end
