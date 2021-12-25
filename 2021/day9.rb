class Heightmap
  attr_reader :heightmap, :low_points, :basin_sizes, :basin_map

  def initialize(filename)
    @heightmap = File.read(filename).split("\n").map { |line| line.chars.map(&:to_i) }
    @low_points = []
    @basin_sizes = Hash.new { |h, k| h[k] = 0 }
    @basin_map = {}
  end

  def calc
    heightmap.each_with_index do |line, line_idx|
      line.each_with_index do |point, point_idx|
        detect_low_point(line_idx, point_idx, point)
        detect_basin(line_idx, point_idx, point)
      end
    end
  end

  private

  def detect_basin(line_idx, point_idx, point)
    return if point == 9

    basin_idx_top = basin_map[[line_idx - 1, point_idx]]
    basin_idx_left = basin_map[[line_idx, point_idx - 1]]

    merge_basins(basin_idx_left, basin_idx_top)

    basin_idx = [basin_idx_top, basin_idx_left].compact.min
    basin_idx ||= basin_sizes.size + 1

    basin_sizes[basin_idx] += 1
    basin_map[[line_idx, point_idx]] = basin_idx
  end

  def merge_basins(basin_idx_left, basin_idx_top)
    return unless basin_idx_left && basin_idx_top
    return if basin_idx_left == basin_idx_top

    basin_idx, basin_idx_to_merge = [basin_idx_top, basin_idx_left].sort

    basin_sizes[basin_idx] += basin_sizes[basin_idx_to_merge]
    basin_sizes[basin_idx_to_merge] = 0

    basin_map.transform_values! { |val| val == basin_idx_to_merge ? basin_idx : val }
  end

  def detect_low_point(line_idx, point_idx, point)
    left = point_idx > 0 && heightmap.dig(line_idx, point_idx - 1)
    return if left && left <= point

    right = heightmap.dig(line_idx, point_idx + 1)
    return if right && right <= point

    up = line_idx > 0 && heightmap.dig(line_idx - 1, point_idx)
    return if up && up <= point

    down = heightmap.dig(line_idx + 1, point_idx)
    return if down && down <= point

    low_points << [line_idx, point_idx, point]
  end
end

heightmap = Heightmap.new('day9.txt')
heightmap.calc

p 'part1', heightmap.low_points.sum { |_, _, point| point + 1 }
p 'part2', heightmap.low_points.
  map { |line_idx, point_idx, _| heightmap.basin_map[[line_idx, point_idx]] }.
  map { |basin_idx| heightmap.basin_sizes[basin_idx] }.
  sort.
  reverse.
  take(3).
  reduce(&:*)