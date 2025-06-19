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
pub(all) enum ECLevel {
  L
  M
  Q
  H
  AUTO
} derive(Eq)

///|
pub(all) enum Mode {
  NUM
  ALNUM
  BIT8
  KANJI
} derive(Eq)

///|
fn to_ecl(l : Int) -> ECLevel {
  match l {
    0 => ECLevel::L
    1 => ECLevel::M
    2 => ECLevel::Q
    3 => ECLevel::H
    _ => ECLevel::AUTO
  }
}

///|
fn to_mode(l : Int) -> Mode {
  match l {
    0 => Mode::NUM
    1 => Mode::ALNUM
    2 => Mode::BIT8
    3 => Mode::KANJI
    _ => Mode::BIT8
  }
}

///|
impl ToInt for ECLevel with to_int(self : ECLevel) -> Int {
  match self {
    ECLevel::L => 0
    ECLevel::M => 1
    ECLevel::Q => 2
    ECLevel::H => 3
    ECLevel::AUTO => 4
  }
}

///|
impl ToInt for Mode with to_int(self : Mode) -> Int {
  match self {
    Mode::NUM => 0
    Mode::ALNUM => 1
    Mode::BIT8 => 2
    Mode::KANJI => 3
  }
}

///|
/// QR Code
/// 
pub(all) struct QRCode {
  version : Int
  level : ECLevel
  mode : Mode
  mask : Int
  qr : Array[Array[Bool]]
}

///|
pub(all) struct QRCodeBuilder {
  version : Int
  level : ECLevel
  mode : Mode
  mut mask : Int
  function_pattern_pos : PosSet
}

///|
pub fn QRCodeBuilder::new(
  data_length~ : Int,
  version~ : Int = -1,
  ec_level~ : ECLevel = ECLevel::AUTO,
  mode~ : Mode = Mode::BIT8,
  mask~ : Int = -1
) -> QRCodeBuilder raise {
  let mut level = ec_level
  let mut ver = version
  if ver < 0 || level == ECLevel::AUTO {
    if level == ECLevel::AUTO && ver == -1 {
      level = to_ecl(
        for l = 3; l >= 0; l = l - 1 {
          ver = 1
          while ver < 41 && qr_info[ver].level[l].capacity[mode] < data_length {
            ver = ver + 1
          }
          if ver == 41 {
            if l == 0 {
              raise Failure("Failed to select Error Correction Level")
            }
            continue
          } else {
            break l
          }
        } else {
          l
        },
      )
      // version == -1
    } else if level != ECLevel::AUTO {
      ver = 1
      while ver < 41 && qr_info[ver].level[level].capacity[mode] < data_length {
        ver = ver + 1
      }
      if ver == 41 {
        raise Failure("Failed to select Version")
      }
    } else {
      let mut l = 3
      while l >= 0 && qr_info[ver].level[l].capacity[mode] < data_length {
        l = l - 1
      }
      if l == -1 {
        raise Failure("Failed to select Error Correction Level")
      }
      level = to_ecl(l)
    }
  }
  if qr_info[ver].level[level].capacity[mode] < data_length {
    raise Failure("Too big data")
  }
  let function_pattern_pos = make_function_pattern_pos(
    ver,
    qr_info[ver].dimension,
    qr_info[ver].alignment_pos,
    qr_info[ver].nalignment_pos,
  )
  { version: ver, level, mode, mask, function_pattern_pos }
}

///|
fn append_bits(v : Array[Bool], length : Int, val : Int) -> Unit {
  for i = length - 1; i >= 0; i = i - 1 {
    let bit = (val >> i) & 1
    v.push(bit != 0)
  }
}

///|
fn QRCodeBuilder::encode(
  self : QRCodeBuilder,
  raw : Array[Byte]
) -> Array[Byte] {
  let bits = [false, false, false, false]

  // Character Count Indicator
  let ncci = qr_info[self.version].nccindicator[self.mode]
  append_bits(bits, ncci, raw.length())

  // Encode data
  match self.mode {
    BIT8 => {
      bits[1] = true
      for byte in raw {
        append_bits(bits, 8, byte.to_int())
      }
    }
    ALNUM => {
      bits[2] = true
      for i = 0; i < raw.length(); i = i + 2 {
        if i + 1 == raw.length() {
          let w = alnum[raw[i].to_int()]
          guard w != -1
          append_bits(bits, 6, w)
          break
        } else {
          let w1 = alnum[raw[i].to_int()]
          let w2 = alnum[raw[i + 1].to_int()]
          guard w1 != -1 && w2 != -1
          append_bits(bits, 11, w1 * 45 + w2)
        }
      }
    }
    NUM => {
      bits[3] = true
      for i = 0; i < raw.length(); i = i + 3 {
        if i + 2 == raw.length() {
          append_bits(
            bits,
            7,
            (raw[i].to_int() - '0') * 10 + (raw[i + 1].to_int() - '0'),
          )
          break
        } else if i + 1 == raw.length() {
          append_bits(bits, 4, raw[i].to_int() - '0')
          break
        } else {
          append_bits(
            bits,
            10,
            (raw[i].to_int() - '0') * 100 +
            (raw[i + 1].to_int() - '0') * 10 +
            (raw[i + 2].to_int() - '0'),
          )
        }
      }
    }
    // Kanji TODO
    KANJI => ...
  }

  // Padding
  let nt = @math.minimum(
    4,
    qr_info[self.version].level[self.level].capacity[self.mode] - raw.length(),
  )
  for i in 0..<nt {
    bits.push(false)
  }
  while bits.length() % 8 != 0 {
    bits.push(false)
  }
  let capacity = qr_info[self.version].level[self.level].ndatawords * 8
  let npadding = (capacity - bits.length()) / 8
  for i in 0..<npadding {
    if i % 2 == 0 {
      bits.append([true, true, true, false, true, true, false, false])
    } else {
      bits.append([false, false, false, true, false, false, false, true])
    }
  }

  // Convert to Array of Byte
  let byte_count = (bits.length() + 7) / 8
  let ret = Array::new()
  for i in 0..<byte_count {
    let mut byte : Byte = 0
    let bit_start = i * 8
    for j in 0..<8 {
      let bit_index = bit_start + j
      if bit_index < bits.length() && bits[bit_index] {
        byte = byte | (1 << (7 - j)).to_byte()
      }
    }
    ret.push(byte)
  }
  ret
}

///|
fn QRCodeBuilder::generate_error_correction_blocks(
  self : QRCodeBuilder,
  encoded : Array[Byte]
) -> Array[Byte] {
  let ec_data = Array::new()
  let ec_work = FixedArray::make(123, (0).to_byte())
  let necb_group = qr_info[self.version].level[self.level].necb_group
  let ecb_group = qr_info[self.version].level[self.level].ecb_group
  let ec_move = fn() {
    for m in 0..<122 {
      ec_work[m] = ec_work[m + 1]
    }
    ec_work[122] = 0
  }
  let mut data_pos = 0
  for i in 0..<necb_group {
    let nec_block = ecb_group[i].nec_block
    let ndatawords = ecb_group[i].ndatawords
    let necwords = ecb_group[i].ntotalwords - ecb_group[i].ndatawords
    for j in 0..<nec_block {
      ec_work.fill(0)
      for i in 0..<ndatawords {
        ec_work[i] = encoded[data_pos + i]
      }
      for k in 0..<ndatawords {
        if ec_work[0] == 0 {
          ec_move()
          continue
        }
        let e = fac_to_exp[ec_work[0].to_int()]
        ec_move()
        for m in 0..<necwords {
          ec_work[m] = ec_work[m] ^
            exp_to_fac[(generator[necwords][m] + e) % 255].to_byte()
        }
      }
      for h in 0..<necwords {
        ec_data.push(ec_work[h])
      }
      data_pos += ndatawords
    }
  }
  ec_data
}

///|
fn QRCodeBuilder::allocate_data(
  self : QRCodeBuilder,
  encoded : Array[Byte],
  ec_data : Array[Byte]
) -> Array[Byte] {
  let final_data = Array::new()
  let necb_group = qr_info[self.version].level[self.level].necb_group
  let ecb_group = qr_info[self.version].level[self.level].ecb_group
  let ndatawords_max = ecb_group[necb_group - 1].ndatawords
  let necwords_max = ecb_group[necb_group - 1].ntotalwords -
    ecb_group[necb_group - 1].ndatawords
  for i in 0..<ndatawords_max {
    let mut pos = i
    for j in 0..<necb_group {
      let ndatawords = ecb_group[j].ndatawords
      for k in 0..<ecb_group[j].nec_block {
        if i < ndatawords {
          final_data.push(encoded[pos])
        }
        pos += ndatawords
      }
    }
  }
  for i in 0..<necwords_max {
    let mut pos = i
    for j in 0..<necb_group {
      let necwords = ecb_group[j].ntotalwords - ecb_group[j].ndatawords
      for k in 0..<ecb_group[j].nec_block {
        if i < necwords {
          final_data.push(ec_data[pos])
        }
        pos += necwords
      }
    }
  }
  final_data
}

///|
fn QRCodeBuilder::fill_function_patterns(
  self : QRCodeBuilder,
  qr : Array[Array[Bool]]
) -> Unit {
  let dimension = qr_info[self.version].dimension

  // Position Detection Pattern
  make_pdp_pos(dimension).fill(qr)

  // Alignment Pattern
  make_alignment_pos(
    qr_info[self.version].alignment_pos,
    qr_info[self.version].nalignment_pos,
    dimension,
  ).fill(qr)

  // Timing Pattern
  make_timing_pos(dimension).fill(qr)
}

// FIXME

///|
fn to_bits(value : Int, bits : Int) -> Array[Bool] {
  let result = Array::make(bits, false)
  for i in 0..<bits {
    let bit = ((value >> i) & 1) == 1
    result[i] = bit
  }
  result
}

// FIXME

///|
fn to_rev_bits(value : Int, bits : Int) -> Array[Bool] {
  let result = Array::make(bits, false)
  for i in 0..<bits {
    let bit = ((value >> (bits - 1 - i)) & 1) == 1
    result[i] = bit
  }
  result
}

// FIXME

///|
fn i64_to_bits(value : Int64, bits : Int) -> Array[Bool] {
  let result = Array::make(bits, false)
  for i in 0..<bits {
    let bit = ((value >> i) & 1) == 1
    result[i] = bit
  }
  result
}

///|
fn QRCodeBuilder::fill_data(
  self : QRCodeBuilder,
  final_data : Array[Byte],
  qr : Array[Array[Bool]]
) -> Unit {
  let dimension = qr_info[self.version].dimension

  //from (dimension - 1,0)
  let pos = Pos::new(dimension - 1, 0)
  let mut delta_y = 1
  let mut delta_x = -1
  let next = fn() {
    while true {
      pos.x = pos.x + delta_x
      if delta_x > 0 {
        pos.y = pos.y + delta_y
      }
      delta_x = -delta_x
      if pos.y < 0 || pos.y >= dimension {
        pos.y = pos.y - delta_y
        delta_y = -delta_y
        pos.x = pos.x - 2
        if pos.x == 6 {
          // Skip Timing Pattern
          pos.x = pos.x - 1
        }
      }
      if not(self.function_pattern_pos.contains(pos)) {
        break
      }
    }
  }
  let final_databits = Array::new()
  for byte in final_data {
    final_databits.append(to_rev_bits(byte.to_int(), 8))
  }

  // Remainder Bits
  let remainder_bits = qr_info[self.version].remainder_bits
  final_databits.append(Array::make(remainder_bits, false))
  for b in final_databits {
    qr[pos.x][pos.y] = b
    next()
  }

  // Dark Module
  qr[8][7] = true
}

///|
fn QRCodeBuilder::apply_mask(
  self : QRCodeBuilder,
  qr : Array[Array[Bool]],
  mask : Int
) -> Array[Array[Bool]] {
  let applied = Array::new()
  for i in qr {
    applied.push(i.copy())
  }
  let dimension = qr_info[self.version].dimension
  for i in 0..<dimension {
    for j in 0..<dimension {
      let true_pos = Pos::new(j, dimension - i - 1)
      // According to the QR Spec, (i, j) = (0, 0) is in the top left module in the symbol.
      // https://files-cdn.cnblogs.com/files/elaron/qr_code.pdf
      // but in our implementation, (0,0) is in the bottom left
      if self.function_pattern_pos.contains(true_pos) {
        continue
      }
      if (mask == 0 && (i + j) % 2 == 0) ||
        (mask == 1 && i % 2 == 0) ||
        (mask == 2 && j % 3 == 0) ||
        (mask == 3 && (i + j) % 3 == 0) ||
        (mask == 4 && (i / 2 + j / 3) % 2 == 0) ||
        (mask == 5 && i * j % 2 + i * j % 3 == 0) ||
        (mask == 6 && (i * j % 2 + i * j % 3) % 2 == 0) ||
        (mask == 7 && (i * j % 3 + (i + j) % 2) % 2 == 0) {
        applied[true_pos.x][true_pos.y] = not(applied[true_pos.x][true_pos.y])
      }
    }
  }
  applied
}

///|
fn QRCodeBuilder::apply_all_masks(
  self : QRCodeBuilder,
  qr : Array[Array[Bool]]
) -> Array[Array[Array[Bool]]] {
  let applies = Array::new()
  for mask in 0..<8 {
    applies.push(self.apply_mask(qr, mask))
  }
  applies
}

///|
fn[I : Compare + Neg + Default] abs(a : I) -> I {
  if a < I::default() {
    -a
  } else {
    a
  }
}

///|
fn check_slice(arr : Array[Bool], start : Int, pattern : Array[Bool]) -> Bool {
  for j in 0..<pattern.length() {
    if arr[start + j] != pattern[j] {
      return false
    }
  }
  true
}

///|
fn search_pattern(arr : Array[Bool], pattern : Array[Bool]) -> Bool {
  let n = arr.length()
  let m = pattern.length()
  if n < m {
    return false
  }
  for start in 0..<(n - m + 1) {
    if check_slice(arr, start, pattern) {
      return true
    }
  }
  false
}

///|
fn get_column(qr : Array[Array[Bool]], col_index : Int) -> Array[Bool] {
  Array::makei(qr.length(), fn(i) { qr[i][col_index] })
}

///|
fn QRCodeBuilder::evaluate_masks(
  self : QRCodeBuilder,
  qrs : Array[Array[Array[Bool]]]
) -> Array[Int] {
  let dimension = qr_info[self.version].dimension
  let penalties = Array::make(qrs.length(), 0)
  let mut penalties_pos = 0
  for qr in qrs {
    let mut penalty = 0
    let mut n = 0
    // 1
    for i in 0..<dimension {
      for j in 1..<dimension {
        if qr[i][j] == qr[i][j - 1] {
          n = n + 1
        } else {
          if n >= 5 {
            penalty = penalty + 3 + n - 5
          }
          n = 1
        }
      }
      if n >= 5 {
        penalty = penalty + 3 + n - 5
      }
      n = 0
    }
    for i in 0..<dimension {
      for j in 1..<dimension {
        if qr[j][i] == qr[j - 1][i] {
          n = n + 1
        } else {
          if n >= 5 {
            penalty = penalty + 3 + n - 5
          }
          n = 1
        }
      }
      if n >= 5 {
        penalty = penalty + 3 + n - 5
      }
      n = 0
    }
    // 2
    for i in 0..<(dimension - 1) {
      for j in 1..<(dimension - 1) {
        if qr[i][j] == qr[i][j + 1] &&
          qr[i][j] == qr[i + 1][j + 1] &&
          qr[i][j] == qr[i + 1][j] {
          penalty += 3
        }
      }
    }
    // 3 11311
    let dimension = qr.length()
    let pattern = [
      true, false, true, true, true, false, true, false, false, false, false,
    ]
    for i in 0..<dimension {
      if search_pattern(qr[i], pattern) {
        penalty = penalty + 40
      }
    }
    for i in 0..<dimension {
      let column = get_column(qr, i)
      if search_pattern(column, pattern) {
        penalty = penalty + 40
      }
    }
    // 4
    let mut black = 0
    for r in qr {
      black += r.fold(init=0, fn(i : Int, b : Bool) { i + b.to_int() })
    }
    penalty += abs((black * 100 / (dimension * dimension) - 50) / 5 * 10)

    // end
    penalties[penalties_pos] = penalty
    penalties_pos = penalties_pos + 1
  }
  return penalties
}

///|
fn QRCodeBuilder::mask(
  self : QRCodeBuilder,
  qr : Array[Array[Bool]]
) -> Array[Array[Bool]] {
  if self.mask == -1 {
    let applies = self.apply_all_masks(qr)
    let penalties = self.evaluate_masks(applies)
    let mut min_pos = 0
    let mut min_penalty = @int.max_value
    for i in 0..<penalties.length() {
      if penalties[i] < min_penalty {
        min_pos = i
        min_penalty = penalties[i]
      }
    }
    self.mask = min_pos
    applies[min_pos]
  } else {
    self.apply_mask(qr, self.mask)
  }
}

///|
fn QRCodeBuilder::fill_format_info(
  self : QRCodeBuilder,
  qr : Array[Array[Bool]]
) -> Unit {
  let dimension = qr_info[self.version].dimension
  // Format infomation
  let mut fmt = ((self.level.to_int() ^ 1) << 3) | self.mask
  let mut modulo = fmt << 10
  for i = 14; i >= 10; i = i - 1 {
    if (modulo & (1 << i)) == 0 {
      continue
    }
    modulo = modulo ^ (0x537 << (i - 10))
  }

  // 0x5412 == 101010000010010 to ensure that result data is not all 0
  fmt = ((fmt << 10) + modulo) ^ 0x5412
  let format_bits = to_bits(fmt, 15)
  let (fpb1, fpb2) = make_format_pos(dimension)
  fpb1.fill_data(qr, format_bits)
  fpb2.fill_data(qr, format_bits)

  // Version Infomation
  if self.version >= 7 {
    let version_bits = i64_to_bits(version_info[self.version], 18)
    let (vpb1, vpb2) = make_version_pos(dimension)
    vpb1.fill_data(qr, version_bits)
    vpb2.fill_data(qr, version_bits)
  }
}

///|
pub fn QRCodeBuilder::generate(
  self : QRCodeBuilder,
  data : Array[Byte]
) -> QRCode {
  let encoded_data = self.encode(data)
  let ec_data = self.generate_error_correction_blocks(encoded_data)
  let final_data = self.allocate_data(encoded_data, ec_data)
  let dimension = qr_info[self.version].dimension
  let mut qr = Array::makei(dimension, fn(_) { Array::make(dimension, false) })
  self.fill_function_patterns(qr)
  self.fill_data(final_data, qr)
  qr = self.mask(qr)
  self.fill_format_info(qr)
  {
    version: self.version,
    level: self.level,
    mode: self.mode,
    mask: self.mask,
    qr,
  }
}

///|
test "8-Bit Data Encode" {
  let data = "https://github.com/caozhanhao/qrcode.mbt"
  let raw = data.to_array().map(fn(c) { c.to_int().to_byte() })
  let builder = QRCodeBuilder::new(data_length=raw.length())
  let encoded = builder.encode(raw)
  assert_eq(encoded, [
    66, 134, 135, 71, 71, 7, 51, 162, 242, 246, 118, 151, 70, 135, 86, 34, 230, 54,
    246, 210, 246, 54, 22, 247, 166, 134, 22, 230, 134, 22, 242, 247, 23, 38, 54,
    246, 70, 82, 230, 214, 39, 64, 236, 17, 236, 17,
  ])
}

///|
test "Number Data Encode" {
  let data = 0x676e616c63L.to_string()
  let raw = data.to_array().map(fn(c) { c.to_int().to_byte() })
  let builder = QRCodeBuilder::new(data_length=raw.length(), mode=Mode::NUM)
  let encoded = builder.encode(raw).map(fn(b) { b.to_int() })
  assert_eq(encoded, [16, 49, 188, 58, 95, 223, 108, 0, 236])
}

///|
test "Error Correction Block" {
  let encoded : Array[Byte] = [32, 65, 205, 69, 41, 220, 46, 128, 236]
  let builder = QRCodeBuilder::new(
    data_length=0,
    version=1,
    ec_level=ECLevel::H,
  )
  let ecb = builder.generate_error_correction_blocks(encoded)
  assert_eq(ecb, [
    42, 159, 74, 221, 244, 169, 239, 150, 138, 70, 237, 85, 224, 96, 74, 219, 61,
  ])
}

///|
test "Data Allocation" {
  let data = "https://github.com/caozhanhao/qrcode.mbt"
  let raw = data.to_array().map(fn(c) { c.to_int().to_byte() })
  let builder = QRCodeBuilder::new(data_length=raw.length())
  let encoded = builder.encode(raw)
  let ec_data = builder.generate_error_correction_blocks(encoded)
  let final_data = builder
    .allocate_data(encoded, ec_data)
    .map(fn(b) { b.to_int() })
  assert_eq(final_data, [
    66, 151, 22, 54, 134, 70, 247, 246, 135, 135, 166, 70, 71, 86, 134, 82, 71, 34,
    22, 230, 7, 230, 230, 214, 51, 54, 134, 39, 162, 246, 22, 64, 242, 210, 242,
    236, 246, 246, 247, 17, 118, 54, 23, 236, 38, 17, 114, 246, 5, 121, 155, 241,
    122, 65, 95, 227, 61, 223, 176, 246, 21, 92, 166, 191, 137, 165, 24, 252, 182,
    1, 122, 217, 191, 196, 10, 111, 66, 214, 170, 133, 210, 223, 169, 26, 33, 186,
    212, 6, 13, 98, 212, 95, 123, 14, 78, 44, 188, 178, 2, 45, 81, 88, 142, 206,
    97, 105, 202, 220, 185, 133, 109, 112, 189, 161, 244, 244, 150, 24, 253, 39,
    23, 73, 152, 239, 145, 114, 34, 194, 213, 81, 186, 170, 200, 82,
  ])
}
