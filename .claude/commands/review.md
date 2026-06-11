---
description: Critic-led structured review of a PR, file, or design. Adversarial by default — the Critic's job is to refute, not approve. Produces a structured findings document the user triages.
---

# /review

Adversarial review via the Critic.

## Usage

```
/review <target>
```

Target can be:

- A GitHub PR URL: `/review https://github.com/yourorg/yourrepo/pull/142`
- A file path: `/review internal/modules/custody/transfer.go`
- A design doc: `/review plans/EPIC-42/design.md`
- A description: `/review the proposed multi-tenant export rate limiting approach`

## The flow

1. **Identify the review target.** Pull the diff (PR), read the file, or open the document.

2. **Invoke the Critic agent.** The Critic operates in adversarial mode by default.

3. **Critic reviews against:**
   - The design or intent (if it can be inferred or is supplied)
   - The acceptance criteria (if applicable)
   - AGENTS.md conventions
   - The relevant ADRs
   - Standard security, performance, audit, and tenancy considerations

4. **Critic produces structured findings.** Each finding has:
   - Severity (high, medium, low)
   - Issue description
   - Suggested fix
   - Location (file:line for code, paragraph for docs)

5. **Critic surfaces the findings to the human.** Human triages — decides which to act on.

## What the Critic looks for (per pass)

### For a PR or code file

- Edge cases not covered by tests
- Error handling correctness (errors wrapped properly, not swallowed)
- Race conditions (project's testing ADR may mandate the race detector)
- Audit event emission in the same transaction as mutations (per the project's audit-log ADR if applicable)
- Tenant boundary enforcement (per the project's multi-tenancy ADR if applicable)
- Data classification respect in logs (per the project's data-handling ADR if applicable)
- Value objects used at every domain primitive entry point (per the project's domain-modelling ADR if applicable)
- Security implications: SQL injection, auth bypass, privilege escalation, information leak
- Performance implications: N+1 queries, missing indexes, unbounded result sets
- Convention drift vs the constitution

### For a design doc

- Underspecified contracts
- Missing error cases
- Missing audit events
- Missing tenancy considerations
- Missing data classifications
- Internal inconsistencies
- Conflicts with existing ADRs
- Hand-wavy areas masked by jargon

### For a free-text proposal

- Unfalsifiable claims
- Hidden assumptions
- Missing constraints

## Output

```markdown
# Review — {target}

## Summary
{1-2 sentence summary of overall finding}

## Pass / Block: {decision}

## Findings

### {high-severity finding 1}
**Severity:** high
**Issue:** {what's wrong}
**Suggested fix:** {what would address it}
**Location:** {file:line or section}

### {medium-severity finding 1}
**Severity:** medium
...

## What I considered and dismissed
{areas I evaluated and determined are acceptable — for transparency}
```

## The adversarial mindset

The Critic defaults to **refuted**, not **accepted**, when uncertain. If you find yourself praising before critiquing, restart.

The Critic does not produce consensus. The agents being reviewed may be wrong in correlated ways (trained on the same patterns). The Critic is the hedge.

## When invoked inside `/plan`

If `/review` is invoked during an active `/plan` session, the review is saved to `plans/{epic}/reviews/{slug}.md` and becomes part of the audit trail.

## Quality bar

- Specific findings (not "could be better" — exact citation)
- Actionable suggested fixes
- Honest about uncertainty ("I am not sure, but worth checking" is allowed and useful)
- Severity calibrated correctly (do not pad medium with style nits)

## Mode and decision

Output carries:
```
mode: doing
decision_required: false   # findings are surfaced for human triage
```

The human triages. The author of the reviewed work addresses or pushes back.
