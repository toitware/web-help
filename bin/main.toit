// Copyright (C) 2025 Toit contributors
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import cli show *
import encoding.json
import host.file

import .index
import .full

main args:
  cmd := Command "build-help"
      --help="Builds the help.toit.io page."
      --options=[
        Option "transcripts-dir"
            --help="The directory containing the transcripts. Relative to the build directory."
            --required,
      ]
      --rest=[
        Option "build-dir"
            --help="The directory to build the help page in."
            --required,
      ]
      --run=:: build it
  cmd.run args

build invocation/Invocation:
  build-dir := invocation["build-dir"]
  transcripts-dir := invocation["transcripts-dir"]

  encoded-index := file.read-contents "$build-dir/$transcripts-dir/index.json"
  index/Map := json.decode encoded-index

  index-html := build-main-index index
      --transcripts-dir=transcripts-dir
      --all-threads-path="all-threads.html"

  full-html := build-full index --transcripts-dir=transcripts-dir

  file.write-contents --path="$build-dir/index.html" index-html
  file.write-contents --path="$build-dir/all-threads.html" full-html
