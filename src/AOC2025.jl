# strategy based on
# https://github.com/goggle/AdventOfCode2024.jl/blob/main/src/AdventOfCode2024.jl

module AOC2025

using Printf

days = 1:6

# import code for all days

for day in days
  ds = @sprintf("%02d", day)
  println(ds)
  include(joinpath(@__DIR__, "day$ds.jl"))
end

"Read a txt file"
function readInput(path::String)
  s = open(path, "r") do file
    read(file, String)
  end
  return s
end

"Read input for a day from a file in data/, e.g., data/day01.txt"
function readInput(day::Integer)
  path = joinpath(@__DIR__, "..", "data", @sprintf("day%02d.txt", day))
  return readInput(path)
end

export readInput

# export a function `dayXY` for each day
for d in days
  global ds = @sprintf("day%02d.txt", d)
  global modSymbol = Symbol(@sprintf("Day%02d", d))
  global dsSymbol = Symbol(@sprintf("day%02d", d))

  @eval begin
    input_path = joinpath(@__DIR__, "..", "data", ds)
    function $dsSymbol(input::String=readInput($d))
      return AOC2025.$modSymbol.$dsSymbol(input)
    end
    export $dsSymbol
  end
end

end # module AOC2025
