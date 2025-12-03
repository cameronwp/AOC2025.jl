module Day01

export main

testStr = """
L68
L30
R48
L5
R60
L55
L1
L99
R14
L82
"""

"Day 1"
function day01(input::String)
  part1TestSol = part1(testStr)
  println("Part 1 Test: $part1TestSol")

  part1Sol = part1(input)
  println("Part 1: $part1Sol")

  part2Sol = part2(input)
  println("Part 1: $part2Sol")
end

function part1(input::String)
  hits::Int = 0

  pos::Int = 50

  rotations = split(input, "\n")

  for rotation ∈ rotations
    if rotation == ""
      continue
    end

    @views direction = rotation[1]
    # modulo here because going around more than once is unnecessary
    clicks = parse(Int, rotation[2:end]) % 100

    if direction == 'L'
      pos -= clicks
      if pos < 0
        pos = 100 + pos
      end
    else
      pos += clicks
      pos = pos % 100
    end

    if pos == 0
      hits += 1
    end
  end

  return hits
end

function part2(_input::String)
  return "in progress"
end

end