lines = File.readlines('day5.txt').map { |line| line.split(' -> ').map { |point| point.split(',').map(&:to_i) } }

points = lines.map do |(x1, y1), (x2, y2)|
  if x1 == x2
    y2, y1 = y1, y2 if y1 > y2
    (y1..y2).map { |y| [x1, y] }
  elsif y1 == y2
    x2, x1 = x1, x2 if x1 > x2
    (x1..x2).map { |x| [x, y1] }
  else
    []
  end
end.flatten(1)

p 'part1'
p points.each_with_object(Hash.new { |h, k| h[k] = 0 }) { |point, acc| acc[point] += 1 }.count { |_, v| v > 1 }

points = lines.map do |(x1, y1), (x2, y2)|
  if x1 == x2
    y2, y1 = y1, y2 if y1 > y2
    (y1..y2).map { |y| [x1, y] }
  elsif y1 == y2
    x2, x1 = x1, x2 if x1 > x2
    (x1..x2).map { |x| [x, y1] }
  elsif (x2 - x1).abs == (y2 - y1).abs
    x_step = x1 < x2 ? 1 : -1
    y_step = y1 < y2 ? 1 : -1
    [x1.step(x2, x_step).to_a, y1.step(y2, y_step).to_a].transpose
  else
    []
  end
end.flatten(1)

p 'part2'
p points.each_with_object(Hash.new { |h, k| h[k] = 0 }) { |point, acc| acc[point] += 1 }.count { |_, v| v > 1 }