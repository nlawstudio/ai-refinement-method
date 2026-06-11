---
description: The bridge between build and refinement. When the Builder hits a stop condition mid-build, /off-course diagnoses the upstream change needed and routes to the appropriate refinement role. Drafts the upstream change as a governed PR; once merged, the original story unblocks and build resumes.
---

# /off-course

The build-to-refinement bridge. Hits when build can't proceed without an upstream change. Diagnoses the kind of change needed, routes to the right refinement role, and produces a governed PR for the upstream change.

This skill is rarely invoked directly by humans — it's almost always triggered by `/build` when a stop condition fires. But it can be invoked manually if a developer notices a problem outside of build (e.g., spots an ambiguous AC in tracker without running build yet).

## Usage

Automatic invocation (from `/build`):

```
/off-course story=STORY-142 reason="AC contradicts the audit-log ADR on event timing"
```

Manual invocation:

```
/off-course STORY-142 the AC is ambiguous about whether per-tenant or global rate limiting
```

## Initialisation — what you do first

1. **Pull the story** from tracker via MCP. Get full context — AC, linked ADRs, prior conversation in the plan, current Builder state.
2. **Read the diagnostic** from the build loop. What stop condition fired? Why?
3. **Read the relevant ADRs** referenced by the story.
4. **Open the original refinement plan** at `plans/{epic-slug}/` if it exists.

## Diagnosis — what kind of upstream change is needed?

This is the first thing you decide. The kind of change determines which refinement role handles it.

| Kind of change | Triggered by | Refinement role |
|---|---|---|
| **ADR gap or contradiction** | Story requires a decision not in linked ADRs, or contradicts one | Architect (interview mode) |
| **AC ambiguity** | Test doesn't make clear what to build | Analyst + Test Author (revise AC + rewrite test) |
| **AC contradiction with an existing ADR** | The AC and an ADR pull in opposite directions | Architect to reconcile + Analyst to update AC |
| **Missing existing-code context** | Builder needs to understand legacy or adjacent behaviour | Cartographer |
| **Security / privacy concern unaddressed** | Builder noticed a threat not in the threat model | Threat Modeller (supplementary session) |
| **Scope expansion needed** | Story can't be completed without doing something beyond declared scope | Analyst (rescope) + possibly Decomposer (split into new story) |
| **Missing test data generator** | Test needs a fixture type that doesn't exist | Test Author (build the generator first) |
| **Architectural boundary crossed** | Implementation would touch more than one architectural boundary | Decomposer (split the story) |

If the diagnosis is unclear, **surface to the human**: "I think this is either an ADR gap or an AC ambiguity — which feels right?"

## Routing — invoke the right role

Once diagnosed, invoke the refinement role. The role's standard skill behaviour applies, with two additions:

1. The context includes the off-course diagnostic and the original story state
2. The output is framed as an **upstream change** to a governed artifact, not a new artifact

### For ADR gaps

Invoke Architect in interview mode. Architect interviews the human on the missing decision, drafts an ADR amendment or new ADR, opens a PR against `docs/adr/`. Once merged, the original story's linked ADRs are updated, and the Builder is re-invoked.

### For AC ambiguity

Invoke Analyst to clarify the AC via interview. Then Test Author re-writes the failing test to match the clarified AC. The tracker story description is updated. Builder re-invoked with the new test.

### For threat-model gaps

Invoke Threat Modeller in supplementary-session mode. The new threats are added to the epic's manifest. The original story may gain new AC or new stop conditions; if it does, route back through Analyst + Test Author.

### For scope expansion

Invoke Analyst to scope the expansion explicitly. If the expansion is genuine new work, Decomposer splits it into a new story under the same epic. The original story may continue (now with reduced scope) or be blocked behind the new story.

## The governed PR

Every off-course resolution produces a PR against one or more governed artifacts:

- `docs/adr/ADR-XXX.md` — new or amending ADR
- `plans/{epic-slug}/scope.md` — scope clarification
- `plans/{epic-slug}/threat-model.md` — supplementary threats
- `plans/{epic-slug}/tests/{story-slug}_test.go` — revised failing test
- tracker story update (via MCP)

The PR carries:
- A link back to the off-course session
- The diagnostic that triggered it
- The original story ID
- The kind of change being made (per the table above)

## Unblocking

Once the governed PR merges:

1. **Update tracker** — the original story moves from `Blocked` back to `Ready`
2. **Re-invoke `/build`** for the story (or surface to the human: "ready to resume?")
3. **Record the off-course event** in the epic's manifest so the audit trail shows the bridge fired

## Quality bar

- The diagnosis is specific. "AC is ambiguous" is not enough; specify which clause is ambiguous and why.
- The routing matches the diagnosis. ADR gaps go to Architect, not Analyst.
- The governed PR is reviewable — not just a hand-wavy comment, but an actual change to a tracked artifact.
- The tracker state transitions are correct.

## Failure modes to avoid

- **Silent fixes.** Never modify code to "work around" the upstream issue. Every off-course goes through a governed PR.
- **Wrong routing.** A scope expansion is not an ADR gap. Diagnose carefully.
- **Skipping the audit trail.** The off-course event is itself part of the compliance trail — it shows the team caught and routed the issue rather than papering over it.
- **Re-invoking Builder before the upstream PR merges.** The whole point is that the upstream gets fixed first.

## Mode tagging

Off-course operates in **interviewing** mode by default (because the diagnosis usually needs human input on the right diagnosis) and then **drafting** mode as the upstream artifact gets produced.

```
mode: interviewing → drafting
decision_required: true
```

## What happens if the human disagrees with the diagnosis

Push back. The human's judgment overrides the diagnostic.

> "I think this is an AC ambiguity, not an ADR gap. Re-route to Analyst, not Architect."

The off-course skill respects this and routes accordingly.

## When invoked outside a `/build` session

A human might notice a problem and want to route it through governance proactively. In that case:

```
/off-course STORY-142 the AC contradicts the multi-tenancy ADR on tenant scoping
```

Same flow, just human-initiated instead of build-initiated.
