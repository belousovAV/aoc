input = File.read('day4.txt')
boards = input.split("\n\n")
row = boards.shift
row = row.split(',').map(&:to_i)
boards = boards.map { |board| board.split("\n").map { |row| row.split(" ").map(&:to_i) } }

class Game
  attr_accessor :boards

  def initialize(boards)
    @boards = boards.map { |board| Board.new(board) }
  end

  def play_win(row)
    row.each do |num|
      boards.each { |b| b.drawn num }
      wbs = boards.select(&:win?)
      return wbs.map(&:score) if wbs.any?
    end
    wbs
  end

  def play_lose(row)
    row.each do |num|
      boards.each { |b| b.drawn num }
      wbs = boards.select(&:win?)
      self.boards -= wbs
      return wbs.map(&:score) if boards.empty?
    end
    wbs
  end
end

class Board
  attr_reader :board, :drawns, :t_board

  def initialize(board)
    @board = board
    @t_board = board.transpose
    @drawns = []
  end

  def drawn(num)
    drawns << num
  end

  def score
    board.flatten.reject { |num| drawns.include? num }.sum * drawns.last
  end

  def win?
    board.any? { |row| row_match?(row) } ||
      t_board.any? { |row| row_match?(row) }
  end

  private

  def row_match?(row)
    row.all? { |num| drawns.include? num }
  end
end

p 'part1'
p Game.new(boards).play_win(row)

p 'part2'
p Game.new(boards).play_lose(row)