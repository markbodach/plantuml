#!/usr/bin/env bash
set -euo pipefail

usage() {
    cat <<EOF
Usage:
    $(basename "$0") FILE.puml

Description:
    Extract PlantUML variables declared using the pattern:

        !\$VARIABLE ?= value

    The script produces a normalized variable listing suitable for:
    
        - Documentation generation
        - Default variable reference guides
        - Theme variable inventories
        - Framework configuration documentation

Behavior:

    • Only variables defined using '?=' are processed.

    • The first definition of a variable is retained.

      Example:

          !\$COLOR_PRIMARY ?= "#FFFFFF"
          !\$COLOR_PRIMARY ?= "#000000"

      Output:

          !\$COLOR_PRIMARY = "#FFFFFF"

      This matches the framework convention where the first
      declaration typically represents the framework default
      value while later definitions may be theme-specific or
      local overrides.

    • Commented lines are ignored.

      Any line whose first non-whitespace character is:

          ,
          '

      will be skipped.

    • Output is sorted alphabetically by variable name.

    • '?=' is replaced with '=' in the final output to create
      a clean variable reference document.

Examples:

    Extract variables from a compiled framework bundle:

        $(basename "$0") all.puml

    Generate a variable reference file:

        $(basename "$0") all.puml > VARIABLES.puml

Output Format:

    Input:

        !\$SPACING_3 ?= 15

    Output:

        !\$SPACING_3 = 15

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

    #
    # Remove leading whitespace for easier matching.
    #
    trimmed = line
    sub(/^[[:space:]]*/, "", trimmed)

    #
    # Ignore comments.
    #
    # Examples:
    #
    #   '\'' Comment
    #   , Comment
    #
    first = substr(trimmed,1,1)

    if (first == "," || first == "'\''")
        next

    #
    # Match PlantUML variable definitions:
    #
    #   !$VARIABLE ?= value
    #
    if (trimmed ~ /^!\$[A-Za-z0-9_]+[[:space:]]*\?=/) {

        #
        # Create display version where:
        #
        #   ?=  ->  =
        #
        output = trimmed
        sub(/\?=/, "=", output)

        #
        # Extract variable name.
        #
        # Example:
        #
        #   !$COLOR_PRIMARY ?= "#FFFFFF"
        #
        # Produces:
        #
        #   COLOR_PRIMARY
        #
        match(trimmed, /^!\$[A-Za-z0-9_]+/)
        varname = substr(trimmed, RSTART + 2, RLENGTH - 2)

        #
        # First occurrence wins.
        #
        # This preserves framework defaults and prevents
        # later overrides from overwriting the documented
        # default configuration.
        #
        if (!(varname in seen)) {

            seen[varname] = 1

            print varname "|" output
        }
    }
}
' "$input_file" |
sort |
cut -d'|' -f2-
