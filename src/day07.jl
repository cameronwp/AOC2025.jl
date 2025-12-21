module Day07

testStr = """.......S.......
...............
.......^.......
...............
......^.^......
...............
.....^.^.^.....
...............
....^.^...^....
...............
...^.^...^.^...
...............
..^...^.....^..
...............
.^.^.^.^.^...^.
...............
"""

function day07(input::String)
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
  lines = split(strip(input), "\n")

  line_count = length(lines)
  cells_count = length(lines[1])

  result = copy(lines)

  splits_count = 0

  # lookahead simulation
  for i ∈ 1:line_count-1
    for j ∈ 1:cells_count
      cell = result[i][j]

      if cell == 'S'
        # start condition
        if result[i+1][j] == '.'
          result[i+1] = result[i+1][1:j-1] * '|' * result[i+1][j+1:end]
        end
      elseif cell == '|'
        # light is coming down
        if result[i+1][j] == '.'
          # empty space below
          result[i+1] = result[i+1][1:j-1] * '|' * result[i+1][j+1:end]
        elseif result[i+1][j] == '^'
          # splitter below
          result[i+1] = result[i+1][1:j-2] * '|' * result[i+1][j:end]
          result[i+1] = result[i+1][1:j] * '|' * result[i+1][j+2:end]
          splits_count += 1
        end
      elseif cell == '^'
        # do nothing
      elseif cell == '.'
        # do nothing
      end
    end
  end

  # println(join(result, "\n"))

  splits_count
end

end # module Day07
