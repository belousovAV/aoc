ns = File.read('day3.txt').split("\n").map { |num| num.chars.map(&:to_i) }

tns = ns.transpose
gr = tns.map { |r| r.sum > r.size / 2 ? 1 : 0 }
er = tns.map { |r| r.sum < r.size / 2 ? 1 : 0 }

def ary_to_num(ary)
  ary.reverse.each_with_index.reduce(0) { |s, (n, i)| s + n * 2 ** i }
end

p 'part1'
p ary_to_num(gr) * ary_to_num(er)

def most_popular_bit(ns, bn)
  tns = ns.transpose
  row = tns[bn - 1]
  [row.sum, row.size / 2.0]
end

def find_or(ns)
  i = 0
  loop do
    mpb1, mpb2 = most_popular_bit(ns, i + 1)
    mpb = mpb1 >= mpb2 ? 1 : 0
    ns = ns.select { |n| n[i] == mpb }
    return ns.first if ns.size == 1
    i += 1
  end
end

def find_cr(ns)
  i = 0
  loop do
    mpb1, mpb2 = most_popular_bit(ns, i + 1)
    mpb = mpb1 >= mpb2 ? 0 : 1
    ns = ns.select { |n| n[i] == mpb }
    return ns.first if ns.size == 1
    i += 1
  end
end

p 'part2'
p ary_to_num(find_or(ns)) * ary_to_num(find_cr(ns))