// Copyright (C) 2025 Toit contributors
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

html-encode str/string -> string:
  result := str
  result = result.replace --all "&" "&amp;"
  result = result.replace --all "<" "&lt;"
  result = result.replace --all ">" "&gt;"
  result = result.replace --all "\"" "&quot;"
  return result
