import argv
import day/day1
import day/day2
import day/day3
//
import day/day5
import gleam/io

pub fn main() {
  case argv.load().arguments {
    ["1"] -> day1.main()
    ["2"] -> day2.main()
    ["3"] -> day3.main()
    ["5"] -> day5.main()
    _ -> io.println("usage: ./adventofgleam <day>")
  }
}
