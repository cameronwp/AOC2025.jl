module Day04

using Printf

testStr = """
..@@.@@@@.
@@@.@.@.@@
@@@@@.@.@@
@.@@@@..@.
@@.@@@@.@@
.@@@@@@@.@
.@.@.@.@@@
@.@@@.@@@@
.@@@@@@@@.
@.@.@@@.@.
"""

macro read_file_as_string(filename)
  # Ensure the argument is a string literal at macro expansion time
  if !isa(filename, AbstractString)
    error("Filename must be a string literal.")
  end

  # Read the file content at macro expansion time
  file_content = read(filename, String)

  # Return the string literal of the file content
  esc(file_content)
end

macro inputToMatrix(input)
  binarified = :(join(replace(rstrip($input), '.' => 0, '@' => 1, '\n' => ';'), ' '))
  eval(Meta.parse(@sprintf("[%s]", eval(binarified))))
end


# @secondAttempt(testin)

function day04(_input::String)
  testMatrix = @inputToMatrix(testStr)
  # display(testMatrix)

  # part1TestSol = part1(testMatrix)
  # println("Part 1 Test: $part1TestSol")

  data = @inputToMatrix(@read_file_as_string("data/day04.txt"))

  part1Sol = part1(data)
  println("Part 1: $part1Sol")

  # part2TestSol = part2(testStr)
  # println("Part 2 Test: $part2TestSol")

  # part2Sol = part2(input)
  # println("Part 2: $part2Sol")
end

function part1(tpMatrix::Matrix{Int64})
  display(tpMatrix)
end

function part2(input::String)
end


end