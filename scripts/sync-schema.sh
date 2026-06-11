#!/usr/bin/env sh
# sync-schema.sh — write the current database schema to docs/schema.sql
#
# The method reads docs/schema.sql at session start as part of the structured
# reference layer. Every Designer, Architect, Builder, and Test Author sees the
# actual data shape — no guessing, no greps, no decisions that contradict reality.
#
# Run this:
#   - manually after a migration: ./scripts/sync-schema.sh
#   - automatically via your migration tool's post-apply hook
#   - automatically via CI on any change to migrations/
#
# Strategy: prefer Atlas if available; fall back to pg_dump --schema-only.
# Schema only — NEVER data. Safe to run against any environment.

set -e

OUTPUT="${SCHEMA_OUTPUT:-docs/schema.sql}"
mkdir -p "$(dirname "$OUTPUT")"

# --- Atlas (preferred if atlas.hcl is present) ---
if command -v atlas >/dev/null 2>&1 && [ -f "atlas.hcl" ]; then
  # Use the dev environment by default; override with ATLAS_ENV
  ATLAS_ENV="${ATLAS_ENV:-dev}"
  atlas schema inspect --env "$ATLAS_ENV" --format '{{ sql . }}' > "$OUTPUT"
  echo "✓ $OUTPUT updated via Atlas (env: $ATLAS_ENV)"
  exit 0
fi

# --- pg_dump fallback ---
if [ -n "${DATABASE_URL:-}" ] && command -v pg_dump >/dev/null 2>&1; then
  pg_dump --schema-only --no-owner --no-privileges --no-comments \
          "$DATABASE_URL" > "$OUTPUT"
  echo "✓ $OUTPUT updated via pg_dump"
  exit 0
fi

# --- Nothing worked ---
cat >&2 <<EOF
✗ Could not sync schema to $OUTPUT

To make this work, either:

  (a) Use Atlas (recommended)
      - Install atlas: https://atlasgo.io/getting-started
      - Add an atlas.hcl in this directory with a 'dev' env (or set ATLAS_ENV)
      - Re-run: ./scripts/sync-schema.sh

  (b) Use pg_dump
      - Ensure pg_dump is installed
      - Set DATABASE_URL to a non-prod database URL
      - Re-run: DATABASE_URL=postgres://... ./scripts/sync-schema.sh

This script writes ONLY the schema (DDL) — never data.
EOF
exit 1
