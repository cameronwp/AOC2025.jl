module Day06

using Printf

testStr = """123 328  51 64
 45 64  387 23
  6 98  215 314
*   +   *   +"""

bracketize(str) = @sprintf("[%s]", str)

"Turn the input string into a matrix with a little string parsing"
function to_matrix(input::String)
  eval(Meta.parse(
    replace(input, '\n' => " ; ", '*' => "\"*\"", '+' => "\"+\"")
    |>
    bracketize
  ))
end

function do_problem(col)
  # turn the problem into lisp-y syntax to solve
  op = @sprintf("%s(%s)", col[end], join(col[1:end-1], ','))
  eval(Meta.parse(op))
end

function day06(input::String)
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
  math_problems = to_matrix(input)
  eachcol(math_problems) .|> do_problem |> sum
end

function part2(input::String)
end

end