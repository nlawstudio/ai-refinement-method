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

A threat modelling exercise produces a canonical threat model when the engineer made the **risk decisions** only they can make — not merely that they were present. Coverage is scaffolding the AI generates (STRIDE across the trust boundaries from the data-flow); the *evidence* is the engineer's recorded decisions on top of it:

- **Boundaries enumerated** from the data-flow, STRIDE applied to each, non-applicable cells marked "N/A — because…". The AI may draft this coverage.
- **The engineer made the calls** only they can: for each surfaced threat, a severity/likelihood rating and a real / not-real judgement; for each real threat, a mitigation linked to a test or ADR; and explicit **residual-risk acceptance, each with a named owner**.
- The cleaned model was **signed off** by the engineer (the signed artifact is the evidence; the raw chat is preserved alongside).

`evidence_quality: human-engaged` means those decisions were made and recorded — not that a transcript exists. If the engineer assents to AI-generated content without making the calls ("just generate it", "looks fine"), the system **refuses to produce a canonical threat model** and labels the draft `not-performed`; it does not count as compliance evidence.

This is the anti-theatre check: the bar is decisions, not participation.

---

## Domain map and glossary promotion rule

A `/storm` session produces a canonical domain map when:

- The Explorer facilitated an event-storming conversation (events, commands, policies, read models, hotspots), not a generated map
- The human engaged and signed off on the map and its proposed bounded contexts
- Hotspots are named, not smoothed over, each tagged with what it needs next (ADR / threat model / scoping decision / spike)

Stored at `plans/{epic}/domain-map.md`. Every new domain term agreed during the session is added to `docs/domain-glossary.md` (the ubiquitous language), which is read by every agent thereafter. The glossary is append-and-revise, never silently overwritten — a changed definition is a decision the human signs off on.

---

## tracker story promotion rule

A node in the refinement tree gets promoted to a tracker story when:

- The node is a leaf (will not be further decomposed)
- It passes the DoR gate — the eight core criteria plus any its declared facets trigger
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

- A node touches data classified Confidential or Restricted (per the project's data-handling ADR)
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
- **NIST 800-53 Rev 5** — optional, added when a FedRAMP engagement is triggered (per the project's compliance-scope ADR)

---

## Quality posture promotion rule

A `/posture` snapshot becomes the canonical record when:

- The human has reviewed the snapshot (it reads the durable artifacts rather than making a new judgement, but the human confirms it reflects reality)
- It is written to `docs/quality-posture.md`, overwriting the prior snapshot

Because the record is a single file in git, its history is the trend — no separate versioning. An `/audit` produces **findings, not a canonical artifact**: its job is to surface drift for the human to route back into refinement (an epic, an ADR, a test), where the normal promotion rules then apply.

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
