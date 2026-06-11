---
description: Draft an ADR via interview with the Architect. Captures an architectural decision with rationale, alternatives, and consequences. Watches the ADR promotion rule — if alternatives are real and the decision would surprise a future contributor, produces a canonical ADR; otherwise records an informal decision.
---

# /adr

Capture an architectural decision via interview. The simplest and most-used skill.

## Usage

```
/adr <topic>
```

Examples:

```
/adr should we use UUIDs or ULIDs for primary keys?
/adr how should FieldDefinition caching work?
/adr blockchain confirmation polling strategy
```

The topic is the decision question. Phrase it as a question if possible — that makes the interview easier.

## The flow

1. **Invoke Architect agent in interview mode.** Pass the topic as the decision being explored.

2. **Architect interviews the human.** Questions covered (the Architect drives this):
   - What is the decision?
   - What is the context that requires this decision now?
   - What alternatives have you considered?
   - What are the trade-offs of each?
   - What constraints apply (existing ADRs, compliance, deadline)?
   - What is the decision?
   - What is the rationale — why this option over the others?
   - What are the consequences (positive and negative)?

3. **Architect tracks the ADR promotion rule continuously:**
   - Would this surprise a future contributor?
   - Were alternatives genuinely considered?
   - **Both** must hold.

4. **When the promotion rule fires** (or if the human explicitly asks to make it an ADR):
   - Announce: "This is shaping up as a durable decision with real alternatives considered — drafting it as an ADR. OK?"
   - On approval, draft using the project's ADR template (see `docs/adr/README.md`).

5. **When the promotion rule does not fire:**
   - Tell the human: "This isn't really an ADR — {reason}. Recording as an informal decision in this session's log."
   - Save to a session note rather than `docs/adr/`.

## The ADR template

```markdown
# ADR-XXX: {Title}

## Status
{Proposed | Accepted | Superseded by ADR-XXX}

## Context
{What is the situation that requires a decision?}

## Options Considered
{Each alternative, with trade-offs}

## Decision
{What was decided}

## Rationale
{Why this option over the others}

## Consequences
{What becomes easier or harder as a result}

## Compliance Mapping
{The project's compliance frameworks. Reference specific control IDs.}

## Date
{Year}
```

## File naming and numbering

- Read `docs/adr/` to find the next sequential ADR number
- Filename: `docs/adr/ADR-{XXX}-{slug-of-title}.md`
  - Pad number to three digits (ADR-020, not ADR-20)
  - Slug is lowercase, hyphen-separated, derived from the title

## Storage on completion

- Canonical ADR → `docs/adr/ADR-XXX-{slug}.md`
- Index entry → update `docs/adr/README.md` index table
- Memory → store ADR summary in gbrain project ring for future reference

## When invoked from inside `/plan`

If `/adr` is invoked while a `/plan` session is active:

- The ADR is associated with the current epic
- The manifest's `adrs_produced` list is updated
- The triggering tree node is marked as `promoted_to_adr: ADR-XXX`

## Quality bar

- ≥2 alternatives genuinely considered (otherwise this is not an ADR)
- Trade-offs explicit for each alternative
- Existing ADR references use ADR IDs verified to exist
- Existing code references use `file:line`
- No hallucinated alternatives — every option in "Options Considered" was actually discussed

## Mode and decision

Output carries:
```
mode: interviewing (during the interview) → drafting (when producing the ADR text)
decision_required: true
```

The human approves the draft before it lands in `docs/adr/`.
