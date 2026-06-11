# Promotion Rules

When conversations produce canonical artifacts. Skills do not gate-keep artifacts — these rules do. The same artifact can be produced by any skill that hits the conditions.

Every promotion is announced to the human. Never silent.

---

## ADR promotion rule

A decision becomes a canonical ADR if **both**:

1. It would **surprise a future contributor** — i.e., a new engineer reading the code in six months would ask "why was this done this way?"
2. Alternatives were **genuinely considered** — i.e., at least two real options were on the table, with trade-offs evaluated.

### Examples

| Conversation | Promotes to ADR? |
|---|---|
| "We picked PostgreSQL because of course we picked PostgreSQL" | **No** — no alternative considered |
| "PostgreSQL vs CockroachDB — we picked PostgreSQL because operational overhead doesn't justify distributed SQL at our scale" | **Yes** — both conditions hold |
| "Let's name this variable `userId` instead of `user_id`" | **No** — wouldn't surprise anyone |
| "Schema-per-tenant over row-level tenancy because the structural isolation guarantee matters more than operational simplicity at our compliance bar" | **Yes** — clear durable decision with real alternative |
| "We're going to use a transaction here" | **No** — standard practice |
| "Hash-chained audit log over external witness service because we want tamper detection without dependency on an outside system" | **Yes** — both conditions hold |

### What the Architect does when the rule fires

1. Announce to the human: *"This is shaping up as a durable decision with real alternatives considered — I'd promote it to an ADR. OK?"*
2. On human approval, draft the ADR using the project's ADR template (see `docs/adr/README.md`)
3. Save to `docs/adr/ADR-XXX-{slug}.md` (next sequential number)
4. Store in gbrain (project ring)
5. Cross-reference any related ADRs by ID

### What the Architect does when the rule does not fire

If the conversation reaches a decision but the rule does not fire:

1. Tell the human: *"This isn't really an ADR — {reason}. Recording as an informal decision in the session log."*
2. Append to `plans/{epic}/decisions.md` if inside a `/plan` session, or to a standalone session note if outside

---

## Threat model promotion rule

A threat modelling exercise produces a canonical threat model if:

- It was an **interview**, not a generated STRIDE template
- The engineer **engaged verbally** with at least the questions: "what are the assets here?", "who would attack this?", "what's the worst-case data exposure?"
- The transcript captures the engineer's verbatim responses (not paraphrased)

If those conditions hold, the threat model is stored at `plans/{epic}/threat-model.md` and referenced in the compliance manifest.

If the engineer skipped the interview ("just generate it") — the system **refuses to produce a canonical threat model**. It produces a draft labelled "not human-engaged" that does not count as compliance evidence.

This is the anti-theatre check.

---

## tracker story promotion rule

A node in the refinement tree gets promoted to a tracker story when:

- The node is a leaf (will not be further decomposed)
- It passes all eight DoR criteria
- The Verifier (DoR mode) has confirmed readiness
- The human has approved promotion (or has a standing approval for the current `/plan` session)

On promotion:
1. Create child story in tracker under the epic
2. Populate description with:
   - The story statement
   - Acceptance criteria
   - Test notes (referencing the test file in `plans/{epic}/tests/`)
   - Linked ADRs by ID
   - Stop conditions
   - Link back to the git plan artifact
3. Set estimate (point value)
4. Set "blocked by" relationships for dependencies
5. Record the tracker story ID in the tree.yaml node

---

## Privacy impact promotion rule

A privacy impact assessment becomes a canonical artifact entry in the manifest when:

- A node touches data classified Confidential or Restricted (per ADR-018)
- The Analyst (privacy mode) has assessed: classification, retention, subject rights, third-party exposure
- The human has reviewed and signed off

Stored in `plans/{epic}/manifest.yaml` under `privacy_impacts`. Includes:
- Story ID
- Data classifications touched
- Reviewer
- Timestamp

---

## Compliance tag promotion rule

A test becomes a tagged compliance evidence artifact when:

- It evidences a specific control (e.g., tenant isolation evidences SOC 2 CC6.1)
- The tag is recorded in the test file's leading comment block in the form `Evidences: SOC2:CC6.1, ISO27001:A.5.15`
- The compliance manifest aggregates tags across all tests for an epic

The current tag vocabulary:
- **SOC 2 Trust Services Criteria** (CC, A, PI, P, C series)
- **ISO 27001 Annex A** controls (A.5 through A.8 series in 2022 version)
- **NIST 800-53 Rev 5** — optional, added when a FedRAMP engagement is triggered (per ADR-016)

---

## Off-course promotion rule

When `/build` hits a stop condition, `/off-course` diagnoses the kind of upstream change needed and produces a governed PR against the right artifact. The diagnosis follows this routing:

| Kind of upstream change | Diagnostic signal | Refinement role | Target artifact |
|---|---|---|---|
| **ADR gap** | Required decision is not in linked ADRs | Architect (interview) | New `docs/adr/ADR-XXX.md` |
| **ADR contradiction** | AC and an existing ADR conflict | Architect (interview) | New superseding ADR + AC update |
| **AC ambiguity** | The failing test does not make clear what to build | Analyst + Test Author | Updated AC in tracker + revised test file |
| **Threat model gap** | Builder discovers a threat not in the threat model | Threat Modeller | Supplementary threat model entry + manifest update |
| **Missing existing-code context** | Builder needs to understand legacy or adjacent behaviour | Cartographer | Findings doc; no governed artifact (informational) |
| **Scope expansion** | Story cannot be completed without scope expansion | Analyst + Decomposer | Updated scope + new split story |
| **Missing test data generator** | Test needs a fixture type that doesn't exist | Test Author | Generator code + updated test |
| **Architectural boundary crossed** | Implementation would touch multiple boundaries | Decomposer | Split into new stories |

Every off-course event is recorded in the original epic's manifest as an audit-trail entry — showing the team surfaced and routed the upstream issue rather than papering over it.

The original tracker story is set to `Blocked` until the governed PR merges, then moves back to `Ready` for Builder to resume.

---

## What promotions are NOT

- Promotions are **not** silent. Every promotion is announced and confirmed.
- Promotions are **not** irreversible. A draft ADR can be rejected; an informal decision can be later promoted if the situation changes.
- Promotions are **not** the only output. Skills produce many artifacts (chat logs, intermediate decisions, exploration notes). Only some get promoted to canonical status.

---

## What to do when a rule is ambiguous

If the Architect or Coordinator cannot decide whether a rule fires — surface it to the human:

> "I'm uncertain whether this should be an ADR. {Reason for uncertainty}. What do you think — record as ADR, informal decision, or move on?"

Uncertainty is information. Asking is not failure.
