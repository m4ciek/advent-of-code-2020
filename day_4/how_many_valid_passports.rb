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

REQUIRED_FIELDS_FOR_PART_1 = EXPECTED.split("\n").map do |line|
  /^[[:space:]]*([^[:space:]]+).*$/.match(line)[1]
end - %w[cid]

passports = ARGF.read.split("\n\n").map do |record|
  record.split(/\s/).map do |key_value|
    key_value.partition(':').values_at(0,-1)
  end
end

# part 1 validation
valid_in_part1 = passports.count do |passport|
  (REQUIRED_FIELDS_FOR_PART_1 - passport.map(&:first)).empty?
end

puts "part 1: #{valid_in_part1} valid passports"

# part 2 is harder (of course)
#
VALIDATORS = {
  :integer_with_range => lambda do |v, range|
    range.include?(Integer(v, 10))
  rescue ArgumentError, TypeError
    false
  end,
  'byr' => ->(v) { VALIDATORS[:integer_with_range][v, 1920..2002] },
  'iyr' => ->(v) { VALIDATORS[:integer_with_range][v, 2010..2020] },
  'eyr' => ->(v) { VALIDATORS[:integer_with_range][v, 2020..2030] },
  'hgt' => lambda do |v|
    match = /^([[:digit:]]+)(in|cm)$/.match(v)
    if match
      VALIDATORS[:integer_with_range][
        match[1],
        case match[2]
        when 'cm'
          150..193
        when 'in'
          59..76
        end
      ]
    end
  end,
  'hcl' => ->(v) { /^#[0-9a-f]{6}$/.match(v) },
  'ecl' => ->(v) { %w[amb blu brn gry grn hzl oth].include?(v) },
  'pid' => ->(v) { v.size == 9 && VALIDATORS[:integer_with_range][v, 0..999_999_999] },
  'cid' => ->(_) { true }
}

REQUIRED_FIELDS_FOR_PART_2 = REQUIRED_FIELDS_FOR_PART_1

# part 2 validation
valid_in_part2 = passports.count do |passport|
  (REQUIRED_FIELDS_FOR_PART_2 - passport.map(&:first)).empty? && passport.all? { |k, v| VALIDATORS.fetch(k)[v] }
end

puts "part 2: #{valid_in_part2} valid passports"