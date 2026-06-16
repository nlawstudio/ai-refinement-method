<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="site/logo-light.png">
    <img src="site/logo.png" alt="The Method" width="300">
  </picture>
</p>

<p align="center"><em>An agentic refinement layer for AI coding agents.</em></p>

[![License: MIT](https://img.shields.io/badge/License-MIT-brightgreen.svg)](LICENSE)
[![Version](https://img.shields.io/github/v/release/nlawstudio/ai-refinement-method?label=version)](https://github.com/nlawstudio/ai-refinement-method/releases)
[![CI](https://github.com/nlawstudio/ai-refinement-method/actions/workflows/ci.yml/badge.svg)](https://github.com/nlawstudio/ai-refinement-method/actions/workflows/ci.yml)

> ### Spec-driven development deserves a better spec.

You describe what you want in plain language; the Method maps the domain, captures the decisions, models the threats, and hands back a coherent set of build-ready stories — each with testable acceptance criteria and a failing test that defines "done." It stops at the spec. Your coding tool builds from it.

**[See the landing page →](https://nlawstudio.github.io/ai-refinement-method/)**  ·  **[Read the spec (METHOD.md)](METHOD.md)**  ·  **[15-minute quickstart](QUICKSTART.md)**

## Why this exists

Code got cheap. Spec quality is the new bottleneck — and everyone building seriously with AI has noticed. Event storming, domain-driven design, and refinement already had the answer: the leverage is upstream, where being wrong is cheap and being right compounds. The problem was always the cost — a skilled facilitator, time the team promised elsewhere, artifacts that got lost the week after. AI fixes the cost.

The Method puts that rigour within reach of every team. It's not dictation, and it's not vibe coding: the AI is a thinking partner that brings expertise, surfaces gaps, and *pushes back* on weak reasoning. You stay the author; it makes you a sharper one. And it deliberately stops at the spec — implementation happens in your own coding tool, against everything the Method produced. **That's the point.**

It's built for software that has to stand up — production B2B, regulated environments, systems with a real audit and a real blast radius. For that work, the hour saved skipping refinement is the quarter spent in remediation.

There's a deeper reason the upstream work matters. As models write more of the code, the code itself commoditises — cheap to generate, easy to regenerate, tied to whichever model you're using this quarter. What doesn't commoditise is your team's judgment about your own domain: the decisions, the threat reasoning, the language, the standards. The Method captures that judgment as plain files in your repo — a constitution, ADRs, a domain glossary, refined specs — owned by you and independent of any one model. Swap the model underneath and it all stays. You can hand a task to an agent; you can't hand off the learning, and this is where it's kept — compounding, every spec sharpening the next.

## How it works

You don't pick a "skill." You describe what you want:

```
Should we use UUIDv7 over UUIDv4 for primary keys?
Map the domain for our new case-management module
Fix the bug where wallet linkage fails for Solana addresses
Add a bulk asset export feature
```

The Method:

1. **Triages** — figures out whether this is a question, a domain to map, a decision, a bug, a story, an epic, or a multi-epic effort.
2. **Decomposes recursively** through dialogue, going only as deep as the shape of the work warrants — storming the domain first when the shape itself is unclear.
3. **Produces structured output in the right place** — tracker stories under the right epic, ADRs in `docs/adr/`, domain maps and threat models in `plans/{epic}/`, the ubiquitous-language glossary in `docs/domain-glossary.md` — all of it a ready spec a developer (or their coding agent) can build from.

The same loop runs at every depth. Small things get a single turn; multi-epic goals get many.

Under the hood, it's **ten role agents** the loop composes based on what the work needs:

| Role | Mode | Job |
|---|---|---|
| Explorer | Interviewing | Event storming — maps the domain, owns the ubiquitous-language glossary |
| Cartographer | Doing | Reads existing code, produces cited findings |
| Analyst | Interviewing / Drafting | Discovery (scope) and privacy lens |
| Architect | Interviewing / Drafting | Decisions and ADR drafting |
| Designer | Drafting | Design docs |
| Decomposer | Drafting | Story-tree breakdown |
| Test Author | Drafting | Failing tests (never sees implementation) |
| Verifier | Doing | The Definition-of-Ready gate |
| Critic | Doing | Adversarial review (refutes, doesn't approve) |
| Threat Modeller | Interviewing | STRIDE at kickoff — the engineer's recorded risk decisions are the evidence |

Every interviewing role is a **thinking partner, not a stenographer** — it brings expertise, surfaces gaps, and pushes back, to make your judgment sharper rather than transcribe it.

A leaf story exits refinement only when it passes the **Definition of Ready** — a gate of eight core criteria plus a conditional layer keyed on the story's shape (a request path owes a non-functional budget; a data change owes a migration and rollback; and so on). The full framework — the loop, the roles, the gate, the promotion rules, compliance — is in **[METHOD.md](METHOD.md)**.

## Install

**The default path: ask your AI coding agent to install it.** In your project directory, open Claude Code / Cursor / Codex and paste:

> *"Install the agentic refinement method in this repo. Follow the instructions at https://github.com/nlawstudio/ai-refinement-method/blob/main/AGENT_INSTALL.md"*

The agent reads [`AGENT_INSTALL.md`](AGENT_INSTALL.md) — a structured prompt that runs the install as a guided interview: it captures your project context, installs the framework, customises `AGENTS.md` (the constitution) and `method.config.yaml` to your project section by section, sets up `docs/adr/`, wires up gbrain (memory) and your tracker MCP, and smoke-tests with `/onboard`. The install itself is a worked example of the Method's principles — interview-driven, transparent, your input cleaned and structured by the AI.

**Prefer to run it yourself?**

```bash
curl -sSL https://raw.githubusercontent.com/nlawstudio/ai-refinement-method/main/install.sh | sh
```

The script copies the framework files in; existing `AGENTS.md`, `method.config.yaml`, and `docs/adr/` are preserved. Re-run the same command to upgrade — it only overwrites framework files. Pin a version with `sh -s -- --ref v2.2.1`. After a manual install you'll customise `AGENTS.md` and `method.config.yaml` and connect your MCPs yourself (credentials live in `~/.claude/mcp.json`, never in the repo).

<details>
<summary><b>What gets installed, manual install, and post-install configuration</b></summary>

### What the installer brings in

| Path | Contents |
|---|---|
| `.claude/agents/` | The ten role agent definitions |
| `.claude/commands/` | The skills the method composes |
| `.method/triggers.md`, `.method/promotion-rules.md` | When roles fire; when artifacts become canonical |
| `plans/_templates/` | Shapes of the `tree.yaml` and `manifest.yaml` artifacts |
| `METHOD.md`, `QUICKSTART.md`, `AGENT_INSTALL.md` | Documentation references (AGENT_INSTALL is also the prompt agents follow for upgrades) |
| `AGENTS.md` | Created from `AGENTS.template.md` if not already present |
| `docs/adr/README.md` | The ADR template, if `docs/adr/` is empty |

### Manual install (no script)

```bash
git clone https://github.com/nlawstudio/ai-refinement-method.git /tmp/method
cd /your/project
cp -R /tmp/method/.claude /tmp/method/.method .
cp -R /tmp/method/plans/_templates plans/
cp /tmp/method/METHOD.md /tmp/method/QUICKSTART.md /tmp/method/AGENT_INSTALL.md .
[ -f AGENTS.md ] || cp /tmp/method/AGENTS.template.md AGENTS.md
```

### After install

1. **Fill in `AGENTS.md`** — project name, stack, accepted ADRs, and your code/testing/data/compliance conventions. Remove the template banner when done.
2. **Add your ADRs** under `docs/adr/` using the template the installer leaves — or let the Method draft your first one the next time you describe a decision.
3. **Connect gbrain** (memory across sessions). With gstack: `/setup-gbrain`. Without it, the Method still works but loses cross-session memory.
4. **Connect your tracker MCP** (Linear / Jira / GitHub Issues). Without one, `/plan` runs in dry-run mode — all git artifacts, no tracker push. Set `tracker.type: none` in `method.config.yaml` to make the git `tree.yaml` the operational state.
5. **Verify** — open Claude Code and run `/onboard`. If the orientation runs, you're set. (`ls .claude/agents | wc -l` should be 10.)

The agent install does all of this interactively; this list is what it does under the hood, and what to do after a manual install.

</details>

## Quickstart

After install, open Claude Code in the project and describe what you want. Start with a decision you'd be making anyway:

```
Should we use [your-current-question]?
```

It triages to a decision, routes to the Architect, and either drafts an ADR (if the promotion rule fires) or records an informal decision. For something bigger — `Add [feature]` — it runs the full flow: scope, decisions, design, threat model, and a tree of ready stories. When the domain is unclear, `Map the domain for [area]` storms it first. Then take the ready stories — each with a failing test as its spec — into your coding tool to build.

**[QUICKSTART.md](QUICKSTART.md)** is the full 15-minute walkthrough, install to first refined story.

## Documentation

- **[QUICKSTART.md](QUICKSTART.md)** — the 15-minute on-ramp
- **[METHOD.md](METHOD.md)** — the canonical framework specification
- **[AGENT_INSTALL.md](AGENT_INSTALL.md)** — the prompt agents follow to install and upgrade
- **[.method/triggers.md](.method/triggers.md)** · **[.method/promotion-rules.md](.method/promotion-rules.md)** — when roles fire and when artifacts become canonical (both tunable)
- **[CHANGELOG.md](CHANGELOG.md)** — version history

`METHOD.md` and `QUICKSTART.md` are designed decks; GitHub strips their styling. Render them — and the landing page — to self-contained HTML:

```bash
npm run build:docs   # → dist/index.html (site), dist/method.html, dist/quickstart.html
open dist/index.html
```

Styling is single-sourced in [`theme/theme.css`](theme/theme.css); the landing page is [`site/index.html`](site/index.html) (vanilla HTML/CSS/JS, no dependencies). [`.github/workflows/pages.yml`](.github/workflows/pages.yml) deploys `dist/` to GitHub Pages on every push to `main` — enable it once under **Settings → Pages → Source: GitHub Actions**.

## Where project state lives

| File | What | Audience |
|---|---|---|
| `method.config.yaml` | Structured settings (tracker, story sizing, compliance, testing) | Tooling + agents |
| `AGENTS.md` | Prose constitution (principles, conventions, stack) | Humans + agents |
| `~/.claude/mcp.json` | Credentials and MCP server URLs | Claude Code only — never in git |

Operational state lives in your tracker (or `tree.yaml` if `tracker.type: none`); the audit trail and durable decisions live in git (`plans/{epic}/`, `docs/adr/`); cross-session memory lives in gbrain, scoped per project.

## Repo layout

```
.claude/agents/     ← 10 role definitions          (ship in install)
.claude/commands/   ← skills                        (ship)
.method/            ← triggers + promotion rules    (ship)
plans/_templates/   ← tree.yaml + manifest.yaml     (ship)
AGENTS.template.md  ← skeleton constitution → AGENTS.md on install
method.config.template.yaml ← skeleton settings → method.config.yaml
METHOD.md           ← framework spec               (ship)
QUICKSTART.md       ← quickstart                    (ship)
AGENT_INSTALL.md    ← the prompt agents follow      (ship)
scripts/build-docs.mjs ← renders decks + site to dist/
theme/theme.css     ← deck styling
site/index.html     ← landing page
install.sh          ← installer
```

## Contributing

The Method installs into any project, with sensible defaults for B2B SaaS work. See **[CONTRIBUTING.md](CONTRIBUTING.md)** for what kinds of PRs are welcome, how to open issues, and the style guide for new agent or skill files. Security issues: **[SECURITY.md](SECURITY.md)**. All participants follow the **[Code of Conduct](CODE_OF_CONDUCT.md)**.

## License

Released under the **[MIT License](LICENSE)**. Use freely; the Method ships as files into your repo, so the license effectively applies to your installed copy as well.
