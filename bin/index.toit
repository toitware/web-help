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
      <a href="$url">$display</a>
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
        <title>Help - Toit</title>
        <link rel="icon" href="assets/images/icon.svg" type="image/svg+xml">
        <link rel="stylesheet" href="assets/css/styles.css">
      </head>
      <body>
        <h1>Help</h1>
        The Toit community provides support through <a href="https://chat.toit.io">Discord</a>, and
        <a href="https://github.com/toitlang/toit/discussions">GitHub Discussions</a>. We
        also answer questions on <a href="https://stackoverflow.com/questions/tagged/toit">Stack Overflow</a>.

        <h2>Topics</h2>
        The following topics have been recently discussed in the Discord channel:
        <ul>
        $(build-entries_ topics --transcripts-dir=transcripts-dir)
        </ul>
        You can also browse the <a href="$all-topics-path">full list of topics</a>.

        <hr>
        <img src="assets/images/toit-logo.inline.svg" alt="Logo" class="center" width="200">
      </body>
    </html>
    """
