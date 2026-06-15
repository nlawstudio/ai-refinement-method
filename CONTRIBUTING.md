# Contributing to the Method

Thanks for your interest in improving the Method. The project is small but ambitious — clear, focused contributions are very welcome.

## What this repo is — and isn't

The Method is a packaged tool that installs into other projects to bring AI-first refinement. It is **not** an application — there's no runtime, no users hitting an endpoint, no production deployment. Contributions are mostly to documentation, agent prompts, and shell scripts.

Treat this repo as a **library of prompts and conventions** that ships across many projects. A change here affects every project that has the Method installed once they upgrade. Bias toward changes that are general and timeless; resist changes that are specific to one project's circumstances.

## Kinds of contribution welcome

- **Bug reports** — an agent does something documented contradicts, the installer breaks on a fresh repo, a citation is wrong
- **Prompt tuning** — an agent file produces poor output in a specific situation; a tighter prompt fixes it
- **New skills** — a new `/<command>` that composes existing roles to solve a recurring problem
- **New roles** — a new agent type that fills a genuine gap (high bar — requires an ADR; see below)
- **Documentation** — typos, clarifications, missing examples, broken links
- **Tracker integrations** — additional tracker types beyond Linear / Jira / GitHub Issues / none
- **Quality-of-life** — better install diagnostics, friendlier error messages, smoke tests

## Kinds of contribution **not** welcome

- **Project-specific examples** that name a particular company, customer, or codebase
- **Speculative features** that don't have a clear use case driving them
- **Personal preference** changes to vocabulary or tone (the Method's voice is deliberate)
- **Major architectural rewrites** that haven't been discussed in an issue first

## Before you open a PR

1. **Open an issue first** for anything substantive. Quick fixes (typos, broken links, obvious bugs) don't need one.
2. **For substantive changes** — new role, new skill, change to the loop, change to the modes, change to promotion rules — propose it as an ADR in the issue. The Method's own ADRs will live in `docs/adr/` (currently empty); the first substantive contribution likely starts that record.
3. **Read [METHOD.md](METHOD.md)** to understand how the change fits the framework.

## Style and tone

The Method's prose has a deliberate voice — direct, technical, light on adverbs, no marketing language. New documentation should match. The `QUICKSTART.md` and `METHOD.md` are stylistic references.

For agent files specifically:
- Lead with the agent's job in one sentence
- State the mode (doing / drafting / interviewing) explicitly
- Use concrete examples, never abstract ones
- Include failure modes — what the agent should avoid

## Pull request checklist

- [ ] One focused change per PR
- [ ] No project-specific references (no company names, customer names, specific repo URLs other than this one)
- [ ] CHANGELOG entry under `[Unreleased]` (we'll move it to the version on release)
- [ ] If you changed an agent or skill file, smoke-test it: install the Method into a scratch repo and try the affected flow

## Versioning

The Method follows [SemVer](https://semver.org/):

- **Patch** (`x.y.Z`): documentation, prompt tuning, small bug fixes
- **Minor** (`x.Y.0`): new agents, new skills, new tracker integrations, additive config
- **Major** (`X.0.0`): breaking changes to the install path, file layout, or constitution structure

## Issues, decisions, discussions

- **Bugs / concrete change proposals** → GitHub Issues
- **Open-ended questions, ideas, "should we..." discussions** → GitHub Discussions (once enabled)
- **Security issues** → see [SECURITY.md](SECURITY.md)

## Code of conduct

This project follows the [Contributor Covenant](CODE_OF_CONDUCT.md). Be kind. Assume good faith.

## License

By contributing, you agree that your contributions will be licensed under the [MIT License](LICENSE).
