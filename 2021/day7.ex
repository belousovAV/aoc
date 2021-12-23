crabs = File.read!("day7.txt") |> String.split(",") |> Enum.map(&String.to_integer(&1))

{min, max} = Enum.min_max(crabs)

res =
  (min..max)
  |> Enum.map(fn i ->
    {
      i,
      crabs
      |> Enum.map(&(abs(i - &1)))
      |> Enum.sum()
    }
  end)
  |> Enum.min_by(fn {_, steps} -> steps end)

IO.inspect({"part1", res})

res =
  (min..max)
  |> Enum.map(fn i ->
    {
      i,
      crabs
      |> Enum.map(&(abs(i - &1)))
      |> Enum.map(&(&1 * (&1 + 1) / 2))
      |> Enum.sum()
    }
  end)
  |> Enum.min_by(fn {_, steps} -> steps end)

IO.inspect({"part2", res})
