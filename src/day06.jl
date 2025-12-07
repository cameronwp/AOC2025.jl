# IMPORTANT
# DO NOT AUTO FORMAT THIS OR YOU WILL LOSE IMPORTANT TRAILING SPACES IN testStr

module Day06

using Printf

testStr = """123 328  51 64 
 45 64  387 23 
  6 98  215 314
*   +   *   +  """

bracketize(str) = @sprintf("[%s]", str)
space_chars(str) = join(str, ' ')
wrap_operators(str) = replace(str, "*" => "\"*\"", "+" => "\"+\"", "%" => "\"%\"")

"Turn the input string into a matrix with a little string parsing"
function to_matrix(input::String)
  eval(Meta.parse(
    replace(input, '\n' => " ; ", '*' => "\"*\"", '+' => "\"+\"")
    |>
    bracketize
  ))
end

"Turn the input string into a matrix by column. Any whitespace turns into a zero (which will need to be filtered out later). Operations are applied across columns"
function to_cephalopod_vector(input::String)
  vectorized = replace(input,
                 # break columns with ;
                 '\n' => ";",
                 # turn all whitespace into 0s
                 r"\s" => '0',
                 # # spread operations to the following columns
                 # # TODO maybe use a regex instead?
                 "*   " => "*%%%", "+   " => "+%%%",
                 "*  " => "*%%", "+  " => "+%%",
                 "* " => "*%", "+ " => "+%",
               ) |> space_chars |> wrap_operators |> bracketize
  eval(Meta.parse(vectorized))
end

function do_problem(col)
  # turn the problem into lisp-y syntax to solve
  # filter out any zeros because they should be in the input
  op = @sprintf("%s(%s)", col[end], join(filter(x -> x != '0', col[1:end-1]), ','))
  eval(Meta.parse(op))
end

function do_math(operator, operands)
  op = @sprintf("%s(%s)", operator, join(operands, ','))
  eval(Meta.parse(op))
end

function day06(input::String)
  part1TestSol = part1(testStr)
  println("Part 1 Test: $part1TestSol")

  part1Sol = part1(input)
  println("Part 1: $part1Sol")

  part2TestSol = part2(testStr)
  println("Part 2 Test: $part2TestSol")

  part2Sol = part2(input)
  println("Part 2: $part2Sol")
end

function part1(input::String)
  math_problems = to_matrix(input)
  eachcol(math_problems) .|> do_problem |> sum
end

function part2(input::String)
  math_problems = to_cephalopod_vector(input)

  total = 0

  operands::Vector{Int64} = []
  for col ∈ Iterators.reverse(eachcol(math_problems))
    digits = [x for x ∈ col[1:end-1] if x != 0]

    if length(digits) == 0
      continue
    end

    operand = parse(Int, join(digits, ""))

    append!(operands, [operand])

    if col[end] == "+" || col[end] == "*"
      total += do_math(col[end], operands)
      empty!(operands)
    end
  end

  total
end

end