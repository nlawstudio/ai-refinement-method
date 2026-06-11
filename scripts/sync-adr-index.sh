#!/usr/bin/env sh
# sync-adr-index.sh — regenerate docs/adr/INDEX.md from the ADR files
#
# The method reads docs/adr/INDEX.md at session start as part of the structured
# reference layer — it tells agents which decisions exist without loading
# every full ADR. Full ADR text is loaded on demand when referenced.
#
# Run this:
#   - manually after adding or accepting an ADR: ./scripts/sync-adr-index.sh
#   - automatically by the /adr skill once it lands an accepted ADR
#   - automatically via CI on any change to docs/adr/

set -e

ADR_DIR="${ADR_DIR:-docs/adr}"
INDEX="$ADR_DIR/INDEX.md"

if [ ! -d "$ADR_DIR" ]; then
  echo "✗ $ADR_DIR does not exist. Create it first, then add ADRs to it."
  exit 1
fi

# Find ADR files matching ADR-XXX-*.md pattern
adr_files=$(ls "$ADR_DIR"/ADR-*.md 2>/dev/null | sort)

if [ -z "$adr_files" ]; then
  cat > "$INDEX" <<EOF
# ADR Index

Auto-generated from \`docs/adr/ADR-*.md\`. Do not edit by hand.

No accepted ADRs yet. As you accept ADRs via the \`/adr\` skill or by hand,
this index regenerates and lands them here.
EOF
  echo "✓ $INDEX initialised (no ADRs yet)"
  exit 0
fi

{
  echo "# ADR Index"
  echo ""
  echo "Auto-generated from \`docs/adr/ADR-*.md\`. Do not edit by hand."
  echo "Regenerate via \`./scripts/sync-adr-index.sh\`."
  echo ""
  echo "| ID | Title | Status |"
  echo "|---|---|---|"
} > "$INDEX"

for f in $adr_files; do
  base=$(basename "$f" .md)
  # Title is the first H1, stripped of leading "# " and any "ADR-XXX:" prefix
  title=$(head -1 "$f" | sed -E 's/^# //; s/^ADR-[0-9]+:[[:space:]]*//')
  # Status is the line after "## Status"
  status=$(awk '/^## Status/{f=1; next} f && NF{print; exit}' "$f" | tr -d '*' | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')
  [ -z "$status" ] && status="?"
  printf "| [%s](%s) | %s | %s |\n" "$base" "${base}.md" "$title" "$status" >> "$INDEX"
done

echo "✓ $INDEX updated ($(echo "$adr_files" | wc -l | tr -d ' ') ADRs indexed)"
