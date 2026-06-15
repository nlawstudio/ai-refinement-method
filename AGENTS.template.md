# AGENTS.md

> **This is a template.** When the method is installed via `install.sh`, this file becomes your project's `AGENTS.md`. Fill in the bracketed sections with your project's specifics. Remove this note when done.

The constitution for **[Your project name]**. Every agent reads this at session start.

For the full framework, see `METHOD.md`. For accepted decisions, see `docs/adr/`.

---

## The unified loop

The method runs as **one loop**, invoked by a developer describing what they want in plain language. The loop:

1. **Triages** the input — figures out whether it's a question, a decision, a bug, a story, an epic, or a multi-epic effort
2. **Decomposes recursively** through dialogue with the human, going only as deep as the work warrants
3. **Produces structured output** — tracker stories, ADRs, threat models, compliance manifests — with this project's SDLC requirements baked in

The same loop runs at every depth. Skills (`/plan`, `/storm`, `/adr`, `/decide`, `/spike`, `/threat-model`, `/explain`, `/review`, `/onboard`, `/handoff`) exist as internal capabilities the method composes — users don't typically invoke them by name. The Method stops at a ready spec; implementation happens in the developer's own coding tool.

---

## Core principles

### The three operating modes

Every agent output operates in exactly one of three modes. The mode is explicit on every output.

| Mode | Pattern |
|---|---|
| **Doing** | AI acts, no human signoff in the moment. Mechanical work — reading code, running tests, generating tags. |
| **Drafting** | AI drafts, human signs off. Structured outputs where AI has a strong first draft — code, tests, decompositions. |
| **Interviewing** | AI asks, human answers, AI cleans + structures + augments, human signs off. Knowledge-dependent outputs where the human's expertise is the value. |

Every output must declare its mode in its frontmatter or output envelope.

### The doing / deciding split

> The AI does. The human decides — or signs off.

- **AI does, autonomously:** reading code, drafting summaries, generating subnodes, writing test code from AC, running scans, mapping controls, drafting ADRs, drafting threat models, generating compliance evidence.
- **Human decides** (or signs off): scope, acceptance criteria, trade-offs at architectural branch points, whether an ADR draft is correct, whether a leaf is "ready", whether the threat model is genuine, what to do with critic findings.
- **The middle — AI proposes, human signs off:** story-point estimates, decomposition shape, stop conditions, test coverage adequacy.

Every output is tagged `decision_required: true | false`. The audit trail records every human sign-off — that's the evidence trail.

### Citation discipline

Any claim about existing code requires a `file:line` citation. Any reference to an ADR requires the ADR ID. Unsourced claims are rejected by the orchestrator.

If you do not know something for certain, **say so** — do not guess and do not paper over uncertainty.

### Adversarial Critic

The Critic role is adversarial by default, not consensus. Its job is to refute. When in doubt, default to "refuted" rather than "accepted."

### No silent fixes

Do not silently fix architectural issues. Surface them to the human instead — a missing decision goes to `/decide` or `/adr`, a domain gap to `/storm`, an ambiguous scope back to the Analyst.

---

## The stack — [your project]

> **Fill in this section with the technology stack and accepted decisions for your project.** Each row should reference an accepted ADR in `docs/adr/`.

Every accepted ADR in `/docs/adr/` is binding. Quick reference table:

| ADR | Decision |
|---|---|
| ADR-001 | [Backend language, e.g., Go / Python / TypeScript] |
| ADR-002 | [Database choice] |
| ADR-003 | [Migration tooling] |
| ADR-004 | [Query layer / ORM] |
| ADR-005 | [Domain modelling approach] |
| ... | [add more as decisions are accepted] |

---

## Conventions

> **Fill in your project's conventions.** What follows is a starter set you can keep, drop, or extend.

### Code

- [Architectural layer rules — e.g., "Domain layer has zero imports from infrastructure."]
- [Module boundary rules]
- [Value object conventions for domain primitives]
- [External dependency abstraction — interfaces in the domain layer]

### Testing

- [Test discipline mandates — race detector, coverage thresholds]
- [Test pyramid expectations]
- [Property-based testing for value objects]
- [Named test categories — tenant isolation, audit emission, etc.]

### Test-first — the test is the spec

- Test Author writes the failing test from AC — **does not see implementation**
- Verifier confirms the test fails for the right reason before the story is marked ready
- Critic adversarially reviews the test (and, on demand via `/review`, code or designs)
- The story ships with the failing test as its spec; a developer implements it downstream in their own coding tool
- This discipline is enforced by separate agent contexts, not by team process

### Data handling

> **If your project has compliance / data-handling requirements**, fill them in here. Examples:

- [Field-level data classification scheme]
- [What may and may not appear in logs]
- [Production data on dev machines policy]

### Compliance

> **If your project has a compliance posture**, declare the primary frameworks.

- [Primary frameworks — e.g., SOC 2, ISO 27001, FedRAMP]
- [Tagging conventions for tests evidencing controls]
- [Mandatory practices — e.g., threat modelling at every epic kickoff]

---

## Refinement-specific rules

### Definition of Ready (the gate)

A leaf story exits refinement only when the gate passes. The gate has two layers — **eight core criteria** every story meets, plus a **conditional layer** keyed on the story's declared `facets` (the shapes that determine what substance it owes).

**Core — every story:**

1. Story in agreed format (As a [user], I want [action], so that [benefit] — or your equivalent)
2. Acceptance criteria are testable, single-statement ("given X, when Y, then Z"), each carrying a **provenance** tag (domain event / ADR / threat / `implementation-detail`)
3. Estimated at **≤3 points** (Fibonacci scale; or your team's equivalent ceiling)
4. Dependencies **typed and verified** (`depends on {story} for {contract}`, or "no dependencies")
5. Architectural impact resolved (ADR, or a "no architectural impact" tag the Verifier confirms against `docs/module-map.md`)
6. Stop conditions listed (standard block + task-specific)
7. Scope crosses ≤1 architectural boundary
8. A failing test exists and **fails for the specified reason** (the expected-vs-actual delta matches the AC); every AC maps to an assertion and back

**Conditional — by facet:** `request-path` adds a non-functional budget + over-limit behaviour + telemetry; `data-change` adds migration/rollback/backfill + telemetry; `shared-resource` adds contention/limit budgets; `external-integration` adds timeout/retry behaviour + telemetry; `ui` adds state enumeration + an accessibility bar as signed criteria. Each facet also brings an edge-case checklist — every item becomes an AC or a dismissed-with-reason. Non-functional budgets are declared as *deviations* from the `nfr` baselines in [`method.config.yaml`](method.config.yaml).

**Epic exit** additionally requires a valid dependency DAG, every domain-map hotspot closed, and a reconciled compliance manifest.

### ADR promotion rule

A decision becomes a canonical ADR if **both** conditions hold:

1. It would **surprise a future contributor**
2. Alternatives were **genuinely considered**

If only one holds, record as an informal decision in the chat log. Do not produce a canonical ADR.

### Standard stop conditions

Every leaf story carries these as part of its spec. They're the contract for whoever implements it: hitting one signals a refinement gap — come back to the Method (`/decide`, `/adr`, `/storm`, re-scope), don't improvise:

- Task requires a decision not covered by linked ADRs
- Completing this would require modifying `AGENTS.md`, an ADR, or a skill
- Three or more attempts at the same problem without progress
- AC ambiguous or contradictory
- Declared dependency is complete but its output does not match the contract the gate recorded
- A *new* security or performance concern refinement could not have foreseen (knowable budgets are gate criteria now)
- Would expand declared scope
- No test data generator exists for this concept
- AC cannot be expressed as a single testable assertion
- Required test level (unit / integration / e2e) is unclear

---

## Operational state vs audit trail

Structured settings — including which tracker the project uses — live in [`method.config.yaml`](method.config.yaml) at the project root. This file is the constitution (prose, conventions, principles); the config file is the parameters (tracker, story sizing, compliance frameworks, etc.).

| Layer | Where | Contents |
|---|---|---|
| **Operational state** | **tracker** (per `method.config.yaml`, or git `tree.yaml` if `tracker.type: none`) | Epics, stories, AC, test notes, point estimates, dependencies, assignments, status |
| **Audit trail** | **Git** (`plans/{epic}/`) | tree.yaml, conversation.md, design.md, threat-model.md, manifest.yaml, tests/ |
| **Durable decisions** | **Git** (`/docs/adr/`) | ADR markdown files |
| **Memory** | **gbrain via MCP** | session / project / org rings (scoped per-project; never global) |

**Bidirectional traceability:** every tracker story carries a link to its git plan artifact in its description. Every tree.yaml leaf records its corresponding tracker story ID. When `tracker.type: none`, the tree.yaml is the canonical record on both sides.

**Vocabulary:** different trackers use different terms (Linear: "story"; Jira: "issue"; GitHub Issues: "issue"). The Method uses **story** as the generic term throughout the skill prompts and agent output. When an agent talks to your specific tracker via MCP, it uses that tracker's native terms.

---

## Structured references loaded at session start

In addition to `AGENTS.md` and accepted ADRs, every agent reads the project's **structured reference layer** at session start — small, slow-changing files that ground decisions in the current reality of the system. If a file doesn't exist, the agent skips it; no agent should fail because a project hasn't generated one yet.

The standard structured reference paths:

| File | Contents | Used by |
|---|---|---|
| `docs/domain-glossary.md` | Ubiquitous language — the project's domain terms, one agreed definition each (owned by the Explorer) | **All roles** |
| `docs/schema.sql` | Database DDL (output of `atlas schema inspect` or equivalent) | Designer, Architect, Test Author |
| `docs/openapi.yaml` *(or `docs/openapi.json`)* | API contracts | Designer, Architect, Critic |
| `docs/module-map.md` | Module dependency graph | Architect, Decomposer, Critic |
| `docs/domain-types.md` | Value object / domain primitive registry | Designer, Test Author, Critic |
| `docs/adr/INDEX.md` | ADR titles + 1-line summaries (full text loaded on demand) | All roles |

The **domain glossary** sits at the top deliberately: the ubiquitous language is the backbone of the model, so every agent reads it first and uses its terms exactly. The Explorer maintains it; when any agent notices a term drifting from the glossary, it flags the drift rather than letting it propagate.

These are the **structured reference layer** — distinct from:

- **Always loaded** (the baseline): `AGENTS.md`, the triggered agent's definition, the triggered skill
- **On-demand** (read at point of need): application code via Cartographer (with `file:line` citations), full ADR text when referenced, gbrain past-plan queries

The structured reference layer is project-specific. The method's job is to read it when present and reflect it back into every decision. The project's job is to keep these files fresh — ideally via CI hooks (e.g., regenerate `docs/schema.sql` after every Atlas migration).

## What to do at session start

Every agent:

1. Reads this file (`AGENTS.md`) for the project's constitution.
2. Reads `method.config.yaml` at the project root for structured settings (tracker, story sizing, compliance frameworks, etc.). If the file is missing, treats all values as defaults.
3. Reads `docs/adr/` index to ground itself in accepted decisions for this project. Full ADR text loaded when referenced.
4. Reads the structured reference layer (above) for any files that exist in this project.
5. Queries gbrain for relevant past plans, ADRs, and patterns for the current context.
6. Checks its trigger profile (`.method/triggers.md`) to know when to surface promotions.
7. Starts in the appropriate mode for its role and the current task.

---

## What not to do

- Do not silently fix architectural issues. Surface them for a human decision (`/decide`, `/adr`, `/storm`).
- Do not let a story exit refinement without a failing test. The test is the spec.
- Do not write the project's production code — the Method produces specs; implementation is the developer's job in their own tool.
- Do not make unsourced claims about existing code. Cite or do not claim.
- Do not approve your own work as Critic. Be adversarial.
- Do not produce checkbox compliance evidence. Engagement is the evidence.
- [Add your project's additional "do not" rules here.]
