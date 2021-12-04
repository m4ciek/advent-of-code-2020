#!/usr/bin/env ruby

matches = ARGF.map do |line|
    s,e,l,pwd = /^(\d+)-(\d+)[[:space:]]+([[:alnum:]]+):[[:space:]]+(.+)$/.match(line).values_at(1,2,3,4)
    [(s.to_i..e.to_i), l, pwd]
end

puts (matches.count do |range, char, pwd|
    range.include?(pwd.count(char))
end)