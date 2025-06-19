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

// QR Spec: https://files-cdn.cnblogs.com/files/elaron/qr_code.pdf

///|
priv trait ToInt {
  to_int(Self) -> Int
}

///|
priv type EnumArr[T] FixedArray[T]

///|
fn[T, E : ToInt] EnumArr::op_get(self : EnumArr[T], index : E) -> T {
  self.inner()[index.to_int()]
}

///|
impl ToInt for Int with to_int(self : Int) {
  self
}

///| Error Correction Block Group Entry
/// 
/// - `nec_block`: Number of block in the group
/// - `ntotalwords`: Total number of codewords (c)
/// - `ndatawords`: Number of encoded data codewords (k)
/// - `nec`: Number of error correction capacity (r)
priv struct ECBGroupEntry {
  nec_block : Int
  ntotalwords : Int
  ndatawords : Int
  nec : Int
}

///| Error Correction Entry
/// 
/// - `ndatawords`: Number of data codewords
/// - `capacity`: A symbol's capacity [0] numeric [1] alphanumeric [2] 8bit [3] Kanji
/// - `necb_group`: Number of the group in `ecb_group`
/// - `ecb_group`: Error correction block group
priv struct ECEntry {
  ndatawords : Int
  capacity : EnumArr[Int]
  necb_group : Int
  ecb_group : FixedArray[ECBGroupEntry]
}

///| QR Information
/// 
/// - `version`: QR version
/// - `dimension`: QR dimension
/// - `totalwords`: Total number of codewords
/// - `ecb_group`: Error correction block group
/// - `remainder_bits`: Number of remainder bits
/// - `nccindicator`: Character Count Indicator [0]numeric [1] alphanumeric [2]	8bit [3] Kanji
/// - `level`: QRLevel [0]L [1]M [2]Q [3]H
/// - `nalignment_pos`: Number of Alignment Pos
/// - `alignment_pos`: Alignment Pos
priv struct QRInfoEntry {
  version : Int
  dimension : Int
  totalwords : Int
  remainder_bits : Int
  nccindicator : EnumArr[Int]
  level : EnumArr[ECEntry]
  nalignment_pos : Int
  alignment_pos : FixedArray[Int]
}

///|
let qr_info : FixedArray[QRInfoEntry] = [
  {
    version: 0,
    dimension: 0,
    totalwords: 0,
    remainder_bits: 0,
    nccindicator: [0, 0, 0, 0],
    level: [
      {
        ndatawords: 0,
        capacity: [0, 0, 0, 0],
        necb_group: 0,
        ecb_group: [
          { nec_block: 0, ntotalwords: 0, ndatawords: 0, nec: 0 },
          { nec_block: 0, ntotalwords: 0, ndatawords: 0, nec: 0 },
        ],
      },
      {
        ndatawords: 0,
        capacity: [0, 0, 0, 0],
        necb_group: 0,
        ecb_group: [
          { nec_block: 0, ntotalwords: 0, ndatawords: 0, nec: 0 },
          { nec_block: 0, ntotalwords: 0, ndatawords: 0, nec: 0 },
        ],
      },
      {
        ndatawords: 0,
        capacity: [0, 0, 0, 0],
        necb_group: 0,
        ecb_group: [
          { nec_block: 0, ntotalwords: 0, ndatawords: 0, nec: 0 },
          { nec_block: 0, ntotalwords: 0, ndatawords: 0, nec: 0 },
        ],
      },
      {
        ndatawords: 0,
        capacity: [0, 0, 0, 0],
        necb_group: 0,
        ecb_group: [
          { nec_block: 0, ntotalwords: 0, ndatawords: 0, nec: 0 },
          { nec_block: 0, ntotalwords: 0, ndatawords: 0, nec: 0 },
        ],
      },
    ],
    nalignment_pos: 0,
    alignment_pos: [0, 0, 0, 0, 0, 0, 0],
  },
  {
    version: 1,
    dimension: 21,
    totalwords: 26,
    remainder_bits: 0,
    nccindicator: [10, 9, 8, 8],
    level: [
      {
        ndatawords: 19,
        capacity: [41, 25, 17, 10],
        necb_group: 1,
        ecb_group: [
          { nec_block: 1, ntotalwords: 26, ndatawords: 19, nec: 2 },
          { nec_block: 0, ntotalwords: 0, ndatawords: 0, nec: 0 },
        ],
      },
      {
        ndatawords: 16,
        capacity: [34, 20, 14, 8],
        necb_group: 1,
        ecb_group: [
          { nec_block: 1, ntotalwords: 26, ndatawords: 16, nec: 4 },
          { nec_block: 0, ntotalwords: 0, ndatawords: 0, nec: 0 },
        ],
      },
      {
        ndatawords: 13,
        capacity: [27, 16, 11, 7],
        necb_group: 1,
        ecb_group: [
          { nec_block: 1, ntotalwords: 26, ndatawords: 13, nec: 6 },
          { nec_block: 0, ntotalwords: 0, ndatawords: 0, nec: 0 },
        ],
      },
      {
        ndatawords: 9,
        capacity: [17, 10, 7, 4],
        necb_group: 1,
        ecb_group: [
          { nec_block: 1, ntotalwords: 26, ndatawords: 9, nec: 8 },
          { nec_block: 0, ntotalwords: 0, ndatawords: 0, nec: 0 },
        ],
      },
    ],
    nalignment_pos: 0,
    alignment_pos: [0, 0, 0, 0, 0, 0, 0],
  },
  {
    version: 2,
    dimension: 25,
    totalwords: 44,
    remainder_bits: 7,
    nccindicator: [10, 9, 8, 8],
    level: [
      {
        ndatawords: 34,
        capacity: [77, 47, 32, 20],
        necb_group: 1,
        ecb_group: [
          { nec_block: 1, ntotalwords: 44, ndatawords: 34, nec: 4 },
          { nec_block: 0, ntotalwords: 0, ndatawords: 0, nec: 0 },
        ],
      },
      {
        ndatawords: 28,
        capacity: [63, 38, 26, 16],
        necb_group: 1,
        ecb_group: [
          { nec_block: 1, ntotalwords: 44, ndatawords: 28, nec: 8 },
          { nec_block: 0, ntotalwords: 0, ndatawords: 0, nec: 0 },
        ],
      },
      {
        ndatawords: 22,
        capacity: [48, 29, 20, 12],
        necb_group: 1,
        ecb_group: [
          { nec_block: 1, ntotalwords: 44, ndatawords: 22, nec: 11 },
          { nec_block: 0, ntotalwords: 0, ndatawords: 0, nec: 0 },
        ],
      },
      {
        ndatawords: 16,
        capacity: [34, 20, 14, 8],
        necb_group: 1,
        ecb_group: [
          { nec_block: 1, ntotalwords: 44, ndatawords: 16, nec: 14 },
          { nec_block: 0, ntotalwords: 0, ndatawords: 0, nec: 0 },
        ],
      },
    ],
    nalignment_pos: 2,
    alignment_pos: [6, 18, 0, 0, 0, 0, 0],
  },
  {
    version: 3,
    dimension: 29,
    totalwords: 70,
    remainder_bits: 7,
    nccindicator: [10, 9, 8, 8],
    level: [
      {
        ndatawords: 55,
        capacity: [127, 77, 53, 32],
        necb_group: 1,
        ecb_group: [
          { nec_block: 1, ntotalwords: 70, ndatawords: 55, nec: 7 },
          { nec_block: 0, ntotalwords: 0, ndatawords: 0, nec: 0 },
        ],
      },
      {
        ndatawords: 44,
        capacity: [101, 61, 42, 26],
        necb_group: 1,
        ecb_group: [
          { nec_block: 1, ntotalwords: 70, ndatawords: 44, nec: 13 },
          { nec_block: 0, ntotalwords: 0, ndatawords: 0, nec: 0 },
        ],
      },
      {
        ndatawords: 34,
        capacity: [77, 47, 32, 20],
        necb_group: 1,
        ecb_group: [
          { nec_block: 2, ntotalwords: 35, ndatawords: 17, nec: 9 },
          { nec_block: 0, ntotalwords: 0, ndatawords: 0, nec: 0 },
        ],
      },
      {
        ndatawords: 26,
        capacity: [58, 35, 24, 15],
        necb_group: 1,
        ecb_group: [
          { nec_block: 2, ntotalwords: 35, ndatawords: 13, nec: 11 },
          { nec_block: 0, ntotalwords: 0, ndatawords: 0, nec: 0 },
        ],
      },
    ],
    nalignment_pos: 2,
    alignment_pos: [6, 22, 0, 0, 0, 0, 0],
  },
  {
    version: 4,
    dimension: 33,
    totalwords: 100,
    remainder_bits: 7,
    nccindicator: [10, 9, 8, 8],
    level: [
      {
        ndatawords: 80,
        capacity: [187, 114, 78, 48],
        necb_group: 1,
        ecb_group: [
          { nec_block: 1, ntotalwords: 100, ndatawords: 80, nec: 10 },
          { nec_block: 0, ntotalwords: 0, ndatawords: 0, nec: 0 },
        ],
      },
      {
        ndatawords: 64,
        capacity: [149, 90, 62, 38],
        necb_group: 1,
        ecb_group: [
          { nec_block: 2, ntotalwords: 50, ndatawords: 32, nec: 9 },
          { nec_block: 0, ntotalwords: 0, ndatawords: 0, nec: 0 },
        ],
      },
      {
        ndatawords: 48,
        capacity: [111, 67, 46, 28],
        necb_group: 1,
        ecb_group: [
          { nec_block: 2, ntotalwords: 50, ndatawords: 24, nec: 13 },
          { nec_block: 0, ntotalwords: 0, ndatawords: 0, nec: 0 },
        ],
      },
      {
        ndatawords: 36,
        capacity: [82, 50, 34, 21],
        necb_group: 1,
        ecb_group: [
          { nec_block: 4, ntotalwords: 25, ndatawords: 9, nec: 8 },
          { nec_block: 0, ntotalwords: 0, ndatawords: 0, nec: 0 },
        ],
      },
    ],
    nalignment_pos: 2,
    alignment_pos: [6, 26, 0, 0, 0, 0, 0],
  },
  {
    version: 5,
    dimension: 37,
    totalwords: 134,
    remainder_bits: 7,
    nccindicator: [10, 9, 8, 8],
    level: [
      {
        ndatawords: 108,
        capacity: [255, 154, 106, 65],
        necb_group: 1,
        ecb_group: [
          { nec_block: 1, ntotalwords: 134, ndatawords: 108, nec: 13 },
          { nec_block: 0, ntotalwords: 0, ndatawords: 0, nec: 0 },
        ],
      },
      {
        ndatawords: 86,
        capacity: [202, 122, 84, 52],
        necb_group: 1,
        ecb_group: [
          { nec_block: 2, ntotalwords: 67, ndatawords: 43, nec: 12 },
          { nec_block: 0, ntotalwords: 0, ndatawords: 0, nec: 0 },
        ],
      },
      {
        ndatawords: 62,
        capacity: [144, 87, 60, 37],
        necb_group: 2,
        ecb_group: [
          { nec_block: 2, ntotalwords: 33, ndatawords: 15, nec: 9 },
          { nec_block: 2, ntotalwords: 34, ndatawords: 16, nec: 9 },
        ],
      },
      {
        ndatawords: 46,
        capacity: [106, 64, 44, 27],
        necb_group: 2,
        ecb_group: [
          { nec_block: 2, ntotalwords: 33, ndatawords: 11, nec: 11 },
          { nec_block: 2, ntotalwords: 34, ndatawords: 12, nec: 11 },
        ],
      },
    ],
    nalignment_pos: 2,
    alignment_pos: [6, 30, 0, 0, 0, 0, 0],
  },
  {
    version: 6,
    dimension: 41,
    totalwords: 172,
    remainder_bits: 7,
    nccindicator: [10, 9, 8, 8],
    level: [
      {
        ndatawords: 136,
        capacity: [322, 195, 134, 82],
        necb_group: 1,
        ecb_group: [
          { nec_block: 2, ntotalwords: 86, ndatawords: 68, nec: 9 },
          { nec_block: 0, ntotalwords: 0, ndatawords: 0, nec: 0 },
        ],
      },
      {
        ndatawords: 108,
        capacity: [255, 154, 106, 65],
        necb_group: 1,
        ecb_group: [
          { nec_block: 4, ntotalwords: 43, ndatawords: 27, nec: 8 },
          { nec_block: 0, ntotalwords: 0, ndatawords: 0, nec: 0 },
        ],
      },
      {
        ndatawords: 76,
        capacity: [178, 108, 74, 45],
        necb_group: 1,
        ecb_group: [
          { nec_block: 4, ntotalwords: 43, ndatawords: 19, nec: 12 },
          { nec_block: 0, ntotalwords: 0, ndatawords: 0, nec: 0 },
        ],
      },
      {
        ndatawords: 60,
        capacity: [139, 84, 58, 36],
        necb_group: 1,
        ecb_group: [
          { nec_block: 4, ntotalwords: 43, ndatawords: 15, nec: 14 },
          { nec_block: 0, ntotalwords: 0, ndatawords: 0, nec: 0 },
        ],
      },
    ],
    nalignment_pos: 2,
    alignment_pos: [6, 34, 0, 0, 0, 0, 0],
  },
  {
    version: 7,
    dimension: 45,
    totalwords: 196,
    remainder_bits: 0,
    nccindicator: [10, 9, 8, 8],
    level: [
      {
        ndatawords: 156,
        capacity: [370, 224, 154, 95],
        necb_group: 1,
        ecb_group: [
          { nec_block: 2, ntotalwords: 98, ndatawords: 78, nec: 10 },
          { nec_block: 0, ntotalwords: 0, ndatawords: 0, nec: 0 },
        ],
      },
      {
        ndatawords: 124,
        capacity: [293, 178, 122, 75],
        necb_group: 1,
        ecb_group: [
          { nec_block: 4, ntotalwords: 49, ndatawords: 31, nec: 9 },
          { nec_block: 0, ntotalwords: 0, ndatawords: 0, nec: 0 },
        ],
      },
      {
        ndatawords: 88,
        capacity: [207, 125, 86, 53],
        necb_group: 2,
        ecb_group: [
          { nec_block: 2, ntotalwords: 32, ndatawords: 14, nec: 9 },
          { nec_block: 4, ntotalwords: 33, ndatawords: 15, nec: 9 },
        ],
      },
      {
        ndatawords: 66,
        capacity: [154, 93, 64, 39],
        necb_group: 2,
        ecb_group: [
          { nec_block: 4, ntotalwords: 39, ndatawords: 13, nec: 13 },
          { nec_block: 1, ntotalwords: 40, ndatawords: 14, nec: 13 },
        ],
      },
    ],
    nalignment_pos: 3,
    alignment_pos: [6, 22, 38, 0, 0, 0, 0],
  },
  {
    version: 8,
    dimension: 49,
    totalwords: 242,
    remainder_bits: 0,
    nccindicator: [10, 9, 8, 8],
    level: [
      {
        ndatawords: 194,
        capacity: [461, 279, 192, 118],
        necb_group: 1,
        ecb_group: [
          { nec_block: 2, ntotalwords: 121, ndatawords: 97, nec: 12 },
          { nec_block: 0, ntotalwords: 0, ndatawords: 0, nec: 0 },
        ],
      },
      {
        ndatawords: 154,
        capacity: [365, 221, 152, 93],
        necb_group: 2,
        ecb_group: [
          { nec_block: 2, ntotalwords: 60, ndatawords: 38, nec: 11 },
          { nec_block: 2, ntotalwords: 61, ndatawords: 39, nec: 11 },
        ],
      },
      {
        ndatawords: 110,
        capacity: [259, 157, 108, 66],
        necb_group: 2,
        ecb_group: [
          { nec_block: 4, ntotalwords: 40, ndatawords: 18, nec: 11 },
          { nec_block: 2, ntotalwords: 41, ndatawords: 19, nec: 11 },
        ],
      },
      {
        ndatawords: 86,
        capacity: [202, 122, 84, 52],
        necb_group: 2,
        ecb_group: [
          { nec_block: 4, ntotalwords: 40, ndatawords: 14, nec: 13 },
          { nec_block: 2, ntotalwords: 41, ndatawords: 15, nec: 13 },
        ],
      },
    ],
    nalignment_pos: 3,
    alignment_pos: [6, 24, 42, 0, 0, 0, 0],
  },
  {
    version: 9,
    dimension: 53,
    totalwords: 292,
    remainder_bits: 0,
    nccindicator: [10, 9, 8, 8],
    level: [
      {
        ndatawords: 232,
        capacity: [552, 335, 230, 141],
        necb_group: 1,
        ecb_group: [
          { nec_block: 2, ntotalwords: 146, ndatawords: 116, nec: 15 },
          { nec_block: 0, ntotalwords: 0, ndatawords: 0, nec: 0 },
        ],
      },
      {
        ndatawords: 182,
        capacity: [432, 262, 180, 111],
        necb_group: 2,
        ecb_group: [
          { nec_block: 3, ntotalwords: 58, ndatawords: 36, nec: 11 },
          { nec_block: 2, ntotalwords: 59, ndatawords: 37, nec: 11 },
        ],
      },
      {
        ndatawords: 132,
        capacity: [312, 189, 130, 80],
        necb_group: 2,
        ecb_group: [
          { nec_block: 4, ntotalwords: 36, ndatawords: 16, nec: 10 },
          { nec_block: 4, ntotalwords: 37, ndatawords: 17, nec: 10 },
        ],
      },
      {
        ndatawords: 100,
        capacity: [235, 143, 98, 60],
        necb_group: 2,
        ecb_group: [
          { nec_block: 4, ntotalwords: 36, ndatawords: 12, nec: 12 },
          { nec_block: 4, ntotalwords: 37, ndatawords: 13, nec: 12 },
        ],
      },
    ],
    nalignment_pos: 3,
    alignment_pos: [6, 26, 46, 0, 0, 0, 0],
  },
  {
    version: 10,
    dimension: 57,
    totalwords: 346,
    remainder_bits: 0,
    nccindicator: [12, 11, 16, 10],
    level: [
      {
        ndatawords: 274,
        capacity: [652, 395, 271, 167],
        necb_group: 2,
        ecb_group: [
          { nec_block: 2, ntotalwords: 86, ndatawords: 68, nec: 9 },
          { nec_block: 2, ntotalwords: 87, ndatawords: 69, nec: 9 },
        ],
      },
      {
        ndatawords: 216,
        capacity: [513, 311, 213, 131],
        necb_group: 2,
        ecb_group: [
          { nec_block: 4, ntotalwords: 69, ndatawords: 43, nec: 13 },
          { nec_block: 1, ntotalwords: 70, ndatawords: 44, nec: 13 },
        ],
      },
      {
        ndatawords: 154,
        capacity: [364, 221, 151, 93],
        necb_group: 2,
        ecb_group: [
          { nec_block: 6, ntotalwords: 43, ndatawords: 19, nec: 12 },
          { nec_block: 2, ntotalwords: 44, ndatawords: 20, nec: 12 },
        ],
      },
      {
        ndatawords: 122,
        capacity: [288, 174, 119, 74],
        necb_group: 2,
        ecb_group: [
          { nec_block: 6, ntotalwords: 43, ndatawords: 15, nec: 14 },
          { nec_block: 2, ntotalwords: 44, ndatawords: 16, nec: 14 },
        ],
      },
    ],
    nalignment_pos: 3,
    alignment_pos: [6, 28, 50, 0, 0, 0, 0],
  },
  {
    version: 11,
    dimension: 61,
    totalwords: 404,
    remainder_bits: 0,
    nccindicator: [12, 11, 16, 10],
    level: [
      {
        ndatawords: 324,
        capacity: [772, 468, 321, 198],
        necb_group: 1,
        ecb_group: [
          { nec_block: 4, ntotalwords: 101, ndatawords: 81, nec: 10 },
          { nec_block: 0, ntotalwords: 0, ndatawords: 0, nec: 0 },
        ],
      },
      {
        ndatawords: 254,
        capacity: [604, 366, 251, 155],
        necb_group: 2,
        ecb_group: [
          { nec_block: 1, ntotalwords: 80, ndatawords: 50, nec: 15 },
          { nec_block: 4, ntotalwords: 81, ndatawords: 51, nec: 15 },
        ],
      },
      {
        ndatawords: 180,
        capacity: [427, 259, 177, 109],
        necb_group: 2,
        ecb_group: [
          { nec_block: 4, ntotalwords: 50, ndatawords: 22, nec: 14 },
          { nec_block: 4, ntotalwords: 51, ndatawords: 23, nec: 14 },
        ],
      },
      {
        ndatawords: 140,
        capacity: [331, 200, 137, 85],
        necb_group: 2,
        ecb_group: [
          { nec_block: 3, ntotalwords: 36, ndatawords: 12, nec: 12 },
          { nec_block: 8, ntotalwords: 37, ndatawords: 13, nec: 12 },
        ],
      },
    ],
    nalignment_pos: 3,
    alignment_pos: [6, 30, 54, 0, 0, 0, 0],
  },
  {
    version: 12,
    dimension: 65,
    totalwords: 466,
    remainder_bits: 0,
    nccindicator: [12, 11, 16, 10],
    level: [
      {
        ndatawords: 370,
        capacity: [883, 535, 367, 226],
        necb_group: 2,
        ecb_group: [
          { nec_block: 2, ntotalwords: 116, ndatawords: 92, nec: 12 },
          { nec_block: 2, ntotalwords: 117, ndatawords: 93, nec: 12 },
        ],
      },
      {
        ndatawords: 290,
        capacity: [691, 419, 287, 177],
        necb_group: 2,
        ecb_group: [
          { nec_block: 6, ntotalwords: 58, ndatawords: 36, nec: 11 },
          { nec_block: 2, ntotalwords: 59, ndatawords: 37, nec: 11 },
        ],
      },
      {
        ndatawords: 206,
        capacity: [489, 296, 203, 125],
        necb_group: 2,
        ecb_group: [
          { nec_block: 4, ntotalwords: 46, ndatawords: 20, nec: 13 },
          { nec_block: 6, ntotalwords: 47, ndatawords: 21, nec: 13 },
        ],
      },
      {
        ndatawords: 158,
        capacity: [374, 227, 155, 96],
        necb_group: 2,
        ecb_group: [
          { nec_block: 7, ntotalwords: 42, ndatawords: 14, nec: 14 },
          { nec_block: 4, ntotalwords: 43, ndatawords: 15, nec: 14 },
        ],
      },
    ],
    nalignment_pos: 3,
    alignment_pos: [6, 32, 58, 0, 0, 0, 0],
  },
  {
    version: 13,
    dimension: 69,
    totalwords: 532,
    remainder_bits: 0,
    nccindicator: [12, 11, 16, 10],
    level: [
      {
        ndatawords: 428,
        capacity: [1022, 619, 425, 262],
        necb_group: 1,
        ecb_group: [
          { nec_block: 4, ntotalwords: 133, ndatawords: 107, nec: 13 },
          { nec_block: 0, ntotalwords: 0, ndatawords: 0, nec: 0 },
        ],
      },
      {
        ndatawords: 334,
        capacity: [796, 483, 331, 204],
        necb_group: 2,
        ecb_group: [
          { nec_block: 8, ntotalwords: 59, ndatawords: 37, nec: 11 },
          { nec_block: 1, ntotalwords: 60, ndatawords: 38, nec: 11 },
        ],
      },
      {
        ndatawords: 244,
        capacity: [580, 352, 241, 149],
        necb_group: 2,
        ecb_group: [
          { nec_block: 8, ntotalwords: 44, ndatawords: 20, nec: 12 },
          { nec_block: 4, ntotalwords: 45, ndatawords: 21, nec: 12 },
        ],
      },
      {
        ndatawords: 180,
        capacity: [427, 259, 177, 109],
        necb_group: 2,
        ecb_group: [
          { nec_block: 12, ntotalwords: 33, ndatawords: 11, nec: 11 },
          { nec_block: 4, ntotalwords: 34, ndatawords: 12, nec: 11 },
        ],
      },
    ],
    nalignment_pos: 3,
    alignment_pos: [6, 34, 62, 0, 0, 0, 0],
  },
  {
    version: 14,
    dimension: 73,
    totalwords: 581,
    remainder_bits: 3,
    nccindicator: [12, 11, 16, 10],
    level: [
      {
        ndatawords: 461,
        capacity: [1101, 667, 458, 282],
        necb_group: 2,
        ecb_group: [
          { nec_block: 3, ntotalwords: 145, ndatawords: 115, nec: 15 },
          { nec_block: 1, ntotalwords: 146, ndatawords: 116, nec: 15 },
        ],
      },
      {
        ndatawords: 365,
        capacity: [871, 528, 362, 223],
        necb_group: 2,
        ecb_group: [
          { nec_block: 4, ntotalwords: 64, ndatawords: 40, nec: 12 },
          { nec_block: 5, ntotalwords: 65, ndatawords: 41, nec: 12 },
        ],
      },
      {
        ndatawords: 261,
        capacity: [621, 376, 258, 159],
        necb_group: 2,
        ecb_group: [
          { nec_block: 11, ntotalwords: 36, ndatawords: 16, nec: 10 },
          { nec_block: 5, ntotalwords: 37, ndatawords: 17, nec: 10 },
        ],
      },
      {
        ndatawords: 197,
        capacity: [468, 283, 194, 120],
        necb_group: 2,
        ecb_group: [
          { nec_block: 11, ntotalwords: 36, ndatawords: 12, nec: 12 },
          { nec_block: 5, ntotalwords: 37, ndatawords: 13, nec: 12 },
        ],
      },
    ],
    nalignment_pos: 4,
    alignment_pos: [6, 26, 46, 66, 0, 0, 0],
  },
  {
    version: 15,
    dimension: 77,
    totalwords: 655,
    remainder_bits: 3,
    nccindicator: [12, 11, 16, 10],
    level: [
      {
        ndatawords: 523,
        capacity: [1250, 758, 520, 320],
        necb_group: 2,
        ecb_group: [
          { nec_block: 5, ntotalwords: 109, ndatawords: 87, nec: 11 },
          { nec_block: 1, ntotalwords: 110, ndatawords: 88, nec: 11 },
        ],
      },
      {
        ndatawords: 415,
        capacity: [991, 600, 412, 254],
        necb_group: 2,
        ecb_group: [
          { nec_block: 5, ntotalwords: 65, ndatawords: 41, nec: 12 },
          { nec_block: 5, ntotalwords: 66, ndatawords: 42, nec: 12 },
        ],
      },
      {
        ndatawords: 295,
        capacity: [703, 426, 292, 180],
        necb_group: 2,
        ecb_group: [
          { nec_block: 5, ntotalwords: 54, ndatawords: 24, nec: 15 },
          { nec_block: 7, ntotalwords: 55, ndatawords: 25, nec: 15 },
        ],
      },
      {
        ndatawords: 223,
        capacity: [530, 321, 220, 136],
        necb_group: 2,
        ecb_group: [
          { nec_block: 11, ntotalwords: 36, ndatawords: 12, nec: 12 },
          { nec_block: 7, ntotalwords: 37, ndatawords: 13, nec: 12 },
        ],
      },
    ],
    nalignment_pos: 4,
    alignment_pos: [6, 26, 48, 70, 0, 0, 0],
  },
  {
    version: 16,
    dimension: 81,
    totalwords: 733,
    remainder_bits: 3,
    nccindicator: [12, 11, 16, 10],
    level: [
      {
        ndatawords: 589,
        capacity: [1408, 854, 586, 361],
        necb_group: 2,
        ecb_group: [
          { nec_block: 5, ntotalwords: 122, ndatawords: 98, nec: 12 },
          { nec_block: 1, ntotalwords: 123, ndatawords: 99, nec: 12 },
        ],
      },
      {
        ndatawords: 453,
        capacity: [1082, 656, 450, 277],
        necb_group: 2,
        ecb_group: [
          { nec_block: 7, ntotalwords: 73, ndatawords: 45, nec: 14 },
          { nec_block: 3, ntotalwords: 74, ndatawords: 46, nec: 14 },
        ],
      },
      {
        ndatawords: 325,
        capacity: [775, 470, 322, 198],
        necb_group: 2,
        ecb_group: [
          { nec_block: 15, ntotalwords: 43, ndatawords: 19, nec: 12 },
          { nec_block: 2, ntotalwords: 44, ndatawords: 20, nec: 12 },
        ],
      },
      {
        ndatawords: 253,
        capacity: [602, 365, 250, 154],
        necb_group: 2,
        ecb_group: [
          { nec_block: 3, ntotalwords: 45, ndatawords: 15, nec: 15 },
          { nec_block: 13, ntotalwords: 46, ndatawords: 16, nec: 15 },
        ],
      },
    ],
    nalignment_pos: 4,
    alignment_pos: [6, 26, 50, 74, 0, 0, 0],
  },
  {
    version: 17,
    dimension: 85,
    totalwords: 815,
    remainder_bits: 3,
    nccindicator: [12, 11, 16, 10],
    level: [
      {
        ndatawords: 647,
        capacity: [1548, 938, 644, 397],
        necb_group: 2,
        ecb_group: [
          { nec_block: 1, ntotalwords: 135, ndatawords: 107, nec: 14 },
          { nec_block: 5, ntotalwords: 136, ndatawords: 108, nec: 14 },
        ],
      },
      {
        ndatawords: 507,
        capacity: [1212, 734, 504, 310],
        necb_group: 2,
        ecb_group: [
          { nec_block: 10, ntotalwords: 74, ndatawords: 46, nec: 14 },
          { nec_block: 1, ntotalwords: 75, ndatawords: 47, nec: 14 },
        ],
      },
      {
        ndatawords: 367,
        capacity: [876, 531, 364, 224],
        necb_group: 2,
        ecb_group: [
          { nec_block: 1, ntotalwords: 50, ndatawords: 22, nec: 14 },
          { nec_block: 15, ntotalwords: 51, ndatawords: 23, nec: 14 },
        ],
      },
      {
        ndatawords: 283,
        capacity: [674, 408, 280, 173],
        necb_group: 2,
        ecb_group: [
          { nec_block: 2, ntotalwords: 42, ndatawords: 14, nec: 14 },
          { nec_block: 17, ntotalwords: 43, ndatawords: 15, nec: 14 },
        ],
      },
    ],
    nalignment_pos: 4,
    alignment_pos: [6, 30, 54, 78, 0, 0, 0],
  },
  {
    version: 18,
    dimension: 89,
    totalwords: 901,
    remainder_bits: 3,
    nccindicator: [12, 11, 16, 10],
    level: [
      {
        ndatawords: 721,
        capacity: [1725, 1046, 718, 442],
        necb_group: 2,
        ecb_group: [
          { nec_block: 5, ntotalwords: 150, ndatawords: 120, nec: 15 },
          { nec_block: 1, ntotalwords: 151, ndatawords: 121, nec: 15 },
        ],
      },
      {
        ndatawords: 563,
        capacity: [1346, 816, 560, 345],
        necb_group: 2,
        ecb_group: [
          { nec_block: 9, ntotalwords: 69, ndatawords: 43, nec: 13 },
          { nec_block: 4, ntotalwords: 70, ndatawords: 44, nec: 13 },
        ],
      },
      {
        ndatawords: 397,
        capacity: [948, 574, 394, 243],
        necb_group: 2,
        ecb_group: [
          { nec_block: 17, ntotalwords: 50, ndatawords: 22, nec: 14 },
          { nec_block: 1, ntotalwords: 51, ndatawords: 23, nec: 14 },
        ],
      },
      {
        ndatawords: 313,
        capacity: [746, 452, 310, 191],
        necb_group: 2,
        ecb_group: [
          { nec_block: 2, ntotalwords: 42, ndatawords: 14, nec: 14 },
          { nec_block: 19, ntotalwords: 43, ndatawords: 15, nec: 14 },
        ],
      },
    ],
    nalignment_pos: 4,
    alignment_pos: [6, 30, 56, 82, 0, 0, 0],
  },
  {
    version: 19,
    dimension: 93,
    totalwords: 991,
    remainder_bits: 3,
    nccindicator: [12, 11, 16, 10],
    level: [
      {
        ndatawords: 795,
        capacity: [1903, 1153, 792, 488],
        necb_group: 2,
        ecb_group: [
          { nec_block: 3, ntotalwords: 141, ndatawords: 113, nec: 14 },
          { nec_block: 4, ntotalwords: 142, ndatawords: 114, nec: 14 },
        ],
      },
      {
        ndatawords: 627,
        capacity: [1500, 909, 624, 384],
        necb_group: 2,
        ecb_group: [
          { nec_block: 3, ntotalwords: 70, ndatawords: 44, nec: 13 },
          { nec_block: 11, ntotalwords: 71, ndatawords: 45, nec: 13 },
        ],
      },
      {
        ndatawords: 445,
        capacity: [1063, 644, 442, 272],
        necb_group: 2,
        ecb_group: [
          { nec_block: 17, ntotalwords: 47, ndatawords: 21, nec: 13 },
          { nec_block: 4, ntotalwords: 48, ndatawords: 22, nec: 13 },
        ],
      },
      {
        ndatawords: 341,
        capacity: [813, 493, 338, 208],
        necb_group: 2,
        ecb_group: [
          { nec_block: 9, ntotalwords: 39, ndatawords: 13, nec: 13 },
          { nec_block: 16, ntotalwords: 40, ndatawords: 14, nec: 13 },
        ],
      },
    ],
    nalignment_pos: 4,
    alignment_pos: [6, 30, 58, 86, 0, 0, 0],
  },
  {
    version: 20,
    dimension: 97,
    totalwords: 1085,
    remainder_bits: 3,
    nccindicator: [12, 11, 16, 10],
    level: [
      {
        ndatawords: 861,
        capacity: [2061, 1249, 858, 528],
        necb_group: 2,
        ecb_group: [
          { nec_block: 3, ntotalwords: 135, ndatawords: 107, nec: 14 },
          { nec_block: 5, ntotalwords: 136, ndatawords: 108, nec: 14 },
        ],
      },
      {
        ndatawords: 669,
        capacity: [1600, 970, 666, 410],
        necb_group: 2,
        ecb_group: [
          { nec_block: 3, ntotalwords: 67, ndatawords: 41, nec: 13 },
          { nec_block: 13, ntotalwords: 68, ndatawords: 42, nec: 13 },
        ],
      },
      {
        ndatawords: 485,
        capacity: [1159, 702, 482, 297],
        necb_group: 2,
        ecb_group: [
          { nec_block: 15, ntotalwords: 54, ndatawords: 24, nec: 15 },
          { nec_block: 5, ntotalwords: 55, ndatawords: 25, nec: 15 },
        ],
      },
      {
        ndatawords: 385,
        capacity: [919, 557, 382, 235],
        necb_group: 2,
        ecb_group: [
          { nec_block: 15, ntotalwords: 43, ndatawords: 15, nec: 14 },
          { nec_block: 10, ntotalwords: 44, ndatawords: 16, nec: 14 },
        ],
      },
    ],
    nalignment_pos: 4,
    alignment_pos: [6, 34, 62, 90, 0, 0, 0],
  },
  {
    version: 21,
    dimension: 101,
    totalwords: 1156,
    remainder_bits: 4,
    nccindicator: [12, 11, 16, 10],
    level: [
      {
        ndatawords: 932,
        capacity: [2232, 1352, 929, 572],
        necb_group: 2,
        ecb_group: [
          { nec_block: 4, ntotalwords: 144, ndatawords: 116, nec: 14 },
          { nec_block: 4, ntotalwords: 145, ndatawords: 117, nec: 14 },
        ],
      },
      {
        ndatawords: 714,
        capacity: [1708, 1035, 711, 438],
        necb_group: 1,
        ecb_group: [
          { nec_block: 17, ntotalwords: 68, ndatawords: 42, nec: 13 },
          { nec_block: 0, ntotalwords: 0, ndatawords: 0, nec: 0 },
        ],
      },
      {
        ndatawords: 512,
        capacity: [1224, 742, 509, 314],
        necb_group: 2,
        ecb_group: [
          { nec_block: 17, ntotalwords: 50, ndatawords: 22, nec: 14 },
          { nec_block: 6, ntotalwords: 51, ndatawords: 23, nec: 14 },
        ],
      },
      {
        ndatawords: 406,
        capacity: [969, 587, 403, 248],
        necb_group: 2,
        ecb_group: [
          { nec_block: 19, ntotalwords: 46, ndatawords: 16, nec: 15 },
          { nec_block: 6, ntotalwords: 47, ndatawords: 17, nec: 15 },
        ],
      },
    ],
    nalignment_pos: 5,
    alignment_pos: [6, 28, 50, 72, 94, 0, 0],
  },
  {
    version: 22,
    dimension: 105,
    totalwords: 1258,
    remainder_bits: 4,
    nccindicator: [12, 11, 16, 10],
    level: [
      {
        ndatawords: 1006,
        capacity: [2409, 1460, 1003, 618],
        necb_group: 2,
        ecb_group: [
          { nec_block: 2, ntotalwords: 139, ndatawords: 111, nec: 14 },
          { nec_block: 7, ntotalwords: 140, ndatawords: 112, nec: 14 },
        ],
      },
      {
        ndatawords: 782,
        capacity: [1872, 1134, 779, 480],
        necb_group: 1,
        ecb_group: [
          { nec_block: 17, ntotalwords: 74, ndatawords: 46, nec: 14 },
          { nec_block: 0, ntotalwords: 0, ndatawords: 0, nec: 0 },
        ],
      },
      {
        ndatawords: 568,
        capacity: [1358, 823, 565, 348],
        necb_group: 2,
        ecb_group: [
          { nec_block: 7, ntotalwords: 54, ndatawords: 24, nec: 15 },
          { nec_block: 16, ntotalwords: 55, ndatawords: 25, nec: 15 },
        ],
      },
      {
        ndatawords: 442,
        capacity: [1056, 640, 439, 270],
        necb_group: 1,
        ecb_group: [
          { nec_block: 34, ntotalwords: 37, ndatawords: 13, nec: 13 },
          { nec_block: 0, ntotalwords: 0, ndatawords: 0, nec: 0 },
        ],
      },
    ],
    nalignment_pos: 5,
    alignment_pos: [6, 26, 50, 74, 98, 0, 0],
  },
  {
    version: 23,
    dimension: 109,
    totalwords: 1364,
    remainder_bits: 4,
    nccindicator: [12, 11, 16, 10],
    level: [
      {
        ndatawords: 1094,
        capacity: [2620, 1588, 1091, 672],
        necb_group: 2,
        ecb_group: [
          { nec_block: 4, ntotalwords: 151, ndatawords: 121, nec: 15 },
          { nec_block: 5, ntotalwords: 152, ndatawords: 122, nec: 15 },
        ],
      },
      {
        ndatawords: 860,
        capacity: [2059, 1248, 857, 528],
        necb_group: 2,
        ecb_group: [
          { nec_block: 4, ntotalwords: 75, ndatawords: 47, nec: 14 },
          { nec_block: 14, ntotalwords: 76, ndatawords: 48, nec: 14 },
        ],
      },
      {
        ndatawords: 614,
        capacity: [1468, 890, 611, 376],
        necb_group: 2,
        ecb_group: [
          { nec_block: 11, ntotalwords: 54, ndatawords: 24, nec: 15 },
          { nec_block: 14, ntotalwords: 55, ndatawords: 25, nec: 15 },
        ],
      },
      {
        ndatawords: 464,
        capacity: [1108, 672, 461, 284],
        necb_group: 2,
        ecb_group: [
          { nec_block: 16, ntotalwords: 45, ndatawords: 15, nec: 15 },
          { nec_block: 14, ntotalwords: 46, ndatawords: 16, nec: 15 },
        ],
      },
    ],
    nalignment_pos: 5,
    alignment_pos: [6, 30, 54, 78, 102, 0, 0],
  },
  {
    version: 24,
    dimension: 113,
    totalwords: 1474,
    remainder_bits: 4,
    nccindicator: [12, 11, 16, 10],
    level: [
      {
        ndatawords: 1174,
        capacity: [2812, 1704, 1171, 721],
        necb_group: 2,
        ecb_group: [
          { nec_block: 6, ntotalwords: 147, ndatawords: 117, nec: 15 },
          { nec_block: 4, ntotalwords: 148, ndatawords: 118, nec: 15 },
        ],
      },
      {
        ndatawords: 914,
        capacity: [2188, 1326, 911, 561],
        necb_group: 2,
        ecb_group: [
          { nec_block: 6, ntotalwords: 73, ndatawords: 45, nec: 14 },
          { nec_block: 14, ntotalwords: 74, ndatawords: 46, nec: 14 },
        ],
      },
      {
        ndatawords: 664,
        capacity: [1588, 963, 661, 407],
        necb_group: 2,
        ecb_group: [
          { nec_block: 11, ntotalwords: 54, ndatawords: 24, nec: 15 },
          { nec_block: 16, ntotalwords: 55, ndatawords: 25, nec: 15 },
        ],
      },
      {
        ndatawords: 514,
        capacity: [1228, 744, 511, 315],
        necb_group: 2,
        ecb_group: [
          { nec_block: 30, ntotalwords: 46, ndatawords: 16, nec: 15 },
          { nec_block: 2, ntotalwords: 47, ndatawords: 17, nec: 15 },
        ],
      },
    ],
    nalignment_pos: 5,
    alignment_pos: [6, 28, 54, 80, 106, 0, 0],
  },
  {
    version: 25,
    dimension: 117,
    totalwords: 1588,
    remainder_bits: 4,
    nccindicator: [12, 11, 16, 10],
    level: [
      {
        ndatawords: 1276,
        capacity: [3057, 1853, 1273, 784],
        necb_group: 2,
        ecb_group: [
          { nec_block: 8, ntotalwords: 132, ndatawords: 106, nec: 13 },
          { nec_block: 4, ntotalwords: 133, ndatawords: 107, nec: 13 },
        ],
      },
      {
        ndatawords: 1000,
        capacity: [2395, 1451, 997, 614],
        necb_group: 2,
        ecb_group: [
          { nec_block: 8, ntotalwords: 75, ndatawords: 47, nec: 14 },
          { nec_block: 13, ntotalwords: 76, ndatawords: 48, nec: 14 },
        ],
      },
      {
        ndatawords: 718,
        capacity: [1718, 1041, 715, 440],
        necb_group: 2,
        ecb_group: [
          { nec_block: 7, ntotalwords: 54, ndatawords: 24, nec: 15 },
          { nec_block: 22, ntotalwords: 55, ndatawords: 25, nec: 15 },
        ],
      },
      {
        ndatawords: 538,
        capacity: [1286, 779, 535, 330],
        necb_group: 2,
        ecb_group: [
          { nec_block: 22, ntotalwords: 45, ndatawords: 15, nec: 15 },
          { nec_block: 13, ntotalwords: 46, ndatawords: 16, nec: 15 },
        ],
      },
    ],
    nalignment_pos: 5,
    alignment_pos: [6, 32, 58, 84, 110, 0, 0],
  },
  {
    version: 26,
    dimension: 121,
    totalwords: 1706,
    remainder_bits: 4,
    nccindicator: [12, 11, 16, 10],
    level: [
      {
        ndatawords: 1370,
        capacity: [3283, 1990, 1367, 842],
        necb_group: 2,
        ecb_group: [
          { nec_block: 10, ntotalwords: 142, ndatawords: 114, nec: 14 },
          { nec_block: 2, ntotalwords: 143, ndatawords: 115, nec: 14 },
        ],
      },
      {
        ndatawords: 1062,
        capacity: [2544, 1542, 1059, 652],
        necb_group: 2,
        ecb_group: [
          { nec_block: 19, ntotalwords: 74, ndatawords: 46, nec: 14 },
          { nec_block: 4, ntotalwords: 75, ndatawords: 47, nec: 14 },
        ],
      },
      {
        ndatawords: 754,
        capacity: [1804, 1094, 751, 462],
        necb_group: 2,
        ecb_group: [
          { nec_block: 28, ntotalwords: 50, ndatawords: 22, nec: 14 },
          { nec_block: 6, ntotalwords: 51, ndatawords: 23, nec: 14 },
        ],
      },
      {
        ndatawords: 596,
        capacity: [1425, 864, 593, 365],
        necb_group: 2,
        ecb_group: [
          { nec_block: 33, ntotalwords: 46, ndatawords: 16, nec: 15 },
          { nec_block: 4, ntotalwords: 47, ndatawords: 17, nec: 15 },
        ],
      },
    ],
    nalignment_pos: 5,
    alignment_pos: [6, 30, 58, 86, 114, 0, 0],
  },
  {
    version: 27,
    dimension: 125,
    totalwords: 1828,
    remainder_bits: 4,
    nccindicator: [14, 13, 16, 12],
    level: [
      {
        ndatawords: 1468,
        capacity: [3517, 2132, 1465, 902],
        necb_group: 2,
        ecb_group: [
          { nec_block: 8, ntotalwords: 152, ndatawords: 122, nec: 15 },
          { nec_block: 4, ntotalwords: 153, ndatawords: 123, nec: 15 },
        ],
      },
      {
        ndatawords: 1128,
        capacity: [2701, 1637, 1125, 692],
        necb_group: 2,
        ecb_group: [
          { nec_block: 22, ntotalwords: 73, ndatawords: 45, nec: 14 },
          { nec_block: 3, ntotalwords: 74, ndatawords: 46, nec: 14 },
        ],
      },
      {
        ndatawords: 808,
        capacity: [1933, 1172, 805, 496],
        necb_group: 2,
        ecb_group: [
          { nec_block: 8, ntotalwords: 53, ndatawords: 23, nec: 15 },
          { nec_block: 26, ntotalwords: 54, ndatawords: 24, nec: 15 },
        ],
      },
      {
        ndatawords: 628,
        capacity: [1501, 910, 625, 385],
        necb_group: 2,
        ecb_group: [
          { nec_block: 12, ntotalwords: 45, ndatawords: 15, nec: 15 },
          { nec_block: 28, ntotalwords: 46, ndatawords: 16, nec: 15 },
        ],
      },
    ],
    nalignment_pos: 5,
    alignment_pos: [6, 34, 62, 90, 118, 0, 0],
  },
  {
    version: 28,
    dimension: 129,
    totalwords: 1921,
    remainder_bits: 3,
    nccindicator: [14, 13, 16, 12],
    level: [
      {
        ndatawords: 1531,
        capacity: [3669, 2223, 1528, 940],
        necb_group: 2,
        ecb_group: [
          { nec_block: 3, ntotalwords: 147, ndatawords: 117, nec: 15 },
          { nec_block: 10, ntotalwords: 148, ndatawords: 118, nec: 15 },
        ],
      },
      {
        ndatawords: 1193,
        capacity: [2857, 1732, 1190, 732],
        necb_group: 2,
        ecb_group: [
          { nec_block: 3, ntotalwords: 73, ndatawords: 45, nec: 14 },
          { nec_block: 23, ntotalwords: 74, ndatawords: 46, nec: 14 },
        ],
      },
      {
        ndatawords: 871,
        capacity: [2085, 1263, 868, 534],
        necb_group: 2,
        ecb_group: [
          { nec_block: 4, ntotalwords: 54, ndatawords: 24, nec: 15 },
          { nec_block: 31, ntotalwords: 55, ndatawords: 25, nec: 15 },
        ],
      },
      {
        ndatawords: 661,
        capacity: [1581, 958, 658, 405],
        necb_group: 2,
        ecb_group: [
          { nec_block: 11, ntotalwords: 45, ndatawords: 15, nec: 15 },
          { nec_block: 31, ntotalwords: 46, ndatawords: 16, nec: 15 },
        ],
      },
    ],
    nalignment_pos: 6,
    alignment_pos: [6, 26, 50, 74, 98, 122, 0],
  },
  {
    version: 29,
    dimension: 133,
    totalwords: 2051,
    remainder_bits: 3,
    nccindicator: [14, 13, 16, 12],
    level: [
      {
        ndatawords: 1631,
        capacity: [3909, 2369, 1628, 1002],
        necb_group: 2,
        ecb_group: [
          { nec_block: 7, ntotalwords: 146, ndatawords: 116, nec: 15 },
          { nec_block: 7, ntotalwords: 147, ndatawords: 117, nec: 15 },
        ],
      },
      {
        ndatawords: 1267,
        capacity: [3035, 1839, 1264, 778],
        necb_group: 2,
        ecb_group: [
          { nec_block: 21, ntotalwords: 73, ndatawords: 45, nec: 14 },
          { nec_block: 7, ntotalwords: 74, ndatawords: 46, nec: 14 },
        ],
      },
      {
        ndatawords: 911,
        capacity: [2181, 1322, 908, 559],
        necb_group: 2,
        ecb_group: [
          { nec_block: 1, ntotalwords: 53, ndatawords: 23, nec: 15 },
          { nec_block: 37, ntotalwords: 54, ndatawords: 24, nec: 15 },
        ],
      },
      {
        ndatawords: 701,
        capacity: [1677, 1016, 698, 430],
        necb_group: 2,
        ecb_group: [
          { nec_block: 19, ntotalwords: 45, ndatawords: 15, nec: 15 },
          { nec_block: 26, ntotalwords: 46, ndatawords: 16, nec: 15 },
        ],
      },
    ],
    nalignment_pos: 6,
    alignment_pos: [6, 30, 54, 78, 102, 126, 0],
  },
  {
    version: 30,
    dimension: 137,
    totalwords: 2185,
    remainder_bits: 3,
    nccindicator: [14, 13, 16, 12],
    level: [
      {
        ndatawords: 1735,
        capacity: [4158, 2520, 1732, 1066],
        necb_group: 2,
        ecb_group: [
          { nec_block: 5, ntotalwords: 145, ndatawords: 115, nec: 15 },
          { nec_block: 10, ntotalwords: 146, ndatawords: 116, nec: 15 },
        ],
      },
      {
        ndatawords: 1373,
        capacity: [3289, 1994, 1370, 843],
        necb_group: 2,
        ecb_group: [
          { nec_block: 19, ntotalwords: 75, ndatawords: 47, nec: 14 },
          { nec_block: 10, ntotalwords: 76, ndatawords: 48, nec: 14 },
        ],
      },
      {
        ndatawords: 985,
        capacity: [2358, 1429, 982, 604],
        necb_group: 2,
        ecb_group: [
          { nec_block: 15, ntotalwords: 54, ndatawords: 24, nec: 15 },
          { nec_block: 25, ntotalwords: 55, ndatawords: 25, nec: 15 },
        ],
      },
      {
        ndatawords: 745,
        capacity: [1782, 1080, 742, 457],
        necb_group: 2,
        ecb_group: [
          { nec_block: 23, ntotalwords: 45, ndatawords: 15, nec: 15 },
          { nec_block: 25, ntotalwords: 46, ndatawords: 16, nec: 15 },
        ],
      },
    ],
    nalignment_pos: 6,
    alignment_pos: [6, 26, 52, 78, 104, 130, 0],
  },
  {
    version: 31,
    dimension: 141,
    totalwords: 2323,
    remainder_bits: 3,
    nccindicator: [14, 13, 16, 12],
    level: [
      {
        ndatawords: 1843,
        capacity: [4417, 2677, 1840, 1132],
        necb_group: 2,
        ecb_group: [
          { nec_block: 13, ntotalwords: 145, ndatawords: 115, nec: 15 },
          { nec_block: 3, ntotalwords: 146, ndatawords: 116, nec: 15 },
        ],
      },
      {
        ndatawords: 1455,
        capacity: [3486, 2113, 1452, 894],
        necb_group: 2,
        ecb_group: [
          { nec_block: 2, ntotalwords: 74, ndatawords: 46, nec: 14 },
          { nec_block: 29, ntotalwords: 75, ndatawords: 47, nec: 14 },
        ],
      },
      {
        ndatawords: 1033,
        capacity: [2473, 1499, 1030, 634],
        necb_group: 2,
        ecb_group: [
          { nec_block: 42, ntotalwords: 54, ndatawords: 24, nec: 15 },
          { nec_block: 1, ntotalwords: 55, ndatawords: 25, nec: 15 },
        ],
      },
      {
        ndatawords: 793,
        capacity: [1897, 1150, 790, 486],
        necb_group: 2,
        ecb_group: [
          { nec_block: 23, ntotalwords: 45, ndatawords: 15, nec: 15 },
          { nec_block: 28, ntotalwords: 46, ndatawords: 16, nec: 15 },
        ],
      },
    ],
    nalignment_pos: 6,
    alignment_pos: [6, 30, 56, 82, 108, 134, 0],
  },
  {
    version: 32,
    dimension: 145,
    totalwords: 2465,
    remainder_bits: 3,
    nccindicator: [14, 13, 16, 12],
    level: [
      {
        ndatawords: 1955,
        capacity: [4686, 2840, 1952, 1201],
        necb_group: 1,
        ecb_group: [
          { nec_block: 17, ntotalwords: 145, ndatawords: 115, nec: 15 },
          { nec_block: 0, ntotalwords: 0, ndatawords: 0, nec: 0 },
        ],
      },
      {
        ndatawords: 1541,
        capacity: [3693, 2238, 1538, 947],
        necb_group: 2,
        ecb_group: [
          { nec_block: 10, ntotalwords: 74, ndatawords: 46, nec: 14 },
          { nec_block: 23, ntotalwords: 75, ndatawords: 47, nec: 14 },
        ],
      },
      {
        ndatawords: 1115,
        capacity: [2670, 1618, 1112, 684],
        necb_group: 2,
        ecb_group: [
          { nec_block: 10, ntotalwords: 54, ndatawords: 24, nec: 15 },
          { nec_block: 35, ntotalwords: 55, ndatawords: 25, nec: 15 },
        ],
      },
      {
        ndatawords: 845,
        capacity: [2022, 1226, 842, 518],
        necb_group: 2,
        ecb_group: [
          { nec_block: 19, ntotalwords: 45, ndatawords: 15, nec: 15 },
          { nec_block: 35, ntotalwords: 46, ndatawords: 16, nec: 15 },
        ],
      },
    ],
    nalignment_pos: 6,
    alignment_pos: [6, 34, 60, 86, 112, 138, 0],
  },
  {
    version: 33,
    dimension: 149,
    totalwords: 2611,
    remainder_bits: 3,
    nccindicator: [14, 13, 16, 12],
    level: [
      {
        ndatawords: 2071,
        capacity: [4965, 3009, 2068, 1273],
        necb_group: 2,
        ecb_group: [
          { nec_block: 17, ntotalwords: 145, ndatawords: 115, nec: 15 },
          { nec_block: 1, ntotalwords: 146, ndatawords: 116, nec: 15 },
        ],
      },
      {
        ndatawords: 1631,
        capacity: [3909, 2369, 1628, 1002],
        necb_group: 2,
        ecb_group: [
          { nec_block: 14, ntotalwords: 74, ndatawords: 46, nec: 14 },
          { nec_block: 21, ntotalwords: 75, ndatawords: 47, nec: 14 },
        ],
      },
      {
        ndatawords: 1171,
        capacity: [2805, 1700, 1168, 719],
        necb_group: 2,
        ecb_group: [
          { nec_block: 29, ntotalwords: 54, ndatawords: 24, nec: 15 },
          { nec_block: 19, ntotalwords: 55, ndatawords: 25, nec: 15 },
        ],
      },
      {
        ndatawords: 901,
        capacity: [2157, 1307, 898, 553],
        necb_group: 2,
        ecb_group: [
          { nec_block: 11, ntotalwords: 45, ndatawords: 15, nec: 15 },
          { nec_block: 46, ntotalwords: 46, ndatawords: 16, nec: 15 },
        ],
      },
    ],
    nalignment_pos: 6,
    alignment_pos: [6, 30, 58, 86, 114, 142, 0],
  },
  {
    version: 34,
    dimension: 153,
    totalwords: 2761,
    remainder_bits: 3,
    nccindicator: [14, 13, 16, 12],
    level: [
      {
        ndatawords: 2191,
        capacity: [5253, 3183, 2188, 1347],
        necb_group: 2,
        ecb_group: [
          { nec_block: 13, ntotalwords: 145, ndatawords: 115, nec: 15 },
          { nec_block: 6, ntotalwords: 146, ndatawords: 116, nec: 15 },
        ],
      },
      {
        ndatawords: 1725,
        capacity: [4134, 2506, 1722, 1060],
        necb_group: 2,
        ecb_group: [
          { nec_block: 14, ntotalwords: 74, ndatawords: 46, nec: 14 },
          { nec_block: 23, ntotalwords: 75, ndatawords: 47, nec: 14 },
        ],
      },
      {
        ndatawords: 1231,
        capacity: [2949, 1787, 1228, 756],
        necb_group: 2,
        ecb_group: [
          { nec_block: 44, ntotalwords: 54, ndatawords: 24, nec: 15 },
          { nec_block: 7, ntotalwords: 55, ndatawords: 25, nec: 15 },
        ],
      },
      {
        ndatawords: 961,
        capacity: [2301, 1394, 958, 590],
        necb_group: 2,
        ecb_group: [
          { nec_block: 59, ntotalwords: 46, ndatawords: 16, nec: 15 },
          { nec_block: 1, ntotalwords: 47, ndatawords: 17, nec: 15 },
        ],
      },
    ],
    nalignment_pos: 6,
    alignment_pos: [6, 34, 62, 90, 118, 146, 0],
  },
  {
    version: 35,
    dimension: 157,
    totalwords: 2876,
    remainder_bits: 0,
    nccindicator: [14, 13, 16, 12],
    level: [
      {
        ndatawords: 2306,
        capacity: [5529, 3351, 2303, 1417],
        necb_group: 2,
        ecb_group: [
          { nec_block: 12, ntotalwords: 151, ndatawords: 121, nec: 15 },
          { nec_block: 7, ntotalwords: 152, ndatawords: 122, nec: 15 },
        ],
      },
      {
        ndatawords: 1812,
        capacity: [4343, 2632, 1809, 1113],
        necb_group: 2,
        ecb_group: [
          { nec_block: 12, ntotalwords: 75, ndatawords: 47, nec: 14 },
          { nec_block: 26, ntotalwords: 76, ndatawords: 48, nec: 14 },
        ],
      },
      {
        ndatawords: 1286,
        capacity: [3081, 1867, 1283, 790],
        necb_group: 2,
        ecb_group: [
          { nec_block: 39, ntotalwords: 54, ndatawords: 24, nec: 15 },
          { nec_block: 14, ntotalwords: 55, ndatawords: 25, nec: 15 },
        ],
      },
      {
        ndatawords: 986,
        capacity: [2361, 1431, 983, 605],
        necb_group: 2,
        ecb_group: [
          { nec_block: 22, ntotalwords: 45, ndatawords: 15, nec: 15 },
          { nec_block: 41, ntotalwords: 46, ndatawords: 16, nec: 15 },
        ],
      },
    ],
    nalignment_pos: 7,
    alignment_pos: [6, 30, 54, 78, 102, 126, 150],
  },
  {
    version: 36,
    dimension: 161,
    totalwords: 3034,
    remainder_bits: 0,
    nccindicator: [14, 13, 16, 12],
    level: [
      {
        ndatawords: 2434,
        capacity: [5836, 3537, 2431, 1496],
        necb_group: 2,
        ecb_group: [
          { nec_block: 6, ntotalwords: 151, ndatawords: 121, nec: 15 },
          { nec_block: 14, ntotalwords: 152, ndatawords: 122, nec: 15 },
        ],
      },
      {
        ndatawords: 1914,
        capacity: [4588, 2780, 1911, 1176],
        necb_group: 2,
        ecb_group: [
          { nec_block: 6, ntotalwords: 75, ndatawords: 47, nec: 14 },
          { nec_block: 34, ntotalwords: 76, ndatawords: 48, nec: 14 },
        ],
      },
      {
        ndatawords: 1354,
        capacity: [3244, 1966, 1351, 832],
        necb_group: 2,
        ecb_group: [
          { nec_block: 46, ntotalwords: 54, ndatawords: 24, nec: 15 },
          { nec_block: 10, ntotalwords: 55, ndatawords: 25, nec: 15 },
        ],
      },
      {
        ndatawords: 1054,
        capacity: [2524, 1530, 1051, 647],
        necb_group: 2,
        ecb_group: [
          { nec_block: 2, ntotalwords: 45, ndatawords: 15, nec: 15 },
          { nec_block: 64, ntotalwords: 46, ndatawords: 16, nec: 15 },
        ],
      },
    ],
    nalignment_pos: 7,
    alignment_pos: [6, 24, 50, 76, 102, 128, 154],
  },
  {
    version: 37,
    dimension: 165,
    totalwords: 3196,
    remainder_bits: 0,
    nccindicator: [14, 13, 16, 12],
    level: [
      {
        ndatawords: 2566,
        capacity: [6153, 3729, 2563, 1577],
        necb_group: 2,
        ecb_group: [
          { nec_block: 17, ntotalwords: 152, ndatawords: 122, nec: 15 },
          { nec_block: 4, ntotalwords: 153, ndatawords: 123, nec: 15 },
        ],
      },
      {
        ndatawords: 1992,
        capacity: [4775, 2894, 1989, 1224],
        necb_group: 2,
        ecb_group: [
          { nec_block: 29, ntotalwords: 74, ndatawords: 46, nec: 14 },
          { nec_block: 14, ntotalwords: 75, ndatawords: 47, nec: 14 },
        ],
      },
      {
        ndatawords: 1426,
        capacity: [3417, 2071, 1423, 876],
        necb_group: 2,
        ecb_group: [
          { nec_block: 49, ntotalwords: 54, ndatawords: 24, nec: 15 },
          { nec_block: 10, ntotalwords: 55, ndatawords: 25, nec: 15 },
        ],
      },
      {
        ndatawords: 1096,
        capacity: [2625, 1591, 1093, 673],
        necb_group: 2,
        ecb_group: [
          { nec_block: 24, ntotalwords: 45, ndatawords: 15, nec: 15 },
          { nec_block: 46, ntotalwords: 46, ndatawords: 16, nec: 15 },
        ],
      },
    ],
    nalignment_pos: 7,
    alignment_pos: [6, 28, 54, 80, 106, 132, 158],
  },
  {
    version: 38,
    dimension: 169,
    totalwords: 3362,
    remainder_bits: 0,
    nccindicator: [14, 13, 16, 12],
    level: [
      {
        ndatawords: 2702,
        capacity: [6479, 3927, 2699, 1661],
        necb_group: 2,
        ecb_group: [
          { nec_block: 4, ntotalwords: 152, ndatawords: 122, nec: 15 },
          { nec_block: 18, ntotalwords: 153, ndatawords: 123, nec: 15 },
        ],
      },
      {
        ndatawords: 2102,
        capacity: [5039, 3054, 2099, 1292],
        necb_group: 2,
        ecb_group: [
          { nec_block: 13, ntotalwords: 74, ndatawords: 46, nec: 14 },
          { nec_block: 32, ntotalwords: 75, ndatawords: 47, nec: 14 },
        ],
      },
      {
        ndatawords: 1502,
        capacity: [3599, 2181, 1499, 923],
        necb_group: 2,
        ecb_group: [
          { nec_block: 48, ntotalwords: 54, ndatawords: 24, nec: 15 },
          { nec_block: 14, ntotalwords: 55, ndatawords: 25, nec: 15 },
        ],
      },
      {
        ndatawords: 1142,
        capacity: [2735, 1658, 1139, 701],
        necb_group: 2,
        ecb_group: [
          { nec_block: 42, ntotalwords: 45, ndatawords: 15, nec: 15 },
          { nec_block: 32, ntotalwords: 46, ndatawords: 16, nec: 15 },
        ],
      },
    ],
    nalignment_pos: 7,
    alignment_pos: [6, 32, 58, 84, 110, 136, 162],
  },
  {
    version: 39,
    dimension: 173,
    totalwords: 3532,
    remainder_bits: 0,
    nccindicator: [14, 13, 16, 12],
    level: [
      {
        ndatawords: 2812,
        capacity: [6743, 4087, 2809, 1729],
        necb_group: 2,
        ecb_group: [
          { nec_block: 20, ntotalwords: 147, ndatawords: 117, nec: 15 },
          { nec_block: 4, ntotalwords: 148, ndatawords: 118, nec: 15 },
        ],
      },
      {
        ndatawords: 2216,
        capacity: [5313, 3220, 2213, 1362],
        necb_group: 2,
        ecb_group: [
          { nec_block: 40, ntotalwords: 75, ndatawords: 47, nec: 14 },
          { nec_block: 7, ntotalwords: 76, ndatawords: 48, nec: 14 },
        ],
      },
      {
        ndatawords: 1582,
        capacity: [3791, 2298, 1579, 972],
        necb_group: 2,
        ecb_group: [
          { nec_block: 43, ntotalwords: 54, ndatawords: 24, nec: 15 },
          { nec_block: 22, ntotalwords: 55, ndatawords: 25, nec: 15 },
        ],
      },
      {
        ndatawords: 1222,
        capacity: [2927, 1774, 1219, 750],
        necb_group: 2,
        ecb_group: [
          { nec_block: 10, ntotalwords: 45, ndatawords: 15, nec: 15 },
          { nec_block: 67, ntotalwords: 46, ndatawords: 16, nec: 15 },
        ],
      },
    ],
    nalignment_pos: 7,
    alignment_pos: [6, 26, 54, 82, 110, 138, 166],
  },
  {
    version: 40,
    dimension: 177,
    totalwords: 3706,
    remainder_bits: 0,
    nccindicator: [14, 13, 16, 12],
    level: [
      {
        ndatawords: 2956,
        capacity: [7089, 4296, 2953, 1817],
        necb_group: 2,
        ecb_group: [
          { nec_block: 19, ntotalwords: 148, ndatawords: 118, nec: 15 },
          { nec_block: 6, ntotalwords: 149, ndatawords: 119, nec: 15 },
        ],
      },
      {
        ndatawords: 2334,
        capacity: [5596, 3391, 2331, 1435],
        necb_group: 2,
        ecb_group: [
          { nec_block: 18, ntotalwords: 75, ndatawords: 47, nec: 14 },
          { nec_block: 31, ntotalwords: 76, ndatawords: 48, nec: 14 },
        ],
      },
      {
        ndatawords: 1666,
        capacity: [3993, 2420, 1663, 1024],
        necb_group: 2,
        ecb_group: [
          { nec_block: 34, ntotalwords: 54, ndatawords: 24, nec: 15 },
          { nec_block: 34, ntotalwords: 55, ndatawords: 25, nec: 15 },
        ],
      },
      {
        ndatawords: 1276,
        capacity: [3057, 1852, 1273, 784],
        necb_group: 2,
        ecb_group: [
          { nec_block: 20, ntotalwords: 45, ndatawords: 15, nec: 15 },
          { nec_block: 61, ntotalwords: 46, ndatawords: 16, nec: 15 },
        ],
      },
    ],
    nalignment_pos: 7,
    alignment_pos: [6, 30, 58, 86, 114, 142, 170],
  },
]

///|
let exp_to_fac : FixedArray[Int] = [
  1, 2, 4, 8, 16, 32, 64, 128, 29, 58, 116, 232, 205, 135, 19, 38, 76, 152, 45, 90,
  180, 117, 234, 201, 143, 3, 6, 12, 24, 48, 96, 192, 157, 39, 78, 156, 37, 74, 148,
  53, 106, 212, 181, 119, 238, 193, 159, 35, 70, 140, 5, 10, 20, 40, 80, 160, 93,
  186, 105, 210, 185, 111, 222, 161, 95, 190, 97, 194, 153, 47, 94, 188, 101, 202,
  137, 15, 30, 60, 120, 240, 253, 231, 211, 187, 107, 214, 177, 127, 254, 225, 223,
  163, 91, 182, 113, 226, 217, 175, 67, 134, 17, 34, 68, 136, 13, 26, 52, 104, 208,
  189, 103, 206, 129, 31, 62, 124, 248, 237, 199, 147, 59, 118, 236, 197, 151, 51,
  102, 204, 133, 23, 46, 92, 184, 109, 218, 169, 79, 158, 33, 66, 132, 21, 42, 84,
  168, 77, 154, 41, 82, 164, 85, 170, 73, 146, 57, 114, 228, 213, 183, 115, 230,
  209, 191, 99, 198, 145, 63, 126, 252, 229, 215, 179, 123, 246, 241, 255, 227, 219,
  171, 75, 150, 49, 98, 196, 149, 55, 110, 220, 165, 87, 174, 65, 130, 25, 50, 100,
  200, 141, 7, 14, 28, 56, 112, 224, 221, 167, 83, 166, 81, 162, 89, 178, 121, 242,
  249, 239, 195, 155, 43, 86, 172, 69, 138, 9, 18, 36, 72, 144, 61, 122, 244, 245,
  247, 243, 251, 235, 203, 139, 11, 22, 44, 88, 176, 125, 250, 233, 207, 131, 27,
  54, 108, 216, 173, 71, 142, 1,
]

///|
let fac_to_exp : FixedArray[Int] = [
  0, 0, 1, 25, 2, 50, 26, 198, 3, 223, 51, 238, 27, 104, 199, 75, 4, 100, 224, 14,
  52, 141, 239, 129, 28, 193, 105, 248, 200, 8, 76, 113, 5, 138, 101, 47, 225, 36,
  15, 33, 53, 147, 142, 218, 240, 18, 130, 69, 29, 181, 194, 125, 106, 39, 249, 185,
  201, 154, 9, 120, 77, 228, 114, 166, 6, 191, 139, 98, 102, 221, 48, 253, 226, 152,
  37, 179, 16, 145, 34, 136, 54, 208, 148, 206, 143, 150, 219, 189, 241, 210, 19,
  92, 131, 56, 70, 64, 30, 66, 182, 163, 195, 72, 126, 110, 107, 58, 40, 84, 250,
  133, 186, 61, 202, 94, 155, 159, 10, 21, 121, 43, 78, 212, 229, 172, 115, 243,
  167, 87, 7, 112, 192, 247, 140, 128, 99, 13, 103, 74, 222, 237, 49, 197, 254, 24,
  227, 165, 153, 119, 38, 184, 180, 124, 17, 68, 146, 217, 35, 32, 137, 46, 55, 63,
  209, 91, 149, 188, 207, 205, 144, 135, 151, 178, 220, 252, 190, 97, 242, 86, 211,
  171, 20, 42, 93, 158, 132, 60, 57, 83, 71, 109, 65, 162, 31, 45, 67, 216, 183,
  123, 164, 118, 196, 23, 73, 236, 127, 12, 111, 246, 108, 161, 59, 82, 41, 157,
  85, 170, 251, 96, 134, 177, 187, 204, 62, 90, 203, 89, 95, 176, 156, 169, 160,
  81, 11, 245, 22, 235, 122, 117, 44, 215, 79, 174, 213, 233, 230, 231, 173, 232,
  116, 214, 244, 234, 168, 80, 88, 175,
]

///|
let generator : FixedArray[FixedArray[Int]] = [
  [
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    87, 229, 146, 149, 238, 102, 21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    251, 67, 46, 61, 118, 70, 64, 94, 32, 45, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    74, 152, 176, 100, 86, 100, 106, 104, 130, 218, 206, 140, 78, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    8, 183, 61, 91, 202, 37, 51, 58, 58, 237, 140, 124, 5, 99, 105, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    120, 104, 107, 109, 102, 161, 76, 3, 91, 191, 147, 169, 182, 194, 225, 120, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    43, 139, 206, 78, 43, 239, 123, 206, 214, 147, 24, 99, 150, 39, 243, 163, 136,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    215, 234, 158, 94, 184, 97, 118, 170, 79, 187, 152, 148, 252, 179, 5, 98, 96,
    153, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    17, 60, 79, 50, 61, 163, 26, 187, 202, 180, 221, 225, 83, 239, 156, 164, 212,
    212, 188, 190, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0,
  ],
  [
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    210, 171, 247, 242, 93, 230, 14, 109, 221, 53, 200, 74, 8, 172, 98, 80, 219,
    134, 160, 105, 165, 231, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0,
  ],
  [
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    229, 121, 135, 48, 211, 117, 251, 126, 159, 180, 169, 152, 192, 226, 228, 218,
    111, 0, 117, 232, 87, 96, 227, 21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0,
  ],
  [
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    173, 125, 158, 2, 103, 182, 118, 17, 145, 201, 111, 28, 165, 53, 161, 21, 245,
    142, 13, 102, 48, 227, 153, 145, 218, 70, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0,
  ],
  [
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    168, 223, 200, 104, 224, 234, 108, 180, 110, 190, 195, 147, 205, 27, 232, 201,
    21, 43, 245, 87, 42, 195, 212, 119, 242, 37, 9, 123, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0,
  ],
  [
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    41, 173, 145, 152, 216, 31, 179, 182, 50, 48, 110, 86, 239, 96, 222, 125, 42,
    173, 226, 193, 224, 130, 156, 37, 251, 216, 238, 40, 192, 180, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0,
  ],
  [
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    10, 6, 106, 190, 249, 167, 4, 67, 209, 138, 138, 32, 242, 123, 89, 27, 120, 185,
    80, 156, 38, 69, 171, 60, 28, 222, 80, 52, 254, 185, 220, 241, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0,
  ],
  [
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    111, 77, 146, 94, 26, 21, 108, 19, 105, 94, 113, 193, 86, 140, 163, 125, 58,
    158, 229, 239, 218, 103, 56, 70, 114, 61, 183, 129, 167, 13, 98, 62, 129, 51,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    200, 183, 98, 16, 172, 31, 246, 234, 60, 152, 115, 0, 167, 152, 113, 248, 238,
    107, 18, 63, 218, 37, 87, 210, 105, 177, 120, 74, 121, 196, 117, 251, 113, 233,
    30, 120, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    159, 34, 38, 228, 230, 59, 243, 95, 49, 218, 176, 164, 20, 65, 45, 111, 39, 81,
    49, 118, 113, 222, 193, 250, 242, 168, 217, 41, 164, 247, 177, 30, 238, 18, 120,
    153, 60, 193, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    59, 116, 79, 161, 252, 98, 128, 205, 128, 161, 247, 57, 163, 56, 235, 106, 53,
    26, 187, 174, 226, 104, 170, 7, 175, 35, 181, 114, 88, 41, 47, 163, 125, 134,
    72, 20, 232, 53, 35, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    250, 103, 221, 230, 25, 18, 137, 231, 0, 3, 58, 242, 221, 191, 110, 84, 230,
    8, 188, 106, 96, 147, 15, 131, 139, 34, 101, 223, 39, 101, 213, 199, 237, 254,
    201, 123, 171, 162, 194, 117, 50, 96, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    190, 7, 61, 121, 71, 246, 69, 55, 168, 188, 89, 243, 191, 25, 72, 123, 9, 145,
    14, 247, 1, 238, 44, 78, 143, 62, 224, 126, 118, 114, 68, 163, 52, 194, 217,
    147, 204, 169, 37, 130, 113, 102, 73, 181, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    112, 94, 88, 112, 253, 224, 202, 115, 187, 99, 89, 5, 54, 113, 129, 44, 58, 16,
    135, 216, 169, 211, 36, 1, 4, 96, 60, 241, 73, 104, 234, 8, 249, 245, 119, 174,
    52, 25, 157, 224, 43, 202, 223, 19, 82, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    228, 25, 196, 130, 211, 146, 60, 24, 251, 90, 39, 102, 240, 61, 178, 63, 46,
    123, 115, 18, 221, 111, 135, 160, 182, 205, 107, 206, 95, 150, 120, 184, 91,
    21, 247, 156, 140, 238, 191, 11, 94, 227, 84, 50, 163, 39, 34, 108, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    232, 125, 157, 161, 164, 9, 118, 46, 209, 99, 203, 193, 35, 3, 209, 111, 195,
    242, 203, 225, 46, 13, 32, 160, 126, 209, 130, 160, 242, 215, 242, 75, 77, 42,
    189, 32, 113, 65, 124, 69, 228, 114, 235, 175, 124, 170, 215, 232, 133, 205,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    116, 50, 86, 186, 50, 220, 251, 89, 192, 46, 86, 127, 124, 19, 184, 233, 151,
    215, 22, 14, 59, 145, 37, 242, 203, 134, 254, 89, 190, 94, 59, 65, 124, 113,
    100, 233, 235, 121, 22, 76, 86, 97, 39, 242, 200, 220, 101, 33, 239, 254, 116,
    51, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    183, 26, 201, 87, 210, 221, 113, 21, 46, 65, 45, 50, 238, 184, 249, 225, 102,
    58, 209, 218, 109, 165, 26, 95, 184, 192, 52, 245, 35, 254, 238, 175, 172, 79,
    123, 25, 122, 43, 120, 108, 215, 80, 128, 201, 235, 8, 153, 59, 101, 31, 198,
    76, 31, 156, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    106, 120, 107, 157, 164, 216, 112, 116, 2, 91, 248, 163, 36, 201, 202, 229, 6,
    144, 254, 155, 135, 208, 170, 209, 12, 139, 127, 142, 182, 249, 177, 174, 190,
    28, 10, 85, 239, 184, 101, 124, 152, 206, 96, 23, 163, 61, 27, 196, 247, 151,
    154, 202, 207, 20, 61, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    82, 116, 26, 247, 66, 27, 62, 107, 252, 182, 200, 185, 235, 55, 251, 242, 210,
    144, 154, 237, 176, 141, 192, 248, 152, 249, 206, 85, 253, 142, 65, 165, 125,
    23, 24, 30, 122, 240, 214, 6, 129, 218, 29, 145, 127, 134, 206, 245, 117, 29,
    41, 63, 159, 142, 233, 125, 148, 123, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    107, 140, 26, 12, 9, 141, 243, 197, 226, 197, 219, 45, 211, 101, 219, 120, 28,
    181, 127, 6, 100, 247, 2, 205, 198, 57, 115, 219, 101, 109, 160, 82, 37, 38,
    238, 49, 160, 209, 121, 86, 11, 124, 30, 181, 84, 25, 194, 87, 65, 102, 190,
    220, 70, 27, 209, 16, 89, 7, 33, 240, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    65, 202, 113, 98, 71, 223, 248, 118, 214, 94, 0, 122, 37, 23, 2, 228, 58, 121,
    7, 105, 135, 78, 243, 118, 70, 76, 223, 89, 72, 50, 70, 111, 194, 17, 212, 126,
    181, 35, 221, 117, 235, 11, 229, 149, 147, 123, 213, 40, 115, 6, 200, 100, 26,
    246, 182, 218, 127, 215, 36, 186, 110, 106, 0, 0, 0, 0, 0, 0,
  ],
  [
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    45, 51, 175, 9, 7, 158, 159, 49, 68, 119, 92, 123, 177, 204, 187, 254, 200, 78,
    141, 149, 119, 26, 127, 53, 160, 93, 199, 212, 29, 24, 145, 156, 208, 150, 218,
    209, 4, 216, 91, 47, 184, 146, 47, 140, 195, 195, 125, 242, 238, 63, 99, 108,
    140, 230, 242, 31, 204, 11, 178, 243, 217, 156, 213, 231, 0, 0, 0, 0,
  ],
  [
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    5, 118, 222, 180, 136, 136, 162, 51, 46, 117, 13, 215, 81, 17, 139, 247, 197,
    171, 95, 173, 65, 137, 178, 68, 111, 95, 101, 41, 72, 214, 169, 197, 95, 7, 44,
    154, 77, 111, 236, 40, 121, 143, 63, 87, 80, 253, 240, 126, 217, 77, 34, 232,
    106, 50, 168, 82, 76, 146, 67, 106, 171, 25, 132, 93, 45, 105, 0, 0,
  ],
  [
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  ],
  [
    247, 159, 223, 33, 224, 93, 77, 70, 90, 160, 32, 254, 43, 150, 84, 101, 190,
    205, 133, 52, 60, 202, 165, 220, 203, 151, 93, 84, 15, 84, 253, 173, 160, 89,
    227, 52, 199, 97, 95, 231, 52, 177, 41, 125, 137, 241, 166, 225, 118, 2, 54,
    32, 82, 215, 175, 198, 43, 238, 235, 27, 101, 184, 127, 3, 5, 8, 163, 238,
  ],
]

///|
let version_info : FixedArray[Int64] = [
  -1L, -1L, -1L, -1L, -1L, -1L, -1L, 0x07c94L, 0x085bcL, 0x09a99L, 0x0a4d3L, 0x0bbf6L,
  0x0c762L, 0x0d847L, 0x0e60dL, 0x0f928L, 0x10b78L, 0x1145dL, 0x12a17L, 0x13532L,
  0x149a6L, 0x15683L, 0x168c9L, 0x177ecL, 0x18ec4L, 0x191e1L, 0x1afabL, 0x1b08eL,
  0x1cc1aL, 0x1d33fL, 0x1ed75L, 0x1f250L, 0x209d5L, 0x216f0L, 0x228baL, 0x2379fL,
  0x24b0bL, 0x2542eL, 0x26a64L, 0x27541L, 0x28c69L,
]

///|
let alnum : FixedArray[Int] = [
  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 36, -1, -1, -1, 37, 38, -1, -1,
  -1, -1, 39, 40, -1, 41, 42, 43, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 44, -1, -1, -1, -1,
  -1, -1, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27,
  28, 29, 30, 31, 32, 33, 34, 35, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
]

///|
fn make_pdp_pos(dimension : Int) -> PosBox {
  PosBox::from_array([
    [0, 0],
    [1, 0],
    [2, 0],
    [3, 0],
    [4, 0],
    [5, 0],
    [6, 0],
    [0, 1],
    [0, 2],
    [0, 3],
    [0, 4],
    [0, 5],
    [0, 6],
    [6, 1],
    [6, 2],
    [6, 3],
    [6, 4],
    [6, 5],
    [6, 6],
    [1, 6],
    [2, 6],
    [3, 6],
    [4, 6],
    [5, 6],
    [2, 2],
    [3, 2],
    [4, 2],
    [2, 3],
    [3, 3],
    [4, 3],
    [2, 4],
    [3, 4],
    [4, 4],
    [0, dimension - 7],
    [1, dimension - 7],
    [2, dimension - 7],
    [3, dimension - 7],
    [4, dimension - 7],
    [5, dimension - 7],
    [6, dimension - 7],
    [0, dimension - 6],
    [0, dimension - 5],
    [0, dimension - 4],
    [0, dimension - 3],
    [0, dimension - 2],
    [0, dimension - 1],
    [6, dimension - 6],
    [6, dimension - 5],
    [6, dimension - 4],
    [6, dimension - 3],
    [6, dimension - 2],
    [6, dimension - 1],
    [1, dimension - 1],
    [2, dimension - 1],
    [3, dimension - 1],
    [4, dimension - 1],
    [5, dimension - 1],
    [2, dimension - 5],
    [3, dimension - 5],
    [4, dimension - 5],
    [2, dimension - 4],
    [3, dimension - 4],
    [4, dimension - 4],
    [2, dimension - 3],
    [3, dimension - 3],
    [4, dimension - 3],
    [dimension - 7, dimension - 7],
    [dimension - 6, dimension - 7],
    [dimension - 5, dimension - 7],
    [dimension - 4, dimension - 7],
    [dimension - 3, dimension - 7],
    [dimension - 2, dimension - 7],
    [dimension - 1, dimension - 7],
    [dimension - 7, dimension - 6],
    [dimension - 7, dimension - 5],
    [dimension - 7, dimension - 4],
    [dimension - 7, dimension - 3],
    [dimension - 7, dimension - 2],
    [dimension - 7, dimension - 1],
    [dimension - 1, dimension - 6],
    [dimension - 1, dimension - 5],
    [dimension - 1, dimension - 4],
    [dimension - 1, dimension - 3],
    [dimension - 1, dimension - 2],
    [dimension - 1, dimension - 1],
    [dimension - 6, dimension - 1],
    [dimension - 5, dimension - 1],
    [dimension - 4, dimension - 1],
    [dimension - 3, dimension - 1],
    [dimension - 2, dimension - 1],
    [dimension - 5, dimension - 5],
    [dimension - 4, dimension - 5],
    [dimension - 3, dimension - 5],
    [dimension - 5, dimension - 4],
    [dimension - 4, dimension - 4],
    [dimension - 3, dimension - 4],
    [dimension - 5, dimension - 3],
    [dimension - 4, dimension - 3],
    [dimension - 3, dimension - 3],
  ])
}

///|
fn make_timing_pos(dimension : Int) -> PosBox {
  let posbox = PosBox::new()
  for i = 8; i <= dimension - 9; i = i + 2 {
    posbox.add_pos(Pos::new(6, i))
  }
  for i = 8; i <= dimension - 9; i = i + 2 {
    posbox.add_pos(Pos::new(i, dimension - 7))
  }
  posbox
}

///|
fn make_function_pattern_pos(
  version : Int,
  dimension : Int,
  ap : FixedArray[Int],
  nap : Int
) -> PosSet {
  let function_pattern = PosSet::new()

  // Around Alignment Pattern
  for i in 0..<nap {
    for j in 0..<nap {
      if (ap[i] == 6 && ap[j] == 6) ||
        (ap[i] == 6 && ap[j] == dimension - 7) ||
        (ap[i] == dimension - 7 && ap[j] == dimension - 7) {
        continue
      }
      function_pattern.add_pos(Pos::new(ap[i], ap[j])) // center
      for k in -2..=2 {
        for l in -2..=2 {
          function_pattern.add_pos(Pos::new(ap[i] + k, ap[j] + l))
        }
      }
    }
  }

  // Around Position Detection Pattern
  function_pattern.add_rect(Pos::new(0, 0), Pos::new(7, 7))
  function_pattern.add_rect(
    Pos::new(0, dimension - 1),
    Pos::new(7, dimension - 8),
  )
  function_pattern.add_rect(
    Pos::new(dimension - 8, dimension - 8),
    Pos::new(dimension - 1, dimension - 1),
  )

  // Around Timing Pattern
  function_pattern.add_rect(Pos::new(6, 8), Pos::new(6, dimension - 10))
  function_pattern.add_rect(
    Pos::new(9, dimension - 7),
    Pos::new(dimension - 9, dimension - 7),
  )

  // Around Format Information
  function_pattern.add_rect(
    Pos::new(8, dimension - 1),
    Pos::new(8, dimension - 9),
  )
  function_pattern.add_rect(
    Pos::new(0, dimension - 9),
    Pos::new(8, dimension - 9),
  )
  function_pattern.add_rect(
    Pos::new(dimension - 8, dimension - 9),
    Pos::new(dimension - 1, dimension - 9),
  )
  function_pattern.add_rect(Pos::new(8, 0), Pos::new(8, 7))

  // Around Version Infomation(Version >= 7)
  if version >= 7 {
    function_pattern.add_rect(Pos::new(0, 8), Pos::new(5, 10))
    function_pattern.add_rect(
      Pos::new(dimension - 9, dimension - 1),
      Pos::new(dimension - 11, dimension - 6),
    )
  }
  function_pattern
}

///|
fn make_alignment_pos(
  ap : FixedArray[Int],
  nap : Int,
  dimension : Int
) -> PosBox {
  let ap_box = PosBox::new()
  for i in 0..<nap {
    for j in 0..<nap {
      if (ap[i] == 6 && ap[j] == 6) ||
        (ap[i] == 6 && ap[j] == dimension - 7) ||
        (ap[i] == dimension - 7 && ap[j] == dimension - 7) {
        continue
      } else {
        ap_box.add_pos(Pos::new(ap[i], ap[j]))
      }
    }
  } //center
  for pos in ap_box.box {
    ap_box.add_rect(
      Pos::new(pos.x - 2, pos.y + 2),
      Pos::new(pos.x + 2, pos.y + 2),
    )
    ap_box.add_rect(
      Pos::new(pos.x - 2, pos.y + 1),
      Pos::new(pos.x - 2, pos.y - 2),
    )
    ap_box.add_rect(
      Pos::new(pos.x - 1, pos.y - 2),
      Pos::new(pos.x + 2, pos.y - 2),
    )
    ap_box.add_rect(
      Pos::new(pos.x + 2, pos.y - 1),
      Pos::new(pos.x + 2, pos.y + 1),
    )
  }
  ap_box
}

///|
fn make_format_pos(dimension : Int) -> (PosBox, PosBox) {
  (
    PosBox::from_array([
      [8, dimension - 1],
      [8, dimension - 2],
      [8, dimension - 3],
      [8, dimension - 4],
      [8, dimension - 5],
      [8, dimension - 6],
      [8, dimension - 8],
      [8, dimension - 9],
      [7, dimension - 9],
      [5, dimension - 9],
      [4, dimension - 9],
      [3, dimension - 9],
      [2, dimension - 9],
      [1, dimension - 9],
      [0, dimension - 9],
    ]),
    PosBox::from_array([
      [dimension - 1, dimension - 9],
      [dimension - 2, dimension - 9],
      [dimension - 3, dimension - 9],
      [dimension - 4, dimension - 9],
      [dimension - 5, dimension - 9],
      [dimension - 6, dimension - 9],
      [dimension - 7, dimension - 9],
      [dimension - 8, dimension - 9],
      [8, 6],
      [8, 5],
      [8, 4],
      [8, 3],
      [8, 2],
      [8, 1],
      [8, 0],
    ]),
  )
}

///|
fn make_version_pos(dimension : Int) -> (PosBox, PosBox) {
  (
    PosBox::from_array([
      [0, 10],
      [0, 9],
      [0, 8],
      [1, 10],
      [1, 9],
      [1, 8],
      [2, 10],
      [2, 9],
      [2, 8],
      [3, 10],
      [3, 9],
      [3, 8],
      [4, 10],
      [4, 9],
      [4, 8],
      [5, 10],
      [5, 9],
      [5, 8],
    ]),
    PosBox::from_array([
      [dimension - 11, dimension - 1],
      [dimension - 10, dimension - 1],
      [dimension - 9, dimension - 1],
      [dimension - 11, dimension - 2],
      [dimension - 10, dimension - 2],
      [dimension - 9, dimension - 2],
      [dimension - 11, dimension - 3],
      [dimension - 10, dimension - 3],
      [dimension - 9, dimension - 3],
      [dimension - 11, dimension - 4],
      [dimension - 10, dimension - 4],
      [dimension - 9, dimension - 4],
      [dimension - 11, dimension - 5],
      [dimension - 10, dimension - 5],
      [dimension - 9, dimension - 5],
      [dimension - 11, dimension - 6],
      [dimension - 10, dimension - 6],
      [dimension - 9, dimension - 6],
    ]),
  )
}
