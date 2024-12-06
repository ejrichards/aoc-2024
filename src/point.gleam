pub opaque type Point {
  Point(#(Int, Int))
}

pub fn new(x x: Int, y y: Int) {
  Point(#(x, y))
}

pub fn x(point: Point) {
  let Point(xy) = point
  xy.0
}

pub fn y(point: Point) {
  let Point(xy) = point
  xy.1
}

pub fn get_8way() -> List(fn(Point) -> Point) {
  [
    fn(p) { new(x(p) + 1, y(p)) },
    fn(p) { new(x(p) + 1, y(p) + 1) },
    fn(p) { new(x(p), y(p) + 1) },
    fn(p) { new(x(p) - 1, y(p) + 1) },
    fn(p) { new(x(p) - 1, y(p)) },
    fn(p) { new(x(p) - 1, y(p) - 1) },
    fn(p) { new(x(p), y(p) - 1) },
    fn(p) { new(x(p) + 1, y(p) - 1) },
  ]
}
