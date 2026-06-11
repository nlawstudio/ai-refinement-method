---
description: Build-loop skill. Picks up a tracker story marked Ready, runs Builder → Verifier → Critic → PR. If Builder hits a stop condition mid-flight, automatically routes to /off-course (the bridge back to refinement).
---

# /build

The build-loop skill. Takes a tracker story that passed Definition of Ready during refinement and turns it into a merged PR. Composes Builder + Verifier + Critic with the off-course bridge as the escape hatch.

## Usage

```
/build <story-id>
```

Examples:

```
/build STORY-142
/build STORY-156
```

Or just describe what story to pick up:

```
build the rate-limiting story
```

The triage layer recognises a build intent and routes to this skill.

## Initialisation — what you do first

1. **Pull the story from tracker** via MCP. Get title, description, AC, linked ADRs, point estimate, dependencies.
2. **Verify dependencies are merged.** If any "blocked by" story is not yet Done, surface to the human: "STORY-142 is blocked by STORY-138 which is still in progress. Wait for it to merge, or pick a different story?"
3. **Locate the failing test** from the refinement phase. It should be at `plans/{epic-slug}/tests/{story-slug}_test.go` or, if the plan was already merged, in the codebase at the expected test location.
4. **Confirm the test still fails** (Verifier in test-confirm mode). If it now passes, the work has been done already — surface and stop.
5. **Open a worktree** for this story (`git worktree add ../{story-slug}` or equivalent isolation).
6. **Read AGENTS.md and the linked ADRs** to load constitutional context for the Builder.

## The build loop

```
Story (tracker: Ready)
     ↓
Builder reads test + AC + linked ADRs + AGENTS.md
     ↓
Builder writes minimum code to make test pass
     ↓
Verifier runs test → expected pass
Verifier runs broader package tests → no regressions
Verifier runs `go test -race` (or project equivalent) → no race detector findings
     ↓
Critic code-critique pass:
  - Edge cases the test doesn't cover
  - Error handling correctness
  - Audit event emission in same transaction as mutation
  - Tenant boundary enforcement
  - Data classification in logs
  - Security implications
  - Performance implications (N+1, unbounded result sets)
  - Convention drift vs the constitution
     ↓
If Critic has high-severity findings → human triages → Builder addresses → loop
If Critic clean → Builder opens PR
     ↓
PR includes:
  - The story ID and tracker story ID in description
  - The linked ADRs
  - Compliance tags evidenced (SOC 2 / ISO 27001 etc.)
  - Test additions
  - Race detector pass confirmation
     ↓
tracker: story moves to In Review
     ↓
Human reviews and merges
     ↓
tracker: story moves to Done
     ↓
Downstream stories unblock automatically (if their "blocked by" was this one)
```

## Stop conditions — when build pauses and routes to off-course

The Builder cannot work around any of these. If hit, **stop and trigger `/off-course`**:

- Task requires a decision not covered by linked ADRs
- Completing this would require modifying AGENTS.md, an ADR, or a skill
- Three or more attempts at the same problem without progress
- AC ambiguous or contradictory (the test doesn't tell you what to build)
- A declared dependency is complete but its output is missing or incorrect
- A security or performance concern not addressed in the constitution has been discovered
- Completing this task would require expanding the declared scope
- The failing test from refinement no longer compiles against the current codebase

When any stop condition fires, the build loop **pauses**, the worktree is left in place for inspection, and `/off-course` is invoked with the diagnostic.

## tracker state transitions

| Phase | tracker status |
|---|---|
| Story selected for build | `Ready` → `In Progress` |
| Builder working | `In Progress` |
| Stop condition fired | `In Progress` → `Blocked` (with comment linking to the off-course session) |
| Off-course resolves and unblocks | `Blocked` → `Ready` (re-enter build) |
| Builder + Critic complete | `In Progress` → `In Review` (with PR link) |
| PR merged | `In Review` → `Done` |

## Quality bar

- Test passes for the right reason (not because Builder mocked the assertion)
- Race detector clean
- Conforms to AGENTS.md and the linked ADRs
- All Critic high-severity findings addressed
- PR description includes the story ID, linked ADRs, compliance tags, and any relevant test additions
- No silent fixes — every deviation from the spec was surfaced via /off-course or to the human

## Failure modes to avoid

- **Working around an ambiguous AC.** If the test is unclear, /off-course it — do not interpret.
- **Approving Critic's own findings as "acceptable."** Findings are for the human to triage.
- **Modifying AGENTS.md or an ADR during build.** Never. Route through /off-course.
- **Adding scope.** If the implementation needs something beyond the declared AC, surface it as a separate story via /off-course.
- **Skipping the race detector.** Mandatory.

## Mode tagging

Output carries:
```
mode: doing
decision_required: false   # for the implementation itself; human reviews the PR
```

The PR review is where the human signs off.

## What happens if tracker isn't connected

Dry-run mode. The skill produces the code and PR locally; manual status updates needed in tracker. All other behaviour identical.
