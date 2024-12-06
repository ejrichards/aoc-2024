import gleam/dict.{type Dict}
import gleam/int
import gleam/io
import gleam/list
import gleam/order.{Gt, Lt}
import gleam/pair
import gleam/set.{type Set}
import gleam/string
import simplifile

pub fn main() {
  let assert Ok(input) = simplifile.read("inputs/day5.txt")

  part1(input) |> int.to_string |> io.println
  part2(input) |> int.to_string |> io.println
}

fn part1(input: String) -> Int {
  let #(invalid_rules, prints) = get_lists(input)

  prints
  |> list.fold(0, fn(total, sequence) {
    case is_valid(sequence, invalid_rules) {
      True -> total + get_middle(sequence)
      False -> total
    }
  })
}

fn part2(input: String) -> Int {
  let #(invalid_rules, prints) = get_lists(input)

  prints
  |> list.fold(0, fn(total, sequence) {
    case is_valid(sequence, invalid_rules) {
      True -> total
      False -> total + { sequence |> rule_sort(invalid_rules) |> get_middle }
    }
  })
}

fn get_lists(input: String) {
  let assert Ok(sections) =
    input
    |> string.split_once("\n\n")

  let invalid_rules =
    sections.0
    |> string.split("\n")
    |> list.map(fn(line) {
      line
      |> string.split_once("|")
      |> unwrap
      |> pair.map_first(int_parse_unsafe)
      |> pair.map_second(int_parse_unsafe)
    })
    |> list.fold(dict.new(), fn(invalid_rules, pair) {
      case dict.get(invalid_rules, pair.1) {
        Ok(rule_list) -> set.insert(rule_list, pair.0)
        Error(_) -> set.insert(set.new(), pair.0)
      }
      |> dict.insert(invalid_rules, pair.1, _)
    })

  let prints =
    sections.1
    |> string.split("\n")
    |> list.filter(string_not_empty)
    |> list.map(fn(line) {
      line
      |> string.split(",")
      |> list.map(int_parse_unsafe)
    })

  #(invalid_rules, prints)
}

fn is_valid(sequence: List(Int), rule_map: Dict(Int, Set(Int))) -> Bool {
  case sequence {
    [current, ..rest] -> {
      case is_valid_page(rest, dict.get(rule_map, current)) {
        True -> is_valid(rest, rule_map)
        False -> False
      }
    }
    [] -> True
  }
}

fn is_valid_page(
  sequence: List(Int),
  invalid_pages: Result(Set(Int), Nil),
) -> Bool {
  case invalid_pages {
    Ok(invalid_rules) -> {
      let found_invalid =
        sequence
        |> list.find(fn(after_page) { set.contains(invalid_rules, after_page) })

      case found_invalid {
        Ok(_) -> False
        Error(_) -> True
      }
    }
    Error(_) -> True
  }
}

fn rule_sort(sequence: List(Int), rule_map: Dict(Int, Set(Int))) -> List(Int) {
  list.sort(sequence, fn(a, b) {
    case dict.get(rule_map, a) {
      Ok(invalid_rules) -> {
        case set.contains(invalid_rules, b) {
          True -> Lt
          False -> Gt
        }
      }
      Error(_) -> Gt
    }
  })
}

fn get_middle(sequence: List(Int)) -> Int {
  sequence |> list.drop(list.length(sequence) / 2) |> list.first |> unwrap
}

fn string_not_empty(string: String) -> Bool {
  !string.is_empty(string)
}

fn int_parse_unsafe(string: String) -> Int {
  string |> int.parse |> unwrap
}

fn unwrap(result: Result(a, e)) -> a {
  case result {
    Ok(v) -> v
    Error(_) -> panic
  }
}
