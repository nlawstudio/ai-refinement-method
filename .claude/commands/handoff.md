---
description: Save and restore session state across Claude sessions. /handoff captures where you are (active work, decisions in flight, open questions, next intended action, file state, mental model). /handoff resume picks up from the most recent handoff. Designed so you can close a session at any point and pick up exactly where you left off — even days later, even in a different agent.
---

# /handoff

A meta-skill that captures the current session's context so it can be resumed later. Two modes:

- `/handoff` (no args) — **capture** state at the end of a session
- `/handoff resume` — **restore** state at the start of a new session

The handoff document is plain markdown, so it works across any agent (Claude Code, Cursor, Codex, anything that can read files). The next session doesn't need to be the same agent — or even know the method exists — to resume.

---

## Capture mode — `/handoff`

### When to use

- At the end of a working session, before closing the chat
- Before switching context to something else
- When you want a checkpoint mid-session (you can run it multiple times — each run produces a new handoff file)
- Before a long break (lunch, end of day, weekend)

### What you do

1. **Draft a summary from session state** (do this first, then show to the human for sign-off — don't interview cold).

   Read:
   - The chat history of the current session for what was discussed and decided
   - `git status` and `git diff --stat` for what files have been touched
   - `git log -5 --oneline` for recent commits
   - Any active `plans/{epic}/` directories — read their `tree.yaml` and `conversation.md` to understand in-flight refinement work
   - `.method/handoffs/LATEST.md` if it exists — to know what state we picked up from at session start, and what's changed since

2. **Draft the handoff document** in the structure below. Fill it in from what you can observe.

3. **Show the draft to the human.** Ask: *"Here's what I captured. Anything to add or correct before I save?"*

4. **Apply their edits.**

5. **Write the file** to `.method/handoffs/{ISO-timestamp}-{slug}.md` where the slug is a short kebab-case description of the work (e.g., `2026-06-08T14-22Z-bulk-export-refinement.md`).

6. **Update the LATEST pointer.** Write a copy to `.method/handoffs/LATEST.md`. This is the file the next session will read.

7. **Tell the human exactly how to resume.** Print something like:

   > Handoff saved at `.method/handoffs/2026-06-08T14-22Z-bulk-export-refinement.md`.
   >
   > To resume in your next session, open Claude Code (or any agent) in this directory and paste:
   >
   > > *Run /handoff resume*
   >
   > Or if the next agent doesn't have this skill installed, paste:
   >
   > > *Read .method/handoffs/LATEST.md and pick up from there.*

### The handoff document structure

```markdown
# Handoff — {ISO timestamp}

**Session summary:** {one sentence — what was this session about}
**Last action:** {the most recent meaningful thing that happened}
**Next action:** {what was about to happen next}

## Where we were

### Active work
{What was being worked on. Be specific — story ID, file paths, plan directory, branch name. Use file:line references where applicable.}

### Recent decisions
{Decisions made this session. Include both promoted (ADR landed) and informal (recorded in decisions.md or chat). One line each.}

### Decisions in flight
{Things that were being discussed but not yet decided. Include the alternatives on the table and where the conversation paused.}

### Open questions
{Questions blocking progress, waiting on input. Be specific about what's needed to answer each one.}

## File state

### Branch
`{current branch name}`

### Uncommitted changes
{Output of `git status --short` — what's modified, what's staged, what's untracked. Use a code block.}

### Recent commits this session
{Output of `git log {session-start-ref}..HEAD --oneline` if known, else last 5 commits. Use a code block.}

### Active plan artifacts
{Any `plans/{epic}/` directories that were touched. Note the state — at what step in the refinement loop, what's left to do.}

## Mental model snapshot

### What I (the user) currently believe
{The user's current understanding of the problem. What they're treating as fact. What assumptions they're operating from. The agent infers this from the chat — don't fabricate.}

### What I (the user) am still unsure about
{Things the user has expressed uncertainty on, or where they've been going back and forth.}

### What the agent thinks the user might be missing
{Optional. Surface concerns or angles that haven't come up but probably should. Flag clearly as AI-surfaced. Skip if nothing comes to mind.}

## Blockers

{Anything that stopped progress this session. External dependencies, undecided decisions, missing context, etc.}

## To resume — instructions for the next session

### First action
{The single most concrete thing the next session should do to pick up. E.g., "Open `plans/bulk-export/tree.yaml`, read the node tagged `needs-decision`, resume the Architect interview." Or "Pull STORY-144 from tracker, run `/build STORY-144` — last attempt hit a stop condition on rate-counter storage, route through `/off-course` if same stop fires again.")}

### Context the next session needs
{Files to read, ADRs to load, gbrain queries to run. Anything that puts the next session at the same starting point.}

### What NOT to redo
{Decisions already made, work already done, context that's stable. Helps the next session avoid relitigating.}

## Files referenced this session

{List of file paths touched or referenced. Helps the next session quickly know which files matter.}
```

### Quality bar

- **Specific over vague.** "Open `plans/bulk-export/tree.yaml`" is useful; "continue the refinement" is not.
- **Cited.** File paths, story IDs, ADR IDs are present where relevant.
- **Honest about uncertainty.** If you don't know what the user was thinking, say so — don't fabricate.
- **The "Next action" is concrete.** A future agent reading this should be able to start in under 60 seconds.

### Failure modes to avoid

- **Generic handoffs.** "We discussed the plan and made progress" is useless. Be specific.
- **Missing the next action.** Without a concrete first move, resumption is harder than starting fresh.
- **Skipping the mental model.** Files and commits are easy to recover; the user's *thinking* isn't, and that's the highest-leverage capture.
- **Fabricating user beliefs.** If you didn't see something in the chat, don't put it in the "what the user believes" section. Mark as inferred or leave out.

---

## Resume mode — `/handoff resume`

### When to use

- At the start of a new session, when picking up previous work
- After a context-loss (closed tab, lost network, switched agents)
- Whenever the user says "where was I?" or "pick up where I left off"

### What you do

1. **Read `.method/handoffs/LATEST.md`.** If it doesn't exist, look at the most recent file in `.method/handoffs/` matching the `YYYY-MM-DDT*Z-*.md` pattern. If there are no handoffs, tell the user: *"No handoff found. This is either your first session, or the handoff file was deleted. Tell me what you want to work on and I'll start fresh."*

2. **Summarise what you read** back to the user. Don't paste the full handoff. Do a 5-line max summary covering:
   - What the previous session was about
   - The last concrete action
   - The single most important open question or blocker
   - The intended next action
   - Roughly how long ago this was (look at the timestamp)

3. **Confirm with the user.** Ask: *"Is this still where you want to pick up, or has something changed?"*

   - If they say it's still right: load the relevant context (open the files mentioned, query gbrain for past plans referenced, etc.) and proceed with the "Next action" from the handoff.
   - If something's changed: ask what's different. Adjust. The previous handoff is still valid as history; you just don't follow its "Next action" literally.

4. **Begin the next action.** Don't ask permission for every step — the handoff has already established the direction. Just do the first concrete thing it described, and check in if you hit a question.

5. **Optional but recommended: capture a fresh handoff at the end of THIS session too.** Running `/handoff` repeatedly across sessions builds an audit trail of the work over time.

### Quality bar for resumption

- **Don't repeat the previous handoff back verbatim.** The user already knows what was happening; you're confirming you're synced, not lecturing.
- **Don't relitigate decisions.** If the handoff says "we decided X," don't ask "should we use X?" Trust the previous state until told otherwise.
- **Don't skip the confirmation.** Always check that the world hasn't changed since the handoff — codebases evolve, decisions get amended, priorities shift.

---

## Storage layout

```
.method/
  handoffs/
    LATEST.md                                    ← pointer to the most recent handoff
    2026-06-08T14-22Z-bulk-export-refinement.md ← per-timestamp handoffs accumulate here
    2026-06-08T09-15Z-uuid-decision.md
    2026-06-07T17-44Z-end-of-day.md
    ...
```

Handoffs accumulate. They're cheap to produce and an audit trail of work over time. The `LATEST.md` pointer always reflects the most recent one.

### Should handoffs be committed to git?

**No, by default.** Handoffs are individual session-continuity snapshots — they describe one person's mid-session mental model and intended next action. They accumulate quickly, they're noisy in code review, and they often contain in-flight thinking that isn't useful to anyone else.

`install.sh` appends `.method/handoffs/` to the target project's `.gitignore` automatically. The handoff files exist on disk locally for you to read and resume from, but they don't get committed.

If a team has a reason to commit them (e.g., genuinely useful as audit trail, or async-collaboration pattern), remove the `.method/handoffs/` line from `.gitignore`. The skill works either way.

---

## Mode tagging

Capture mode operates in **drafting** mode — the AI drafts, the human signs off.

```
mode: drafting
decision_required: true
```

Resume mode operates in **doing** mode — the AI reads, summarises, confirms, proceeds.

```
mode: doing
decision_required: false  (the user is already directing by invoking resume)
```

---

## Why this skill exists

Long conversations have a context-window cost. Closing a session forfeits any context not committed to the codebase or memory. Without a structured handoff, resumption means either re-reading the chat (expensive) or starting fresh and missing nuances.

The handoff captures the cheap-to-write, expensive-to-lose state — the user's working mental model, the decisions-in-flight, the next intended action. Everything else (files, commits, plans, ADRs) is already on disk.

The skill is also cross-agent. A handoff written in a Claude Code session can be read by Cursor or Codex (or vice versa) — the file is plain markdown with no agent-specific metadata.
