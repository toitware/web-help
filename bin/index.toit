// Copyright (C) 2025 Toit contributors
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import io

import .utils

MAX-ENTRIES_ := 15

build-entries_ topics/Map --transcripts-dir/string -> string:
  buffer := io.Buffer
  entry-count := 0
  topics.do --values: | entry/Map |
    url := "$transcripts-dir/$entry["filename"]"
    display := entry["displayName"]
    escaped-display := html-encode display
    buffer.write """
    <li>
      <a href="url">$display</a>
    </li>
    """
    if entry-count++ > MAX-ENTRIES_:
      return buffer.to-string
  return buffer.to-string

build-main-index topics/Map --transcripts-dir/string --all-topics-path/string -> string:
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
        $(build-entries_ topics --transcripts-dir=transcripts-dir)
        </ul>
        You can also browse the <a href="$all-topics-path">full list of topics</a>.
      </body>
    </html>
    """
