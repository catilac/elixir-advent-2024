# day2 advent of code 2024

defmodule Safety do
  def count_safe(reports, dampen) do 
    if dampen do
      reports |> Enum.filter(&is_safe_with_dampener/1) |> Enum.count
    else
      reports |> Enum.filter(&is_safe/1) |> Enum.count 
    end
  end

  defp is_safe_with_dampener(report) do
    if is_safe(report) do
      true
    else
      Enum.to_list(0..(Enum.count(report) - 1))
      |> (Enum.map(fn idx -> List.delete_at(report, idx) end))
      |> Enum.any?(&is_safe/1)
    end
  end

  defp is_safe(report) do
    pairs = Enum.zip(report, tl report)

    Enum.all?(pairs, &between_1_and_3/1) and
    (Enum.all?(pairs, &pos?/1) or Enum.all?(pairs, &neg?/1))
  end

  defp between_1_and_3({a, b}) do
    n = abs(a-b)
    1 <= n && n <= 3
  end

  defp pos?({a, b}) do 
    (a-b) > 0
  end

  defp neg?(x) do
    !pos?(x)
  end
end

defmodule Day2 do


  defmodule Part1 do

    def run() do
      {:ok, input} = File.read("input")
      num_safe = Day2.parse_input(input) |> Safety.count_safe(false)
      IO.puts("Number of safe reports: #{num_safe}")
    end

  end

  defmodule Part2 do

    def run() do
      {:ok, input} = File.read("input")
      num_safe = Day2.parse_input(input) |> Safety.count_safe(true)
      IO.puts("Number of safe reports: #{num_safe}")
    end

  end

  # Helpers

  def parse_input(input) do
    String.split(input, "\n") |> Enum.reject(fn line -> String.trim(line) == "" end)
    |> Enum.map(fn line -> line |> String.split |> Enum.map(&String.to_integer/1) end)
  end

end

Day2.Part1.run()
Day2.Part2.run()
