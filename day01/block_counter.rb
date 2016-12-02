class BlockCounter
  attr_reader :blocks_moved

  HEADINGS = {
    :north => "+",
    :east  => "+",
    :south => "-",
    :west  => "-"
  }

  def initialize
    @heading      = :north
    @blocks_moved = 0
  end

  def parse_directions(input)
    @directions = input.split(', ')
  end

  def walk!
    @directions.each { |step| move(step) }
    puts "We walked #{@blocks_moved.abs} blocks"
  end

  private

  def move(step)
    direction, count = parse_step(step)
    set_heading!(direction)
    @blocks_moved = @blocks_moved.send(HEADINGS[@heading], count)
  end

  def set_heading!(direction)
    bearing     = HEADINGS.keys.index(@heading)
    new_bearing = direction == "R" ? bearing + 1 : bearing - 1
    @heading    = HEADINGS.keys[new_bearing%4]
  end

  def parse_step(step)
    steps = step.match(/(\w)(\d+)/)
    [steps[1], Integer(steps[2])]
  end
end

if __FILE__==$0
  block_counter = BlockCounter.new
  # block_counter.parse_directions("R2, L3")
  # block_counter.parse_directions("R2, R2, R2")
  # block_counter.parse_directions("R5, L5, R5, R3")
  input = File.read('input.txt')
  block_counter.parse_directions(input)
  block_counter.walk!
end
