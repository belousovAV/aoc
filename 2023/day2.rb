Cub = Struct.new(:number, :color)
Set = Struct.new(:cubs)
Game = Struct.new(:id, :sets)

games = File.readlines(__dir__ + "/day2.txt", chomp: true).map do |line|
  game, line = line.split(":")

  id = game[5..-1].to_i
  
  sets = line.split(";").map do |set|
    cubs = set.split(",").map do |cub|
      number, color = cub.split(" ")

      Cub.new(number.to_i, color)
    end

    Set.new(cubs)
  end
  
  Game.new(id, sets)
end

SETUP = {
  "red" => 12,
  "green" => 13,
  "blue" => 14,
}.freeze

sum = games.sum do |game|
  is_valid = game.sets.all? do |set|
    set.cubs.all? do |cub|
      SETUP[cub.color] >= cub.number
    end
  end

  is_valid ? game.id : 0
end

p sum

sum = games.sum do |game|
  setup = {}

  game.sets.each do |set|
    set.cubs.each do |cub|
      setup[cub.color] = [setup[cub.color] || 0, cub.number].max
    end
  end

  setup.each_value.reduce { _1 * _2 }
end

p sum