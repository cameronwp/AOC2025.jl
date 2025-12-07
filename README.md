# Advent of Code 2025

Written in Julia as a learning exercise. No external dependencies (yet).

## Usage

1. Enter a Julia REPL
2. `] activate .`
3. `using AOC2025`
4. Then run a function for whatever day you want, e.g., `day01()` will run parts 1 and 2 for day 1 and print the results.

## Development Notes

- Increment the range at the top of `src/AOC2025.jl` every time you add a new day.

## Strategies

- **Day 01**: Algebra
- **Day 02**: Brute force, pattern matching
- **Day 03**: Brute force, pattern matching
- **Day 04**: Sliding windows, trying macros to parse inputs at compile time
- **Day 05**: Interval algebra, use of `eval()` to turn input data into Julia
- **Day 06**: Matrix operations, use of `eval()` to turn input data into Julia