// Copyright 2025 caozhanhao
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

///|
priv struct Pos {
  mut x : Int
  mut y : Int
} derive(Show)

///|
fn Pos::new(x : Int, y : Int) -> Pos {
  { x, y }
}

///|
impl Eq for Pos with op_equal(p1, p2) {
  p1.x == p2.x && p1.y == p2.y
}

///|
impl Compare for Pos with compare(p1 : Pos, p2 : Pos) {
  if p1.x == p2.x {
    Compare::compare(p1.y, p2.y)
  } else {
    Compare::compare(p1.x, p2.x)
  }
}

///|
impl Hash for Pos with hash_combine(self, hasher : Hasher) {
  hasher.combine(Hash::hash(self.x))
  hasher.combine(Hash::hash(self.y))
}

///|
priv struct PosBox {
  box : Array[Pos]
}

///|
fn PosBox::new() -> PosBox {
  { box: Array::new() }
}

///|
fn PosBox::from_array(arr : Array[Array[Int]]) -> PosBox {
  let box = arr.map(fn(p) { Pos::new(p[0], p[1]) })
  { box, }
}

///|
fn PosBox::add_pos(self : PosBox, p : Pos) -> Unit {
  self.box.push(p)
}

///|
fn PosBox::add_rect(self : PosBox, p1 : Pos, p2 : Pos) -> Unit {
  let min_x = @math.minimum(p1.x, p2.x)
  let min_y = @math.minimum(p1.y, p2.y)
  let max_x = @math.maximum(p1.x, p2.x)
  let max_y = @math.maximum(p1.y, p2.y)
  for x = min_x; x <= max_x; x = x + 1 {
    for y = min_y; y <= max_y; y = y + 1 {
      self.box.push(Pos::new(x, y))
    }
  }
}

///|
fn PosBox::fill(self : PosBox, vec : Array[Array[Bool]]) -> Unit {
  for p in self.box {
    vec[p.x][p.y] = true
  }
}

///|
fn PosBox::fill_data(
  self : PosBox,
  vec : Array[Array[Bool]],
  data : Array[Bool]
) -> Unit {
  for i in 0..<data.length() {
    vec[self.box[i].x][self.box[i].y] = data[i]
  }
}

///|
priv struct PosSet {
  box : Set[Pos]
}

///|
fn PosSet::new() -> PosSet {
  { box: Set::new() }
}

///|
fn PosSet::add_pos(self : PosSet, p : Pos) -> Unit {
  self.box.add(p)
}

///|
fn PosSet::add_rect(self : PosSet, p1 : Pos, p2 : Pos) -> Unit {
  let min_x = @math.minimum(p1.x, p2.x)
  let min_y = @math.minimum(p1.y, p2.y)
  let max_x = @math.maximum(p1.x, p2.x)
  let max_y = @math.maximum(p1.y, p2.y)
  for x = min_x; x <= max_x; x = x + 1 {
    for y = min_y; y <= max_y; y = y + 1 {
      self.box.add(Pos::new(x, y))
    }
  }
}

///|
fn PosSet::contains(self : PosSet, pos : Pos) -> Bool {
  self.box.contains(pos)
}
