import gleam/int
import gleam/io
import gleam/list
import gleam/set
import gleam/string
import matrix.{type Matrix}
import point.{type Point}
import simplifile

pub fn main() {
  let assert Ok(input) = simplifile.read("inputs/day4.txt")

  part1(input) |> int.to_string |> io.println
}

fn part1(input: String) -> Int {
  let matrix =
    input
    |> matrix.parse_char_map

  matrix
  |> matrix.find_all_members("X")
  |> set.fold(0, fn(total, point) { total + count_xmas(point, matrix) })
}

fn count_xmas(point: Point, matrix: Matrix(String)) -> Int {
  point.get_8way()
  |> list.count(fn(step) {
    let text = matrix |> matrix.take(point, 4, step) |> string.join("")

    case text {
      "XMAS" -> True
      _ -> False
    }
  })
}
