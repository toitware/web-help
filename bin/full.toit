// Copyright (C) 2025 Toit contributors
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import io

import .utils

build-entries_ index/Map --transcripts-dir/string -> string:
  buffer := io.Buffer
  index.do --values: | entry/Map |
    url := "$transcripts-dir/$entry["filename"]"
    display := entry["displayName"]
    escaped-display := html-encode display
    buffer.write """
    <li>
      <a href="$url">$display</a>
    </li>
    """
  return buffer.to-string

build-full index/Map --transcripts-dir/string -> string:
  return """
    <!DOCTYPE html>
    <html>
      <head>
        <title>Help - Toit</title>
        <link rel="icon" href="assets/images/icon.svg" type="image/svg+xml">
        <link rel="stylesheet" href="assets/css/styles.css">
      </head>
      <body>
        <h1>Topics</h1>
        <ul>
        $(build-entries_ index --transcripts-dir=transcripts-dir)
        </ul>

        <hr>
        <img src="assets/images/toit-logo.inline.svg" alt="Logo" class="center" width="200">
      </body>
    </html>
    """
