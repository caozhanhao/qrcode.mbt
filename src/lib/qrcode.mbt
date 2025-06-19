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

pub enum ECLevel {
  L
  M
  Q
  H
  AUTO
} derive(Eq)

pub enum Mode {
  NUM
  ALNUM
  BIT8
  KANJI
} derive(Eq)

fn to_ecl(l: Int) -> ECLevel {
  match l {
    0 => ECLevel::L
    1 => ECLevel::M
    2 => ECLevel::Q
    3 => ECLevel::H
    _ => ECLevel::AUTO
  }
}

fn to_mode(l : Int) -> Mode {
  match l {
    0 => Mode::NUM
    1 => Mode::ALNUM
    2 => Mode::BIT8
    3 => Mode::KANJI
    _ => Mode::BIT8
  }
}

fn ecl_to_int(l : ECLevel) -> Int {
  match l {
    ECLevel::L => 0
    ECLevel::M => 1
    ECLevel::Q => 2
    ECLevel::H => 3
    ECLevel::AUTO => 4
  }
}

fn mode_to_int(l : Mode) -> Int {
  match l {
    Mode::NUM => 0
    Mode::ALNUM => 1
    Mode::BIT8 => 2
    Mode::KANJI => 3
  }
}

///|
/// QR Code
/// 
pub struct QRCode {
  version : Int
  level : ECLevel
  mode : Mode
  mask : Int
  qr : Array[Array[Bool]]
}

pub struct QRCodeBuilder {
  version : Int
  level : ECLevel
  mode : Mode
  mask : Int
  encoded_data : Array[Bool]
  ec_data : Array[Bool]
  filled : Array[Array[Bool]]
  raw : Array[Byte]
  function_pattern_pos: PosSet
}

pub fn QRCodeBuilder::new(
  data~ : Array[Byte],
  version~ : Int = -1,
  ec_level~ : ECLevel = ECLevel::AUTO,
  mode~ : Mode = Mode::BIT8,
  mask~ : Int = -1
) -> QRCodeBuilder {
  let mut level = ec_level
  let mut version = version
  if level == ECLevel::AUTO && version == -1 {
    for l = 3; l >= 0; l = l - 1 {
      version = 1
      while version < 41 &&
            qr_info[version].level[l].capacity[mode_to_int(mode)] <
            data.length() {
        version = version + 1
      }
      if version == 41 {
        guard l != 0
        continue
      } else {
        break
      }
    } else {
      level = to_ecl(l)
    }
    // version == -1
  } else if level != ECLevel::AUTO {
    version = 1
    while version < 41 &&
          qr_info[version].level[ecl_to_int(level)].capacity[mode_to_int(mode)] <
          data.length() {
      version = version + 1
    }
    guard version != 41  //ecl undef
  } else {
    let mut l = 3
    while l >= 0 &&
          qr_info[version].level[l].capacity[mode_to_int(mode)] < data.length() {
      l = l - 1
    }
    guard l != -1
    level = to_ecl(l)
  }
  guard qr_info[version].level[ecl_to_int(level)].capacity[mode_to_int(mode)] <
    data.length()
  let function_pattern_pos = make_function_pattern_pos(
    version,
    qr_info[version].dimension,
    qr_info[version].alignment_pos,
    qr_info[version].nalignment_pos,
  )
  {
    version,
    level,
    mode,
    mask,
    encoded_data: Array::new(),
    ec_data: Array::new(),
    filled: Array::new(),
    raw: data,
    function_pattern_pos,
  }
}

pub fn QRCodeBuilder::generate() -> QRCode {
  ...
}