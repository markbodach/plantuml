#!/usr/bin/env bash
set -euo pipefail

# Recursively merge Markdown files using local relative includes.
#
# Line-level include forms, each occupying its own line:
#   !include relative/path.md
#   !INCLUDE "relative/path.md"
#   <!-- include: relative/path.md -->
#   {% include_relative relative/path.md %}
#
# Inline include form, one or more per line:
#   Text before {{include: relative/path.md}} text after.
#
# Paths are resolved relative to the file containing the directive.
# Include directives inside fenced code blocks are preserved unchanged.

ROOT_DIR="$(pwd)"

INCLUDE_DEPTH=0
INCLUDE_COUNT=0

relative_path() {
local path=$1
echo "${path#"$ROOT_DIR"/}"
}

log_include() {
  local file=$1
  local prefix=""
  local display
  local i

  display=$(realpath --relative-to="$ROOT_DIR" "$file")

  for ((i=0; i<INCLUDE_DEPTH; i++)); do
    prefix+="│   "
  done

  printf '%s└── %s\n' "$prefix" "$display" >&2
  # echo "${prefix}└── $(basename "$file")" >&2
}

usage() {
  cat <<'EOF'
Usage:
  merge-markdown.sh INPUT.md [-o OUTPUT.md]
  merge-markdown.sh INPUT.md > OUTPUT.md

Options:
  -o, --output FILE   Write merged Markdown to FILE.
  -h, --help          Show this help.
EOF
}

input=""
output=""

while (($#)); do
  case "$1" in
    -o|--output)
      (($# >= 2)) || { echo "Error: $1 requires a file." >&2; exit 2; }
      output=$2
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    --)
      shift
      break
      ;;
    -*)
      echo "Error: unknown option: $1" >&2
      usage >&2
      exit 2
      ;;
    *)
      [[ -z "$input" ]] || { echo "Error: only one input file is allowed." >&2; exit 2; }
      input=$1
      shift
      ;;
  esac
done

[[ -n "$input" ]] || { usage >&2; exit 2; }
[[ -f "$input" ]] || { echo "Error: input file not found: $input" >&2; exit 1; }

stack_file=$(mktemp)
tmp_output=""
cleanup() {
  rm -f "$stack_file"
  [[ -z "$tmp_output" ]] || rm -f "$tmp_output"
}
trap cleanup EXIT

canonical_path() {
  local path=$1 dir base
  dir=$(dirname -- "$path")
  base=$(basename -- "$path")
  (cd -- "$dir" 2>/dev/null && printf '%s/%s\n' "$PWD" "$base")
}

trim_and_unquote() {
  local value=$1
  value=$(printf '%s' "$value" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')
  if [[ "$value" =~ ^\"(.*)\"$ ]]; then
    value=${BASH_REMATCH[1]}
  elif [[ "$value" =~ ^\'(.*)\'$ ]]; then
    value=${BASH_REMATCH[1]}
  fi
  printf '%s' "$value"
}

resolve_include() {
  local including_file=$1 target=$2 dir include_path
  target=$(trim_and_unquote "$target")

  if [[ -z "$target" ]]; then
    echo "└── Error: empty include path in $including_file" >&2
    return 1
  fi
  if [[ "$target" = /* ]]; then
    echo "└── Error: include must use a relative path in $including_file: $target" >&2
    return 1
  fi

  dir=$(dirname -- "$including_file")
  include_path="$dir/$target"
  [[ -f "$include_path" ]] || {
    echo "└── Error: included file not found in $including_file: $target ($include_path)" >&2
    return 1
  }
  printf '%s' "$include_path"
}

expand_inline_line() {
  
  local line=$1 including_file=$2
  local inline_re='^(.*)\{\{[[:space:]]*include:[[:space:]]*([^}]+)[[:space:]]*\}\}(.*)$'
  local prefix target suffix include_path replacement

  # The greedy prefix processes the rightmost token first. Repeating the loop
  # expands every inline token while preserving the original token order.
  while [[ "$line" =~ $inline_re ]]; do
    prefix=${BASH_REMATCH[1]}
    target=${BASH_REMATCH[2]}
    suffix=${BASH_REMATCH[3]}
    include_path=$(resolve_include "$including_file" "$target") || return 1
    replacement=$(expand_file "$include_path") || return 1
    line="${prefix}${replacement}${suffix}"
  done

  printf '%s\n' "$line"
}

expand_file() {
  local file=$1 canonical line target include_path fence=0
  local fence_re='^[[:space:]]*(```|~~~)'
  local include_re='^[[:space:]]*![Ii][Nn][Cc][Ll][Uu][Dd][Ee][[:space:]]+(.+)[[:space:]]*$'
  local comment_re='^[[:space:]]*<!--[[:space:]]*[Ii][Nn][Cc][Ll][Uu][Dd][Ee][[:space:]]*:[[:space:]]*(.+)[[:space:]]*-->[[:space:]]*$'
  local jekyll_re='^[[:space:]]*\{%[[:space:]]+include_relative[[:space:]]+(.+)[[:space:]]*%\}[[:space:]]*$'

  canonical=$(canonical_path "$file") || {
    echo "└── Error: cannot resolve path: $file" >&2
    return 1
  }

  log_include "$canonical"
  INCLUDE_DEPTH=$((INCLUDE_DEPTH + 1))
  INCLUDE_COUNT=$((INCLUDE_COUNT + 1))


  if grep -Fqx -- "$canonical" "$stack_file"; then
    echo "Error: recursive include cycle detected at: $canonical" >&2
    echo "Include stack:" >&2
    sed 's/^/  /' "$stack_file" >&2
    return 1
  fi

  printf '%s\n' "$canonical" >> "$stack_file"

  while IFS= read -r line || [[ -n "$line" ]]; do
    if [[ "$line" =~ $fence_re ]]; then
      fence=$((1 - fence))
      printf '%s\n' "$line"
      continue
    fi

    if ((fence != 0)); then
      printf '%s\n' "$line"
      continue
    fi

    target=""
    if [[ "$line" =~ $include_re ]]; then
      target=${BASH_REMATCH[1]}
    elif [[ "$line" =~ $comment_re ]]; then
      target=${BASH_REMATCH[1]}
    elif [[ "$line" =~ $jekyll_re ]]; then
      target=${BASH_REMATCH[1]}
    fi

    if [[ -n "$target" ]]; then
      include_path=$(resolve_include "$canonical" "$target") || return 1
      expand_file "$include_path" || return 1
    else
      expand_inline_line "$line" "$canonical" || return 1
    fi
  done < "$canonical"

  INCLUDE_DEPTH=$((INCLUDE_DEPTH - 1))
  sed -i '$d' "$stack_file"
}

if [[ -n "$output" ]]; then
  tmp_output=$(mktemp)
  expand_file "$input" > "$tmp_output"
  mkdir -p -- "$(dirname -- "$output")"
  mv -- "$tmp_output" "$output"
  tmp_output=""
else
  expand_file "$input"
fi

printf '\nMerged %d Markdown file(s).\n\n' "$INCLUDE_COUNT" >&2