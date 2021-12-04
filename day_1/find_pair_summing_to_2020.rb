#!/usr/bin/env ruby

numbers = ARGF.map(&:to_i)

puts ((2..3).map do |pick_n|
    numbers.combination(pick_n) do |comb|
        break "found #{pick_n} numbers that sum to 2020 and multiply to #{comb.reduce(:*)}" if comb.sum == 2020
    end
end.join("\n"))