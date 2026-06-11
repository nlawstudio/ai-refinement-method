---
description: Investigate a technical unknown via Architect and Cartographer. Surfaces the question, reads existing code where relevant, evaluates options. May produce an ADR if the investigation surfaces a real decision; otherwise produces an investigation note.
---

# /spike

A time-boxed technical investigation. Composes Architect (decision interview) + Cartographer (read existing code) for questions where neither alone is sufficient.

## Usage

```
/spike <question>
```

Examples:

```
/spike how does the current crypto flow handle blockchain reorgs?
/spike what's the right way to integrate this third-party API given our data-handling constraints?
/spike can we use Postgres LISTEN/NOTIFY for field definition cache invalidation, or do we need an external broker?
```

## When to use this vs other skills

| Use this | When |
|---|---|
| `/spike` | The question involves both existing code (Cartographer's job) AND a decision (Architect's job) |
| `/explain` | The question is purely "how does the current system work?" |
| `/decide` | The question is purely "which option do we pick?" — no code reading needed |
| `/adr` | You already know you're going to produce an ADR |

## The flow

1. **Parse the spike question.** Decide whether it needs Cartographer first, Architect first, or both interleaved.

2. **Cartographer phase (if needed).** Invoke Cartographer to read relevant existing code. Produce cited findings about what exists today.

3. **Architect phase.** Invoke Architect in interview mode. The Architect has the Cartographer's findings as context. The conversation surfaces:
   - The question being investigated
   - What we know now (from Cartographer)
   - What options exist
   - What we recommend doing

4. **Track ADR promotion rule.** If the investigation surfaces a decision that meets the rule, promote to ADR. If not, produce an investigation note.

5. **Produce the output.**

## Output forms

### If an ADR was promoted

- ADR in `docs/adr/ADR-XXX-{slug}.md`
- Spike note linking to the ADR (so the investigation context is preserved)

### If no ADR was promoted

Write to `plans/{spike-slug}/spike-note.md` (or `docs/spikes/{date}-{slug}.md` for standalone):

```markdown
# Spike: {question}

**Date:** {date}
**Investigated by:** {human}

## Question
{the question being investigated}

## Findings — what exists today
{Cartographer's cited findings}

## Options explored
{from the Architect interview}

## Recommendation
{the recommended approach — may or may not be a formal decision}

## Open questions
{anything still unresolved}

## Why this did not produce an ADR
{reason — e.g., "no real alternative emerged" or "exploratory only, decision deferred"}
```

## When invoked inside `/plan`

If `/spike` is invoked while a `/plan` session is active:

- The spike is associated with the current epic
- The spike-note is saved to `plans/{epic}/spikes/{slug}.md`
- Any ADR promoted is associated with the epic
- The triggering tree node references the spike

## Quality bar

- Cartographer findings have `file:line` citations
- Architect output has explicit options and trade-offs
- The recommendation is concrete — "we should do X" or "we cannot decide without {missing input}"

## Mode and decision

Output carries:
```
mode: interviewing (Architect) + doing (Cartographer)
decision_required: true (if ADR promoted) or false (if exploratory)
```

The human signs off on the recommendation.
