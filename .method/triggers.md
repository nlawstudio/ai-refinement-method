# Trigger Profiles

When each role gets invoked. Transparent by design — humans can read the conditions and tune them when promotions feel wrong (too eager, not eager enough).

The orchestrator watches these continuously. When a condition matches, the orchestrator either invokes the role (for autonomous roles) or asks the human ("This looks like X — invoke Y agent? Or carry on?").

Every invocation is announced. None are silent.

---

## Cartographer

**Scope:** application code reads only. Schema, API contract, module-graph, and domain-type questions resolve from the structured reference layer (`docs/schema.sql`, `docs/openapi.yaml`, `docs/module-map.md`, `docs/domain-types.md`) without invoking Cartographer.

Invoked when:
- Conversation references existing application code behaviour
- Human cannot answer "does the system do X today?" for an implementation question
- Any task involves rebuilding, refactoring, or integrating with existing implementation code
- An agent needs to verify a claim about existing code at the implementation level (citation discipline)
- `/explain` skill invoked on application code

**Not invoked for:** "what does the schema look like?" (read `docs/schema.sql` directly), "what API endpoints exist?" (read `docs/openapi.yaml` directly), "which modules depend on which?" (read `docs/module-map.md` directly). These questions resolve from Tier 2.

Operates in **doing** mode. No human sign-off needed for reading.

---

## Explorer

Invoked when:
- The front of an epic in unfamiliar or contested domain territory — before scope or decomposition
- Greenfield work where the domain model doesn't exist yet
- A rebuild or migration where the model is implicit in old code and needs surfacing
- The conversation reveals the team doesn't share a model (same word for different things, or different words for one thing)
- `/storm` skill invoked

**Not invoked for:** small bugs or well-understood changes where the domain shape isn't the open question.

Operates in **interviewing** mode. Maps the domain (events, commands, policies, hotspots), proposes bounded contexts, and maintains the ubiquitous-language glossary. Transcript captured; map and glossary signed off.

---

## Analyst — Scope mode

Invoked when:
- Epic kickoff (mandatory at start of `/plan`)
- Scope question surfaces during refinement
- Decomposer cannot determine in/out of scope for a node
- Human says "what are we actually trying to do here"

Operates in **interviewing** mode. Transcript captured.

## Analyst — Privacy lens mode

Invoked when:
- Any node touches data classified sensitive per the project's data-handling ADR
- New endpoint, new data flow, new external integration
- Audit chain or audit access patterns are affected
- `/plan` reaches a story involving PII or other sensitive content

Operates in **drafting** mode. Output reviewed by human.

---

## Architect — Decision interview mode

Invoked when:
- A decision-point node appears in the refinement tree
- Two or more alternatives are surfaced for the same node
- A trade-off discussion starts
- `/decide`, `/adr`, or `/spike` skill invoked
- Cartographer surfaces an undocumented decision in existing code

Operates in **interviewing** mode. Transcript captured.

## Architect — ADR drafting mode

Invoked when:
- The ADR promotion rule fires during interview (see `promotion-rules.md`)
- Human explicitly asks "let's make this an ADR"

Operates in **drafting** mode. Draft reviewed by human.

---

## Designer

Invoked when:
- ADRs for an epic are accepted and a design doc is needed
- A node has flag `needs-design`
- Decomposer cannot produce DoR-ready leaves without more design context
- `/plan` reaches the design phase

Operates in **drafting** mode.

---

## Decomposer

Invoked when:
- Design doc is approved and DoR-ready stories need to be produced
- A node carries flag `needs-decomposition`
- A leaf story estimates >3 points (must be split further)
- `/plan` reaches the decomposition phase

Operates in **drafting** mode.

---

## Test Author

Invoked when:
- A story has AC and is approaching DoR (during refinement, not after)
- A node carries flag `needs-test-spec`
- A story is reaching candidate-ready state without a failing test yet

**Does not see implementation.** Operates in **drafting** mode. The failing test is the spec a developer later implements against, in their own tool.

---

## Verifier

Invoked when:
- A leaf story is a candidate for "ready"
- The DoR gate needs confirmation — the eight core criteria plus any its facets trigger
- Test Author has produced a test file (Verifier confirms it fails for the specified reason)
- An epic is closing (Verifier runs the epic-level exit checks: dependency DAG, hotspot closure, manifest completeness)

Operates in **doing** mode. The gate a story passes before exiting refinement.

---

## Critic — Test critique pass

Invoked **immediately after** Test Author produces a test file. Job: does this test exercise the right behaviour, or just hit coverage?

Operates in **doing** mode. Default to "this is insufficient" unless the test genuinely exercises behaviour.

## Critic — Code or design critique (on-demand)

Invoked when `/review` targets a PR, a code file, or a design doc. Job: what could break this that the tests don't catch? What does it hand-wave? Where would I attack it?

Operates in **doing** mode. Default to "refuted" rather than "accepted" when uncertain. Not an automated step — invoked deliberately by the human against work that already exists.

---

## Threat Modeller

Invoked when:
- **Epic kickoff** (mandatory at start of `/plan`)
- Any story introduces new attack surface (new endpoint, new external integration)
- Any story changes authentication or permission boundaries (per the project's auth ADRs)
- Any story modifies the audit chain or its integrity (per the project's audit-log ADR)
- Any story touches the tenant isolation boundary (per the project's multi-tenancy ADR)
- `/threat-model` skill invoked standalone

Operates in **interviewing** mode. The engineer's engaged input — cleaned by the AI and signed off — is the compliance evidence. Generic STRIDE output without engineer engagement does not count.

---

## How to tune

If a role is invoked too eagerly: tighten the conditions above. Make them more specific.

If a role is missed when it should have been invoked: surface the case at retro, add the missed condition above.

Trigger tuning is itself a form of constitution change — should go through the same governance as other constitution changes.
