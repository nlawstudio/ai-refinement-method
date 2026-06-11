# Security Policy

## Reporting a vulnerability

The Method is a tool that installs files into other projects' repositories. Security issues in this scope generally fall into one of:

- The `install.sh` script behaves in a way that could compromise a target repository (e.g., writes outside the target directory, leaks credentials, downloads tampered content)
- An agent or skill prompt could be manipulated to perform an action that wasn't intended (prompt injection from untrusted input that an agent reads)
- Documented patterns that could lead users to handle credentials unsafely

If you find something in scope, please **do not** open a public issue. Instead, email:

**nicholas@nicholaslawrence.studio**

Include:

- A description of the issue
- Steps to reproduce
- What an attacker could achieve
- (If you have one) a suggested fix

I'll acknowledge within 72 hours. Disclosure timeline depends on severity; a typical fix-then-disclose window is 30–90 days from acknowledgement, but I'm happy to coordinate if you have a specific publication plan.

## Out of scope

- Vulnerabilities in upstream tools (Claude Code, Cursor, Codex, MCP servers, gbrain) — please report those to their respective maintainers
- Issues in projects that *use* the Method but stem from how that project uses it (configure your `AGENTS.md`, `method.config.yaml`, MCP credentials per your team's policies)
- Behaviour that is documented and is working as designed but that you disagree with — open a regular issue for those

## Credentials safety

The Method is designed so that **no credentials are ever stored in `AGENTS.md` or `method.config.yaml`**. All MCP server URLs and tokens live in `~/.claude/mcp.json` per user, never committed.

If you find a documented pattern that encourages otherwise, please report it as a security issue.
