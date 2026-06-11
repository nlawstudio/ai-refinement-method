---
description: Standalone STRIDE-style threat modelling interview via the Threat Modeller. Same agent as runs at epic kickoff in /plan, but invoked here for ad hoc threat modelling outside a refinement session. Produces a structured threat model with verbatim engineer transcript — engagement is the compliance evidence.
---

# /threat-model

Standalone invocation of the Threat Modeller. Use when you want to threat-model something *outside* of an epic refinement session — e.g., a security concern surfaced in code review, a new external integration being scoped, a piece of existing functionality you want to evaluate retroactively.

## Usage

```
/threat-model <what is being threat-modelled>
```

Examples:

```
/threat-model the new Chainalysis integration
/threat-model the document presigned URL flow
/threat-model bulk export endpoint we shipped last sprint
```

## The flow

1. **Invoke Threat Modeller in interview mode.**

2. **Threat Modeller runs the full STRIDE interview** (see `.claude/agents/threat-modeller.md` for the question script):
   - Assets, adversaries
   - Spoofing, Tampering, Repudiation, Information disclosure, Denial of service, Elevation of privilege
   - Compliance lens (SOC 2 / ISO 27001 controls touched)

3. **Verbatim capture of engineer responses.** This is the load-bearing part. The transcript IS the compliance evidence.

4. **AI augmentation.** Threat Modeller adds threats the engineer did not surface, flagged as AI-sourced (not human-sourced).

5. **Anti-theatre check.** If the engineer is not genuinely engaging — answering questions with "skip this," "just generate it," or providing only one-word responses — the Threat Modeller produces a draft labelled `evidence_quality: not-performed` and informs the engineer.

## Output

Write to either:

- `docs/threat-models/{date}-{slug}.md` for standalone threat models
- `plans/{epic}/threat-model.md` if invoked during an active `/plan` session (will not overwrite the epic-kickoff threat model — saved as `threat-model-supplementary-{slug}.md`)

Plus a manifest entry recording the threat model.

## When this is invoked inside `/plan`

Usually, the epic-kickoff threat model is sufficient and you would not invoke `/threat-model` again during a single epic. But you might, when:

- A specific story surfaces a new attack surface that wasn't visible at epic kickoff
- A scope change introduces a new adversary or asset
- The engineer realises mid-refinement that the kickoff threat model missed something material

In those cases, the supplementary threat model is **additive** — it does not replace the kickoff one.

## Quality bar (same as the Threat Modeller agent)

- Verbatim engineer responses captured
- AI additions flagged as AI-sourced
- Project-specific threats surfaced (e.g., for multi-tenant B2B SaaS: cross-tenant, insider, repudiation, audit chain integrity)
- The mitigation for each threat is concrete or marked as open
- Evidence quality is recorded honestly — `human-engaged`, `draft-only`, or `not-performed`

## Mode and decision

Output carries:
```
mode: interviewing
decision_required: true
```

The human signs off on the threat model after the interview, confirming the verbatim transcript is accurate.

## The anti-theatre rule, re-stated

A generated STRIDE template that the engineer did not engage with is **not compliance evidence**. The Threat Modeller will refuse to mark such a model as `human-engaged`. This is the design's safeguard against checkbox compliance.
