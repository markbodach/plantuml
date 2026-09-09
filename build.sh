#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DIST_DIR="" #"/dist"

echo ""
echo "==========[ Building Distribution ]==========[[["
echo ""
"$ROOT_DIR/scripts/build-dist.sh"

echo ""

echo "Building '${ROOT_DIR}${DIST_DIR}/README.md'"
"${ROOT_DIR}/scripts/merge-markdown.sh" \
    "${ROOT_DIR}/docs/README.template.md" \
    -o "${ROOT_DIR}${DIST_DIR}/README.md"


# Ensure distribution directories exists
if [ -n "${DIST_DIR:-}" ]; then
    cp -f "${ROOT_DIR}${DIST_DIR}/README.md" "${ROOT_DIR}/README.md"
fi


echo ""
echo "]]]==========[ Distribution Completed ]=========="
echo ""