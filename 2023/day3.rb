lines = File.readlines(__dir__ + "/day3.txt", chomp: true).map { "." + _1 + "." }
lines.unshift("." * lines[0].size)
lines.push("." * lines[0].size)

DIGITS = "0".."9"

def digit?(char)
  DIGITS.include?(char)
end

def symbol?(char)
  char != "." && !digit?(char)
end

sum = 0

lines[1..-2].each.with_index(1) do |line, line_idx|
  number_start = nil
  
  line[1..-1].each_char.with_index(1) do |char, char_idx|
    if digit?(char)
      number_start ||= char_idx
      next
    end

    next if number_start.nil?

    left = number_start - 1
    right = char_idx

    is_valid =
      symbol?(lines[line_idx][left]) ||
      symbol?(lines[line_idx][right]) ||
      lines[line_idx - 1][left..right].each_char.any? { symbol?(_1) } ||
      lines[line_idx + 1][left..right].each_char.any? { symbol?(_1) }

    if is_valid
      sum += line[number_start...char_idx].to_i
    end

    number_start = nil
  end
end

p sum

STAR = "*"

def star?(char)
  char == STAR
end

@gears = {}

def store_number(line, col, number)
  pos = [line, col]
  @gears[pos] ||= []
  @gears[pos] << number
end

lines[1..-2].each.with_index(1) do |line, line_idx|
  number_start = nil
  
  line[1..-1].each_char.with_index(1) do |char, char_idx|
    if digit?(char)
      number_start ||= char_idx
      next
    end

    next if number_start.nil?

    left = number_start - 1
    right = char_idx
    number = line[number_start...char_idx].to_i

    if star?(char = lines[line_idx][left])
      store_number(line_idx, left, number)
    end

    if star?(lines[line_idx][right])
      store_number(line_idx, right, number)
    end

    (left..right).each do |idx|
      if star?(lines[line_idx - 1][idx])
        store_number(line_idx - 1, idx, number)
      end

      if star?(lines[line_idx + 1][idx])
        store_number(line_idx + 1, idx, number)
      end
    end

    number_start = nil
  end
end

sum = @gears.each_value.sum do |first_num, second_num|
  next 0 if second_num.nil?

  first_num * second_num
end

p sum