#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<EOF
Usage:
  $(basename "$0") FILE.puml

Description:
  Extracts all PlantUML skinparam statements, including multiline blocks.

Examples extracted:
  skinparam shadowing \$!SHADOWING
  skinparam BackgroundColor #FFFFFF

  skinparam class {
    BackgroundColor White
    BorderColor Black
  }

Commented lines beginning with "," or "'" are excluded.
EOF
}

if [[ $# -ne 1 ]]; then
  usage >&2
  exit 2
fi

input_file=$1

if [[ ! -f "$input_file" ]]; then
  printf 'Error: file not found: %s\n' "$input_file" >&2
  exit 1
fi

awk '
function count_character(text, character, copy) {
  copy = text
  return gsub(character, "", copy)
}

BEGIN {
  in_skinparam_block = 0
  brace_depth = 0
}

{
  line = $0

  # Remove leading whitespace for comment detection
  trimmed = line
  sub(/^[[:space:]]*/, "", trimmed)

  # Skip PlantUML comment lines
  if (substr(trimmed, 1, 1) == "," ||
      substr(trimmed, 1, 1) == "'\''") {
    next
  }

  # Continue processing an active multiline skinparam block
  if (in_skinparam_block) {
    print line

    brace_depth += count_character(line, "{")
    brace_depth -= count_character(line, "}")

    if (brace_depth <= 0) {
      in_skinparam_block = 0
      brace_depth = 0
    }

    next
  }

  # Match a skinparam statement/block
  if (line ~ /^[[:space:]]*skinparam([[:space:]]|$)/) {
    print line

    opening_braces = count_character(line, "{")
    closing_braces = count_character(line, "}")

    brace_depth = opening_braces - closing_braces

    if (brace_depth > 0) {
      in_skinparam_block = 1
    }

    next
  }
}

END {
  if (in_skinparam_block) {
    print "Warning: unterminated skinparam block in " FILENAME > "/dev/stderr"
    exit 1
  }
}
' "$input_file"