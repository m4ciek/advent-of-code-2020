#!/usr/bin/env ruby

numbers = ARGF.map(&:to_i)

puts (numbers.size.times do |i|
    trial, *rest = numbers.rotate(i)
    cand = rest.find do |trial_2|
        break trial_2 if trial + trial_2 == 2020
    end
    break [trial, cand] if cand
end).reduce(:*)