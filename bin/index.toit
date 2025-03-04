// Copyright (C) 2025 Toit contributors
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import io

import .utils

MAX-ENTRIES_ := 15

build-entries_ index/Map --transcripts-dir/string -> string:
  buffer := io.Buffer
  entry-count := 0
  index.do --values: | entry/Map |
    url := "$transcripts-dir/$entry["filename"]"
    display := entry["displayName"]
    escaped-display := html-encode display
    buffer.write """
    <li>
      <a href="url">$display</a>
    </li>
    """
    if entry-count > MAX-ENTRIES_:
      return buffer.to-string
  return buffer.to-string


build-main-index index/Map --transcripts-dir/string --all-threads-path/string -> string:
  return """
    <!DOCTYPE html>
    <html>
      <head>
        <title>Help</title>
      </head>
      <body>
        The Toit community provides support through <a href="https://chat.toit.io">Discord</a>, and
        <a href="https://github.com/toitlang/toit/discussions">GitHub Discussions</a>.

        The following topics have been recently discussed in the Discord channel:
        <h1>Help</h1>
        <ul>
        $(build-entries_ index --transcripts-dir=transcripts-dir)
        </ul>
        A full list of topics can be found at <a href="$all-threads-path">All Threads</a>.
      </body>
    </html>
    """
