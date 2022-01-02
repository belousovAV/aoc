lines = File.read!("day10.txt") |> String.split("\n")

defmodule SyntaxScoring do
  @scores %{
    ")" => 3,
    "]" => 57,
    "}" => 1197,
    ">" => 25137
  }

  @map %{
    ")" => "(",
    "]" => "[",
    "}" => "{",
    ">" => "<"
  }

  @open_chars ["(", "[", "{", "<"]
  @close_chars [")", "]", "}", ">"]

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
