class RoomDecoder
  def set_lines(lines)
    @lines = lines
  end

  def read_file
    set_lines(File.readlines('input.txt'))
  end

  def check_rooms
    total = @lines.reduce(0) do |sum, line|
      room = Room.new(line)
      sum += room.sector_id if room.valid?
      sum
    end
    puts total
  end
end

class Room
  attr_reader :sector_id
  attr_reader :checksum

  def initialize(encrypted_name)
    @encrypted_name = encrypted_name.gsub(/-/, '')
    @sector_id = Integer(encrypted_name.match(/(\d+)/)[1])
    @checksum  = encrypted_name.match(/\[(.*)\]/)[1]
  end

  def valid?
    @checksum == calculated_checksum
  end

  private

  def calculated_checksum
    letters = @encrypted_name.match(/([a-z]+)/)[1].chars
    letters.
      reduce(Hash.new(0)) { |h, x| h[x] += 1; h  }.
      sort_by { |k, v| [-v, k]  }.
      take(5).
      map(&:first).
      join
  end
end

if __FILE__==$0
  # test_rooms = [
  #   "aaaaa-bbb-z-y-x-123[abxyz]",
  #   "a-b-c-d-e-f-g-h-987[abcde]",
  #   "not-a-real-room-404[oarel]",
  #   "totally-real-room-200[decoy]"
  # ]
  room_decoder = RoomDecoder.new
  # room_decoder.set_lines(test_rooms)
  room_decoder.read_file
  room_decoder.check_rooms
end
