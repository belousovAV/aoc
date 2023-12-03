lines = File.readlines(__dir__ + '/day1.txt', chomp: true)

DIGITS = "0".."9"

sum = lines.sum do |line|
  first = line.each_char.find { DIGITS.include? _1 }
  last = line.reverse.each_char.find { DIGITS.include? _1 }
  "#{first}#{last}".to_i
end

p sum

DICT = {
  "0" => 0, 
  "1" => 1, 
  "2" => 2, 
  "3" => 3, 
  "4" => 4, 
  "5" => 5, 
  "6" => 6, 
  "7" => 7, 
  "8" => 8, 
  "9" => 9,
  "zero" => 0, 
  "one" => 1, 
  "two" => 2, 
  "three" => 3, 
  "four" => 4, 
  "five" => 5, 
  "six" => 6, 
  "seven" => 7, 
  "eight" => 8, 
  "nine" => 9,
}.freeze

def find_digit(line, reverse = false)
  acc = []

  line.each_char do |char|
    acc = acc.map { reverse ? char + _1  : _1 + char }
    acc << char
    
    acc.each do
      digit = DICT[_1]
      return digit if digit
    end
  end
end

sum = lines.sum do |line|
  find_digit(line) * 10 + find_digit(line.reverse, true)
end

p sum