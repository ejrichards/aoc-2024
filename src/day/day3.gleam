import gleam/int
import gleam/io
import gleam/list
import gleam/string
import simplifile

// don't use regex don't use regex don't use regex don't use regex don't use regex
pub fn main() {
  let assert Ok(input) = simplifile.read("inputs/day3.txt")

  part1(input) |> int.to_string |> io.println
}

fn part1(input: String) -> Int {
  // This doesn't seem the most efficient but feels more readable?
  // Would theoretically break this up, but just moving on for now
  string.split(input, "mul(")
  |> list.filter_map(fn(line) {
    case string.split(line, ")") {
      [first, _, ..] -> Ok(first)
      _ -> Error(Nil)
    }
  })
  |> list.filter_map(fn(line) {
    case string.split(line, ",") {
      [first, second] -> Ok(#(first, second))
      _ -> Error(Nil)
    }
  })
  |> list.filter(fn(args) {
    case string.length(args.0), string.length(args.1) {
      a, b if 1 <= a && a <= 3 && 1 <= b && b <= 3 -> True
      _, _ -> False
    }
  })
  |> list.filter_map(fn(args) {
    case int.parse(args.0), int.parse(args.1) {
      Ok(a), Ok(b) -> Ok(a * b)
      _, _ -> Error(Nil)
    }
  })
  |> int.sum
}
