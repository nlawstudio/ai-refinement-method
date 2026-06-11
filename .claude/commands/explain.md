---
description: Cartographer-led walkthrough of existing code. Pure reading — no decisions, no modifications. Produces a structured, cited explanation of how some part of the system works. Use when you need to understand existing code, onboard onto a module, or verify a claim about current behaviour.
---

# /explain

Read-only walkthrough of the existing codebase. The Cartographer's natural home.

## Usage

```
/explain <what you want explained>
```

Examples:

```
/explain how does the current crypto wallet linkage work?
/explain the FieldDefinition validation flow
/explain how RLS is enforced on the assets table — show me the policy and the session setup
/explain what happens when a custody transfer is initiated
```

## The flow

1. **Cartographer reads the relevant code.** Uses Read, Grep, Glob, and Bash as needed. Stays read-only.

2. **Cartographer produces structured findings** with `file:line` citations for every claim.

3. **If the user's question contained ambiguity** (e.g., "the crypto flow" could mean ingestion or custody transfer), the Cartographer surfaces the ambiguity first and asks for clarification rather than guessing.

4. **If the codebase does not contain the requested information** (the feature doesn't exist, or the question is about behaviour that's not implemented yet), the Cartographer says so explicitly. Absence is a valid finding.

## Output

The output is the Cartographer's structured findings, rendered in chat. Format:

```markdown
## Question
{verbatim user question}

## Findings

### {key concept 1}
{description}

**Citation:** `path/to/file.go:42-58`

### {key concept 2}
...

## What I could not determine
{anything the code did not answer}

## Adjacent observations
{things I noticed during the read that might be relevant — surfaced for the user's awareness}
```

## When invoked inside `/plan`

If `/explain` is invoked while a `/plan` session is active, the findings are saved to `plans/{epic}/explanations/{slug}.md` so they become part of the refinement audit trail.

If the explanation surfaces something that materially changes the plan (e.g., a constraint the planner did not know about), the Coordinator announces and the human decides what to do with the new information.

## Quality bar

- Every claim has a `file:line` citation
- No interpretive leaps unsupported by code
- Uncertainty is named explicitly — "I could not determine X" rather than "X probably works as Y"
- Surfaces adjacent observations without padding the main findings

## Mode and decision

Output carries:
```
mode: doing
decision_required: false
```

Reading the code does not require human approval. The findings inform the user; downstream decisions are theirs.

## What this is NOT

- Not a code review (`/review` is that)
- Not an investigation that produces a decision (`/spike` is that)
- Not an onboarding curriculum (`/onboard` is that — it composes /explain with curated structure)
