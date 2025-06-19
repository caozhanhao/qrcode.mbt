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
/// Format for outputting QR codes in different visual representations.
///
/// Constructors:
///
/// * `ANSI256` : ANSI 256-color terminal format that renders QR codes using
/// colored terminal escape sequences
/// * `JPG` : JPEG image format (not yet implemented)
/// * `PNG` : PNG image format (not yet implemented)
///
pub(all) enum PaintFmt {
  ANSI256

  // TODO
  JPG
  PNG
}

// TODO, file stream

///|
/// Renders a QR code to the console or saves it in a specified visual format.
///
/// Parameters:
///
/// * `self` : The QR code to render.
/// * `fmt` : The output format for rendering the QR code.
///
/// Example:
///
/// ```moonbit
/// test "QRCode::paint" {
///   let builder = QRCodeBuilder::new(data_length=7)
///   let qr = builder.generate("moonbit".to_array().map(fn(c) { c.to_int().to_byte() }))
///   qr.paint(PaintFmt::ANSI256)
/// }
/// ```
///
pub fn QRCode::paint(self : QRCode, fmt : PaintFmt) -> Unit {
  match fmt {
    ANSI256 =>
      for i = self.qr.length() - 1; i >= 0; i = i - 1 {
        let mut buf : String = ""
        for j in 0..<self.qr.length() {
          if self.qr[j][i] {
            buf = buf + "\x1b[48;5;16m  \x1b[0m"
          } else {
            buf = buf + "\x1b[48;5;231m  \x1b[0m"
          }
        }
        println(buf)
      }
    JPG => ...
    PNG => ...
  }
}

///|
test "ANSI256 Output" {
  let tests = ["moonbit", "caozhanhao/qrcode", "opqr", "2025-06-18"]
  for data in tests {
    let builder = QRCodeBuilder::new(data_length=data.length())
    // FIXME
    let qr = builder.generate(
      data.to_array().map(fn(c) { c.to_int().to_byte() }),
    )
    qr.paint(PaintFmt::ANSI256)
    println("-------------------------------------")
  }
}
