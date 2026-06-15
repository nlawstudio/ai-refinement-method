---
description: A standing snapshot and trend of the project's cross-cutting quality — user experience, test adequacy, compliance, and NFRs. Rebuilds the human's mental model of where these non-local concerns stand, and writes a dated record so drift is visible over time. The lightweight, recurring half of the stewardship layer. Use periodically, or whenever you've lost track of where quality has gone.
---

# /posture

A quick, standing read of where the project's cross-cutting quality stands — **user experience, test adequacy, compliance, and NFRs** — and how it has moved since last time. The point is to rebuild your mental model of the whole when AI has handled enough of the build that you've lost the thread.

This is the light, recurring half of the stewardship layer. For a deep dig into where a concern has actually broken, use `/audit`.

## Usage

```
/posture            # snapshot all concerns + trend since the last record
/posture compliance # one concern
```

## The flow

1. **Read the standing record.** Load the previous snapshot from `docs/quality-posture.md` (if it exists) to diff against.
2. **Take the snapshot (Cartographer-led, light).** For each concern, read the cheap, durable signals — the compliance manifests, the test counts and tags, the NFR budgets declared vs. the `method.config.yaml` baselines, the open hotspots, the ADR index — and summarise where each stands. This is a pulse, not the deep survey `/audit` runs.
3. **Diff against the last record.** What improved, what slipped, what's new. Drift is the headline, not the absolute numbers.
4. **Write the record.** Overwrite `docs/quality-posture.md` with the new dated snapshot. Because it's one file in git, its history *is* the trend — `git log -p docs/quality-posture.md` shows every move.

## Output

Rendered in chat, and written to `docs/quality-posture.md`:

```markdown
# Quality posture — {date}

| Concern | Standing | Since last |
|---|---|---|
| User experience | {one line} | ↑ / → / ↓ {what moved} |
| Test adequacy | {one line} | ... |
| Compliance | {one line} | ... |
| NFRs | {one line} | ... |

## What slipped
{the drift worth a human's attention — each with where to look}

## Worth a deeper look
{concerns where the snapshot is ambiguous — candidates for /audit}
```

## Quality bar

- **Honest signals, cheaply read.** `/posture` reports what the durable artifacts already say; it does not re-derive the project. If a signal is missing (no manifest, no module map), it reports the *absence* as the finding rather than guessing.
- **Trend over level.** "Compliance: 3 manifests, 1 not-performed" is data; "compliance slipped — a new epic shipped with an un-engaged threat model" is the point.
- **Points forward.** Anything ambiguous or worrying is flagged as a candidate for `/audit` or for re-refinement — `/posture` orients, it doesn't adjudicate.

## Mode and decision

```
mode: doing
decision_required: false
```

The snapshot informs the human. Writing the record is mechanical; what to do about a slip is the human's call.

## What this is NOT

- Not the deep sweep (`/audit`) — that adversarially digs for where a concern broke; `/posture` is the quick "where do we stand."
- Not a gate — it doesn't block anything. It rebuilds your view so you can decide where to look.
- Not a fixer — drift it surfaces runs back through refinement.
