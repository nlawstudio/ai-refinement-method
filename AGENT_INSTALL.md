# AGENT_INSTALL.md

> **You are an AI agent helping a human install the agentic refinement method into their project.**
>
> This document is the prompt you follow. Read it end-to-end before starting. Then walk the human through the install as a structured interview — one step at a time, confirming each step, never skipping or batching.
>
> The install process is itself an interview. Apply the same principles the method uses for everything else:
>
> - **Doing** (autonomous mechanical work) — run commands, copy files, check things
> - **Drafting** (AI drafts, human signs off) — fill in templates with structured content
> - **Interviewing** (ask, listen, clean, sign off) — get the human's project context into the constitution
>
> Engage the human as you go. Don't dump output; have a conversation. Their input is the value — your job is to structure it cleanly.

---

## Who you are and what you're doing

You are an AI coding agent (Claude Code, Cursor, Codex, or similar) in a human's project repository. The human has asked you to install the agentic refinement method — a multi-agent system that turns intent into refined work and shipped code.

By the end of this install, the human will have:

1. The method framework files in their repo (`.claude/`, `.method/`, etc.)
2. A filled-in `AGENTS.md` constitution specific to their project
3. A `docs/adr/` directory with their accepted architecture decisions (existing ones moved in, or first ones interviewed during install)
4. gbrain and Linear MCPs wired up if available
5. A verified working install

You will get them there by interviewing them and doing the mechanical work as you go.

---

## Step 1 — Confirm the context (interview)

Before running anything, get the project context. Ask the human these questions, one at a time, capturing their answers cleanly:

1. **What does this project do?** One sentence describing what they're building.
2. **What stack are they using?** Language, primary database, frameworks, deployment target. If they don't know yet, that's fine — note it.
3. **New or existing project?** If existing, are there accepted architecture decisions documented somewhere already?
4. **What compliance posture, if any?** SOC 2, ISO 27001, HIPAA, FedRAMP, none? Even informal.
5. **Which operational tracker do they use?** Options: `linear` / `jira` / `github-issues` / `none`. "None" is valid — the git tree.yaml becomes the operational state. Capture the exact value.

   **Follow-up identifying questions based on their answer** — capture these too, you'll write them into `method.config.yaml` in Step 3:

   - **Linear:** What's their Linear team ID? (If they don't know, note it as TBD — they can find it after the MCP wires up in Step 6b.)
   - **Jira:** What's their Jira site URL (e.g., `company.atlassian.net`)? What's the project key (e.g., `PROJ`)? Do they use a custom field for story points (it's usually `customfield_10016` or similar — they can find it later if not sure).
   - **GitHub Issues:** Which repo? (Defaults to current repo's `owner/name` from `git remote -v`.)
   - **None:** No follow-up.

6. **Are they using gbrain (memory) already?** Yes / no / not sure.
7. **What's their team size?** Solo, small team, larger.
8. **Story point scale + ceiling?** Fibonacci with ceiling 3 is the recommended default. T-shirt sizes (`xs/s/m/l`) is also supported. Capture if they want anything non-default.
9. **Story format preference?** `user-story` (As a..., I want..., so that...) is the default. `technical` or `freeform` are alternatives.
10. **Compliance frameworks?** SOC 2, ISO 27001, HIPAA, FedRAMP, or none. Used for test tagging. Empty list is fine.

Capture all answers in your working memory. You'll use them in Step 3 to fill in `AGENTS.md` (prose constitution) and `method.config.yaml` (structured settings). Don't write anything to disk yet.

After all answers, summarise back to them in your own structured words:

> "Just to confirm — you're building {one-sentence}. Stack is {stack}. {Existing or new} project. {Compliance posture}. Tracker: {linear/jira/github-issues/none} + {tracker identifiers}. Point scale: {scale}, ceiling {N}. Story format: {format}. {gbrain / not yet}. Team size: {size}. Right?"

Wait for their confirmation. Adjust if anything's wrong.

---

## Step 2 — Run the install (doing)

Now do the mechanical work. You have two options:

### Option A — run install.sh (preferred if you have shell access)

```sh
curl -sSL https://raw.githubusercontent.com/nlawstudio/ai-refinement-method/main/install.sh | sh
```

This clones the method repo, copies the framework files into the current directory, and creates `AGENTS.md` from the template if one doesn't exist. It also creates a starter `docs/adr/README.md` if `docs/adr/` is empty.

### Option B — manual copy (if you can't run scripts)

Clone the method, then copy the framework files manually:

```sh
git clone --depth 1 https://github.com/nlawstudio/ai-refinement-method.git /tmp/method
cp -R /tmp/method/.claude .
cp -R /tmp/method/.method .
mkdir -p plans
cp -R /tmp/method/plans/_templates plans/
cp /tmp/method/METHOD.md .
cp /tmp/method/TUTORIAL.md .
cp /tmp/method/INSTALL.md .
cp /tmp/method/AGENT_INSTALL.md .

# Only if AGENTS.md doesn't exist
[ -f AGENTS.md ] || cp /tmp/method/AGENTS.template.md AGENTS.md

# Only if docs/adr/ doesn't exist
[ -d docs/adr ] || (mkdir -p docs/adr && cp /tmp/method/AGENTS.template.md docs/adr/README.md)
```

### Verify the install

Confirm the install worked:

```sh
ls .claude/agents/    # should list 10 role .md files
ls .claude/commands/  # should list ~10 skill .md files
ls .method/          # triggers.md and promotion-rules.md
ls plans/_templates/  # tree.yaml.example, manifest.yaml.example
cat VERSION           # may or may not exist depending on install path
```

Tell the human what was copied. Be specific:

> "Installed method v{version} into this directory. 10 role agents in `.claude/agents/`, 10 skills in `.claude/commands/`, trigger profiles and promotion rules in `.method/`, templates in `plans/_templates/`. Framework documentation: `METHOD.md`, `TUTORIAL.md`, `INSTALL.md`. Constitution: `AGENTS.md` (created from template — we'll customise it next). ADR directory: `docs/adr/` (empty, ready for your decisions)."

---

## Step 3 — Customise AGENTS.md (drafting + interviewing)

Two files get customised in this step:

- **`AGENTS.md`** — the project's prose constitution (principles + conventions). Walk through bracketed placeholders.
- **`method.config.yaml`** — the project's structured settings (tracker, story sizing, compliance, etc.). Fill in from Step 1 answers.

Do both in order: AGENTS.md first (sections 3a-3f), then `method.config.yaml` (section 3g).

**Do not edit blindly.** For each section, present the placeholder, ask the human for their input, draft the cleaned content, and confirm before writing.

### The sections to fill, in order:

#### 3a. Project name (preamble)

Replace `[Your project name]` with the project name. Confirm casing and any subtitle.

#### 3b. The stack table

Open the `## The stack — [your project]` section. The template has placeholder rows like:

```markdown
| ADR | Decision |
|---|---|
| ADR-001 | [Backend language, e.g., Go / Python / TypeScript] |
| ADR-002 | [Database choice] |
...
```

Based on the human's Step 1 answers, draft the actual rows. For each one:

- **If the human has an accepted ADR for this decision already:** use the actual ADR ID and summary from `docs/adr/` (or ask them to point you at the source so you can move it in)
- **If the human hasn't decided yet:** mark the row as `[TBD — to be decided via /adr]` and remove the ADR-NNN reference

The goal is that every row in this table either:
- Points to an existing ADR with the actual decision summarised, OR
- Is flagged as TBD so it gets decided through `/adr` during normal use

Don't invent decisions the human hasn't made.

#### 3c. Conventions sections

The template has four conventions blocks: Code, Testing, Data handling, Compliance. Each has bracketed starter text.

For each block:

1. Show the human the starter text and ask: "Does this match how your team works? What would you change?"
2. Capture their answer
3. Draft the conventions in their voice but cleanly structured
4. Show them the draft
5. Adjust based on their feedback
6. Write it in

If they say "I don't know yet" for any block, leave the template defaults and note that this section needs revisiting after they've done a few cycles of work with the method.

#### 3d. Compliance frameworks

Based on the compliance posture from Step 1, fill in:

- Primary frameworks (SOC 2, ISO 27001, etc.)
- Tagging conventions for tests
- Any mandatory practices

If they have no compliance posture, leave that section as "No formal compliance framework currently active. Tagging tests with controls is optional."

#### 3e. Remove the template banner

The top of `AGENTS.md` has a banner that says "This is a template" and "Remove this note when done." Remove it.

#### 3f. AGENTS.md final review

Show them the full `AGENTS.md` you've produced. Ask: "Anything to change before we move on?" Wait for sign-off.

#### 3g. Fill in `method.config.yaml`

Open `method.config.yaml` (the install script created it from the template with defaults). Walk the human through each section using their Step 1 answers:

**Tracker block.** Set `tracker.type` to their tracker (`linear` / `jira` / `github-issues` / `none`). Set `tracker.mcp_server` to the name they'll register the MCP under in Step 6b (typically the same as the type, e.g., `linear`). Fill in the tracker-specific sub-block based on their identifying answers:

- For Linear: `linear.team_id`
- For Jira: `jira.site`, `jira.project_key`, optionally `jira.points_custom_field`
- For GitHub Issues: `github_issues.owner`, `github_issues.repo`
- For none: nothing further

If any tracker identifier was "TBD" in Step 1, leave it as `null` for now and note as a follow-up. The MCP wiring in Step 6b will let them retrieve missing IDs.

**Story sizing.** Set `story_points.scale` and `story_points.ceiling` per Step 1 answers (default: `fibonacci` and `3`).

**Story format.** Set `story_format` per Step 1 answer (default: `user-story`).

**Compliance.** Set `compliance.frameworks` to the list from Step 1 (or `[]` if none).

**Testing.** Use defaults (`race_detector_required: true`, `property_tests_for_value_objects: true`) unless they specifically want different.

#### 3h. method.config.yaml final review

Show them the full `method.config.yaml`. Ask: "Anything to change?" Wait for sign-off.

---

## Step 4 — Set up docs/adr/ (interviewing or doing, depending on starting state)

### 4a. If they already have accepted ADRs somewhere

Help them move existing ADRs in:

1. Ask: "Where are your current ADRs?" (Could be another repo, a wiki, a Notion doc.)
2. Help them get the content into `docs/adr/ADR-XXX-{slug}.md` files.
3. If their existing ADRs don't follow the Method's recommended template format (Status, Context, Options Considered, Decision, Rationale, Consequences, Compliance Mapping, Date), offer to reformat them — but **only if the human says yes**. Existing decisions are sacred; reformatting requires their explicit approval.
4. Update the stack table in `AGENTS.md` to reference the moved ADRs by their final IDs.

### 4b. If they have no ADRs yet

Offer to run a mini-interview to surface their first few:

> "Want me to run quick interviews on the top 3-5 architectural decisions you've made? We'll produce real ADRs that go into `docs/adr/`. Each one takes ~5 minutes and the method will reference them going forward."

If they say yes, for each decision they raise:

1. Run an Architect-style interview (use the actual `/adr` skill if you have access to it, or follow the structure from `.claude/agents/architect.md`)
2. Track the ADR promotion rule:
   - Would this surprise a future contributor? AND
   - Were alternatives genuinely considered?
3. If both hold, draft an ADR and have them approve. Land in `docs/adr/ADR-XXX-{slug}.md`.
4. If only one holds, record as an informal decision and move on.

If they say no — that's fine. They can use `/adr` later as decisions come up.

Either way, by the end of Step 4 either:
- The stack table in `AGENTS.md` has actual ADR references, or
- The stack table has `[TBD]` entries that will get filled in via `/adr` during normal use

---

## Step 5 — Structured reference layer (doing, with check-ins)

The method reads project-specific structured references at session start when present. These constrain every decision without loading raw code. Walk the human through setting up the relevant ones for their project.

The standard files:

| File | What | When the project benefits |
|---|---|---|
| `docs/schema.sql` | Database DDL | Any project with a database. Highest leverage of any structured ref. |
| `docs/openapi.yaml` | API contracts | Any project with HTTP / RPC APIs |
| `docs/module-map.md` | Module dependency graph | Any project with internal architecture worth respecting |
| `docs/domain-types.md` | Value object / domain primitive registry | Any project using value objects |
| `docs/adr/INDEX.md` | ADR titles + 1-line summaries (full text loaded on demand) | Any project with accepted ADRs (auto-regenerated by `/adr` skill) |

### 5a. Schema export

If the human said they use a database in Step 1:

> "The method becomes dramatically more useful when it has the schema at session start. Every Designer, Architect, Builder, and Test Author session sees the actual data shape — no guessing, no greps."
>
> "I'll run `./scripts/sync-schema.sh` now to generate `docs/schema.sql`."

Run it:

```sh
./scripts/sync-schema.sh
```

The script is already installed (the method's install.sh put it there). It prefers Atlas (if `atlas.hcl` is present in the project) and falls back to `pg_dump --schema-only` using `DATABASE_URL`. **Schema only — never data.**

If neither Atlas nor pg_dump is available, the script will exit with clear instructions for setup. Surface that to the human:

> "The sync script couldn't run because {Atlas isn't installed / DATABASE_URL isn't set / etc.}. Options: (a) install Atlas and add an atlas.hcl, (b) set DATABASE_URL to a non-prod database and use pg_dump. Want help with either, or skip for now?"

If they want to wire it into their migration tool's post-apply hook, help them:

- **Atlas:** add a `hook "post-apply"` block in `atlas.hcl` that runs `./scripts/sync-schema.sh` after every migration
- **Other tools:** equivalent — find the post-apply hook for their tool

If they want to wire it into CI, help them write a GitHub Action / GitLab CI step that runs the script on any change to `migrations/` and commits the result if it changed.

If they say "later" — log as a follow-up. The script is installed; they can run it manually as needed.

### 5a-bis. ADR index

Run `./scripts/sync-adr-index.sh` now to (re)generate `docs/adr/INDEX.md`. The script is installed. If they have existing ADRs (set up in Step 4), this populates the index from them. If they don't, it leaves a placeholder noting no ADRs yet.

```sh
./scripts/sync-adr-index.sh
```

Going forward, the `/adr` skill regenerates the index every time it lands an accepted ADR — so the human won't typically need to run this manually.

### 5b. Other structured refs

For each of the other structured refs, ask:

> "Do you have API contracts (OpenAPI spec) somewhere? If so, let's link it as `docs/openapi.yaml`. If not, want me to generate one from your route definitions, or skip for now?"

> "Do you want me to script a module map (`docs/module-map.md`)? Useful for any project with more than ~5 internal modules. We can do this once and add a CI script to keep it fresh."

> "Do you have a value object / domain primitives registry? If you use them, we can codify them in `docs/domain-types.md` from your type definitions."

> "The ADR index (`docs/adr/INDEX.md`) auto-regenerates as ADRs are added — no setup needed."

For any of these the human says "yes" to, do the setup work. For any they say "skip" or "not yet" to, log as a follow-up.

### 5c. CI hooks for freshness

Once the structured refs exist, they need to be kept fresh. Offer to write a CI step or git hook that regenerates them automatically:

> "Schema and module map can drift from reality if no one regenerates them. Want me to write a CI step that regenerates them on every PR, and fails the build if the committed versions don't match what they should be? Catches drift mechanically."

## Step 6 — Wire up MCPs (doing, with check-ins)

### 6a. gbrain (memory)

If the human said in Step 1 that they use gbrain (gstack), it should already be available. If they said "not sure":

```sh
# Check whether gbrain MCP is registered
ls ~/.claude/mcp_servers 2>/dev/null || echo "No MCP servers directory"
```

**Default: project-scoped brain.** gbrain should be **scoped to this project**, not shared across every project the developer works on. This isolates client data, IP, and patterns between unrelated projects (e.g., one client's work and another client's work should never bleed into each other's memory).

> "gbrain stores memory across sessions — past plans, accepted ADRs, patterns. We'll set it up **scoped to this project specifically**. That way, if you work on other projects with the Method installed, none of their memory bleeds in here, and vice versa.
>
> gbrain has three rings: session (in-flight conversation state), project (canonical ADRs, past plans on this project), org (cross-project patterns — within this project's brain only).
>
> Which backend do you want?
> - **Local PGLite** — zero infrastructure, fully isolated by default. Best for solo work or single-machine.
> - **Dedicated Supabase for this project** — shared across this project's team if multiple devs work on it. Requires creating a new Supabase project specifically for this work. Don't reuse a Supabase brain from another project.
>
> Which do you want?"

If they pick local PGLite:
1. Run the gstack `/setup-gbrain` skill **inside this project's directory** with the `local` (PGLite) option
2. Verify the `.gbrain-source` pin file lands at the repo root — this is what scopes gbrain queries to this worktree
3. Note: the global `~/.gbrain/config.json` may point at a different brain. gbrain reads the worktree-pinned config when in this directory.

If they pick dedicated Supabase:
1. Help them create a **new** Supabase project specifically for this work (do not point at any existing Supabase brain used for another client/project)
2. Run `/setup-gbrain` inside this project's directory pointing at the new Supabase URL
3. Verify the `.gbrain-source` pin file lands at the repo root
4. Authentication via Supabase auth — use SSO if available
5. Session ring stays local

If they don't have gstack or don't want gbrain right now, log as a follow-up. The Method works without gbrain — it just loses cross-session memory for this project.

### Why project-scoped, not shared globally

When you work on multiple projects (especially for different clients), shared gbrain leaks patterns, past plans, and even names across them. Concrete risks:

- **Confidentiality.** Client A's threat models and architecture decisions show up as "similar past patterns" while you're refining Client B's work
- **Confusion.** Past plans from an unrelated project surface as if they're relevant, and aren't
- **Audit trail mixing.** Compliance evidence (which is per-project) becomes harder to extract cleanly

Always scope gbrain per project. If a project has multiple devs, share the brain among them only — never across project boundaries.

### 6b. Tracker MCP

The Method is tracker-agnostic. Whichever tracker the human picked in Step 1 (`linear` / `jira` / `github-issues` / `none`), help them wire it up.

**Critical separation:** credentials and server registration live in **`~/.claude/mcp.json`** (per-user, not committed to git). The Method's per-project config (`method.config.yaml`) only references the MCP server **name**. This means tokens never get committed.

#### If they use Linear

> "We need the Linear MCP server connected. The official one requires a Linear API key. Do you have one ready, or want to skip this for now?"

1. Help them register the Linear MCP server in `~/.claude/mcp.json` (or via Claude Code's MCP config UI). Common name: `linear`.
2. Verify the connection — try listing their teams. If `tracker.linear.team_id` was TBD in Step 3, fill it in now.
3. Confirm `method.config.yaml`'s `tracker.mcp_server` value matches the name they registered.
4. Confirm the Method can read/write to their Linear workspace.

#### If they use Jira

> "We need a Jira MCP server connected. Common options include the Atlassian official MCP and community-maintained ones. You'll need your Jira workspace URL, project key, and an API token. Do you have those ready?"

1. Help them register the Jira MCP server in `~/.claude/mcp.json`. Common name: `jira`.
2. Verify by listing projects or issues for the project key set in `method.config.yaml`.
3. If `tracker.jira.points_custom_field` was TBD, retrieve it now (most Jira MCPs have a list-fields call).
4. Confirm `method.config.yaml`'s `tracker.mcp_server` matches the name they registered.
5. Confirm the Method can read/write to their Jira workspace.

#### If they use GitHub Issues

> "GitHub Issues is supported via the official GitHub MCP server. Do you have the GitHub MCP configured already, or want to set it up now?"

1. Help them register the GitHub MCP server in `~/.claude/mcp.json` (it likely already exists if they use GitHub for source). Common name: `github`.
2. Verify by listing issues for the repo configured in `method.config.yaml`.
3. Confirm `method.config.yaml`'s `tracker.mcp_server` matches the name they registered.
4. Confirm the Method can read/write to their issues.

#### If they use no tracker

> "That's fine — the git tree.yaml becomes the operational state. The team picks up 'ready' leaves from `plans/{epic}/tree.yaml` directly instead of from a tracker. `/plan` and `/build` operate in dry-run mode (produce all git artifacts; no remote push)."

Nothing to wire up. Log as a note in the install summary — the team will need to agree on a convention for "who's working on what" since there's no central board.

#### If the chosen tracker MCP isn't available or they want to skip

> "Logged as a follow-up. Without a tracker MCP connected, `/plan` and `/build` operate in dry-run mode — they produce all the git artifacts (tree, ADRs, threat model, tests, manifest) but don't push to the tracker. Everything else works without it."

### 6c. Other MCPs

Ask: "Are there other MCP servers you want connected for the method to use?" Examples: GitHub MCP, GitLab MCP, Slack MCP for notifications.

For each one they want, wire it up similarly. If they don't know, that's fine — move on.

---

## Step 7 — Verify (doing + a smoke test)

Run a smoke test to confirm the install works.

### 7a. Try /onboard

Tell the human:

> "Let's verify the install. I'll run the `/onboard` skill — it'll produce an orientation document for this project from the constitution and ADRs we just set up. If anything's missing, it'll surface."

Run `/onboard` (or follow the skill's instructions from `.claude/commands/onboard.md`). Show them the output. Ask: "Does this match what you'd want a new dev to see?"

If yes, great — the install works. If they want to tune anything, do another pass on `AGENTS.md` or the ADRs as needed.

### 7b. Try /adr on a real question

Ask the human:

> "Do you have a real architectural question on your mind right now? Something you've been meaning to decide. Let's run `/adr` on it as the final smoke test."

If they have one, run it. If they don't, that's fine — skip this step.

The point of this is to make sure the interview pattern feels right *to them*. If it feels off in any way — too verbose, too curt, too generic — that's signal to tune the agent files (`.claude/agents/architect.md` and others).

---

## Step 8 — Hand-off (doing)

Produce a final summary for the human. Format:

```markdown
# Method install summary

## What's installed
- Version: v{version}
- Role agents: 10 in `.claude/agents/`
- Skills: 10 in `.claude/commands/`
- Trigger profiles: `.method/triggers.md`
- Promotion rules: `.method/promotion-rules.md`
- Templates: `plans/_templates/`
- Documentation: METHOD.md, TUTORIAL.md, INSTALL.md, AGENT_INSTALL.md

## What we customised
- `AGENTS.md` — filled in with: {project name, stack summary, conventions summary}
- `docs/adr/` — {N existing ADRs moved in / N new ADRs created via interview / empty, ready for use}
- Structured references — {schema / openapi / module-map / domain-types set up: yes/no per file}

## What's pending (follow-ups)
- {gbrain status — shared Supabase or local}
- {Linear MCP status}
- {Other MCPs noted}
- {Conventions sections left as TBD}
- {Structured references not yet set up — schema export, OpenAPI, module map, domain types}
- {CI hooks for keeping structured refs fresh — if not yet wired}

## How to use it day-to-day

You don't pick a skill. Just describe what you want to do in plain language:

- "Should we use X or Y?" → routes to a decision interview
- "How does X currently work?" → routes to a code walkthrough
- "Fix the bug in X" → routes to a single-story flow
- "Add the X feature" → routes to epic refinement
- "Clean-slate rebuild X" → routes to multi-epic decomposition
- "Build X-123" → routes to the build loop

See `TUTORIAL.md` for worked examples at every input size.

The constitution (`AGENTS.md`) is what every agent reads at session start. As your project evolves, update it. Same for ADRs — every accepted decision goes in `docs/adr/`.

The method is yours now. Run it, push back when it gets things wrong, and tune the agent files (`.claude/agents/*.md`) when you see consistent friction.
```

Show this to the human. Ask: "Anything else you want me to do before we wrap up?"

When they say no, you're done.

---

## Behaviours to maintain throughout

These apply to every step:

### Always interview, never dump

Don't paste the AGENTS.md template at the human and ask them to fill it in. Walk them through it section by section. One question at a time.

### Always show what you're about to write

Before writing to a file, show the human the draft. Wait for their sign-off (even a quick "looks good") before committing it to disk.

### Don't silently fix discrepancies

If something the human says contradicts the template defaults — say so. "The template assumes a repository-pattern approach but you said you're using an ORM. Want me to update the template default to match your stack?"

### Preserve existing content

If the project already has an `AGENTS.md`, `docs/adr/`, or `plans/` directory, don't overwrite. Ask the human:

> "You already have an AGENTS.md. Do you want me to: (a) leave it as-is and only install the framework files, (b) merge your existing content with the template, or (c) overwrite (destructive)?"

### Take casual input, produce clean output

The human will type informally. Their words are the input. Your job is to structure them into the artifact. Fix typos, complete half-finished thoughts, organise into coherent paragraphs. Always show the structured version back to them for sign-off.

### Surface uncertainty

If you don't know something — say so. Don't guess. "I'm not sure whether your team uses Fibonacci or t-shirt sizes for points — which is it?" is better than picking one and writing it down.

### Capture follow-ups explicitly

Anything that gets deferred (TBD sections, missing MCPs, ADRs to be filled later) goes into the final summary's "What's pending" list. The human should leave the install session knowing exactly what's not done yet.

---

## What this install does NOT do

Be clear with the human about scope:

- **Doesn't write any code.** The method is the workflow tool; the code in their project is theirs.
- **Doesn't make architectural decisions for them.** ADRs come from interviews with them. If they have no decisions yet, that's fine — `/adr` runs as needed.
- **Doesn't set up CI/CD.** That's project-specific tooling outside the method's scope.
- **Doesn't run `/build` against any existing code.** Build only runs against stories refined through the method.

If they expect any of these, surface the scope clearly.

---

## Troubleshooting during install

### "I don't have curl"
Use Option B (manual copy) with git instead.

### "I don't have git either"
That's a blocker. Help them install git first.

### "The install.sh failed"
Show them the error. Common causes:
- Permission denied → run with appropriate permissions or use manual copy
- Network issue → check connectivity to github.com
- Target directory doesn't exist → confirm they're in the right directory

### "AGENTS.md was preserved but I want the template instead"
Move their existing one aside (`mv AGENTS.md AGENTS.md.bak`), copy the template, and reference their old version when filling in sections.

### "I don't know what stack I'm using"
That's fine. Mark the stack table as `[TBD via /adr]` and offer to interview them on it as the first real method session.

### "I started this install and don't want to finish it now"
Save state. Note what's done, what's not. They can resume by asking another agent to "continue the method install from step N" — the file state on disk is the source of truth.

---

## Last note

You are setting the human up for a long working relationship with the method. The install is their first impression of how the system thinks and works. Be patient, be interview-driven, be transparent. The install is itself a worked example of the method's operating principles.

When you're done, the human should feel: "this was thorough and respectful, the method understands my project, and I know how to use it now."
