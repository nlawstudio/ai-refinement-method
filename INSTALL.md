# Installing the Method

The method ships as a set of markdown files: agent definitions, skill definitions, trigger profiles, and templates. Installing it into a project means copying these files into the project's directory, plus connecting two MCP servers (gbrain for memory, tracker for operational state).

> **Most installs go through an AI agent.** If you're a human asking Claude Code / Cursor / Codex to install this for you, point them at [`AGENT_INSTALL.md`](AGENT_INSTALL.md). It contains the full prompt the agent follows — they'll interview you, install the framework, and customise `AGENTS.md` to your project as they go. The rest of this document is for direct human install (or for understanding what the agent will do under the hood).
>
> The recommended prompt to your agent:
>
> > *"Install the agentic refinement method in this repo. Follow the instructions at https://github.com/nlawstudio/ai-refinement-method/blob/main/AGENT_INSTALL.md"*

## One-line install

In the target project directory:

```bash
curl -sSL https://raw.githubusercontent.com/nlawstudio/ai-refinement-method/main/install.sh | sh
```

Or, with an explicit target:

```bash
curl -sSL https://raw.githubusercontent.com/nlawstudio/ai-refinement-method/main/install.sh | sh -s -- --target /path/to/your/project
```

The script clones the method repo and copies the framework files in. Existing files in the target are preserved.

To pin a specific version:

```bash
curl -sSL https://raw.githubusercontent.com/nlawstudio/ai-refinement-method/main/install.sh | sh -s -- --ref v1.2.1
```

## What the script installs

| Path | Contents |
|---|---|
| `.claude/agents/` | Ten role agent definitions (Explorer, Cartographer, Analyst, Architect, Designer, Decomposer, Test Author, Verifier, Critic, Threat Modeller) |
| `.claude/commands/` | Skills as internal capabilities the method composes |
| `.method/triggers.md` | When each role gets invoked — transparent and tunable |
| `.method/promotion-rules.md` | When conversations produce canonical artifacts |
| `.method/installed-version` | The method version installed in this project |
| `plans/_templates/` | Shape of `tree.yaml` and `manifest.yaml` artifacts |
| `METHOD.md`, `TUTORIAL.md`, `INSTALL.md`, `AGENT_INSTALL.md` | Documentation references (AGENT_INSTALL is the prompt agents follow for upgrades and re-installs) |
| `AGENTS.md` | Created from `AGENTS.template.md` if not already present |
| `docs/adr/README.md` | Created with the ADR template if `docs/adr/` is empty |

## What you have to do once it's installed

### 1. Fill in `AGENTS.md`

The installed `AGENTS.md` is a template with bracketed placeholders. Fill in:

- Your project's name in the preamble
- The technology stack and references to accepted ADRs
- Project-specific conventions (code, testing, data handling, compliance)

Remove the template banner at the top once done.

### 2. Add your project's ADRs

If your project has accepted architecture decisions, write them up as `docs/adr/ADR-XXX-title.md` files using the template the installer left in `docs/adr/README.md`.

Don't have any yet? That's fine — the first time you describe a decision to the method, it'll draft the first ADR for you.

### 3. Connect gbrain (memory)

gbrain is the persistent memory layer used by the method. It maintains three rings: session (current plan), project (your ADRs and past plans), org (cross-project patterns).

If you have gstack installed:

```
/setup-gbrain
```

Otherwise, see the gbrain documentation for manual MCP wiring.

Without gbrain, the method still works — it just loses memory across sessions. Past plans, accepted ADRs, and prior patterns won't be queryable. Recommended for any sustained use.

### 4. Connect tracker (operational state)

The method pushes refined stories to tracker and reads epics back. You'll need a tracker MCP server installed and configured with your workspace API key.

Without tracker, the method operates in **dry-run mode** — produces all the git artifacts (tree, ADRs, threat model, tests, manifest) but does not push to tracker. Everything else works.

### 5. Verify

Open Claude Code in the project directory and run:

```
/onboard
```

The method will run a curated tour of your installed setup and produce an orientation document for any dev joining the project.

## Upgrading

To upgrade an existing installation to the latest method:

```bash
curl -sSL https://raw.githubusercontent.com/nlawstudio/ai-refinement-method/main/install.sh | sh
```

The script preserves your `AGENTS.md` and `docs/adr/` — it only overwrites framework files (`.claude/`, `.method/`, `plans/_templates/`, and the documentation references). Check the [CHANGELOG](https://github.com/nlawstudio/ai-refinement-method/blob/main/CHANGELOG.md) before upgrading to see what changed.

## Manual install

If you can't or don't want to run the install script, clone the method and copy what you need:

```bash
git clone https://github.com/nlawstudio/ai-refinement-method.git /tmp/method
cd /your/project

# Framework files
cp -R /tmp/method/.claude .
cp -R /tmp/method/.method .
cp -R /tmp/method/plans/_templates plans/

# Documentation
cp /tmp/method/METHOD.md .
cp /tmp/method/TUTORIAL.md .
cp /tmp/method/INSTALL.md .
cp /tmp/method/AGENT_INSTALL.md .

# Constitution template (only if you don't have one)
[ -f AGENTS.md ] || cp /tmp/method/AGENTS.template.md AGENTS.md
```

## What's NOT installed

The install script deliberately does not bring in:

- The method's own README or CHANGELOG (those are for the method repo, not for the project)
- Any project-specific instance content from the method repo
- Live `plans/{epic}/` directories — those accumulate as the method is used

## Troubleshooting

### "git: command not found"
The install script uses git to clone the repo. Install git first.

### "I don't have curl"
Use the manual install path above with git.

### "The script copied AGENTS.md but I had my own"
The script preserves your existing `AGENTS.md`. If you see the template, it means you didn't have one previously. Open `AGENTS.md` and fill in the bracketed sections.

### "How do I know if it's installed correctly?"
After install, check:

```bash
ls .claude/agents/ | wc -l       # should be 10
ls .claude/commands/ | wc -l     # should be 10 (refinement skills)
cat .method/installed-version   # should match the method version
```

Then open Claude Code in the directory and type:

```
/onboard
```

If the orientation runs, you're set.

### "Can I re-run the agent install later?"
Yes. `AGENT_INSTALL.md` is installed alongside the framework files. Any future agent in this project can read it and re-run the install (e.g., for upgrades, or to walk a new dev through customising `AGENTS.md`).
