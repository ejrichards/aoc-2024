import argv
import day/day1
import day/day2
import gleam/io

pub fn main() {
  case argv.load().arguments {
    ["1"] -> day1.main()
    ["2"] -> day2.main()
    _ -> io.println("usage: ./adventofgleam <day>")
  }
}
