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