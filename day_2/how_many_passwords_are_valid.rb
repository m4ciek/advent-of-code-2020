#!/usr/bin/env ruby

matches = ARGF.map do |line|
    s,e,l,pwd = /^(\d+)-(\d+)[[:space:]]+([[:alnum:]]+):[[:space:]]+(.+)$/.match(line).values_at(1,2,3,4)
    [(s.to_i..e.to_i), l, pwd]
end

puts 'part one:'
puts (matches.count do |range, char, pwd|
    range.include?(pwd.count(char))
end)

puts 'part two:'
puts (matches.count do |range, char, pwd|
    1 == pwd.chars.values_at(range.begin.pred, range.end.pred).count(char)
end)