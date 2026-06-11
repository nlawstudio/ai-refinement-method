---
description: Discuss a decision with the Architect without committing to whether it becomes an ADR. If the conversation reveals durable alternatives genuinely considered, automatically transitions to drafting an ADR. If not, records an informal decision in the session log.
---

# /decide

A discussion-mode entry point for decisions. Lighter weight than `/adr` — does not assume the conversation will produce an ADR.

## Usage

```
/decide <topic>
```

Examples:

```
/decide should we cache field definitions in memory or in Postgres LISTEN/NOTIFY?
/decide do we need a separate read replica for analytics queries?
/decide naming convention for repository methods — Save vs Persist vs Store?
```

## Why this exists alongside `/adr`

`/adr` assumes from the start that the conversation will produce an ADR. `/decide` does not. It is more useful when:

- You are not sure whether the topic warrants an ADR
- You want to think out loud with the Architect first
- The topic might turn out to be a tactical decision (no ADR) or a strategic one (ADR)

Functionally, they are similar. The difference is the *initial framing*.

## The flow

1. **Invoke Architect in interview mode.** Same interview as `/adr` but framed as a discussion.

2. **Architect interviews the human** to surface context, alternatives, trade-offs, constraints, and the proposed decision.

3. **Architect tracks the ADR promotion rule continuously.** Same rule as `/adr`:
   - Would this surprise a future contributor?
   - Were alternatives genuinely considered?

4. **Branching:**

   - **If the rule fires:** Architect announces: "This is shaping up as a durable decision worth recording as an ADR — promote it?" If the human says yes, transition to ADR drafting mode (same flow as `/adr`).

   - **If the rule does not fire:** Architect informs the human: "This isn't really an ADR — {reason}. I'll record it as an informal decision in this session's log."

5. **Either way**, the conversation has a useful output:
   - The decision is recorded somewhere (canonical ADR or session log)
   - The rationale is captured

## Recording an informal decision

If the rule does not fire, write to:

- If `/decide` was invoked inside a `/plan` session: `plans/{epic}/decisions.md`
- If standalone: `~/decisions/{date}-{slug}.md` (or appropriate session-local location)

Format:

```markdown
# Decision: {topic}

**Date:** {date}
**Made by:** {human}

## Context
{from the interview}

## Decision
{what was decided}

## Rationale
{why}

## Why this is not an ADR
{reason — e.g., "default choice with no real alternative" or "tactical scope, not architectural"}
```

## When the human disagrees with promotion

If the Architect proposes promoting to an ADR and the human says "no, this isn't ADR-worthy" — respect that. The human's call wins. Record as an informal decision.

If the human asks to promote to an ADR but the rule does not fire — proceed cautiously. Ask: "I don't think this meets the ADR promotion rule because {reason}. Do you want to promote anyway?" If they confirm, proceed — but note in the ADR that it was promoted despite the rule. (This is rare but possible.)

## Quality bar

Same as `/adr` for promoted decisions. For informal decisions, the rationale is captured but no template is enforced — just the four-section structure above.

## Mode and decision

Output carries:
```
mode: interviewing
decision_required: true
```

The human approves either the ADR draft or the informal decision text before it lands.
