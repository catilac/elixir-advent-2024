defmodule Day1 do

  defmodule Part1 do

    def run() do
      dist = 
        Day1.read_and_parse_file()
        |> Enum.map(&Enum.sort/1)
        |> total_distance

      IO.puts "Total Distance: #{dist}"
    end

    def total_distance([left, right]) do
      Enum.zip(left, right)
      |> Enum.map(fn {a,b} -> abs(a-b) end)
      |> Enum.sum
    end
  end

  defmodule Part2 do

    def run() do
      score = Day1.read_and_parse_file()
      |> similarity_score

      IO.puts("The similarity score is: #{score}")
    end

    def similarity_score([left, right]) do
      counts = get_counts(right)
      Enum.reduce left, 0, fn n, acc -> acc + n * (Map.get(counts, n) || 0) end
    end

    def get_counts(list) do
      Enum.reduce(list, %{}, fn key, map ->
        elem(Map.get_and_update(map, key, fn curr_val -> {nil, (curr_val || 0) + 1} end), 1)
      end)
    end
  end

  # Helpers
  
  def read_and_parse_file() do
    {:ok, contents} = File.read("input")
      # Get all the lines
    String.split(contents, "\n") 
    |> Enum.reject(fn x -> x == "" end)
    |> Enum.map(&String.split/1)
    |> Enum.map(fn x -> Enum.map(x, &String.to_integer/1) end)
    |> get_two_lists
  end

  def get_two_lists(pairs) do
    Enum.reduce(
      pairs, {[], []}, 
      fn [first, last], {l, r} -> {[first | l], [last | r]} end)
      |> Tuple.to_list
  end

end

Day1.Part1.run()
Day1.Part2.run()
