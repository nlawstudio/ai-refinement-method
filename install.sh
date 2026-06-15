#!/usr/bin/env sh
# install.sh — bootstrap the method into a target project directory
#
# Usage:
#   curl -sSL https://raw.githubusercontent.com/nlawstudio/ai-refinement-method/main/install.sh | sh
#   curl -sSL https://raw.githubusercontent.com/nlawstudio/ai-refinement-method/main/install.sh | sh -s -- --target /path/to/project
#
# What it does:
#   - Clones the method repo to a temp directory
#   - Copies the framework files into the target directory:
#     - .claude/agents/, .claude/commands/ (role and skill definitions)
#     - .method/ (trigger profiles and promotion rules)
#     - plans/_templates/ (refinement artifact templates)
#     - METHOD.md, QUICKSTART.md, AGENT_INSTALL.md (documentation references)
#   - Creates AGENTS.md from AGENTS.template.md if one does not already exist
#   - Preserves anything that already exists in the target

set -e

METHOD_REPO="${METHOD_REPO:-https://github.com/nlawstudio/ai-refinement-method.git}"
METHOD_REF="${METHOD_REF:-main}"
TARGET_DIR="$(pwd)"

# Parse arguments
while [ $# -gt 0 ]; do
  case "$1" in
    --target)
      TARGET_DIR="$2"
      shift 2
      ;;
    --ref)
      METHOD_REF="$2"
      shift 2
      ;;
    -h|--help)
      cat <<EOF
Usage: install.sh [--target DIR] [--ref BRANCH_OR_TAG]

  --target DIR    Install into DIR (default: current directory)
  --ref REF       Use a specific branch or tag (default: main)
EOF
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      exit 1
      ;;
  esac
done

if [ ! -d "$TARGET_DIR" ]; then
  echo "Target directory does not exist: $TARGET_DIR" >&2
  exit 1
fi

TEMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TEMP_DIR"' EXIT

echo "▸ Cloning method from $METHOD_REPO ($METHOD_REF)"
git clone --quiet --depth 1 --branch "$METHOD_REF" "$METHOD_REPO" "$TEMP_DIR/method"

METHOD_VERSION="$(cat "$TEMP_DIR/method/VERSION" 2>/dev/null || echo unknown)"
echo "▸ Installing method v$METHOD_VERSION into $TARGET_DIR"

# --- v0.x → v1.0+ migration: rename .harness/ to .method/, HARNESS.md to METHOD.md ---
# Existing installs from v0.x had .harness/ and HARNESS.md. v1.0 renamed both.
# This block detects the old paths and migrates them. Idempotent — re-runs are safe.

if [ -d "$TARGET_DIR/.harness" ] && [ ! -d "$TARGET_DIR/.method" ]; then
  mv "$TARGET_DIR/.harness" "$TARGET_DIR/.method"
  echo "  ✓ migrated .harness/ → .method/ (from v0.x install)"
elif [ -d "$TARGET_DIR/.harness" ] && [ -d "$TARGET_DIR/.method" ]; then
  echo "  ⚠ both .harness/ and .method/ exist in target; merging .harness/ into .method/"
  cp -R "$TARGET_DIR/.harness/." "$TARGET_DIR/.method/"
  rm -rf "$TARGET_DIR/.harness"
  echo "  ✓ merged and removed old .harness/"
fi

if [ -f "$TARGET_DIR/HARNESS.md" ] && [ ! -f "$TARGET_DIR/METHOD.md" ]; then
  rm "$TARGET_DIR/HARNESS.md"
  echo "  ✓ removed old HARNESS.md (replaced by METHOD.md below)"
elif [ -f "$TARGET_DIR/HARNESS.md" ]; then
  rm "$TARGET_DIR/HARNESS.md"
fi

# Migrate gitignore entries from old names
if [ -f "$TARGET_DIR/.gitignore" ]; then
  sed -i.bak 's|^\.harness/handoffs/$|.method/handoffs/|' "$TARGET_DIR/.gitignore" 2>/dev/null && \
    rm -f "$TARGET_DIR/.gitignore.bak"
fi

# --- Framework files (always installed) ---

mkdir -p "$TARGET_DIR/.claude"
cp -R "$TEMP_DIR/method/.claude/agents" "$TARGET_DIR/.claude/"
cp -R "$TEMP_DIR/method/.claude/commands" "$TARGET_DIR/.claude/"
echo "  ✓ .claude/agents/   (10 role definitions)"
echo "  ✓ .claude/commands/ (skills)"

cp -R "$TEMP_DIR/method/.method" "$TARGET_DIR/"
echo "  ✓ .method/         (trigger profiles + promotion rules)"

mkdir -p "$TARGET_DIR/plans"
cp -R "$TEMP_DIR/method/plans/_templates" "$TARGET_DIR/plans/"
echo "  ✓ plans/_templates/ (tree.yaml + manifest.yaml shapes)"

cp "$TEMP_DIR/method/METHOD.md" "$TARGET_DIR/METHOD.md"
cp "$TEMP_DIR/method/QUICKSTART.md" "$TARGET_DIR/QUICKSTART.md"
cp "$TEMP_DIR/method/AGENT_INSTALL.md" "$TARGET_DIR/AGENT_INSTALL.md"
echo "  ✓ METHOD.md, QUICKSTART.md, AGENT_INSTALL.md (documentation)"

# Pre-v2.1 installs shipped the quickstart as TUTORIAL.md — clean up on upgrade.
if [ -f "$TARGET_DIR/TUTORIAL.md" ]; then
  rm "$TARGET_DIR/TUTORIAL.md"
  echo "  ✓ TUTORIAL.md      (removed — replaced by QUICKSTART.md)"
fi

# Pre-2.1 installs shipped INSTALL.md — install/setup now lives in the README.
if [ -f "$TARGET_DIR/INSTALL.md" ]; then
  rm "$TARGET_DIR/INSTALL.md"
  echo "  ✓ INSTALL.md       (removed — install/setup now in the README)"
fi

mkdir -p "$TARGET_DIR/scripts"
cp "$TEMP_DIR/method/scripts/sync-schema.sh" "$TARGET_DIR/scripts/"
cp "$TEMP_DIR/method/scripts/sync-adr-index.sh" "$TARGET_DIR/scripts/"
chmod +x "$TARGET_DIR/scripts/sync-schema.sh" "$TARGET_DIR/scripts/sync-adr-index.sh"
echo "  ✓ scripts/         (sync-schema.sh, sync-adr-index.sh — keep structured refs fresh)"

# --- AGENTS.md — install from template if not already present ---

if [ -f "$TARGET_DIR/AGENTS.md" ]; then
  echo "  ⊘ AGENTS.md       (preserved — already exists in target)"
else
  cp "$TEMP_DIR/method/AGENTS.template.md" "$TARGET_DIR/AGENTS.md"
  echo "  ✓ AGENTS.md       (created from template — fill in the bracketed sections)"
fi

# --- method.config.yaml — install from template if not already present ---

if [ -f "$TARGET_DIR/method.config.yaml" ]; then
  echo "  ⊘ method.config.yaml  (preserved — already exists in target)"
else
  cp "$TEMP_DIR/method/method.config.template.yaml" "$TARGET_DIR/method.config.yaml"
  echo "  ✓ method.config.yaml  (created from template — tracker defaults to none; customise as needed)"
fi

# --- docs/adr/ — leave to the project; just ensure the directory exists ---

if [ ! -d "$TARGET_DIR/docs/adr" ]; then
  mkdir -p "$TARGET_DIR/docs/adr"
  cat > "$TARGET_DIR/docs/adr/README.md" <<'EOF'
# Architecture Decision Records

This directory holds your project's accepted ADRs. The method reads them at
session start and references them throughout refinement and build.

Each ADR follows this shape:

```markdown
# ADR-XXX: Title

## Status
Proposed | Accepted | Superseded by ADR-XXX

## Context
What is the situation that requires a decision?

## Options Considered
What alternatives were evaluated?

## Decision
What was decided?

## Rationale
Why this option over the others?

## Consequences
What becomes easier or harder as a result?

## Compliance Mapping
Optional. Which controls does this decision implement or support?
(SOC 2, ISO 27001, NIST 800-53 if applicable.)

## Date
YYYY
```

ADRs are **append-only**. Once accepted, never edited — superseded by new ADRs.
EOF
  echo "  ✓ docs/adr/       (created — add your project's ADRs here)"
else
  echo "  ⊘ docs/adr/       (preserved — already exists in target)"
fi

# --- VERSION marker ---

mkdir -p "$TARGET_DIR/.method"
echo "$METHOD_VERSION" > "$TARGET_DIR/.method/installed-version"

# --- .gitignore: ensure handoffs are local-only by default ---

GITIGNORE="$TARGET_DIR/.gitignore"
GITIGNORE_LINE=".method/handoffs/"
GITIGNORE_COMMENT="# Method handoffs (session-continuity snapshots — local only by default)"

if [ -f "$GITIGNORE" ]; then
  if ! grep -qE "^\.method/handoffs/" "$GITIGNORE" 2>/dev/null; then
    printf "\n%s\n%s\n" "$GITIGNORE_COMMENT" "$GITIGNORE_LINE" >> "$GITIGNORE"
    echo "  ✓ .gitignore       (appended .method/handoffs/ — handoffs are local-only by default)"
  else
    echo "  ⊘ .gitignore       (already excludes .method/handoffs/)"
  fi
else
  printf "%s\n%s\n" "$GITIGNORE_COMMENT" "$GITIGNORE_LINE" > "$GITIGNORE"
  echo "  ✓ .gitignore       (created with .method/handoffs/ excluded)"
fi

echo ""
echo "▸ Method v$METHOD_VERSION installed."
echo ""
echo "═══════════════════════════════════════════════════════════════════════"
echo "  NEXT STEP — recommended path"
echo "═══════════════════════════════════════════════════════════════════════"
echo ""
echo "  Open Claude Code (or Cursor / Codex) in this directory and paste:"
echo ""
echo "    Install the agentic refinement method in this repo. Follow the"
echo "    instructions in AGENT_INSTALL.md."
echo ""
echo "  The agent will walk you through an 8-step guided install:"
echo "    1. Capture your project context (stack, ADRs, compliance, team)"
echo "    2. Verify the install"
echo "    3. Customise AGENTS.md section by section, with your sign-off"
echo "    4. Set up docs/adr/ (move in existing or interview on first ones)"
echo "    5. Set up structured references (run scripts/sync-schema.sh,"
echo "       wire up Atlas hook or CI for freshness)"
echo "    6. Wire up gbrain MCP and Linear MCP"
echo "    7. Smoke-test via /onboard"
echo "    8. Hand off with a setup summary"
echo ""
echo "  The agent install IS the install. Running ./install.sh just put"
echo "  the framework files in place — the customisation happens in the"
echo "  agent session."
echo ""
echo "═══════════════════════════════════════════════════════════════════════"
echo ""
echo "Manual path (if you'd rather): see https://github.com/nlawstudio/ai-refinement-method#install"
