fishes = File.read('day6.txt').split(',').map(&:to_i)
fishes = fishes.each_with_object(Hash.new { |h, k| h[k] = 0 }) { |num, acc| acc[num] += 1 }.to_h

def run(init_fishes, days)
  result_fishes = days.times.reduce(init_fishes) do |fishes, _|
    fishes.each_with_object(Hash.new { |h, k| h[k] = 0 }) do |(num, count), acc|
      next acc[num - 1] += count if num > 0

      acc[8] += count
      acc[6] += count
    end
  end

  result_fishes.sum { |_, count| count }
end

p 'part1', run(fishes.dup, 80)
p 'part2', run(fishes.dup, 256)