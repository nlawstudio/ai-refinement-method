---
description: Full epic refinement. Iteratively decomposes a tracker epic into DoR-ready stories via the agent panel, producing a tree, ADRs, threat model, failing tests, compliance manifest, and tracker stories. Operational state lives in tracker; rich audit trail lives in git.
---

# /plan

Full epic refinement using the role panel. The biggest skill. Composes the whole panel: Analyst → Threat Modeller → Architect → Designer → Decomposer → Test Author → Verifier → Critic.

## Usage

```
/plan <epic-id>
```

Example:
```
/plan EPIC-42
```

## Initialisation — what you do first

1. **Parse the epic ID** from the user's invocation.
2. **Pull the epic from tracker** via MCP. Get title, description, any existing child stories that pre-date refinement.
3. **Create the plan directory:** `plans/{epic-slug}/` where `{epic-slug}` is derived from the epic title (lowercase, kebab-case).
4. **Initialise tree.yaml** — see `plans/_templates/tree.yaml.example` for shape. Root node is the epic.
5. **Initialise conversation.md** — empty file with a session-start header.
6. **Query gbrain** for relevant past plans, ADRs, patterns. Surface to the human if relevant ones exist.
7. **Read AGENTS.md and the accepted ADRs.** Constitution loaded.

## The mandatory opening sequence

Every `/plan` session opens with these phases, in order, before general refinement:

### Phase 0 — Domain discovery (Explorer, when the domain needs mapping)

**Conditional.** If the epic is in unfamiliar or contested domain territory — greenfield, a rebuild, or a domain the team doesn't yet share a model of — invoke the Explorer (`/storm`) first. The event-storming session maps domain events, policies, and hotspots; proposes bounded contexts; and captures the ubiquitous language in `docs/domain-glossary.md`. Its hotspots become the agenda for scope (Phase 1), threat modelling (Phase 2), and decisions (Phase 3); its bounded contexts shape how the epic decomposes (Phase 5).

Skip this phase when the domain is already well understood — go straight to scope.

### Phase 1 — Scope (Analyst, scope mode)

Invoke Analyst in interviewing mode. The human is interviewed on scope. The output (a scope block) is saved to `plans/{epic}/scope.md` and added to the tree as a `scope_node`. If Phase 0 ran, the domain map and its hotspots are input here.

Do not proceed until the human has signed off on scope. Vague scope here pollutes everything downstream.

### Phase 2 — Threat model (Threat Modeller, mandatory)

Invoke Threat Modeller in interviewing mode. The interview is run; the transcript is captured. The output is saved to `plans/{epic}/threat-model.md` and added to the tree as a `threat_model` node.

If the human refuses to engage, mark the threat model as `evidence_quality: not-performed` and inform the human that the epic cannot complete refinement without a genuine threat model interview. They may still proceed, but the compliance manifest will reflect the gap.

### Phase 3 — Architecture decisions (Architect, interview mode)

For each significant decision surfaced during scope or threat modelling, invoke Architect in interviewing mode. Track the ADR promotion rule; promote when it fires.

### Phase 4 — Design (Designer)

Once ADRs are accepted, invoke Designer. Produce `plans/{epic}/design.md`. Human signs off on the design before decomposition begins.

### Phase 5 — Decomposition (Decomposer)

Decomposer produces the story tree. Each leaf must be ≤3 points. Anything 5+ gets split.

### Phase 6 — Test specs (Test Author, per leaf)

For each leaf at candidate-ready, Test Author produces a failing test. Critic runs test-critique pass. Verifier confirms the test fails for the right reason.

### Phase 7 — Promotion to tracker

For each leaf passing DoR, promote to tracker under the epic. See "Promotion to tracker" below.

### Phase 8 — Compliance manifest

The manifest accumulates as the session proceeds — every promotion writes to it. At session end, the Verifier runs the manifest-completeness check (part of its epic-level exit checks): every promoted story's controls, privacy impacts, and test coverage reconciled, and the threat model signed. The manifest does not close with an unreconciled section.

## The refinement loop (after the mandatory opening)

For nodes that are not yet at DoR:

1. **Pick the next node.** Breadth-first for the first 2-3 levels (the human sees the full tree shape early). Depth-first within branches after that. Always allow human override.
2. **Dispatch to the right agent** based on the node's flag:

   | Flag | Agent |
   |---|---|
   | needs-domain-map | Explorer (storm mode) |
   | needs-discovery | Analyst (scope mode) |
   | needs-existing-code-read | Cartographer |
   | needs-decision | Architect (interview mode) |
   | needs-design | Designer |
   | needs-decomposition | Decomposer |
   | needs-test-spec | Test Author |
   | needs-privacy-assessment | Analyst (privacy mode) |
   | needs-threat-model | Threat Modeller |
   | DoR-ready-check | Verifier (DoR mode) |
   | needs-critic-pass | Critic |

3. **Render the new state** to the human in chat:
   - What you just decomposed and how (which node, which agent, what came back)
   - Current state of the tree (with the active node highlighted)
   - What's about to happen next
   - Any open questions blocking progress

4. **Wait for human response.** They can: approve, modify, ask for alternatives, drill elsewhere, pause.

5. **Update tree.yaml and conversation.md.** Loop.

## Promotion to tracker — per leaf

When a leaf passes DoR (confirmed by Verifier in DoR mode) and the human approves promotion:

1. Use tracker MCP to create a child story under the epic
2. Populate the description:

   ```
   ## Story
   {story title and format}

   ## Acceptance Criteria
   - {AC 1}
   - {AC 2}
   ...

   ## Test Notes
   Test file: plans/{epic}/tests/{story-slug}_test.go
   Test level: {unit | integration | e2e}
   Compliance tags: {SOC2:CC6.1, ISO27001:A.5.15, ...}

   ## Linked ADRs
   - {ADR-XXX} — {short description}
   - {ADR-YYY} — {short description}
   ...

   ## Stop Conditions
   See AGENTS.md standard block plus:
   - {any task-specific}

   ---
   Refined under [plans/{epic-slug}/]({repo-url}/tree/main/plans/{epic-slug})
   ```

3. Set estimate to the point value
4. Set dependencies via tracker's "blocked by" relationship for each declared dependency
5. Record the tracker story ID in the tree.yaml node

## Termination

Refinement is complete when:

- All leaves pass the DoR gate (core criteria + their facets' conditional criteria)
- The Verifier's epic-level exit checks pass: the leaf set forms a valid dependency DAG, every domain-map hotspot is closed (resolved or explicitly deferred), and the compliance manifest reconciles
- All decisions are captured (promoted to ADRs or recorded as informal decisions)
- All test specs compile and fail for the specified reason
- Threat model is present and human-reviewed, with the engineer's risk decisions recorded (or explicitly marked not-performed with human acknowledgement)
- The human marks the plan as complete

Pause (resumable) when:

- The human marks the session as draft
- An agent surfaces an unresolvable question requiring offline input (missing ADR, customer decision, infrastructure question)

Resumption: `/plan resume <epic-id>` re-opens the session and picks up where it left off based on tree.yaml state.

## Output artifacts

At session end:

- `plans/{epic-slug}/tree.yaml` — full tree state
- `plans/{epic-slug}/conversation.md` — full chat log
- `plans/{epic-slug}/scope.md` — scope brief
- `plans/{epic-slug}/threat-model.md` — interview transcript + structured model
- `plans/{epic-slug}/design.md` — design doc
- `plans/{epic-slug}/decisions.md` — informal decisions log
- `plans/{epic-slug}/tests/*.go` — failing tests per leaf
- `plans/{epic-slug}/manifest.yaml` — compliance evidence pack
- `docs/adr/ADR-XXX-{slug}.md` — any new ADRs promoted during the session
- tracker stories created under the epic, with bidirectional links

Then: open a PR for the `plans/{epic-slug}/` directory. The PR is the artifact that gets reviewed.

## Critical behaviours

- **Always show the current tree state at every turn.** Transparency is non-negotiable.
- **Always announce promotions.** "This is shaping up as an ADR — OK?" Never silent.
- **Always tag outputs with mode and decision_required.**
- **Never silently transition between skills.** If `/plan` surfaces something that warrants `/threat-model` invocation, announce.
- **Never accept a leaf as ready that does not pass the DoR gate (core criteria + its facets' conditional criteria).**
- **Never silently fix architectural issues.** Surface them — route a missing decision to `/decide` or `/adr`, a domain gap to `/storm`, an ambiguous scope back to the Analyst.

## What happens when something goes wrong

- Agent surfaces a finding the human disagrees with → the human's decision wins; record it in decisions.md as a noted disagreement.
- Agent produces a confidently wrong claim → the citation discipline rule catches it (the orchestrator rejects unsourced claims at the trigger profile level).
- Tree gets very large (>50 leaves) → consider whether the epic should have been split before refinement; surface to human.
- Session token budget exhausted → save state, surface to human, resume later.
- Human marks the plan as a draft → save tree.yaml, conversation.md, all artifacts; do not promote anything not yet promoted.
