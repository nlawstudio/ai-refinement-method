# Agentic Refinement Method

[![License: MIT](https://img.shields.io/badge/License-MIT-brightgreen.svg)](LICENSE)
[![Version](https://img.shields.io/github/v/release/nlawstudio/ai-refinement-method?label=version)](https://github.com/nlawstudio/ai-refinement-method/releases)
[![CI](https://github.com/nlawstudio/ai-refinement-method/actions/workflows/ci.yml/badge.svg)](https://github.com/nlawstudio/ai-refinement-method/actions/workflows/ci.yml)

A packaged tool that installs into any project repo to make AI-first **refinement** cheap and rigorous. A developer describes what they want in plain language; the method figures out the shape of the work, maps the domain through event-storming-style dialogue, and produces a coherent set of tracker stories ready to build — with acceptance criteria, failing tests, risk assessments, compliance tags, threat models, and linked ADRs all in place.

Code got cheap; spec quality is the new bottleneck. The Method puts the rigour of event storming, domain-driven design, and refinement within reach of every team — and hands off a spec your coding tool (Claude Code, Cursor, Codex) can execute. It stops at the spec; it doesn't write your production code. That's the point.

**Current version:** `v1.2.4` — proper OSS scaffolding (license, contributing, security, CI). Quickstart-shaped tutorial since v1.2.1; structured `method.config.yaml` since v1.2.0; tracker-agnostic since v1.1.0. See [CHANGELOG.md](CHANGELOG.md).

## Install

**The recommended path: ask an AI coding agent to do the install for you.**

In your project directory, open Claude Code / Cursor / Codex and give the agent this prompt:

> *"Install the agentic refinement method in this repo. Follow the instructions at https://github.com/nlawstudio/ai-refinement-method/blob/main/AGENT_INSTALL.md"*

The agent will read [`AGENT_INSTALL.md`](AGENT_INSTALL.md) — a structured prompt that walks you through the install as a guided interview:

1. Captures your project context (what you're building, your stack, compliance posture, team size, tracker)
2. Runs the install
3. Customises `AGENTS.md` (the constitution) and `method.config.yaml` (the settings) to your project — section by section, with your sign-off
4. Sets up `docs/adr/` — moves in your existing ADRs, or interviews you on your first ones
5. Wires up gbrain and your tracker MCP (Linear / Jira / GitHub Issues, or `none` for git-only)
6. Runs a smoke test (`/onboard`) to verify it works
7. Hands off with a setup summary and any follow-ups

The install itself is a worked example of the method's operating principles — interview-driven, transparent, your input cleaned and structured by the AI.

### Direct human install (fallback)

If you'd rather run it directly without an agent:

```bash
curl -sSL https://raw.githubusercontent.com/nlawstudio/ai-refinement-method/main/install.sh | sh
```

Or pin a version:

```bash
curl -sSL https://raw.githubusercontent.com/nlawstudio/ai-refinement-method/main/install.sh | sh -s -- --ref v1.2.1
```

The script copies framework files into the target. Existing `AGENTS.md`, `method.config.yaml`, and `docs/adr/` are preserved. You'll need to customise `AGENTS.md` and `method.config.yaml` manually, and connect MCPs yourself (credentials live in `~/.claude/mcp.json`, never in the project). See [INSTALL.md](INSTALL.md) for the human-facing setup guide.

## How it feels to use

You don't pick which "skill" to invoke. You describe what you want:

```
Map the domain for our new case-management module
```
```
Should we use UUIDv7 over UUIDv4 for primary keys?
```
```
I need to fix the bug where wallet linkage fails for Solana addresses
```
```
Add a bulk asset export feature
```
```
Clean-slate the platform rebuild
```

The method:

1. **Triages** — figures out whether this is a question, a domain to map, a decision, a bug, a story, an epic, or a multi-epic effort
2. **Decomposes recursively** through dialogue with you, going only as deep as the shape of the work warrants — storming the domain first when the shape itself is unclear
3. **Produces structured output** in the right place — tracker stories under the right epic, ADRs in `docs/adr/`, the domain map and threat models in `plans/{epic}/`, the ubiquitous-language glossary in `docs/domain-glossary.md`, all of it a ready spec a developer (or their coding agent) can build from

The same loop runs at every depth. Small things get a single turn; multi-epic goals get many turns. The Method stops at a ready spec — implementation happens in your own coding tool, against everything the Method produced.

## Read these in order

1. **[TUTORIAL.md](TUTORIAL.md)** — the Method in 15 minutes (quickstart — why it exists, how to use it, what you get)
2. **[INSTALL.md](INSTALL.md)** — install and setup guide
3. **[METHOD.md](METHOD.md)** — the canonical framework specification (depth reference)
4. **`AGENTS.md` (in your installed project)** — the constitution every agent reads at session start
5. **`method.config.yaml` (in your installed project)** — structured settings (tracker, story sizing, compliance, testing)
6. **`docs/adr/` (in your installed project)** — your accepted architecture decisions
7. **[.method/triggers.md](.method/triggers.md)** — when each agent role is invoked (transparent and tunable)
8. **[.method/promotion-rules.md](.method/promotion-rules.md)** — when conversations produce canonical artifacts

## The role panel (the agent primitives)

Ten roles. Each has a distinct context, output shape, quality bar, trigger profile, and failure mode. The method composes them based on what the work needs.

| Role | Mode | Job |
|---|---|---|
| Explorer | Interviewing | Event storming — maps the domain, owns the ubiquitous-language glossary |
| Cartographer | Doing | Reads existing code, produces cited findings |
| Analyst | Interviewing / Drafting | Discovery (scope) and privacy lens |
| Architect | Interviewing / Drafting | Decisions and ADR drafting |
| Designer | Drafting | Design docs |
| Decomposer | Drafting | Story tree breakdown |
| Test Author | Drafting | Failing tests (does not see implementation) |
| Verifier | Doing | DoR gate — confirms a story is ready |
| Critic | Doing | Adversarial review (test critique + on-demand `/review`) |
| Threat Modeller | Interviewing | STRIDE at epic kickoff — engagement is the evidence |

Every interviewing role is a **thinking partner, not a stenographer** — it brings expertise, surfaces gaps, and pushes back on weak reasoning. The point is to make your judgment sharper, not to transcribe it.

## Internal capabilities (skills)

These exist as internal patterns the method composes; you don't have to invoke them by name. Power users can still invoke directly.

| Skill | What it does internally |
|---|---|
| `/plan` | Full multi-phase refinement (the method's default for anything bigger than a bug) |
| `/storm` | Explorer-led event storming — maps the domain, captures ubiquitous language |
| `/adr` | Architect interview that produces an ADR via the promotion rule |
| `/decide` | Architect interview that may or may not produce an ADR |
| `/spike` | Cartographer + Architect investigation |
| `/threat-model` | Standalone threat modelling |
| `/explain` | Cartographer-led walkthrough of existing code |
| `/review` | Critic-led adversarial review of a PR, file, or design |
| `/onboard` | Generates orientation for a new dev |
| `/handoff` | Capture session state at end of session; `/handoff resume` picks up where you left off |

## Repo layout

```
.claude/
  agents/                ← 10 role definitions (ship in install)
  commands/              ← 10 skills (ship in install)

.method/
  triggers.md            ← role invocation conditions (ship)
  promotion-rules.md     ← canonical artifact promotion rules (ship)

scripts/
  sync-schema.sh         ← regenerates docs/schema.sql (Atlas + pg_dump)
  sync-adr-index.sh      ← regenerates docs/adr/INDEX.md

plans/_templates/        ← tree.yaml and manifest.yaml shapes (ship)

AGENTS.template.md          ← skeleton constitution (becomes AGENTS.md on install)
method.config.template.yaml ← skeleton settings (becomes method.config.yaml on install)
METHOD.md                   ← framework spec (ship)
TUTORIAL.md                 ← walkthrough (ship)
INSTALL.md                  ← human-facing install guide (ship)
AGENT_INSTALL.md            ← the prompt AI agents follow to install (ship)
README.md                   ← this file
CHANGELOG.md                ← version history
VERSION                     ← current version
install.sh                  ← installer
```

## Three files for project state

| File | What | Audience |
|---|---|---|
| `method.config.yaml` | Structured settings (tracker, story sizing, compliance) | Tooling + agents |
| `AGENTS.md` | Prose constitution (principles, conventions, stack) | Humans + agents |
| `~/.claude/mcp.json` | Credentials and MCP server URLs | Claude Code only — never git |

## Quickstart after install

Open Claude Code in the project directory and describe what you want to do.

Smallest valuable test — pick a decision you'd be making anyway:

```
Should we use [your-current-question]?
```

The method triages to a decision, routes to the Architect in interview mode, and either produces an ADR (if the promotion rule fires) or records an informal decision.

For something bigger:

```
Add [feature]
```

This routes to the full refinement flow — scope, decisions, design, threat model, and a tree of ready stories.

When the domain itself is unclear, storm it first:

```
Map the domain for [area]
```

The Explorer facilitates an event-storming session and captures the ubiquitous language.

Then take the ready stories — each with a failing test as its spec — into your coding tool to implement.

See [TUTORIAL.md](TUTORIAL.md) for the 15-minute quickstart.

## Contributing

The Method is installable in any project, with sensible defaults for B2B SaaS work. See [CONTRIBUTING.md](CONTRIBUTING.md) for what kinds of PRs are welcome, how to open issues, and the style/tone guide for new agent or skill files. Security issues: see [SECURITY.md](SECURITY.md). All participants are expected to follow the [Code of Conduct](CODE_OF_CONDUCT.md).

## License

Released under the [MIT License](LICENSE). Use freely; the Method ships as files into your repo so the license effectively applies to your installed copy as well.
