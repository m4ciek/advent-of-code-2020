#!/usr/bin/env ruby

map_width = nil

map = ARGF.map do |line|
    map_width ||= line.size.pred
    line.strip.chars.map.with_index do |chr, idx|
        1 << idx if chr.eql?('#')
    end.compact.reduce(:|)
end

puts (
    [
        # part 1: shift left by 3 for every increment of 1 downhill
        [
            3,1
        ],
        # part 2: four new cases in addition to the one above
        [
            1,1,
            3,1,
            5,1,
            7,1,
            1,2
        ]
    ].map.with_index do |steps, idx|
        format(
            "part %d: %d collisions",
            idx.succ,
            steps.each_slice(2).map do |pair|
                map.map.with_index.count do |row, idx|
                    h_pos = Rational(*pair) * idx % map_width
                    h_pos.denominator == 1 && 0 != row & 1 << h_pos
                end
            end.reduce(:*)
        )
    end.join("\n")
)