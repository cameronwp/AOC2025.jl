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

"Turn the contents of a file into a string"
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

"Convert the day's input into a 2x2 matrix where every . is a 0 and every @ is a 1"
macro input_to_matrix(input)
  # the day's input is already super close to being a valid matrix. do a little string parsing then eval it to become an actual matrix
  binarified = :(join(replace(rstrip($input), '.' => 0, '@' => 1, '\n' => ';'), ' '))
  eval(Meta.parse(@sprintf("[%s]", eval(binarified))))
end

"Slide a (window_rows, windows_cols) size window over a 2D matrix and perform `op` on each window"
function iterate_sliding_window(op::Function, matrix::Matrix{Int64}, window_rows::Int, window_cols::Int)
  rows, cols = size(matrix)

  for i ∈ 1:(rows-window_rows+1)
    for j ∈ 1:(cols-window_cols+1)
      window = @view matrix[i:(i+window_rows-1), j:(j+window_cols-1)]
      op(window, i, j)
    end
  end
end

function day04(_input::String)
  # skip the use of the input string because we're using macros to rewrite the day's input data into 2D matrices
  testMatrix = @input_to_matrix(testStr)

  part1TestSol = part1(testMatrix)
  println("Part 1 Test: $part1TestSol")

  data = @input_to_matrix(@read_file("data/day04.txt"))

  part1Sol = part1(data)
  println("Part 1: $part1Sol")

  part2TestSol = part2(testMatrix)
  println("Part 2 Test: $part2TestSol")

  part2Sol = part2(data)
  println("Part 2: $part2Sol")
end

"1 if the toilet paper roll is accessible, 0 if not"
function count_accessible(submatrix)
  submatrix[5] * (sum(submatrix) < 5 ? 1 : 0)
end

function part1(tpMatrix::Matrix{Int64})
  rows, cols = size(tpMatrix)

  # pad the edge of the matrix with zeros so the iterator below looks at the original edge locations
  padded = zeros(Int, rows + 2, cols + 2)
  padded[2:end-1, 2:end-1] = padded[2:end-1, 2:end-1] .+ tpMatrix

  count = 0

  # iterates through a 3x3 window of every non-edge element
  iterate_sliding_window(padded, 3, 3) do window, _row, _col
    count += count_accessible(window)
  end

  count
end

function part2(tpMatrix::Matrix{Int64})
  rows, cols = size(tpMatrix)

  padded = zeros(Int, rows + 2, cols + 2)
  padded[2:end-1, 2:end-1] = padded[2:end-1, 2:end-1] .+ tpMatrix

  to_be_removed = []
  total_removed = 0

  # initialize the removal list
  iterate_sliding_window(padded, 3, 3) do window, i, j
    if count_accessible(window) == 1
      # i, j are the top left of the 3x3 window, we want to remove the center
      append!(to_be_removed, [(i + 1, j + 1)])
    end
  end

  # keep removing TP until there's nothing left to be removed
  while !isempty(to_be_removed)
    total_removed += length(to_be_removed)

    for (row, col) ∈ to_be_removed
      padded[row, col] = 0
    end

    empty!(to_be_removed)

    iterate_sliding_window(padded, 3, 3) do window, i, j
      if count_accessible(window) == 1
        append!(to_be_removed, [(i + 1, j + 1)])
      end
    end
  end

  total_removed
end


end