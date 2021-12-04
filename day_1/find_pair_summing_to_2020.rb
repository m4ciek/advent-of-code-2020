#!/usr/bin/env ruby

puts (ARGF.map(&:to_i).combination(3) do |comb|
    break comb.reduce(:*) if comb.sum == 2020
end)