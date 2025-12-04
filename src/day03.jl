module Day03

testStr = """
987654321111111
811111111111119
234234234234278
818181911112111
"""

function joltageFromTwo(bank::SubString{String})
  if length(bank) == 0
    return 0
  end

  tensIndex = -1
  onesIndex = -1

  for i ∈ 9:-1:1
    place = findfirst(Char('0' + i), bank[1:end-1])
    if !isnothing(place)
      tensIndex = place
      break
    end
  end

  for i ∈ 9:-1:1
    place = findfirst(Char('0' + i), bank[tensIndex+1:end])
    if !isnothing(place)
      onesIndex = place + tensIndex
      break
    end
  end

  parse(Int, bank[tensIndex]) * 10 + parse(Int, bank[onesIndex])
end

function day03(input::String)
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
  joltages = split(input, "\n")
  sum(map(joltageFromTwo, joltages))
end

function part2(input::String)

end


end