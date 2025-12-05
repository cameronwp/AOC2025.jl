module Day05

using Printf

testStr = """3-5
10-14
16-20
12-18

1
5
8
11
17
32"""

split_newlines(str) = split(str, "\n")
bracketize(str) = @sprintf("[%s]", str)
parenthesize(str) = @sprintf("(%s)", str)
commatize(str) = join(str, ",")
dash_to_comma(str) = replace(str, '-' => ',')
atoi(str) = parse(Int, str)

function day05(input::String)
  part1TestSol = part1(testStr)
  println("Part 1 Test: $part1TestSol")

  part1Sol = part1(input)
  println("Part 1: $part1Sol")

  # part2TestSol = part2(testStr)
  # println("Part 2 Test: $part2TestSol")

  # part2Sol = part2(input)
  # println("Part 2: $part2Sol")
end

function part1(input::String)
  raw_intervals, raw_ingredients = split(rstrip(input), "\n\n")
  all_intervals_str = split(raw_intervals, '\n') .|> dash_to_comma .|> parenthesize |> commatize |> bracketize

  all_intervals = eval(Meta.parse(all_intervals_str))
  all_ingredients = split(raw_ingredients, '\n') .|> atoi

  is_fresh(ingredient) = begin
    for (lower, upper) ∈ all_intervals
      if lower <= ingredient <= upper
        return 1
      end
    end
    0
  end

  sum(all_ingredients .|> is_fresh)
end

function part2(input::String)
end


end # module Day05