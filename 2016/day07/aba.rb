# NOTE: This does not yield the correct solution. It's off by 1.
count = 0
File.readlines("input.txt").each do |line|
  abas = line.scan(/([a-z])([a-z])(\1).*(\2\1\2)/i).flatten
  next if abas.empty?
  aba = abas[0..2].join
  bab = abas.last
  supernets = []
  hypernets = []
  arr1 = line.split(/\[/)
  supernets << arr1.shift
  arr1.each do |str|
    hypernet, supernet = str.split(/\]/)
    supernets << supernet
    hypernets << hypernet
  end
  p line
  p supernets
  p hypernets
  supernets.each do |supernet|
    hypernets.each do |hypernet|
      if (hypernet.include?(bab) && supernet.include?(aba)) ||
         (hypernet.include?(aba) && supernet.include?(bab))
        count += 1
        puts "#{hypernet}, #{supernet}, #{aba}, #{bab} *"
      else
        puts "#{hypernet}, #{supernet}, #{aba}, #{bab}"
      end
    end
  end
end
p count
