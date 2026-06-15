# Changelog

All notable changes to the method will be documented here. Versions follow [SemVer](https://semver.org/).

---

## [2.2.0] — 2026-06-15

### Added
- **Stewardship layer** — two project-level skills that keep cross-cutting quality legible across the whole project, the across-time complement to the per-epic Definition of Ready:
  - `/posture` — a standing snapshot + trend of UX, testing, compliance, and NFR health; rebuilds the human's mental model and writes a dated record (`docs/quality-posture.md`) so drift is visible over time.
  - `/audit` — an on-demand deep adversarial sweep for where a concern has actually eroded; ranked findings with evidence (Cartographer survey + Critic refutation).
- **Thesis pillar** in METHOD.md naming the principle the stewardship layer serves: the human stays the author of the *non-local, non-failing* quality (UX, testing, compliance, NFRs) that erodes silently as AI takes more of the build.

### Changed
- **Landing page** refreshed to orient newcomers and surface the new ideas: a "new to spec-driven development?" explainer (linking GitHub's Spec Kit and AWS Kiro), a "Stay in control as scope grows" section introducing the stewardship layer, and FAQ entries on how the Method differs from spec-generators and how it keeps quality under control.

---

## [2.1.0] — 2026-06-15

### Added
- **Landing page** (`site/index.html`) — a self-contained project site (vanilla HTML/CSS/JS, no build dependencies). `npm run build:docs` copies it into `dist/` alongside the styled decks, so `dist/` is a complete deployable site root.
- **`.github/workflows/pages.yml`** — builds and deploys the site to GitHub Pages on push to `main`.

### Changed
- **Tiered Definition of Ready** (`method_version` → 2.1.0). The DoR gate is now eight strengthened *core* criteria plus a *conditional* layer keyed on each story's `facets` (`request-path`, `data-change`, `shared-resource`, `external-integration`, `ui`). Concerns that used to surface at implementation time as stop conditions are pulled into the gate: non-functional budgets, typed-and-verified dependencies, module-map-verified architectural impact, per-facet edge enumeration, migration/rollback, observability signals, and AC provenance. The Verifier gains a red-test review (the failing test must fail for the *specified* reason, not merely fail) and epic-level exit checks (dependency DAG, hotspot closure, manifest completeness). Threat-model evidence is now the engineer's recorded risk decisions — severity, real/not, residual-risk owner — rather than mere participation. The test command is parameterized via `method.config.yaml` (`testing.command`) instead of Go-hardcoded. Touches `METHOD.md`, the verifier/decomposer/test-author/threat-modeller/critic/explorer agents, `.method/`, `AGENTS.template.md`, `method.config.template.yaml`, and the plan templates.
- **`TUTORIAL.md` → `QUICKSTART.md`** — renamed (history preserved) and rewritten as a true 15-minute quickstart: install → first decision → first refined story. All cross-references updated; `npm run build:docs` now emits `dist/quickstart.html`.
- Restyled the decks and landing page into one identity — calm navy ink on warm paper with a single terracotta accent, hairline-driven layout, navy "machine" surfaces for code and callouts. The strapline is now **"Spec-driven development deserves a better spec."**
- **README rewritten** as a standalone OSS front door — leads with the agent-driven install as the default path, keeps the problem/why/how narrative (role panel + DoR summary), and folds the manual-install detail into a collapsible section. Now that the landing page carries the polished pitch, the README is leaner but still self-contained.

### Removed
- **`INSTALL.md`** — its install and setup content moved into the README (install/setup is now in one place, with the agent flow as the default). The installer and `AGENT_INSTALL.md` no longer ship it, and upgrades remove the old shipped copy.

### Fixed
- Removed build-phase leftovers that contradicted the v2.0.0 "stops at the spec" narrowing: `AGENT_INSTALL.md` ("…and shipped code"), `AGENTS.template.md` ("writing implementation from failing tests"), `CONTRIBUTING.md` ("…and build workflows").
- Aligned the `plans/_templates/` examples to the `DoR-ready` flag the `/plan` orchestrator actually sets — the templates still carried the orphaned `harness-ready` / `ready_for_build` vocabulary from the removed build phase, which referenced a flag the system never produces.

---

## [2.0.1] — 2026-06-12

Visual refresh for the styled decks, plus a real render pipeline so they actually display. No changes to the Method itself.

### Added
- **`theme/theme.css`** — single source of truth for the deck design system: deep navy ink on dusty rose, coral accent, with sage and mustard secondaries (inspired by a reference mockup).
- **`scripts/build-docs.mjs`** + **`npm run build:docs`** — renders `METHOD.md` and `TUTORIAL.md` to self-contained `dist/*.html` with the theme inlined and Mermaid diagrams drawn. Pure Node stdlib; markdown-it and Mermaid load from CDN in the output page.
- README "Viewing the styled docs" section.

### Changed
- Restyled both decks to the new palette — color-blocked navy cover with a coral circle motif, warm-palette Mermaid fills, coral-spined role cards, sage agent turns in the tutorial chats.
- Removed the inline `<style>` blocks from `METHOD.md` and `TUTORIAL.md` — the styling now lives only in `theme/theme.css`. (GitHub and most previewers strip inline `<style>`, so those blocks never rendered anyway; the build pipeline is how the decks are meant to be viewed.)

### Why
The decks carried their CSS in `<style>` blocks that GitHub strips, so the design never showed. Moving styling into `theme/theme.css` and adding a build step makes it viewable (open the built HTML, or print to PDF) and gives one place to maintain the look.

---

## [2.0.0] — 2026-06-12 — **Refocused on spec generation**

The Method is now a **spec-generation method**, full stop. It turns fuzzy intent into a ready spec — domain mapped, decisions captured, threats modelled, stories testable — and hands off to whatever coding tool you already use. It no longer writes production code.

This is a deliberate narrowing. The thesis: **code got cheap; spec quality is the new bottleneck.** Build tooling is a crowded, commodity space (every coding agent ships it). Refinement — event storming, domain-driven design, the upstream thinking where taste is load-bearing — is the neglected, high-leverage part. The Method does that one thing well.

### Removed — the build phase
- `.claude/agents/builder.md` — the Builder agent
- `.claude/commands/build.md` — the `/build` skill
- `.claude/commands/off-course.md` — the `/off-course` bridge skill
- METHOD.md "The build phase and the off-course bridge" section (replaced by "Where the Method ends: the handoff to build")
- All build-phase triggers and the off-course promotion rule from `.method/`
- The build example and Builder references throughout TUTORIAL.md, README.md, AGENTS.template.md, INSTALL.md, AGENT_INSTALL.md

### Added — domain discovery (event storming + DDD)
- **`.claude/agents/explorer.md`** — the Explorer role. Facilitates event storming as a conversation: maps domain events, commands, policies, read models, and hotspots; proposes bounded contexts; owns the ubiquitous-language glossary.
- **`.claude/commands/storm.md`** — the `/storm` skill.
- **`docs/domain-glossary.md`** — the ubiquitous language as a first-class artifact, wired into the top of the structured reference layer (Tier 2) so every agent reads it and uses its terms exactly. Soft-enforced: agents flag drift rather than letting it propagate.
- METHOD.md "Domain discovery — event storming and ubiquitous language" section.
- `/plan` gains a conditional **Phase 0 — domain discovery** that runs the Explorer before scope when the domain needs mapping.
- A worked event-storming example in TUTORIAL.md (Example 3 — mapping a domain).

### Added — the partnership / anti-sycophancy spine
- Every interviewing agent (Explorer, Analyst, Architect, Threat Modeller) now has an explicit **"partner, not a stenographer"** instruction: bring expertise, surface gaps, and *push back* on weak reasoning. Sycophancy is named as a failure mode. The AI is a thinking partner that makes your judgment sharper — not a transcriber, and not a rubber-stamp.

### Changed — roles trimmed to refinement
- **Verifier** is now single-purpose: the DoR gate. (Its build-time "behavioural check" mode is gone.)
- **Critic** keeps its test-critique pass and its on-demand `/review` of PRs/code/designs; the automatic post-Builder "code critique" step is gone (there's no Builder).
- **Test Author** reframed: the failing test it writes is the spec a developer implements against, downstream, in their own tool.
- **Stop conditions** are now the handoff contract on each story — signals to come back to the Method, not build-loop pauses.
- Role panel: still ten roles (Builder out, Explorer in). Skills: ten (`/build` + `/off-course` out, `/storm` in).
- Thesis (METHOD.md §2) rewritten around the DDD/event-storming lineage, the three-move partnership, the anti-vibe-coding stance, and an "isn't this waterfall?" rebuttal.

### Fixed
- Removed several stale "verbatim transcript" references that contradicted the cleaned-and-signed interview pattern (Analyst, Threat Modeller, `/threat-model`, promotion rules).
- Genericised leaked project-specific ADR numbers in `.method/promotion-rules.md`.

### Migration
This is a major version for a reason. If you relied on `/build` or `/off-course`, they're gone — implementation now happens in your own coding tool against the specs the Method produces. Re-install or upgrade:

```bash
curl -sSL https://raw.githubusercontent.com/nlawstudio/ai-refinement-method/main/install.sh | sh
```

The installer preserves your `AGENTS.md`, `method.config.yaml`, and `docs/adr/`. Your `docs/domain-glossary.md` will be created the first time you run `/storm`.

---

## [1.2.4] — 2026-06-11

Standard OSS project scaffolding added. Behavioural change: none — the Method itself is unchanged.

### Added
- `LICENSE` — MIT (permissive). Copyright Nicholas Lawrence Studio.
- `CONTRIBUTING.md` — what kinds of contributions are welcome, style/tone guide for agent and skill files, versioning policy, PR checklist
- `SECURITY.md` — private vulnerability disclosure process; scope of in-/out-of-scope issues
- `CODE_OF_CONDUCT.md` — adopts Contributor Covenant 2.1 by reference
- `.github/ISSUE_TEMPLATE/` — three YAML-form templates (bug, feature, question) plus `config.yml` pointing first-time visitors at the tutorial and security policy
- `.github/PULL_REQUEST_TEMPLATE.md` — checklist enforcing scope, no project-specific references, CHANGELOG entry, smoke-test for agent changes
- `.github/workflows/ci.yml` — three jobs: `shellcheck` on shipped scripts, `yaml-lint` on shipped YAML, internal markdown link check via lychee
- README badges — license, version, CI status

### Changed
- `README.md` — Contributing section now points at the new community files; License section names MIT explicitly with link

### Why
v1.2.3 published the Method publicly but lacked the standard OSS legal and community infrastructure. v1.2.4 fills that out so the repo is friendly to contributors, discoverable, and verifiable on CI.

---

## [1.2.3] — 2026-06-11 — **First public release**

The Method is now open source. Previously developed in a private repo; this is the first version published publicly.

### Changed
- **Repo URL:** moved to [`nlawstudio/ai-refinement-method`](https://github.com/nlawstudio/ai-refinement-method) (public). All install URLs, raw-content URLs, and clone targets updated across `install.sh`, `README.md`, `METHOD.md`, `AGENT_INSTALL.md`, `INSTALL.md`, `TUTORIAL.md`, and `method.config.template.yaml`.
- **History:** the public repo starts fresh at v1.2.3. CHANGELOG entries for v0.1.0 through v1.2.2 are preserved as documentation of how the Method got here — no prior commits or tags are reachable from this repo.
- **GitHub Issues example** in `METHOD.md` updated to use `your-org` / `your-repo` placeholders.

### Why
The private development phase reached a natural release point: AR-specific references stripped in v1.2.2, tracker-agnostic since v1.1.0, structured config since v1.2.0, quickstart-shaped tutorial since v1.2.1. Going public preserves the documented version trail without surfacing private commit history.

---

## [1.2.2] — 2026-06-11

References to the original validation project's company name stripped from the shipped framework. The Method is fully generic: agent prompts, command files, documentation, and templates no longer reference a specific company by name.

### Changed
- `.claude/agents/*` — "AR template" / "AR systems" / "AR-shaped" / "AR personnel" / "AR's threat landscape" generalised to project-/internal-/domain-neutral phrasing
- `.claude/commands/*` — `AR-142`, `AR-EPIC-42`, `AR-138`, etc. replaced with generic `STORY-142`, `EPIC-42`, etc. in usage examples
- `METHOD.md` — subtitle, intro, thesis, role tables, ADR diagram, manifest example, gbrain rings, Jira project key example, version history all generalised
- `AGENT_INSTALL.md` — Jira project key example, ADR template reference, gbrain isolation example generalised
- `method.config.template.yaml` — Jira project key example generalised
- `README.md` — company-specific provenance line removed; Contributing reframed for generic OSS positioning
- `.method/promotion-rules.md` — "AR template" generalised
- `INSTALL.md` — stale `--ref v0.2.0` bumped to `v1.2.1`
- `CHANGELOG.md` — historical entries reworded to refer to the original validation project generically; factual history preserved

### Why
The Method is a generic OSS tool. Naming a specific validation company in shipped framework prompts, in worked examples, in templates, and in the canonical specification leaks instance-specific context into every project that installs the Method. Stripping the references makes the framework cleanly portable.

### Migration
Re-install or upgrade — none of the changes are behavioural; agent prompts read the same to the LLM, and the generalised wording is functionally equivalent. Existing installations need no action.

---

## [1.2.1] — 2026-06-10

`TUTORIAL.md` rewritten as a quickstart. Leads with **why the Method exists** before any "how". Cuts long worked examples in favour of focused ones — one per shape (decision, bug, epic, threat model, handoff) — and removes content that overlapped with `METHOD.md`.

### Changed
- `TUTORIAL.md`: new cover ("The Method, in 15 minutes") and quickstart-shaped structure
- New §1 "Why this exists" leads with the problem the Method solves and what raw Claude Code doesn't give you
- New §2 "What you get" — concrete outputs per input shape
- New §3 "15-minute quickstart" — install + first decision + first refined story
- Mental model section consolidates the one-loop diagram, three modes, and ten-agent panel
- Five focused examples replace the previous nine
- Tracker references generalised (Linear / Jira / GitHub Issues) — generic story IDs in all worked examples
- FAQ and Troubleshooting tightened, no longer redundant with `METHOD.md`

### Why
The previous TUTORIAL was reference-shaped — comprehensive but slow to extract value from on day one. A quickstart-shaped doc lets new users get to their first ADR and first refined story in 15 minutes, then graduate to `METHOD.md` for depth.

---

## [1.2.0] — 2026-06-10

Configuration is now a proper file. `method.config.yaml` at the project root holds all structured settings — tracker type and identifiers, story sizing, compliance frameworks, testing requirements. `AGENTS.md` reverts to pure prose constitution. Credentials stay in `~/.claude/mcp.json` (per-user, never git).

### Added
- `method.config.template.yaml` — the schema template with sensible defaults and inline documentation
- `install.sh` now copies `method.config.template.yaml` to target as `method.config.yaml` on install (preserves existing if present)
- `METHOD.md` gains a "Configuration" section with the full schema, defaults table, and how agents/tooling read it
- `AGENT_INSTALL.md` Step 1 asks tracker-specific follow-up questions (team ID for Linear, site/project key for Jira, owner/repo for GitHub Issues) and asks about story sizing, format, and compliance frameworks
- `AGENT_INSTALL.md` Step 3 splits into AGENTS.md customisation (3a-3f) and method.config.yaml customisation (3g-3h)
- `AGENT_INSTALL.md` Step 6b emphasises the credentials/MCP separation: tokens live in `~/.claude/mcp.json`, never in the Method's config
- `README.md` gains a "Three files for project state" section clarifying the split

### Changed
- `AGENTS.template.md` no longer has a `tracker:` field — moved to `method.config.yaml`. AGENTS.md references the config file for tracker info. Session-start instructions now include reading `method.config.yaml`.
- Per-tracker custom identifiers (Linear team ID, Jira project key + custom fields, GitHub owner/repo + labels) are now first-class config — agents can read them without prompting

### Why
For an installable OSS project, structured config + prose constitution is the standard pattern (Tailwind, Vite, Tsconfig, etc.). Putting `tracker:` inside `AGENTS.md` mixed config with prose and made tooling brittle. Splitting them gives:
- A predictable place for tooling to read settings (no markdown parsing)
- Clearer responsibility per file
- Schema-validatable in the future
- Familiar pattern for OSS contributors

### Migration
Existing v1.1.x installs: on next install, `method.config.yaml` will be created with `tracker: none` defaults. If you had `tracker:` set in `AGENTS.md`, update `method.config.yaml` manually with the right type and any identifiers. The `tracker:` line in `AGENTS.md` can be removed (it's now noise).

---

## [1.1.0] — 2026-06-10

The Method is now **tracker-agnostic**. Linear was the only tracker the skills knew about; that's now a `tracker:` config in `AGENTS.md` that the install step asks about. Supported values: `linear`, `jira`, `github-issues`, `none`.

### Changed
- **All skill prompts** (`/plan`, `/build`, `/off-course`, etc.) and **all agent definitions** now reference *"the tracker"* / *"a tracker story"* / *"tracker MCP"* instead of hardcoding Linear. ~130 references swept across 14 files.
- `AGENTS.template.md` adds a `tracker:` config field at the top of the "Operational state vs audit trail" section. Includes a note that "story" is the generic term used in skill prompts; agents translate to tracker-native terms (Jira "issue", etc.) when talking to MCP.
- `AGENT_INSTALL.md` Step 1 now asks "which tracker?" (not "do you use Linear?"). The captured value is written to the new `tracker:` field in `AGENTS.md`.
- `AGENT_INSTALL.md` Step 6b is rewritten with explicit branches for Linear / Jira / GitHub Issues / none — each with the relevant MCP setup guidance.

### How it works
- The skills read `AGENTS.md` at session start
- They see the `tracker:` value
- When invoking MCP to write a story or read an epic, they use whichever tracker MCP is configured
- All in-text references say "the tracker" generically; agents translate to that specific tracker's vocabulary when interacting with it

### No tracker (`tracker: none`)
A valid configuration. `/plan` and `/build` operate in dry-run mode — they produce all the git artifacts (tree.yaml, ADRs, threat model, tests, manifest), but don't push to any external system. The `tree.yaml` becomes the operational record. Suitable for solo work or small teams.

### Breaking?
**Not for existing v1.0.x installs**, as long as the user's `AGENTS.md` either has no `tracker:` field (defaults to dry-run / `none`) or matches their setup. Anyone with a Linear MCP wired up and an updated `AGENTS.md` (`tracker: linear`) gets identical behaviour to before.

---

## [1.0.1] — 2026-06-10

gbrain scoping made explicit. The Method now strongly defaults to **per-project gbrain** during install — never a global brain shared across multiple projects, especially across different clients.

### Changed
- `AGENT_INSTALL.md` Step 6a (gbrain) rewritten. Project-scoped is now the default recommendation, not an option among others. The two valid backends are presented as: local PGLite (solo / single-machine) or dedicated Supabase (multi-dev team on this specific project). Pointing two projects at the same Supabase brain is now called out as an anti-pattern.
- `METHOD.md` "Memory via gbrain" section now includes a "gbrain is scoped per project — never globally shared" subsection with explicit guidance on confidentiality, pattern confusion, and audit-trail mixing risks.

### Why
When the same developer works on multiple projects with the Method installed (especially for different clients), shared gbrain leaks client data, IP, and patterns across them. The `.gbrain-source` pin file at each project's repo root is the mechanism for scoping; documenting this as the default install path means it's harder to accidentally end up with a shared brain.

### No breaking changes
Existing installs are not affected. This is a documentation and install-flow update only.

---

## [1.0.0] — 2026-06-09 — **Renamed: Harness → Method (breaking)**

The project is renamed from **"the harness"** to **"the method"**. *"Harness"* in AI-coding vocabulary already means runtime infrastructure (Claude Code, Cursor, OpenHands — the loop that gives a model agency). What we've built is a methodology + codification + tooling that *runs on top of* a harness. *"Method"* is what it actually is.

This is the first 1.0 release. Cosmetic rename, but a breaking change in every public path.

### Renamed
- Repo (at the time): `harness` → `method` (later renamed again at v1.2.3 — see that entry)
- `HARNESS.md` → `METHOD.md`
- `.harness/` → `.method/` (trigger profiles, promotion rules, handoffs all move here)
- `.gitignore` entry: `.harness/handoffs/` → `.method/handoffs/`
- Install URL (at the time): `harness/main/install.sh` → `method/main/install.sh` (later updated at v1.2.3)
- Environment variables: `HARNESS_REPO` → `METHOD_REPO`, `HARNESS_REF` → `METHOD_REF`, `HARNESS_VERSION` → `METHOD_VERSION`
- `harness-ready` → `DoR-ready` (the term aligns with standard Agile vocabulary)
- All in-text references to "the harness" → "the method"
- Tutorial chat-transcript role labels: `Harness (triage)` → `Method (triage)`

### Migration for existing v0.x installs

**The new `install.sh` auto-migrates `v0.x` installations.** When run in a project that has `.harness/`, it:

1. Renames `.harness/` → `.method/` (idempotent — re-runs are safe)
2. Removes `HARNESS.md` (replaced by the new `METHOD.md`)
3. Updates the `.gitignore` entry for handoffs from `.harness/handoffs/` to `.method/handoffs/`
4. Installs the new framework files

For an upgrade:

```bash
curl -sSL https://raw.githubusercontent.com/nlawstudio/ai-refinement-method/main/install.sh | sh
```

The script handles the rename. The agent install (`AGENT_INSTALL.md`) is unchanged — same 8 steps, just everywhere it said "harness" it now says "method."

### Why this rename, why now

In AI-coding usage, "harness" overwhelmingly refers to the agent runtime infrastructure — the tool dispatch loop, context management, session persistence that gives an LLM the ability to act. Claude Code is a harness. Cursor is a harness. `lm-evaluation-harness` is a harness. What we built is a layer of methodology + role definitions + project conventions that runs *on top of* a harness. Calling our thing "the harness" conflates the two layers and confuses anyone in the AI-coding world who hears the term.

"Method" is precise: a codified way of working. *"Our team's method for agentic engineering. It runs on Claude Code."* That sentence parses cleanly without anyone retrofitting the vocabulary.

The cost of renaming now: small (only a handful of people have touched this). The cost of renaming later: much larger. Doing it at the v1.0 boundary is the natural time.

---

## [0.2.5] — 2026-06-08

Handoffs are local-only by default. Session-continuity snapshots accumulate quickly and contain in-flight individual thinking — they're not the kind of artifact that benefits from being committed. The method now sets this up automatically.

### Changed
- `install.sh` appends `.method/handoffs/` to the target project's `.gitignore` automatically. Creates the file if it doesn't exist; appends if it does (idempotent — re-runs don't duplicate the line).
- `.claude/commands/handoff.md` updated to reflect the new default. Was "commit by default, gitignore optionally"; now "local-only by default, commit optionally by removing from .gitignore".
- This repo's `.gitignore` updated for the same reason — handoffs don't get committed.

---

## [0.2.4] — 2026-06-08

Session continuity. The method now has a `/handoff` skill — capture session state at the end of a working block, resume exactly where you left off in any future session (same agent or different).

### Added
- `.claude/commands/handoff.md` — new skill with two modes:
  - `/handoff` (no args) — capture state at end of session: active work, decisions in flight, open questions, file state, mental model snapshot, concrete next action
  - `/handoff resume` — restore state at start of new session: reads `.method/handoffs/LATEST.md`, summarises, confirms, picks up
- Handoff documents are plain markdown, so they work across agents (Claude Code, Cursor, Codex, etc.)
- Handoffs accumulate in `.method/handoffs/{ISO-timestamp}-{slug}.md` with a `LATEST.md` pointer
- Skill catalogue (10 → 11) updated in README.md and METHOD.md

### Why it matters
Long conversations have a context-window cost. Closing a session forfeits any context not committed to disk. Without a structured handoff, resumption means either re-reading the chat (expensive) or starting fresh and missing nuances. The handoff captures the cheap-to-write, expensive-to-lose state — your working mental model, decisions in flight, the next intended action. Everything else (files, commits, plans, ADRs) is already on disk.

---

## [0.2.3] — 2026-06-08

Two things now happen out of the box: the structured-reference scripts ship with the install, and the agent-driven setup is the prominent next-step after `install.sh` runs.

### Added
- `scripts/sync-schema.sh` — generates `docs/schema.sql` from the database schema. Prefers Atlas (if `atlas.hcl` is present); falls back to `pg_dump --schema-only` using `DATABASE_URL`. Schema only — never data. Idempotent; safe to run repeatedly.
- `scripts/sync-adr-index.sh` — (re)generates `docs/adr/INDEX.md` from the ADR files. Run after adding ADRs; also called automatically by the `/adr` skill once it lands an accepted ADR.
- `install.sh` copies `scripts/` to the target project and sets executable permissions.

### Changed
- `install.sh` next-step output is now a prominent banner pointing at the agent-driven install via `AGENT_INSTALL.md`. The recommended path is to paste a short prompt into the user's AI coding agent — the agent walks through the 8-step guided install.
- `AGENT_INSTALL.md` Step 5 now runs `./scripts/sync-schema.sh` and `./scripts/sync-adr-index.sh` as default actions during install, and offers to wire them into the project's migration tool's post-apply hook or CI.

---

## [0.2.2] — 2026-06-08

A third tier of context. The method now formally distinguishes "always loaded" (constitution + agent + skill) from "structured references" (schema, contracts, module map, ADR index — small, slow-changing, project-grounding) from "on-demand" (application code via Cartographer). Schema in particular becomes a baseline for every Designer, Architect, Builder, Test Author session — agents make decisions grounded in the actual data shape from session start.

### Added
- New section in METHOD.md: "The three-tier context model" with diagram
- `AGENTS.template.md`: a section listing structured reference files that agents read at session start when present
- `AGENT_INSTALL.md`: new step for structured-reference setup (offers to wire up Atlas schema export, OpenAPI generation, module map, ADR index)
- `AGENT_INSTALL.md`: gbrain setup guidance — shared Supabase for project + org rings recommended for multi-dev teams; local PGLite fine for solo / session-ring-only
- Convention: `docs/schema.sql`, `docs/openapi.yaml`, `docs/module-map.md`, `docs/domain-types.md`, `docs/adr/INDEX.md` as the standard structured-reference file paths

### Changed
- All agent definitions updated to consult the structured references at session start where applicable
- Cartographer's scope refined: explicitly for *application code* reads. Schema, contract, and module-graph questions resolve from the structured-reference baseline without needing Cartographer.
- `.method/triggers.md`: Cartographer trigger conditions tightened to reflect the scope refinement

---

## [0.2.1] — 2026-06-08

The install process is now agent-driven. Most users will ask Claude Code, Cursor, or Codex to install the method — those agents now have a structured prompt to follow.

### Added
- `AGENT_INSTALL.md` — a structured prompt for AI coding agents driving the install. Walks the agent through a 7-step interview-driven install: capture project context, run the install, customise `AGENTS.md` section by section, set up `docs/adr/` (move in existing ADRs or interview the user on their first ones), wire up MCPs, smoke-test, hand off.
- `AGENT_INSTALL.md` is now copied into target projects by `install.sh` — available for future re-installs and upgrades.

### Changed
- `install.sh` copies `AGENT_INSTALL.md` alongside the other documentation
- `INSTALL.md` adds a header pointing humans at the agent-install path as the recommended option
- `README.md` reframes the install as agent-driven first, with direct human install as the fallback

---

## [0.2.0] — 2026-06-08

The first packaged release. The method is now a distributable tool that installs into any project repo via `install.sh`.

### Added
- `install.sh` — one-line install into a target directory
- `INSTALL.md` — setup guide including gbrain MCP and Linear MCP wiring
- `AGENTS.template.md` — skeleton constitution for new projects
- `VERSION` and `CHANGELOG.md`
- `.claude/commands/build.md` — build-loop skill (Builder → Verifier → Critic → PR)
- `.claude/commands/off-course.md` — bridge skill for routing back to refinement when build hits a stop condition
- METHOD.md: new section on the build phase and the off-course bridge
- METHOD.md: new section on distribution and versioning
- TUTORIAL.md: worked example for building a story end-to-end
- TUTORIAL.md: worked example for off-course (build → refinement bridge)
- Several new Mermaid diagrams for the build phase and the two-loop architecture

### Changed
- `.claude/agents/verifier.md` and `.claude/agents/critic.md` — build-time modes made explicit
- `.method/triggers.md` — added build-phase triggers and off-course routing conditions
- `.method/promotion-rules.md` — added off-course promotion rules (kind of upstream change → which role)
- All agent files — generic ADR references instead of hardcoded project-specific IDs. Agents now read the project's own `docs/adr/` at session start.
- README.md — re-framed as "the tool" with install instructions and version status
- Documentation positions the original validation project as an illustrative example, not the embedded instance

### Removed
- `AGENTS.md` — replaced by `AGENTS.template.md`. Per-project constitutions live in the project repo, not the method repo.
- `docs/adr/` (the 19 ADRs from the original validation project) — per-project content. ADRs live in the project repo the method is installed into.
- `DECK.md` and `FRAMEWORK.md` — superseded by METHOD.md from v0.1.x
- `AI-First Engineering at Team Scale.pdf` — reference material, not part of the tool

---

## [0.1.0] — 2026-06-07

Initial commit. Refinement-phase scaffold.

### Added
- 10 role agent definitions in `.claude/agents/`
- 8 user-facing skill definitions in `.claude/commands/`
- `AGENTS.md` constitution
- `METHOD.md` framework specification
- `TUTORIAL.md` walkthrough
- `.method/triggers.md` and `.method/promotion-rules.md`
- `plans/_templates/` for tree.yaml and manifest.yaml
- 19 accepted Architecture Decision Records from the original validation project (later removed in 0.2.0 when the method became a distributable tool)
