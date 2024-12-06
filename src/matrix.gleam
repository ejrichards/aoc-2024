import gleam/dict.{type Dict}
import gleam/list
import gleam/set.{type Set}
import gleam/string
import point.{type Point}
import util

pub opaque type Matrix(member) {
  Matrix(map: Dict(Point, member), flattened: List(member), line_length: Int)
}

fn insert(matrix: Matrix(member), point: Point, member: member) {
  Matrix(
    dict.insert(matrix.map, point, member),
    matrix.flattened,
    matrix.line_length,
  )
}

pub fn parse_char_map(input: String) -> Matrix(String) {
  let lines = input |> string.split("\n")
  let line_length = lines |> list.first |> util.unwrap |> string.length
  let flattened =
    lines
    |> string.join("")
    |> string.to_graphemes

  flattened
  |> list.index_fold(
    Matrix(dict.new(), flattened, line_length),
    fn(map, char, i) {
      insert(map, point.new(i / line_length, i % line_length), char)
    },
  )
}

pub fn find_all_members(matrix: Matrix(member), target: member) -> Set(Point) {
  matrix.flattened
  |> list.index_fold(set.new(), fn(set, char, i) {
    case char == target {
      True ->
        set.insert(
          set,
          point.new(i / matrix.line_length, i % matrix.line_length),
        )
      False -> set
    }
  })
}

pub fn get(matrix: Matrix(member), point: Point) -> Result(member, Nil) {
  dict.get(matrix.map, point)
}

pub fn take(
  matrix: Matrix(a),
  start: Point,
  n: Int,
  step: fn(Point) -> Point,
) -> List(a) {
  take_loop(matrix, start, n, step, [])
}

fn take_loop(
  matrix: Matrix(a),
  point: Point,
  n: Int,
  step: fn(Point) -> Point,
  acc: List(a),
) -> List(a) {
  case n <= 0 {
    True -> list.reverse(acc)
    False ->
      case get(matrix, point) {
        Error(_) -> list.reverse(acc)
        Ok(value) -> take_loop(matrix, step(point), n - 1, step, [value, ..acc])
      }
  }
}
