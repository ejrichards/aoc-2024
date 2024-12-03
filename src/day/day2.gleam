import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string
import simplifile

pub fn main() {
  let assert Ok(input) = simplifile.read("inputs/day2.txt")

  part1(input) |> int.to_string |> io.println
}

fn part1(input: String) -> Int {
  get_list(input)
  |> list.fold(0, fn(total, sequence) {
    case is_valid(sequence) {
      True -> total + 1
      False -> total
    }
  })
}

fn get_list(input: String) -> List(List(Int)) {
  input
  |> string.split("\n")
  |> list.map(fn(line) {
    line
    |> string.split(" ")
    |> list.map(int.parse)
    |> result.values
  })
  |> list.filter(not_empty)
}

fn is_valid(sequence: List(Int)) -> Bool {
  case sequence {
    [first, second, ..rest] if first > second ->
      is_valid_loop([second, ..rest], first, fn(a, b) {
        a > b && is_safe_diff(a, b)
      })
    [first, second, ..rest] if first < second ->
      is_valid_loop([second, ..rest], first, fn(a, b) {
        a < b && is_safe_diff(a, b)
      })
    [_, _, ..] -> False
    [] | [_] -> True
  }
}

fn is_valid_loop(
  sequence: List(Int),
  last: Int,
  is_valid_pair: fn(Int, Int) -> Bool,
) -> Bool {
  case sequence {
    [current, ..rest] -> {
      case is_valid_pair(last, current) {
        True -> is_valid_loop(rest, current, is_valid_pair)
        False -> False
      }
    }
    [] -> True
  }
}

fn is_safe_diff(a: Int, b: Int) -> Bool {
  let diff = int.absolute_value(b - a)
  1 <= diff && diff <= 3
}

fn not_empty(list: List(a)) -> Bool {
  list != []
}
