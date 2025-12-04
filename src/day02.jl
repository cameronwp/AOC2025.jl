module Day02

testStr = """
11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124
"""

function day02(input::String)
  part1TestSol = part1(testStr)
  println("Part 1 Test: $part1TestSol")

  part1Sol = part1(input)
  println("Part 1: $part1Sol")

  # part2TestSol = part2(testStr)
  # println("Part 2 Test: $part2TestSol")

  # part2Sol = part2(input)
  # println("Part 2: $part2Sol")
end

strMatch(x, y) = x == y

# repeated N times
function parseInvalidRepeated(productID::Int)
  maybePatternedID = "$productID"
  println("-------------", maybePatternedID, "----------")
  charCount = length(maybePatternedID)
  halfway = round(charCount / 2)

  hasPattern = false

  currPattern = ""

  for i ∈ eachindex(maybePatternedID)
    if i > halfway
      break
    end

    currPattern *= maybePatternedID[i]

    if charCount % i != 0
      continue
    end

    hasPattern = all(
      map(
        idx -> currPattern == maybePatternedID[idx:idx+i-1],
        i+1:i:charCount-i+1
      )
    )

    if hasPattern
      println("^^^")
      break
    end
  end

  hasPattern ? productID : 0
end

# repeated N times
function parseInvalidTwice(productID::Int)
  maybePatternedID = "$productID"
  halfway = Int(round(length(maybePatternedID) / 2))

  firstHalf = maybePatternedID[1:halfway]
  secondHalf = maybePatternedID[halfway+1:end]

  firstHalf == secondHalf ? productID : 0
end

function rangeToIDs(range::SubString{String})
  split(range, "-")
end

function makeRange(firstLast)
  first = parse(Int, firstLast[1])
  last = parse(Int, firstLast[2])
  collect(first:last)
end

function part1(input::String)
  rawRanges = split(input, ",")

  productIDRanges = map(rangeToIDs, rawRanges)

  allProductIds = Iterators.flatten(map(makeRange, productIDRanges))

  sum(map(parseInvalidTwice, allProductIds))
end

function part2(input::String)
end

end