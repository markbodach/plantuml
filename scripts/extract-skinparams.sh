#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<EOF
Usage:
  $(basename "$0") FILE.puml

Description:
  Extracts PlantUML skinparam definitions and preserves the
  first occurrence of each setting.

Features:

  - Supports simple skinparams:

        skinparam shadowing false

  - Supports block skinparams:

        skinparam class {
            BackgroundColor White
            BorderColor Black
        }

  - Duplicate properties are ignored after first occurrence.

  - Duplicate blocks are merged.

  - Commented lines beginning with "," or "'" are ignored.

  - Output is normalized and grouped by skinparam block.

Examples:

    skinparam class {
        BackgroundColor White
    }

    skinparam class {
        BorderColor Black
    }

Produces:

    skinparam class {
        BackgroundColor White
        BorderColor Black
    }

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

BEGIN {

    in_block = 0

    block_name = ""

    block_count = 0
    simple_count = 0
}

#
# Trim helper
#
function trim(s) {

    sub(/^[[:space:]]+/, "", s)
    sub(/[[:space:]]+$/, "", s)

    return s
}

{
    line = $0

    trimmed = line
    sub(/^[[:space:]]*/, "", trimmed)

    #
    # Ignore comments
    #
    first = substr(trimmed,1,1)

    if (first == "," || first == "'\''")
        next

    #
    # Continue processing block
    #
    if (in_block) {

        #
        # End block
        #
        if (trimmed ~ /^}/) {

            in_block = 0
            block_name = ""

            next
        }

        #
        # Property line
        #
        if (match(trimmed,/^([A-Za-z0-9_]+)[[:space:]]+(.*)$/,m)) {

            prop = m[1]
            value = m[2]

            key = block_name "." prop

            if (!(key in seen_property)) {

                seen_property[key]=1

                property_value[key]=value

                if (!(block_name SUBSEP prop in block_property_order)) {

                    block_property_order[block_name SUBSEP prop]=1

                    property_list[block_name] = property_list[block_name] prop "\n"

                }
            }
        }

        next
    }

    #
    # Block Start
    #
    if (match(trimmed,
        /^skinparam[[:space:]]+([A-Za-z0-9_]+)[[:space:]]*{$/,
        m))
    {
        block_name = m[1]

        if (!(block_name in seen_block)) {

            seen_block[block_name]=1

            block_count++
            block_order[block_count]=block_name
        }

        in_block = 1

        next
    }

    #
    # Simple skinparam
    #
    if (match(trimmed,
        /^skinparam[[:space:]]+([A-Za-z0-9_]+)[[:space:]]+(.*)$/,
        m))
    {
        param = m[1]

        if (!(param in seen_simple)) {

            seen_simple[param]=1

            simple_count++
            simple_order[simple_count]=param

            simple_value[param]=trimmed
        }

        next
    }

}

END {

    #
    # Simple skinparams
    #
    for (i=1; i<=simple_count; i++) {

        param = simple_order[i]

        print simple_value[param]
    }

    #
    # Blank line between sections
    #
    if (simple_count > 0 && block_count > 0)
        print ""

    #
    # Block skinparams
    #
    for (i=1; i<=block_count; i++) {

        block = block_order[i]

        print "skinparam " block " {"

        n = split(property_list[block], props, "\n")

        for (j=1; j<=n; j++) {

            prop = props[j]

            if (prop == "")
                continue

            key = block "." prop

            print "    " prop " " property_value[key]
        }

        print "}"
        print ""
    }
}
' "$input_file"
