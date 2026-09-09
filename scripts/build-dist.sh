#!/usr/bin/env bash
set -euo pipefail

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENTRY_POINT="src/all.puml"
DIST_DIR="dist"
OUTPUT_FILE="$DIST_DIR/all.puml"

DOC_DIR="docs/dist-auto-generated"

DIST_README="$DOC_DIR/_dist-metadata.md"
DIST_TREE="$DOC_DIR/_repository-structure.md"
DIST_DEFAULTVARS="$DOC_DIR/_default-variables.md"
DIST_SKINPARAMS="$DOC_DIR/_skin-params.md"



# Ensure output directories exists
mkdir -p "$DIST_DIR"
mkdir -p "$DOC_DIR"

# 1. Write the compiled PUML bundle header with the dynamic Date & Time stamp
echo "' ========================================================" > "$OUTPUT_FILE"
echo "' Combined PlantUML Library Bundle (SASS-Style Compilation)" >> "$OUTPUT_FILE"
echo "' Generated on: $(date '+%Y-%m-%d %H:%M:%S %Z')" >> "$OUTPUT_FILE"
echo "' ========================================================" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# Initialize a temporary file to track the imported tree
TREE_LOG=$(mktemp)
echo "src/all.puml (Root Master)" > "$TREE_LOG"

# 2. Define the recursive compilation and tree-tracking function
compile_file() {
    local target_file=$1
    local depth=$2
    local current_dir
    current_dir=$(dirname "$target_file")

    if [ ! -f "$target_file" ]; then
        echo "└── Warning: File not found -> $target_file" >&2
        return
    fi

    # Read the file line by line safely
    while IFS= read -r line || [ -n "$line" ]; do
        # Regex to capture: !include path/to/file.puml
        if [[ "$line" =~ ^[[:space:]]*\!include[[:space:]]+([^[:space:]]+) ]]; then
            local relative_include="${BASH_REMATCH[1]}"
            local full_path="$current_dir/$relative_include"
            
            # Format indentation for the markdown tree based on call depth
            local indent=""
            for ((i=0; i<depth; i++)); do indent+="  "; done
            echo "${indent}└── $relative_include" >> "$TREE_LOG"
            
            # Write to compiled output
            echo "' --- Importing: $full_path ---" >> "$OUTPUT_FILE"
            compile_file "$full_path" $((depth + 1)) # Recursive call, increments depth
            echo "' --- End Import: $full_path ---" >> "$OUTPUT_FILE"
            echo "" >> "$OUTPUT_FILE"
            
        elif [[ ! "$line" =~ ^@startuml && ! "$line" =~ ^@enduml ]]; then
            echo "$line" >> "$OUTPUT_FILE"
        fi
    done < "$target_file"
}

# 3. Kick off compilation
if [ -f "$ENTRY_POINT" ]; then
    compile_file "$ENTRY_POINT" 1
    echo "└── Successfully compiled library into '$OUTPUT_FILE'"
else
    echo "└── Error: Master entry point '$ENTRY_POINT' not found!" >&2
    exit 1
fi

defaultvars=$("$SCRIPT_DIR/extract-default-variables.sh" "$OUTPUT_FILE" )
cat << EOF > "$DIST_DEFAULTVARS"
# All Override PlantUML Variables
This list is generated from the repository's puml source code.  Use these variables before loading the repository.  

\`\`\`plantuml
@startuml

$defaultvars

@enduml
\`\`\`

EOF

echo "└── Successfully parsed PlantUML default variables to '$DIST_DEFAULTVARS'"


skinparams=$("$SCRIPT_DIR/extract-skinparams.sh" "$OUTPUT_FILE" )
cat << EOF > "$DIST_SKINPARAMS"
# All Defined PlantUML skinparam Variables
This list is generated from the repository's puml source code.  Skin parameters can be re-initialized after including the repository.  

\`\`\`plantuml
@startuml

$skinparams

@enduml
\`\`\`

EOF

echo "└── Successfully parsed PlantUML skinparam variables to '$DIST_SKINPARAMS'"


# 4. Generate the README.md dynamically inside the dist folder
TREE_CONTENT=$(cat "$TREE_LOG")

cat << EOF > "$DIST_README"
# Production Distribution Bundle

This directory contains the production-ready distribution assets compiled via SASS-style dependency architecture.

* **Compiled Bundle:** \`all.puml\`
* **Generated on:** $(date '+%Y-%m-%d %H:%M:%S %Z')

## 🚀 How To Use It

Simply include the compiled production bundle path using your raw GitHub link at the top of your local diagram files:

\`\`\`plantuml
@startuml

&excl;&dollar;OH_THEME_ENABLED = %true()
&excl;&dollar;TOGAF_THEME_ENABLED = %true()

' Archimate and TOGAF
&excl;define MBpuml https://markbodach.github.io/plantuml
&excl;includeurl MBpuml/all.puml


' Your custom components are now available globally!
'MyCustomDatabase(db1, "User Database")
@enduml
\`\`\`

EOF

# Clean up temp file
rm -f "$TREE_LOG"


echo "└── Successfully generated production metadata inside '$DIST_README'"


cat << EOF > "$DIST_TREE"
## 📦 Bundled  Repository Tree
This tree maps out exactly how the source code files were evaluated and sequenced into this final \`all.puml\` production asset:

\`\`\`text
$TREE_CONTENT
\`\`\`
EOF

echo "└── Successfully generated production repository tree inside '$DIST_TREE'"

echo ""