# FILENAME = "input_example.txt"
FILENAME = "input.txt"

arr = nil
File.foreach(FILENAME) do |line|
  characters = line.chomp.chars
  arr = Array.new(characters.count) { Hash.new(0) } if arr.nil?
  characters.each_with_index do |char, idx|
    arr[idx][char] += 1
  end
end
letters = arr.map do |column|
  column.sort_by { |k,v| v }.first.first
end
p letters.join
