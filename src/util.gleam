import gleam/int
import gleam/string

pub fn index_of(list: List(a), any elem: a) -> Result(Int, Nil) {
  index_of_loop(list, elem, 0)
}

fn index_of_loop(list: List(a), elem: a, i: Int) -> Result(Int, Nil) {
  case list {
    [] -> Error(Nil)
    [first, ..] if first == elem -> Ok(i)
    [_, ..rest] -> index_of_loop(rest, elem, i + 1)
  }
}

pub fn unwrap(result: Result(a, e)) -> a {
  case result {
    Ok(v) -> v
    Error(_) -> panic
  }
}

pub fn string_not_empty(string: String) -> Bool {
  !string.is_empty(string)
}

pub fn int_parse_unsafe(string: String) -> Int {
  string |> int.parse |> unwrap
}

pub fn not_empty(list: List(a)) -> Bool {
  list != []
}
