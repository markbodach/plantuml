#!/usr/bin/env bash
set -euo pipefail

usage() {
    cat <<EOF
Usage:
    $(basename "$0") FILE.puml

Description:
    Extract PlantUML variables defined using:

        !\$VARIABLE ?= value

    Output is sorted alphabetically by variable name and
    ?= is replaced with =.

    Commented lines beginning with "," or "'" are ignored.
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
{
    line = $0

    # Remove leading whitespace
    trimmed = line
    sub(/^[[:space:]]*/, "", trimmed)

    # Skip comments
    first = substr(trimmed,1,1)
    if (first == "," || first == "'\''")
        next

    # Match:
    # !$VARIABLE ?= value
    if (trimmed ~ /^!\$[A-Za-z0-9_]+[[:space:]]*\?=/) {

        output = trimmed
        sub(/\?=/, "=", output)

        # Extract variable name for sorting
        match(trimmed, /^!\$[A-Za-z0-9_]+/)
        varname = substr(trimmed, RSTART, RLENGTH)

        print varname "|" output
    }
}
' "$input_file" |
sort |
cut -d'|' -f2-