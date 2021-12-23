fishes = File.read('day6.txt').split(',').map(&:to_i)

80.times do
  fishes.size.times do |i|
    next fishes[i] -= 1 if fishes[i] > 0

    fishes[i] = 6
    fishes << 8
  end
end

p 'part1', fishes.size