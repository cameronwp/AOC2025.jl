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

macro read_file(filename)
  # ensure the argument is a string literal at macro expansion time
  if !isa(filename, AbstractString)
    error("Filename must be a string literal.")
  end

  # read the file content at macro expansion time
  file_content = read(filename, String)

  # return the string literal of the file content
  esc(file_content)
end

macro input_to_matrix(input)
  binarified = :(join(replace(rstrip($input), '.' => 0, '@' => 1, '\n' => ';'), ' '))
  eval(Meta.parse(@sprintf("[%s]", eval(binarified))))
end

function iterate_sliding_window(matrix::Matrix{Int64}, window_rows::Int, window_cols::Int, op::Function)
  rows, cols = size(matrix)

  for i ∈ 1:(rows-window_rows+1)
    for j ∈ 1:(cols-window_cols+1)
      window = @view matrix[i:(i+window_rows-1), j:(j+window_cols-1)]
      op(window)
    end
  end
end

function day04(_input::String)
  testMatrix = @input_to_matrix(testStr)

  part1TestSol = part1(testMatrix)
  println("Part 1 Test: $part1TestSol")

  data = @input_to_matrix(@read_file("data/day04.txt"))

  part1Sol = part1(data)
  println("Part 1: $part1Sol")

  # part2TestSol = part2(testStr)
  # println("Part 2 Test: $part2TestSol")

  # part2Sol = part2(input)
  # println("Part 2: $part2Sol")
end

function count_accessible(submatrix)
  submatrix[5] * (sum(submatrix) < 5 ? 1 : 0)
end

function part1(tpMatrix::Matrix{Int64})
  rows, cols = size(tpMatrix)

  # pad the edge of the matrix with zeros so the iterator below looks at the original edge locations
  padded = zeros(Int, rows + 2, cols + 2)
  padded[2:end-1, 2:end-1] = padded[2:end-1, 2:end-1] .+ tpMatrix

  count = 0

  # iterates through non-edge locations
  iterate_sliding_window(padded, 3, 3, (window) -> count += count_accessible(window))

  count
end

function part2(input::String)
end


end