class RoomDecoder
  attr_reader :valid_rooms

  def initialize
    @valid_rooms = []
    @decoder = Decoder.new
  end

  def set_lines(lines)
    @lines = lines
  end

  def read_file
    set_lines(File.readlines('input.txt'))
  end

  def validate_rooms
    @lines.each do |line|
      room = Room.new(line)
      @valid_rooms << room if room.valid?
    end
  end

  def find_room
    winner = @valid_rooms.find do |room|
      @decoder.room = room
      @decoder.decrypt_name =~ /north/
    end
    p winner
  end

  def sector_id_total
    @valid_rooms.map(&:sector_id).inject(:+)
  end
end

class Decoder
  attr_reader :room

  def initialize
    @letters = ('a'..'z').to_a
  end

  def room=(room)
    @room = room
  end

  def shift_offset
    room.sector_id % @letters.count
  end

  def decrypt_name
    words = @room.encrypted_name.split(/-/).select { |str| str[0] =~ /[a-z]/ }
    decoded = words.map do |word|
      word.chars.map do |char|
        idx = @letters.index(char)
        if idx + shift_offset >= @letters.count
          @letters[idx + shift_offset - @letters.count]
        else
          @letters[idx + shift_offset]
        end
      end.join
    end
    decoded.join(' ')
  end
end

class Room
  attr_reader :sector_id
  attr_reader :checksum
  attr_reader :encrypted_name

  def initialize(encrypted_name)
    @encrypted_name = encrypted_name
    @sector_id      = Integer(encrypted_name.match(/(\d+)/)[1])
    @checksum       = encrypted_name.match(/\[(.*)\]/)[1]
  end

  def valid?
    @checksum == calculated_checksum
  end

  private

  def calculated_checksum
    letters = @encrypted_name.gsub(/-/, '').match(/([a-z]+)/)[1].chars
    letters.
      reduce(Hash.new(0)) { |h, x| h[x] += 1; h  }.
      sort_by { |k, v| [-v, k]  }.
      take(5).
      map(&:first).
      join
  end
end

if __FILE__==$0
  room_decoder = RoomDecoder.new
  room_decoder.read_file
  room_decoder.validate_rooms
  room_decoder.find_room
  puts room_decoder.sector_id_total
end
