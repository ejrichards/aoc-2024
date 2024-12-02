import argv
import day/day1
import gleam/io

pub fn main() {
  case argv.load().arguments {
    ["1"] -> day1.main()
    _ -> io.println("usage: ./adventofgleam <day>")
  }
}
