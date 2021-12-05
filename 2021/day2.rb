mvs = File.readlines('day2.txt').map { |move| t, v = move.split(' '); [t, v.to_i] }

p 'part1'
p mvs.reduce([0, 0]) { |(h, v), (mt, mv)| mt == 'forward' && [h + mv.to_i, v] || mt == 'up' && [h, v - mv.to_i] || [h, v + mv.to_i] }.reduce(&:*)

p 'part2'
p mvs.reduce([0, 0, 0]) { |(h, v, a), (mt, mv)| mt == 'forward' && [h + mv, v + mv * a, a] || mt == 'up' && [h, v, a - mv] || [h, v, a + mv] }.take(2).reduce(&:*)