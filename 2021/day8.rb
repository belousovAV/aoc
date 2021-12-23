input = File.readlines('day8.txt').map do |line|
  ten, four = line.split('|')
  {
    ten: ten.split(' ').map(&:strip),
    four: four.split(' ').map(&:strip)
  }
end

res = input.reduce(0) do |acc, line|
  acc + line[:four].count { |digit| [2, 3, 4, 7].include?(digit.size) }
end

p 'part1', res

MAP = {
  0 => 'abcefg'.chars,
  1 => 'cf'.chars,
  2 => 'acdeg'.chars,
  3 => 'acdfg'.chars,
  4 => 'bcdf'.chars,
  5 => 'abdfg'.chars,
  6 => 'abdefg'.chars,
  7 => 'acf'.chars,
  8 => 'abcdefg'.chars,
  9 => 'abcdfg'.chars
}.invert.freeze

input.each do |line|
  line[:ten].map!(&:chars)
  line[:four].map!(&:chars)
end

def find_char_map(ten)
  map = {}

  d1 = ten.find { |d| d.size == 2 }
  d4 = ten.find { |d| d.size == 4 }
  d7 = ten.find { |d| d.size == 3 }
  d8 = ten.find { |d| d.size == 7 }

  ca = (d7 - d1).first
  map[ca] = 'a'

  d6 = ten.find { |d| d.size == 6 && (d1 - d).any? }

  cc = (d8 - d6).first
  map[cc] = 'c'

  cf = (d1 - [cc]).first
  map[cf] = 'f'

  d9 = ten.find { |d| d != d6 && d.size == 6 && (d - d7 - d4).size == 1 }

  cg = (d9 - d7 - d4).first
  map[cg] = 'g'

  d0 = ten.find { |d| d.size == 6 && d != d9 && d != d6 }

  ce = (d0 - d7 - d4 - [cg]).first
  map[ce] = 'e'

  cb = (d0 - [ca, cc, cf, cg, ce]).first
  map[cb] = 'b'

  cd = (d4 - [cb, cc, cf]).first
  map[cd] = 'd'

  map
end

res = input.sum do |line|
  char_map = find_char_map(line[:ten])

  line[:four].reverse.each_with_index.sum do |d, i|
    d = d.map { |c| char_map[c] }.sort

    MAP[d] * 10**i
  end
end

p 'part2', res