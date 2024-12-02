import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string
import simplifile

pub fn main() {
  let assert Ok(input) = simplifile.read("inputs/day1.txt")

  part1(input) |> int.to_string |> io.println
}

fn part1(input: String) -> Int {
  let #(list1, list2) =
    input
    |> string.split("\n")
    |> list.map(string.split_once(_, "   "))
    |> result.values
    |> list.unzip()

  list.zip(parse_and_sort(list1), parse_and_sort(list2))
  |> list.map(fn(ids) { int.absolute_value(ids.0 - ids.1) })
  |> list.fold(0, int.add)
}

fn parse_and_sort(items: List(String)) -> List(Int) {
  items
  |> list.map(int.parse(_))
  |> result.values
  |> list.sort(int.compare)
}
