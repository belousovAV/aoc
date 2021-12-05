ms = File.readlines('day1.txt').map(&:to_i)

p 'part1'
p ms.each_cons(2).count { |pr, nx| pr < nx }
p 'part2'
p ms.each_cons(3).map(&:sum).each_cons(2).count { |l, r| l < r }