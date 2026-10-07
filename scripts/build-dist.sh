#!/usr/bin/env bash
set -euo pipefail

# =========================================================
# Below is a complete refactor of your build script that:
# 
# Builds the core framework bundle (all.puml)
# Builds a separate bundle for every theme found under themes/*
# Produces:
# all.puml
# theme-{theme}.puml
# Generates repository trees for the core build and each theme build
# Reuses the same compilation logic for all bundles
# Keeps your variable and skinparam extraction logic for the core framework bundle only (you could later extend this to themes if desired)
# =========================================================

# =========================================================
# Configuration
# =========================================================



SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

CORE_ENTRY="src/all.puml"

THEMES_DIR="src/themes"

DIST_DIR=""
OUTPUT_FILE="${DIST_DIR}all.puml"

DOC_DIR="docs/dist-auto-generated"

DIST_README="${DOC_DIR}/_dist-metadata.md"
DIST_TREE="${DOC_DIR}/_repository-structure.md"
DIST_DEFAULTVARS="${DOC_DIR}/_default-variables.md"
DIST_SKINPARAMS="${DOC_DIR}/_skin-params.md"

# =========================================================
# Setup
# =========================================================

if [[ -n "${DIST_DIR:-}" ]]; then
    mkdir -p "$DIST_DIR"
fi

mkdir -p "$DOC_DIR"

LAST_COMMIT=$(git rev-parse HEAD)
LAST_COMMIT_MESSAGE=$(git log -1 --pretty=%B)

BUILD_TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S %Z')

# =========================================================
# Generic Bundle Compiler
# =========================================================

compile_bundle() {

    local entry_file="$1"
    local output_file="$2"
    local tree_file="$3"
    local bundle_name="$4"

    echo "' ========================================================" > "$output_file"
    echo "' Combined PlantUML Library Bundle (SASS-Style Compilation)" >> "$output_file"
    echo "' Bundle Name: $bundle_name" >> "$output_file"
    echo "' Generated on: $BUILD_TIMESTAMP" >> "$output_file"
    echo "' Build Commit Hash: $LAST_COMMIT" >> "$output_file"
    echo "' Build Commit Comment: $LAST_COMMIT_MESSAGE" >> "$output_file"
    echo "' ========================================================" >> "$output_file"
    echo "" >> "$output_file"

    echo "$entry_file (Root Master)" > "$tree_file"

    compile_file "$entry_file" 1 "$output_file" "$tree_file"

    echo "└── Successfully compiled '$bundle_name' into '$output_file'"
}

# =========================================================
# Recursive Compiler
# =========================================================

compile_file() {

    local target_file="$1"
    local depth="$2"
    local output_file="$3"
    local tree_file="$4"

    local current_dir
    current_dir=$(dirname "$target_file")

    if [[ ! -f "$target_file" ]]; then
        echo "└──X Warning: File not found -> $target_file" >&2
        return
    fi

    while IFS= read -r line || [[ -n "$line" ]]; do

        if [[ "$line" =~ ^[[:space:]]*\!include[[:space:]]+([^[:space:]]+) ]]; then

            local relative_include="${BASH_REMATCH[1]}"
            local full_path="$current_dir/$relative_include"

            local indent=""
            for ((i=0; i<depth; i++)); do
                indent+="  "
            done

            echo "${indent}└── $relative_include" >> "$tree_file"

            echo "' --- Importing: $full_path ---" >> "$output_file"

            compile_file \
                "$full_path" \
                $((depth + 1)) \
                "$output_file" \
                "$tree_file"

            echo "' --- End Import: $full_path ---" >> "$output_file"
            echo "" >> "$output_file"

        elif [[ ! "$line" =~ ^@startuml && ! "$line" =~ ^@enduml ]]; then

            echo "$line" >> "$output_file"

        fi

    done < "$target_file"
}

# =========================================================
# Build Core Framework Bundle
# =========================================================

CORE_TREE=$(mktemp)

compile_bundle \
    "$CORE_ENTRY" \
    "$OUTPUT_FILE" \
    "$CORE_TREE" \
    "Core Framework"

# =========================================================
# Extract Core Variables
# =========================================================

defaultvars=$(
    "$SCRIPT_DIR/extract-default-variables.sh" "$OUTPUT_FILE"
)

cat << EOF > "$DIST_DEFAULTVARS"
# All Override PlantUML Variables

This list is generated from the repository's puml source code.

Use these variables before loading the repository.

\`\`\`plantuml
@startuml

$defaultvars

@enduml
\`\`\`
EOF

echo "└── Successfully parsed PlantUML default variables to '$DIST_DEFAULTVARS'"

# =========================================================
# Extract Core SkinParams
# =========================================================

skinparams=$(
    "$SCRIPT_DIR/extract-skinparams.sh" "$OUTPUT_FILE"
)

cat << EOF > "$DIST_SKINPARAMS"
# All Defined PlantUML skinparam Variables

This list is generated from the repository's puml source code.

Skin parameters can be re-initialized after including the repository.

\`\`\`plantuml
@startuml

$skinparams

@enduml
\`\`\`
EOF

echo "└── Successfully parsed PlantUML skinparam variables to '$DIST_SKINPARAMS'"

# =========================================================
# Build Theme Bundles
# =========================================================

THEME_TREE_DOC="${DOC_DIR}/_themes.md"

cat << EOF > "$THEME_TREE_DOC"
# Theme Bundles

Generated theme distribution bundles.

EOF

if [[ -d "$THEMES_DIR" ]]; then

    echo ""
    echo "Building Theme Bundles"
    echo "======================"

    for theme_dir in "$THEMES_DIR"/*; do

        [[ -d "$theme_dir" ]] || continue

        theme_name=$(basename "$theme_dir")

        theme_entry="${theme_dir}/index.puml"

        if [[ ! -f "$theme_entry" ]]; then
            echo "└── Skipping '$theme_name' (no index.puml)"
            continue
        fi

        theme_output="${DIST_DIR}theme-${theme_name}.puml"

        theme_tree=$(mktemp)

        compile_bundle \
            "$theme_entry" \
            "$theme_output" \
            "$theme_tree" \
            "Theme: ${theme_name}"

        tree_content=$(cat "$theme_tree")

        cat << EOF >> "$THEME_TREE_DOC"

---

## theme-${theme_name}.puml

\`\`\`text
$tree_content
\`\`\`

EOF

        rm -f "$theme_tree"

    done

fi

# =========================================================
# Core Tree Documentation
# =========================================================

TREE_CONTENT=$(cat "$CORE_TREE")

cat << EOF > "$DIST_TREE"
## 📦 Bundled Repository Tree

This tree maps out exactly how the source code files were evaluated and sequenced into the final \`all.puml\` production asset.

\`\`\`text
$TREE_CONTENT
\`\`\`
EOF

# =========================================================
# Metadata
# =========================================================

cat << EOF > "$DIST_README"
# Production Distribution Bundle

This directory contains the production-ready distribution assets compiled via SASS-style dependency architecture.

## Core Bundle

* Compiled Bundle: **\`all.puml\`**

## Theme Bundles

Any discovered theme repositories are compiled as:

\`\`\`text
theme-<theme-name>.puml
\`\`\`

Example:

\`\`\`text
theme-corporate.puml
theme-panelapp.puml
\`\`\`

## Build Metadata

* Generated on: **$BUILD_TIMESTAMP**
* Build Commit Hash: **$LAST_COMMIT**
* Build Commit Comment: **$LAST_COMMIT_MESSAGE**

## Usage

\`\`\`plantuml
@startuml

!define MBpuml https://markbodach.github.io/plantuml

!includeurl MBpuml/all.puml

!includeurl MBpuml/theme-corporate.puml

Register_Theme("Corporate")

Load_Lib_Styles_All()

@enduml
\`\`\`

EOF

echo "└── Successfully generated production metadata"
echo "└── Successfully generated repository tree"
echo "└── Successfully generated theme bundle documentation"

rm -f "$CORE_TREE"

echo ""
echo "Build Completed Successfully"