#!/usr/bin/env ruby

EXPECTED = <<-EOF
    byr (Birth Year)
    iyr (Issue Year)
    eyr (Expiration Year)
    hgt (Height)
    hcl (Hair Color)
    ecl (Eye Color)
    pid (Passport ID)
    cid (Country ID)
EOF

REQUIRED_FIELDS_FOR_PART_1 = EXPECTED.split("\n").map do |line| /^[[:space:]]*([^[:space:]]+).*$/.match(line)[1] end - %w(cid)

passports = ARGF.read.split("\n\n").map do |record|
    record.split(/\s/).map do |key_value|
        key_value.partition(':').values_at(0,-1)
    end
end

valid_in_part_1 = passports.count do |passport|
    (REQUIRED_FIELDS_FOR_PART_1 - passport.map(&:first)).empty?
end

puts "part 1: #{valid_in_part_1} valid passports"

#binding.pry