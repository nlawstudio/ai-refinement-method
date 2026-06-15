---
description: On-demand deep adversarial sweep of the whole project's cross-cutting quality — user experience, test adequacy, compliance, and NFRs — to find where it has drifted. Composes Cartographer (read) and Critic (refute). Produces ranked findings with evidence. The project-level complement to the per-story Critic. Use when you want to know where quality has actually eroded across everything built so far.
---

# /audit

A deep, adversarial sweep of the whole project for drift in the quality that doesn't live in any single file: **user experience, test adequacy, compliance, and non-functional requirements**. Where the Critic refutes one artifact at refinement time, `/audit` surveys everything built so far and finds where these non-local, non-failing concerns have slipped.

This is the heavy, on-demand half of the stewardship layer. For a lighter recurring snapshot, use `/posture`.

## Usage

```
/audit                      # all cross-cutting concerns, whole project
/audit testing              # one concern: testing | ux | compliance | nfr (+ any in method.config.yaml)
/audit nfr in the export module
```

## The flow

1. **Scope.** Confirm which concern(s) and how much of the project (default: all concerns, whole project). State the lenses to be applied and what evidence each will read.
2. **Survey (Cartographer-led).** Read the project's accumulated state for each concern: the code, the test suite, the compliance manifests (`plans/*/manifest.yaml`), the ADRs, the domain map, and the constitution (`AGENTS.md`) as the standard to measure against. Every observation carries a `file:line` or artifact citation.
3. **Refute (Critic-led).** For each candidate finding, an adversarial pass: is this real drift, or noise? Default to "insufficient" when uncertain; verify against the evidence. Drop what can't be substantiated.
4. **Rank and report.** Order surviving findings by how much each erodes the concern, each with: what drifted, why it matters, the evidence, and a concrete next step (an epic to refine, an ADR to draft, a test to add, a budget to set).

For breadth, the survey fans out — one lens per concern, running independently — then findings are deduped before the adversarial pass. The point is coverage no single read would catch.

## Lenses — what "drift" means per concern

- **User experience** — states left unhandled (loading / empty / error), accessibility regressions, interaction seams that compound across features. (For a project scoped back-end-only, this lens reports "out of scope" and says so rather than inventing findings.)
- **Test adequacy** — tests that pass without pinning the behaviour, happy-path-only coverage, missing edge/negative cases, assertions that don't trace back to an AC.
- **Compliance** — manifests with `evidence_quality: not-performed` or unreconciled sections, threat models that were assented-to rather than decided, controls claimed but not evidenced by a test.
- **NFRs** — request paths with no stated budget, limits that drifted from the `method.config.yaml` baselines, `monitor-in-prod` budgets that were never instrumented.

## Output

```markdown
# Audit — {concern(s)} — {date}

## Verdict
{one paragraph: where the project's cross-cutting quality stands, and the sharpest risk}

## Findings (ranked)

### 1. {what drifted} — {concern} — {severity}
**Evidence:** {file:line / artifact}
**Why it matters:** {the non-local, non-failing consequence}
**Next step:** {refine an epic / draft an ADR / add a test / set a budget}

...

## Checked and clear
{lenses applied that found no real drift — so "clear" is recorded, not assumed}
```

## Quality bar

- **Adversarial, not reassuring.** A clean audit means you looked hard and found little — not that you looked lightly. Record what was checked and cleared.
- **Evidence, not vibes.** Every finding cites the artifact or `file:line` it rests on. No finding survives the Critic pass without it.
- **Names the non-local consequence.** "This test is thin" is weak; "this test passes without exercising the wrong-tenant path, so a tenant-isolation regression would ship green" is a finding.
- **No silent caps.** If the sweep bounded coverage (one module, top-N findings), say so — a partial audit must not read as a clean bill of health.

## Mode and decision

```
mode: doing
decision_required: false
```

The audit surfaces findings for the human to triage. It does not fix anything — each finding points back into the Method (refine, decide, test), where the human stays the author.

## What this is NOT

- Not the per-story Critic (`/review`) — that refutes one artifact; `/audit` surveys the whole project.
- Not the recurring snapshot (`/posture`) — that's the lighter "where do we stand" pulse; `/audit` is the deep dig for where it broke.
- Not a fixer — it reports drift; closing it runs back through refinement.
