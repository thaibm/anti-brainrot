#!/usr/bin/env bash
# Checks that the rules and both language versions of the docs stay in sync:
#   - docs/vi and docs/en contain the same files (recursively);
#   - both requirements tables list the same IDs;
#   - every active requirement has a <!-- R-xx --> marker in rules/mentor.md, and every marker is active;
#   - every active requirement has a test scenario in docs/vi/maintainers/testing.md.
set -euo pipefail

KIT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
RULES="$KIT_DIR/rules/mentor.md"
VI="$KIT_DIR/docs/vi/maintainers/requirements.md"
EN="$KIT_DIR/docs/en/maintainers/requirements.md"
TESTING="$KIT_DIR/docs/vi/maintainers/testing.md"
failed=0

# Requirement rows look like: | <a id="r-01"></a>R-01 | ... | active |
table_ids() {
  grep -E '^\| <a id="r-[0-9]+"></a>R-[0-9]+ ' "$1" | grep -oE '^\| <a id="r-[0-9]+"></a>R-[0-9]+' | grep -oE 'R-[0-9]+' | sort -u
}

active_ids() {
  grep -E '^\| <a id="r-[0-9]+"></a>R-[0-9]+ .*\| active \|$' "$1" | grep -oE '^\| <a id="r-[0-9]+"></a>R-[0-9]+' | grep -oE 'R-[0-9]+' | sort -u
}

rule_ids() {
  grep -oE '<!-- (R-[0-9]+ ?)+ -->' "$1" | grep -oE 'R-[0-9]+' | sort -u
}

doc_files() {
  (cd "$KIT_DIR/docs/$1" && find . -name '*.md' | sort)
}

compare() {
  local label="$1" left="$2" right="$3"
  if [ "$left" != "$right" ]; then
    echo "FAIL: $label"
    diff <(echo "$left") <(echo "$right") | grep -E '^[<>]' || true
    failed=1
  else
    echo "ok:   $label"
  fi
}

compare "docs/vi vs docs/en file list" "$(doc_files vi)" "$(doc_files en)"
compare "requirement IDs, vi vs en" "$(table_ids "$VI")" "$(table_ids "$EN")"
compare "active requirements vs rules/mentor.md markers" "$(active_ids "$VI")" "$(rule_ids "$RULES")"
# The compatibility table also has "| R-xx |" rows, so compare against scenario rows only (lines with 4 cells).
compare "active requirements vs test scenarios" "$(active_ids "$VI")" \
  "$(grep -E '^\| R-[0-9]+ \|[^|]+\|[^|]+\|[^|]+\|$' "$TESTING" | grep -oE '^\| R-[0-9]+' | grep -oE 'R-[0-9]+' | sort -u)"

exit "$failed"
