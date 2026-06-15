---
description: Curated orientation for a new dev joining the team. Composes Cartographer (read code), Architect (summarise ADRs), and structured curriculum into a personalised onboarding doc. Output is read once at the start; /explain handles ongoing questions.
---

# /onboard

Produce a structured orientation document for a new dev joining this project.

## Usage

```
/onboard
```

Or with a focus area:

```
/onboard --focus auth
/onboard --focus testing
/onboard --focus compliance
```

## The flow

1. **Read AGENTS.md** (the project's constitution).
2. **Read the ADR index** in `docs/adr/` and summarise each ADR in plain language.
3. **Cartographer surveys the codebase structure** — high-level: module layout, entry points, where domain logic lives, where infrastructure lives.
4. **Compose an orientation doc** structured for a first read.

## Output

`docs/onboarding/{name-or-date}.md`:

```markdown
# Welcome to {project name}

You've just joined the team. This document is your one-shot orientation. It is generated from the current state of the codebase and ADRs — re-run `/onboard` any time to get a fresh one.

## What we're building

{Project-specific summary derived from AGENTS.md and ADRs}

## Who you'll work with

{Team structure, ways of working}

## The things you must know before writing code

{Top 5 ADRs the architect identifies as load-bearing for this project}

For each:
- 2-3 sentence summary
- What you'd be surprised by
- Where to look for the decision

## The constitution

`AGENTS.md` is the project's constitution. Every agent reads it at session start. So should you. Conventions you'll be held to are documented there.

## Codebase map

{Cartographer fills this in — module structure, where things live, how to navigate.}

## The ADRs in plain language

{Architect summarises each ADR in 2-3 sentences.}

## The method — how we work with AI

This project uses the agentic refinement method. When you sit down to do something, describe it in plain language. The method figures out the shape:

- Asking a question → walkthrough
- Mapping an unfamiliar domain → event storming (`/storm`)
- Making a decision → ADR or informal record
- Fixing a bug → 1 story
- Adding a feature → epic refinement

The method produces a ready spec — stories with failing tests, decisions, threat models, a domain map. You take those into your own coding tool to implement.

You'll see the method invoke agents (Explorer, Cartographer, Analyst, Architect, etc.) — these are role primitives the loop composes. You don't have to pick them by name.

See `QUICKSTART.md` for the 15-minute on-ramp — install, first decision, first refined story.

## First week

- Read this document
- Read AGENTS.md
- Skim the ADR index; deep-read the ones marked load-bearing above
- Describe a small piece of the codebase you want to understand — the method will run /explain
- Pair with another dev on a small story to feel the method
- Don't write production code in week one unless someone is watching

## Where to ask questions

- For "how does X work" — describe it; the method will run /explain on X
- For "should I do X or Y" — describe the decision; the method routes to the Architect
- For "I'm stuck on something" — ask a teammate
- For "I think we should change Y" — propose it; the method will check the ADR promotion rule
- For "this might be a security issue" — flag it; the method routes to the Threat Modeller

Welcome aboard.
```

## Quality bar

- The codebase map is accurate (Cartographer's citations)
- The ADR summaries are faithful (not aspirational)
- The doc is generated fresh — never stale
- One read should be enough to start working under supervision

## When the team grows

Each new dev runs `/onboard` on their first day. The doc is regenerated for them, reflecting whatever state the codebase, ADRs, and conventions are in at that moment.

## Mode and decision

Output carries:
```
mode: doing
decision_required: false
```

The new dev reads the doc. No approval gate.

## What this is NOT

- Not a quick start — the project's QUICKSTART.md (installed by the method) is that
- Not the full constitution — AGENTS.md is that
- Not the framework spec — METHOD.md is that
- A one-shot orientation that points at all of the above
