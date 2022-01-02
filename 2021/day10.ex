lines = File.read!("day10.txt") |> String.split("\n")

defmodule SyntaxScoring do
  @scores %{
    ")" => 3,
    "]" => 57,
    "}" => 1197,
    ">" => 25137
  }

  @incomplete_scores %{
    ")" => 1,
    "]" => 2,
    "}" => 3,
    ">" => 4
  }

  @map %{
    ")" => "(",
    "]" => "[",
    "}" => "{",
    ">" => "<"
  }

  @invert_map Map.new(@map, fn {key, val} -> {val, key} end)

  @open_chars ["(", "[", "{", "<"]
  @close_chars [")", "]", "}", ">"]

  def middle_score(lines) do
    scores =
      lines
      |> Enum.reject(&corrapted_char(&1))
      |> Enum.map(&incomplete_score(&1))
      |> Enum.sort()

    Enum.at(scores, div(length(scores), 2))
  end

  def incomplete_score(line) do
    closing_chars(line)
    |> Enum.reduce(0, fn char, acc ->
      acc * 5 + @incomplete_scores[char]
    end)
  end

  def closing_chars(str), do: closing_chars(String.graphemes(str), [])
  def closing_chars([], acc), do: acc |> Enum.map(&@invert_map[&1])

  def closing_chars([char | tail], acc) when char in @open_chars,
    do: closing_chars(tail, [char | acc])

  def closing_chars([char | _], []) when char in @close_chars, do: []

  def closing_chars([char | tail], [last_char | acc]) do
    if @map[char] == last_char do
      closing_chars(tail, acc)
    else
      []
    end
  end

  def corrapted_score(line) do
    char = corrapted_char(line)
    @scores[char] || 0
  end

  def corrapted_char(str), do: corrapted_char(String.graphemes(str), [])
  def corrapted_char([], _), do: nil

  def corrapted_char([char | tail], acc) when char in @open_chars,
    do: corrapted_char(tail, [char | acc])

  def corrapted_char([char | _], []) when char in @close_chars, do: nil

  def corrapted_char([char | tail], [last_char | acc]) do
    if @map[char] == last_char do
      corrapted_char(tail, acc)
    else
      char
    end
  end
end

IO.inspect({
  "part1",
  Enum.reduce(lines, 0, fn line, score ->
    score + SyntaxScoring.corrapted_score(line)
  end)
})

IO.inspect({
  "part2",
  SyntaxScoring.middle_score(lines)
})
