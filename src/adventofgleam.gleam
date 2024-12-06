import argv
import day/day1
import day/day2
import day/day3
import day/day4
import day/day5
// import day/day6
import gleam/io

pub fn main() {
  case argv.load().arguments {
    ["1"] -> day1.main()
    ["2"] -> day2.main()
    ["3"] -> day3.main()
    ["4"] -> day4.main()
    ["5"] -> day5.main()
    // ["6"] -> day6.main()
    _ -> io.println("usage: ./adventofgleam <day>")
  }
}
