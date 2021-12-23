heightmap = File.read('day9.txt').split("\n").map { |line| line.chars.map(&:to_i) }

low_points = []
basins = []

heightmap.each_with_index do |line, line_idx|
  line.each_with_index do |point, point_idx|
    left = point_idx > 0 && heightmap.dig(line_idx, point_idx - 1)
    next if left && left <= point

    right = heightmap.dig(line_idx, point_idx + 1)
    next if right && right <= point

    up = line_idx > 0 && heightmap.dig(line_idx - 1, point_idx)
    next if up && up <= point

    down = heightmap.dig(line_idx + 1, point_idx)
    next if down && down <= point

    low_points << point
  end
end

p 'part1', low_points.sum { |point| point + 1 }