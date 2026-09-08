#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo ""
echo "==========[ Building Distribution ]==========[[["
echo ""
"$ROOT_DIR/scripts/build-dist.sh"

echo ""

echo "Building '$ROOT_DIR/dist/README.md'"
"$ROOT_DIR/scripts/merge-markdown.sh" \
    "$ROOT_DIR/docs/README.template.md" \
    -o "$ROOT_DIR/dist/README.md"


cp -f "$ROOT_DIR/dist/README.md" "$ROOT_DIR/README.md"

echo ""
echo "]]]==========[ Distribution Completed ]=========="
echo ""