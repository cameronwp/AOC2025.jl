using Test

include("../src/day05.jl")

@testset "Day05.clean_intervals()" begin
  # basically a noop
  empty_intervals = convert(Vector{Tuple{Int64,Int64}}, [])
  @test isempty(Day05.clean_intervals(empty_intervals))

  # single
  @test Day05.clean_intervals([(3, 5)]) == [(3, 5)]

  # no overlap
  @test Day05.clean_intervals([(3, 5), (1, 2)]) == [(1, 2), (3, 5)]
  # # no overlap, reversed order
  @test Day05.clean_intervals([(1, 2), (3, 5)]) == [(1, 2), (3, 5)]
  # # lower of second intersects the first
  @test Day05.clean_intervals([(1, 4), (3, 5)]) == [(1, 4), (5, 5)]
  # # upper of second intersects the first
  @test Day05.clean_intervals([(3, 5), (1, 4)]) == [(1, 4), (5, 5)]
  # # second is totally contained in first
  @test Day05.clean_intervals([(3, 5), (4, 4)]) == [(3, 5)]

  # first is totally contained in second. one of the following should be the result
  @test Day05.clean_intervals([(4, 4), (3, 5)]) == [(3, 5)]
  @test Day05.clean_intervals([(3, 4), (2, 5)]) == [(2, 5)]
  @test Day05.clean_intervals([(3, 4), (1, 6)]) == [(1, 6)]

  @test Day05.clean_intervals([(3, 4), (6, 8), (1, 10)]) == [(1, 10)]
  @test Day05.clean_intervals([(10, 20), (1, 11), (9, 21)]) == [(1, 11), (12, 21)]
  @test Day05.clean_intervals([(10, 20), (1, 10), (2, 21)]) == [(1, 10), (11, 21)]
  @test Day05.clean_intervals([(10, 20), (1, 10), (1, 21)]) == [(1, 10), (11, 21)]
  @test Day05.clean_intervals([(10, 20), (1, 10), (1, 20)]) == [(1, 10), (11, 20)]

  @test Day05.clean_intervals([(10, 20), (1, 10), (1, 20), (19, 25)]) == [(1, 10), (11, 20), (21, 25)]
end

@testset "Day05.count_ingredients()" begin
  empty_intervals = convert(Vector{Tuple{Int64,Int64}}, [])
  @test Day05.count_ingredients(empty_intervals) == 0

  @test Day05.count_ingredients([(3, 5)]) == 3
  @test Day05.count_ingredients([(3, 5), (1, 2)]) == 5
  @test Day05.count_ingredients([(1, 10), (11, 21)]) == 21
end
