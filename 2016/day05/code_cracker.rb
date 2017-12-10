require "digest"

door_id = "abc"

i = 3231929

md5 = Digest::MD5.new
md5.update "#{door_id}#{i}"
hash = md5.hexdigest
if (hash =~ /^0{5}/)
  puts hash
end

puts "#{door_id}"
