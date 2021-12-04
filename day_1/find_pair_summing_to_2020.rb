#!/usr/bin/env ruby

puts (
    ARGF.map(&:to_i).permutation do |p|
        cand = p.each_cons(2).find do |pair|
            pair.sum == 2020
        end
        break cand if cand
    end
).reduce(:*)