#!/usr/bin/env ruby

map_width = nil

map = ARGF.map do |line|
    map_width ||= line.size.pred
    line.strip.chars.map.with_index do |chr, idx|
        1 << idx if chr.eql?('#')
    end.compact.reduce(:|)
end

collisions = map.map.with_index.count do |row, idx|
    0 != row & (1 << ((idx*3)%map_width))
end

puts collisions

#binding.pry