<style>
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=JetBrains+Mono:wght@400;500;600&display=swap');

:root {
  --bg: #F7F5F0;
  --ink: #14110F;
  --muted: #6F665A;
  --line: #E5E0D5;
  --accent: #C84B31;
  --dark: #14110F;
  --code-bg: #EEEAE0;
}

html, body {
  background: var(--bg);
  color: var(--ink);
  margin: 0;
  padding: 0;
}

body {
  font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
  font-size: 17px;
  line-height: 1.65;
  letter-spacing: -0.005em;
  max-width: 820px;
  margin: 0 auto;
  padding: 80px 48px 160px;
  font-weight: 400;
}

h1 {
  font-size: 56px;
  font-weight: 700;
  letter-spacing: -0.035em;
  line-height: 1.05;
  margin: 0 0 24px 0;
}

h2 {
  font-size: 32px;
  font-weight: 600;
  letter-spacing: -0.025em;
  line-height: 1.2;
  margin: 80px 0 24px 0;
  padding-top: 32px;
  border-top: 1px solid var(--line);
}

h2::before {
  content: "§ " counter(h2-counter, decimal-leading-zero);
  counter-increment: h2-counter;
  display: block;
  font-family: 'JetBrains Mono', ui-monospace, monospace;
  font-size: 12px;
  letter-spacing: 0.18em;
  text-transform: uppercase;
  color: var(--accent);
  font-weight: 600;
  margin-bottom: 14px;
}

body { counter-reset: h2-counter; }

h3 {
  font-size: 22px;
  font-weight: 600;
  letter-spacing: -0.015em;
  line-height: 1.3;
  margin: 40px 0 16px 0;
}

h4 {
  font-family: 'JetBrains Mono', ui-monospace, monospace;
  font-size: 13px;
  font-weight: 600;
  letter-spacing: 0.12em;
  text-transform: uppercase;
  color: var(--muted);
  margin: 32px 0 12px 0;
}

p { margin: 0 0 18px 0; }
ul, ol { margin: 0 0 18px 0; padding-left: 22px; }
li { margin-bottom: 8px; }
li::marker { color: var(--accent); }

strong { font-weight: 600; }
em { color: var(--accent); font-style: normal; font-weight: 500; }

code {
  font-family: 'JetBrains Mono', ui-monospace, monospace;
  font-size: 0.85em;
  background: var(--code-bg);
  padding: 2px 7px;
  border-radius: 4px;
}

pre {
  background: var(--dark);
  color: #F0EBE0;
  padding: 22px 26px;
  border-radius: 8px;
  font-size: 14px;
  line-height: 1.6;
  margin: 24px 0;
  overflow-x: auto;
}
pre code { background: transparent; color: inherit; padding: 0; font-size: 1em; }

table {
  width: 100%;
  border-collapse: collapse;
  margin: 20px 0 28px 0;
  font-size: 15px;
}
th {
  text-align: left;
  font-family: 'JetBrains Mono', ui-monospace, monospace;
  font-weight: 600;
  font-size: 11px;
  letter-spacing: 0.12em;
  text-transform: uppercase;
  padding: 12px 16px 12px 0;
  border-bottom: 2px solid var(--ink);
}
td {
  padding: 12px 16px 12px 0;
  border-bottom: 1px solid var(--line);
  vertical-align: top;
}
td:first-child, th:first-child { padding-left: 0; }
tr:last-child td { border-bottom: none; }

blockquote {
  border-left: 3px solid var(--accent);
  padding: 8px 0 8px 24px;
  margin: 28px 0;
  font-size: 20px;
  font-weight: 500;
  line-height: 1.4;
  letter-spacing: -0.012em;
}
blockquote p { margin: 0; }

hr { border: none; border-top: 1px solid var(--line); margin: 48px 0; }
a { color: var(--accent); text-decoration: none; border-bottom: 1px solid var(--accent); }
a:hover { background: var(--code-bg); }

.cover {
  margin: 0 0 80px 0;
  padding: 0 0 48px 0;
  border-bottom: 1px solid var(--line);
}
.cover .eyebrow {
  font-family: 'JetBrains Mono', ui-monospace, monospace;
  font-size: 12px;
  letter-spacing: 0.2em;
  text-transform: uppercase;
  color: var(--accent);
  font-weight: 600;
  margin-bottom: 32px;
}
.cover h1 {
  font-size: 72px;
  font-weight: 700;
  letter-spacing: -0.04em;
  line-height: 0.98;
  margin: 0 0 24px 0;
}
.cover .subtitle {
  font-size: 24px;
  color: var(--muted);
  font-weight: 400;
  max-width: 640px;
  line-height: 1.35;
  margin-bottom: 56px;
  letter-spacing: -0.015em;
}
.cover .meta {
  font-family: 'JetBrains Mono', ui-monospace, monospace;
  font-size: 13px;
  color: var(--muted);
  letter-spacing: 0.04em;
  line-height: 2;
}
.cover .meta strong {
  color: var(--ink);
  font-weight: 600;
  text-transform: uppercase;
  font-size: 11px;
  letter-spacing: 0.14em;
  display: inline-block;
  width: 120px;
}

.toc {
  background: var(--code-bg);
  border-radius: 8px;
  padding: 32px 36px;
  margin: 48px 0 80px 0;
}
.toc .toc-label {
  font-family: 'JetBrains Mono', ui-monospace, monospace;
  font-size: 12px;
  letter-spacing: 0.18em;
  text-transform: uppercase;
  color: var(--accent);
  font-weight: 600;
  margin-bottom: 18px;
}
.toc ol {
  list-style: none;
  padding: 0;
  margin: 0;
  counter-reset: toc-counter;
  font-size: 15px;
}
.toc li {
  display: flex;
  align-items: baseline;
  padding: 6px 0;
  margin: 0;
  counter-increment: toc-counter;
}
.toc li::before {
  content: counter(toc-counter, decimal-leading-zero);
  font-family: 'JetBrains Mono', ui-monospace, monospace;
  font-size: 11px;
  color: var(--muted);
  letter-spacing: 0.1em;
  margin-right: 18px;
  font-weight: 500;
  min-width: 24px;
}
.toc a {
  color: var(--ink);
  border-bottom: none;
  font-weight: 500;
}
.toc a:hover { color: var(--accent); background: transparent; }

.callout {
  background: var(--dark);
  color: var(--bg);
  padding: 40px 44px;
  border-radius: 10px;
  margin: 40px 0;
}
.callout .callout-label {
  font-family: 'JetBrains Mono', ui-monospace, monospace;
  font-size: 11px;
  letter-spacing: 0.18em;
  text-transform: uppercase;
  color: var(--accent);
  font-weight: 600;
  margin-bottom: 14px;
}
.callout p {
  font-size: 20px;
  line-height: 1.4;
  font-weight: 500;
  letter-spacing: -0.015em;
  margin: 0 0 12px 0;
}
.callout p:last-child { margin-bottom: 0; }
.callout em { color: var(--accent); font-weight: 600; }

.role-card {
  border: 1px solid var(--line);
  border-radius: 8px;
  padding: 28px 32px;
  margin: 24px 0;
  background: rgba(255,255,255,0.4);
}
.role-card h3 {
  margin-top: 0;
  margin-bottom: 6px;
  font-size: 22px;
}
.role-card .role-tags {
  font-family: 'JetBrains Mono', ui-monospace, monospace;
  font-size: 11px;
  letter-spacing: 0.12em;
  text-transform: uppercase;
  color: var(--accent);
  font-weight: 600;
  margin-bottom: 18px;
}
.role-card dl {
  display: grid;
  grid-template-columns: 140px 1fr;
  gap: 8px 16px;
  margin: 0;
  font-size: 15px;
}
.role-card dt {
  font-family: 'JetBrains Mono', ui-monospace, monospace;
  font-size: 11px;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  color: var(--muted);
  font-weight: 600;
  padding-top: 2px;
}
.role-card dd { margin: 0; }

.diagram-caption {
  font-family: 'JetBrains Mono', ui-monospace, monospace;
  font-size: 12px;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  color: var(--muted);
  text-align: center;
  margin-top: 8px;
  margin-bottom: 24px;
}

@media print {
  body { max-width: none; padding: 24px; font-size: 11pt; }
  h1, h2 { break-after: avoid; }
  table, pre, blockquote, .callout, .role-card { break-inside: avoid; }
  a { color: var(--ink); border-bottom: none; }
}
</style>

<div class="cover">

<div class="eyebrow">Canonical · v2 · for team and AI reference</div>

# The Method

<div class="subtitle">An agentic refinement and build method. One loop. Many depths. Your project's SDLC baked in.</div>

<div class="meta">

<strong>Status</strong> Canonical — current locked design<br>
<strong>Scope</strong> The unified refinement + build method. Both phases first-class; off-course bridge in between.<br>
<strong>Date</strong> June 2026<br>
<strong>Audience</strong> Engineering teams using the Method, and the AI agents being built against it

</div>

</div>

<div class="toc">

<div class="toc-label">Contents</div>

<ol>
<li><a href="#what-this-document-is">What this document is</a></li>
<li><a href="#thesis">Thesis</a></li>
<li><a href="#the-unified-loop">The unified loop</a></li>
<li><a href="#the-three-modes">The three modes — doing, drafting, interviewing</a></li>
<li><a href="#the-role-panel">The role panel</a></li>
<li><a href="#triage-and-routing">Triage and routing</a></li>
<li><a href="#recursive-decomposition">Recursive decomposition</a></li>
<li><a href="#skills-as-internal-capabilities">Skills as internal capabilities</a></li>
<li><a href="#definition-of-ready">Definition of Ready — the gate</a></li>
<li><a href="#stop-conditions">Stop conditions</a></li>
<li><a href="#adrs-and-the-promotion-rule">ADRs and the promotion rule</a></li>
<li><a href="#testing-strategy">Testing strategy</a></li>
<li><a href="#compliance-baked-in">Compliance baked in</a></li>
<li><a href="#team-pattern">Team pattern — convene, drive, disperse</a></li>
<li><a href="#memory-via-gbrain">Memory via gbrain</a></li>
<li><a href="#configuration">Configuration (method.config.yaml)</a></li>
<li><a href="#the-three-tier-context-model">The three-tier context model</a></li>
<li><a href="#failure-modes-and-mitigations">Failure modes and mitigations</a></li>
<li><a href="#storage-and-artifacts">Storage and artifacts</a></li>
<li><a href="#the-build-phase">The build phase and the off-course bridge</a></li>
<li><a href="#distribution-and-versioning">Distribution and versioning</a></li>
<li><a href="#whats-out-of-scope">What's out of scope</a></li>
<li><a href="#open-questions">Open questions</a></li>
<li><a href="#glossary">Glossary</a></li>
</ol>

</div>

## What this document is

The canonical specification of the Method. It serves two audiences:

- **Humans on the engineering team** read this to understand what the Method is, how the system works, and how their day-to-day changes when it's in use.
- **AI agents building or running the Method** read this as the authoritative spec. Where this document is precise, treat it as binding. Where it's open, defer to a human decision.

Sections 1–7 set the framing and the architecture. Sections 8–13 cover mechanics (skills, DoR, stop conditions, ADRs, testing, compliance). Sections 14–17 cover team pattern, memory, failure modes, storage. Sections 18–20 are scope, open questions, glossary.

## Thesis

The role of a software engineer building B2B SaaS will look fundamentally different two years from now. The teams that go on that journey deliberately will outperform those who don't.

The shift is from owning code to owning outcomes — from executing tickets to conducting an AI bench of collaborators. Most teams will lean on Claude Code, Cursor, and similar as productivity boosters around the existing workflow. The Method goes further: a codified way of working that turns the team's expertise into a multiplier the team has to learn how to use.

The Method is the deliverable. Real engineering work — refinement, decisions, design, threat modelling, story breakdown, building, off-course handling — is what it's tested against.

<div class="callout">
<div class="callout-label">Why refinement first</div>
<p>Most teams underinvest in refinement. A 30-minute backlog-grooming meeting that adds AC to stories someone else already wrote.</p>
<p>What we're building is the full upstream chunk: <em>idea → decisions → design → tasks</em> — discovery, architectural design, refinement, and documentation collapsed into one iterative agent-driven process.</p>
<p>If refinement is great, the build phase gets dramatically easier. If refinement is mediocre, no downstream tooling fixes it.</p>
</div>

## The unified loop

The method runs as **one loop**, invoked by a developer describing what they want in plain language. The loop handles inputs of any size — a single bug, a decision, a feature, a multi-epic rebuild — by adapting its **depth** of recursion. The loop **shape** itself is invariant.

```mermaid
flowchart TB
    Start([Developer types intent in plain language])
    Start --> Triage{TRIAGE<br/>What shape is this?}

    Triage -->|Question / walkthrough| Walk[Cartographer-led<br/>answer with citations]
    Triage -->|Decision| Decide[Architect interview<br/>→ ADR if rule fires]
    Triage -->|Bug| Bug[Lightweight flow:<br/>read code → AC → test → 1 story]
    Triage -->|Story / small feature| Story[Refinement to 1 story or<br/>small set of stories]
    Triage -->|Epic| Epic[Full refinement:<br/>scope → threat → ADRs →<br/>design → decompose → tests]
    Triage -->|Multi-epic goal| Multi[Decompose into epics first<br/>then full flow per epic]

    Walk --> Decompose{DOES EACH UNIT<br/>PASS DoR?}
    Decide --> Decompose
    Bug --> Decompose
    Story --> Decompose
    Epic --> Decompose
    Multi --> Decompose

    Decompose -->|Yes — leaf ready| tracker[(tracker<br/>backlog)]
    Decompose -->|No — too big or unclear| Recurse[Decompose<br/>further]
    Recurse --> Decompose

    tracker --> Audit[(Git audit trail<br/>tree, transcript,<br/>ADRs, threat model,<br/>compliance manifest)]

    style Start fill:#C84B31,color:#fff
    style Triage fill:#fff4e0
    style Decompose fill:#f4e8f4
    style tracker fill:#e0f0f8
    style Audit fill:#fff4e0
```

<div class="diagram-caption">The unified loop — same shape, depth adapts to the input</div>

### The "same loop, many depths" principle

| Input | Depth of recursion | Output |
|---|---|---|
| *"Should we use UUIDv7 over UUIDv4?"* | 1 turn — triage → decision | ADR or informal decision. No tracker. |
| *"How does the legacy wallet linkage work?"* | 1 turn — triage → walkthrough | Cited findings. No tracker. |
| *"Fix the Solana wallet linkage bug"* | Triage → 1 story | 1 tracker story with failing test |
| *"Add bulk asset export feature"* | Triage → 1 epic → ~10–20 stories | 1 tracker epic + stories + ADRs + threat model |
| *"Clean-slate the platform rebuild"* | Triage → ~8 epics → ~100+ stories | Many tracker epics, each fully refined |

The depth varies enormously. The loop itself is identical. That's what makes the method predictable: developers learn one mental model and it works at every scale.

### Three layers, decoupled

```mermaid
flowchart LR
    Intent[Developer intent] --> Loop[Unified Loop]
    Loop --> Skills["Skills layer<br/>(internal capabilities)"]
    Skills --> Roles["Role layer<br/>(10 agent primitives)"]
    Roles --> Modes["Mode layer<br/>(doing / drafting / interviewing)"]
    Modes --> Output[tracker + git artifacts]
    Memory[(gbrain memory<br/>session/project/org)] -.-> Loop
    Memory -.-> Roles

    style Loop fill:#C84B31,color:#fff
    style Memory fill:#f4e8f4
```

<div class="diagram-caption">Layers — the developer interacts with the loop; everything else is internal</div>

## The three modes

Every agent output operates in exactly one of three modes. The mode is explicit on every output, captured in the audit trail.

```mermaid
flowchart LR
    A[Agent produces output] --> B{What kind of work?}
    B -->|Mechanical| C[DOING<br/>AI acts<br/>No signoff needed]
    B -->|Has a good draft| D[DRAFTING<br/>AI drafts<br/>Human signs off]
    B -->|Needs human expertise| E[INTERVIEWING<br/>AI asks<br/>Human answers<br/>AI cleans + structures<br/>Human signs off]

    style C fill:#e8f4e8
    style D fill:#fff4e0
    style E fill:#f4e8f4
```

<div class="diagram-caption">The three modes of every agent output</div>

| Mode | Pattern | Best for |
|---|---|---|
| **Doing** | AI acts, no human signoff | Mechanical work — reading code, running tests, generating tags |
| **Drafting** | AI drafts → human signs off | Structured outputs where AI has a strong first draft (code, tests, decompositions) |
| **Interviewing** | AI asks → human answers → AI cleans, structures, augments → human signs off | Knowledge-dependent outputs where the human's expertise is the value |

### Why interviewing matters

The naive pattern — AI drafts, human reviews — has a known failure mode: humans rubber-stamp. The interview pattern flips it: the AI asks targeted questions, the human answers from their own knowledge, the AI structures and cleans the answers (typos fixed, half-finished thoughts completed, organisation imposed) and adds what the human missed. The human signs off on the cleaned artifact.

The **signed-off cleaned artifact is the compliance evidence**, not the raw chat. The raw chat log lives in `plans/{epic}/conversation.md` alongside the artifact, available if anyone needs to verify "yes, this conversation actually happened."

This is what separates the method from "skills that have good prompts" — the human's *thinking* is the input, structured by the AI, approved by the human.

### The doing / deciding split (the operating principle)

<div class="callout">
<div class="callout-label">Operating principle</div>
<p>The AI does. The human decides — or signs off.</p>
</div>

- **AI does, autonomously:** reading code, drafting summaries, generating subnodes, writing test code from AC, writing implementation from failing tests, running scans, mapping controls, drafting ADRs, drafting threat models, generating compliance evidence.
- **Human decides** (or signs off): scope, acceptance criteria, trade-offs at architectural branch points, whether an ADR draft is correct, whether a leaf is "ready", whether the threat model is genuine, what to do with critic findings.
- **The middle — AI proposes, human signs off:** story-point estimates, decomposition shape, stop conditions, test coverage adequacy.

Every output is tagged `decision_required: true | false`. The audit trail records every human sign-off — that's the evidence trail.

## The role panel

Ten roles. Each has a distinct context window, output shape, quality bar, invocation trigger, failure mode, and primary mode. A role exists when those six things make it irreducible to another role.

```mermaid
flowchart TB
    subgraph Discovery["Discovery & decisions"]
        Analyst[Analyst<br/>scope + privacy]
        Architect[Architect<br/>decisions + ADRs]
        Threat[Threat Modeller<br/>STRIDE interview]
    end

    subgraph Reading["Reading existing code"]
        Cart[Cartographer<br/>cited findings]
    end

    subgraph Design["Design & breakdown"]
        Des[Designer<br/>design docs]
        Dec[Decomposer<br/>story tree]
    end

    subgraph Build["Build & verify"]
        TA[Test Author<br/>failing tests]
        B[Builder<br/>implementation]
        V[Verifier<br/>DoR + behaviour]
        Critic[Critic<br/>adversarial review]
    end

    style Discovery fill:#f4e8f4
    style Reading fill:#e8f4e8
    style Design fill:#fff4e0
    style Build fill:#e0f0f8
```

<div class="diagram-caption">The role panel — grouped by where they fire</div>

Detailed role cards follow. Each describes the role's job, context, output, quality bar, triggers, and failure mode.

<div class="role-card">

### Cartographer
<div class="role-tags">Mode: doing · Triggered by: existing-code-read</div>

<dl>
<dt>Job</dt><dd>Reads the existing system. Maps behaviours, data, integrations. Read-only on old code.</dd>
<dt>Context</dt><dd>The codebase, plus the question being asked. Does not see ADRs unless given explicitly.</dd>
<dt>Output</dt><dd>Structured findings with mandatory <code>file:line</code> citations. System maps, behaviour catalogues, data model extracts.</dd>
<dt>Quality bar</dt><dd>Every claim is verifiable. No assertion without a citation.</dd>
<dt>Triggers</dt><dd>Conversation references existing system behaviour; human can't answer "does the system do X today?"; any rebuild work or refactoring.</dd>
<dt>Failure mode</dt><dd>Mis-reads code; cites wrong file; hallucinates behaviour that doesn't exist.</dd>
</dl>
</div>

<div class="role-card">

### Analyst
<div class="role-tags">Modes: interviewing (scope), drafting (privacy lens)</div>

<dl>
<dt>Job</dt><dd><strong>Scope mode</strong>: interviews the human to establish what is being built, for whom, why, what's in/out. <strong>Privacy lens mode</strong>: assesses data-handling implications per the project's data-handling ADR.</dd>
<dt>Context</dt><dd>The goal, relevant past plans from gbrain, the project's domain context.</dd>
<dt>Output</dt><dd>Scope mode: cleaned brief, signed off by human. Privacy mode: classification assessment.</dd>
<dt>Quality bar</dt><dd>Scope explicit including out-of-scope. Privacy assessments cite the project's data classes precisely.</dd>
<dt>Triggers</dt><dd>Epic kickoff (scope mode); any node touching Confidential or Restricted data (privacy mode).</dd>
<dt>Failure mode</dt><dd>Accepts unclear scope; misses privacy implications when data flows are indirect.</dd>
</dl>
</div>

<div class="role-card">

### Architect
<div class="role-tags">Modes: interviewing (decisions), drafting (ADR doc)</div>

<dl>
<dt>Job</dt><dd>Surfaces and resolves architectural decisions. Interviews the human on trade-offs. Drafts ADRs from interview output. Surfaces risks alongside trade-offs.</dd>
<dt>Context</dt><dd>The question, relevant existing ADRs from gbrain, Cartographer findings if existing code is involved.</dd>
<dt>Output</dt><dd>Cleaned interview synthesis + draft ADR (when promotion rule fires) + risk register entries.</dd>
<dt>Quality bar</dt><dd>≥2 genuine alternatives surfaced when a decision is durable. Trade-offs explicit. Every existing-ADR reference cites the ADR by ID.</dd>
<dt>Triggers</dt><dd>Decision points surfaced during refinement; conflicts with existing ADRs detected.</dd>
<dt>Failure mode</dt><dd>Hallucinates "alternatives considered" that aren't real; cites ADRs that don't exist.</dd>
</dl>
</div>

<div class="role-card">

### Designer
<div class="role-tags">Mode: drafting</div>

<dl>
<dt>Job</dt><dd>Translates brief + ADRs + Cartographer's map into design docs (data model, API contracts, UI components, equivalence/divergence spec).</dd>
<dt>Context</dt><dd>Brief, accepted ADRs, existing-system map, design template.</dd>
<dt>Output</dt><dd><code>plans/{epic}/design.md</code> per the project's design template.</dd>
<dt>Quality bar</dt><dd>Precise enough that Decomposer can produce DoR-ready leaves from it.</dd>
<dt>Triggers</dt><dd>After ADRs are accepted; before Decomposer runs.</dd>
<dt>Failure mode</dt><dd>Under-specifies contracts; misses error cases; ignores accepted ADRs.</dd>
</dl>
</div>

<div class="role-card">

### Decomposer
<div class="role-tags">Mode: drafting</div>

<dl>
<dt>Job</dt><dd>Breaks design into story tree. Estimates story points. Recursively splits anything &gt;3 points until every leaf fits.</dd>
<dt>Context</dt><dd>Design doc, relevant ADRs, past similar stories from gbrain.</dd>
<dt>Output</dt><dd>Tree of stories, each carrying point estimate + AC + linked ADR.</dd>
<dt>Quality bar</dt><dd>Every leaf is ≤3 points. Every leaf has testable AC. Every leaf carries one of {linked ADR, "no architectural impact" tag}.</dd>
<dt>Triggers</dt><dd>Design doc approved; epic kickoff for a tightly-scoped epic.</dd>
<dt>Failure mode</dt><dd>Estimates poorly; misses dependencies; trees that look complete but skip an obvious story.</dd>
</dl>
</div>

<div class="role-card">

### Builder
<div class="role-tags">Mode: doing → human reviews at PR</div>

<dl>
<dt>Job</dt><dd>Implements stories. Sees the failing test from Test Author as its spec. Writes minimum code to pass.</dd>
<dt>Context</dt><dd>Story, AC, linked ADR, failing test file, constitution.</dd>
<dt>Output</dt><dd>Code + passing test + PR.</dd>
<dt>Quality bar</dt><dd>Test passes, race detector clean, conforms to constitution and linked ADRs.</dd>
<dt>Triggers</dt><dd>Leaf passes DoR, failing test exists.</dd>
<dt>Failure mode</dt><dd>Writes code that passes the test without solving the underlying intent.</dd>
</dl>
</div>

<div class="role-card">

### Test Author
<div class="role-tags">Mode: drafting · Runs during refinement, not after</div>

<dl>
<dt>Job</dt><dd>Writes failing test from AC. A story is only DoR-ready when its test compiles and fails for the right reason.</dd>
<dt>Context</dt><dd>Story + AC + design + relevant ADRs + interface stubs. <strong>Does not see implementation.</strong></dd>
<dt>Output</dt><dd>Test file with a test that compiles and fails on assertion.</dd>
<dt>Quality bar</dt><dd>Test fails for the right reason. Test exercises behaviour, not just coverage.</dd>
<dt>Triggers</dt><dd>Story has AC and is approaching DoR.</dd>
<dt>Failure mode</dt><dd>Vacuous tests; over-mocking; tests that compile but don't actually fail when code is wrong.</dd>
</dl>
</div>

<div class="role-card">

### Verifier
<div class="role-tags">Modes: DoR check (refinement), behavioural check (build)</div>

<dl>
<dt>Job</dt><dd><strong>DoR mode</strong>: confirms a leaf passes the eight readiness criteria. <strong>Behavioural mode</strong>: confirms code meets test specs and equivalence requirements (rebuild).</dd>
<dt>Context</dt><dd>DoR: the leaf + checklist. Behavioural: PR + tests + (for rebuild) legacy behaviour.</dd>
<dt>Output</dt><dd>Pass/fail report with specific findings.</dd>
<dt>Quality bar</dt><dd>No false positives on "ready". A leaf marked ready genuinely meets every DoR criterion.</dd>
<dt>Triggers</dt><dd>Refinement: leaf reaching candidate-ready. Build: PR ready for landing.</dd>
<dt>Failure mode</dt><dd>Passes leaves that don't actually meet DoR; misses equivalence regressions.</dd>
</dl>
</div>

<div class="role-card">

### Critic
<div class="role-tags">Mode: doing — two passes (test critique, code critique)</div>

<dl>
<dt>Job</dt><dd>Adversarial review. <strong>First pass</strong> after Test Author: does this test exercise the right behaviour, or just hit coverage? <strong>Second pass</strong> after Builder: what could break this that the tests don't catch?</dd>
<dt>Context</dt><dd>First pass: <code>(story, AC, design, test file)</code>. Second pass: <code>(story, AC, test file, implementation)</code>.</dd>
<dt>Output</dt><dd>Structured findings with severity and rationale.</dd>
<dt>Quality bar</dt><dd>Findings are concrete and actionable. Adversarial <em>by default</em>; defaults to "refuted" when uncertain.</dd>
<dt>Triggers</dt><dd>Test file produced (first pass); PR produced (second pass).</dd>
<dt>Failure mode</dt><dd>Going along with the test/code; consensus illusion with other agents.</dd>
</dl>
</div>

<div class="role-card">

### Threat Modeller
<div class="role-tags">Mode: interviewing · engagement IS the evidence</div>

<dl>
<dt>Job</dt><dd>Drives a STRIDE-style threat modelling interview at epic kickoff. Captures engineer responses in chat, cleans + structures them for the artifact, augments with gaps the engineer didn't surface, surfaces signed-off model.</dd>
<dt>Context</dt><dd>Epic brief, past threat models from gbrain, the project's threat landscape.</dd>
<dt>Output</dt><dd>Cleaned + signed structured threat model + reference to raw chat transcript.</dd>
<dt>Quality bar</dt><dd>Human engagement evidenced (not generated). Gaps flagged as AI-surfaced. Project-specific threats (for multi-tenant B2B SaaS: cross-tenant, insider, repudiation, audit chain) actively surfaced.</dd>
<dt>Triggers</dt><dd>Epic kickoff (mandatory); any story introducing new attack surface, changing auth boundaries, or modifying audit chain integrity.</dd>
<dt>Failure mode</dt><dd>Generic STRIDE output that does not engage the engineer's domain knowledge — produces theatre, not evidence.</dd>
</dl>
</div>

## Triage and routing

The first step of the unified loop. The developer types intent in plain language; the method determines the shape of the work before anything else happens.

```mermaid
flowchart TD
    Intent([Intent received]) --> Read[Analyst reads intent<br/>+ pulls gbrain context]
    Read --> Cart{References<br/>existing code?}
    Cart -->|Yes| RunCart[Cartographer survey<br/>to ground triage]
    Cart -->|No| Shape
    RunCart --> Shape{What shape?}

    Shape -->|Single question| QA[Answer flow:<br/>Cartographer-led if<br/>about existing code,<br/>Architect-led if abstract]
    Shape -->|Single decision| DEC[Decision flow:<br/>Architect interview<br/>+ promotion rule]
    Shape -->|Single bug| BUG[Bug flow:<br/>Cartographer locate<br/>→ Test Author<br/>→ tracker story]
    Shape -->|Single story-sized work| STORY[Lightweight refinement:<br/>scope clarification<br/>→ AC → test → tracker]
    Shape -->|Epic-sized work| EPIC[Full refinement:<br/>scope → threat → ADRs<br/>→ design → decompose<br/>→ tests → tracker]
    Shape -->|Goal too big for 1 epic| MULTI[Epic decomposition first:<br/>break goal into epic shapes<br/>→ then per-epic full flow]

    style Intent fill:#C84B31,color:#fff
    style Shape fill:#fff4e0
    style EPIC fill:#e0f0f8
    style MULTI fill:#e0f0f8
```

<div class="diagram-caption">Triage — how the method decides what depth to run at</div>

### What the triage analyst considers

- **Verbs and nouns in the intent.** "fix" → likely a bug. "add", "implement", "build" → likely a story or epic. "should", "evaluate", "decide" → decision. "how does" → walkthrough. "rebuild", "redesign at scale" → multi-epic.
- **Scope words.** "the platform", "the new build", "from scratch" suggest multi-epic. "the bulk export endpoint" suggests a single epic. "the wallet linkage bug" suggests a single story.
- **Implications surfaced by Cartographer.** If a quick survey reveals the intent touches many modules, that biases toward bigger sizing.
- **Past plans from gbrain.** If a similar intent has come up before and produced an epic, this one probably will too.
- **Compliance triggers.** If the intent touches Confidential/Restricted data, auth boundaries, or audit chain, the triage step pre-loads the Threat Modeller and Privacy Lens requirements.

The triage step is **always interview-led**. If the AI is uncertain about the shape, it asks the human. *"This sounds like it could be a single epic or three — do you want me to scope it as one body of work and decompose, or should we split it up front?"*

The triage decision is **explicit and visible** — the human sees what the method concluded and can override before the loop continues.

## Recursive decomposition

After triage, the loop applies recursive decomposition. The shape of decomposition adapts to size, but the test for "are we done?" is uniform: **every leaf must pass DoR**.

```mermaid
flowchart TB
    Unit([Unit of work])
    Unit --> Check{Passes<br/>DoR?}

    Check -->|Yes| Leaf[Promote to tracker<br/>+ record in tree]
    Check -->|No, too big| Split[Decomposer splits<br/>into smaller units]
    Check -->|No, unclear scope| Scope[Analyst clarifies via<br/>interview with human]
    Check -->|No, undecided architecture| Decide[Architect interview<br/>→ ADR draft]
    Check -->|No, missing existing-code context| Read[Cartographer reads<br/>relevant code]
    Check -->|No, security-sensitive| TM[Threat Modeller<br/>session]
    Check -->|No, no failing test| Test[Test Author writes<br/>failing test]

    Split --> Unit
    Scope --> Unit
    Decide --> Unit
    Read --> Unit
    TM --> Unit
    Test --> Unit

    Leaf --> Done([Leaf complete])

    style Unit fill:#fff4e0
    style Check fill:#f4e8f4
    style Done fill:#e0f0f8
```

<div class="diagram-caption">Recursive decomposition — every non-leaf node loops back through DoR</div>

### Multi-epic decomposition

When triage decides a goal is too big for a single epic, the loop runs one additional layer: it decomposes the goal into epic-shaped units first, then runs the full per-epic flow.

```mermaid
flowchart TB
    Goal([Goal — too big for one epic])
    Goal --> EpicAnalyst[Analyst interview to scope<br/>and propose epic breakdown]
    EpicAnalyst --> Review{Human approves<br/>epic shape?}
    Review -->|Adjust| EpicAnalyst
    Review -->|Yes| Epictracker[Create epic placeholders<br/>in tracker]
    Epictracker --> PerEpic{For each<br/>epic shape}
    PerEpic --> FullFlow[Full per-epic refinement:<br/>scope → threat → ADRs<br/>→ design → decompose<br/>→ tests → stories]
    FullFlow --> PerEpic
    PerEpic -->|All epics refined| Complete([Multi-epic plan complete])

    style Goal fill:#C84B31,color:#fff
    style Review fill:#fff4e0
    style FullFlow fill:#e0f0f8
    style Complete fill:#e0f0f8
```

<div class="diagram-caption">Multi-epic decomposition — adds one outer loop before the per-epic flow</div>

The per-epic flow is identical to the single-epic case. Multi-epic is just an outer loop that runs the full flow N times, with shared context (gbrain memory) so each epic's threat model and ADRs can reference the others.

## Skills as internal capabilities

Skills are the method's internal patterns. They exist as named compositions of roles × modes, but they are **not the primary user surface**. The developer describes intent; the method decides which skill (or skills) to invoke.

Power users who want explicit control can still invoke them directly.

| Skill | Internal role composition | Triggered by triage when |
|---|---|---|
| `/plan` | Full panel | Intent triages to epic or multi-epic |
| `/adr` | Architect (interview + draft) | Intent triages to a durable decision with alternatives |
| `/decide` | Architect (interview) | Intent triages to a discussion-mode decision |
| `/spike` | Cartographer + Architect | Intent triages to a technical investigation |
| `/threat-model` | Threat Modeller | Intent triages to security-sensitive work, or epic kickoff |
| `/explain` | Cartographer | Intent triages to a walkthrough of existing code |
| `/review` | Critic | Intent references a PR, file, or design to review |
| `/onboard` | Cartographer + Architect | New dev orientation requested |
| `/handoff` | None (meta-skill) | End of session or "pick up where I left off" |

### Cross-skill promotion

Even when a skill starts in one mode, the conversation can produce artifacts that belong to another skill's output type. The promotion rules decide.

```mermaid
flowchart LR
    A["/decide opens"] --> B[Architect interview]
    B --> C{Promotion rule:<br/>2+ real alternatives?<br/>Surprises future contributor?}
    C -->|Both yes| ADR[Promote to canonical ADR<br/>announce to human]
    C -->|Either no| Informal[Record as informal<br/>decision in session log]

    style A fill:#C84B31,color:#fff
    style C fill:#fff4e0
    style ADR fill:#e0f0f8
```

<div class="diagram-caption">Promotion rules decide what gets created — skills are entry points, not gatekeepers</div>

The same pattern applies for threat model promotion, tracker story promotion, privacy impact promotion, and compliance tag promotion. All rules are in `.method/promotion-rules.md` — transparent and tunable.

## Definition of Ready — the gate

A leaf story cannot exit refinement until it passes every criterion:

1. **Story in agreed format** ("As a [user], I want [action], so that [benefit]" — or team-agreed equivalent)
2. **Acceptance criteria are testable, single-statement** — "given X, when Y, then Z" form
3. **Estimated at ≤3 points** — anything larger must be split
4. **Dependencies identified** — by story ID or "no dependencies" tag
5. **Linked to architectural context** — an ADR ID or "no architectural impact" tag
6. **Stop conditions listed** — the standard block plus any task-specific
7. **Scope crosses ≤1 architectural boundary**
8. **A failing test exists** — written by Test Author, compiles, fails on assertion

A story that cannot be made to meet these isn't ready. It either gets split further, gets an ADR drafted, or becomes an open question.

## Stop conditions

Standard block, included in every leaf story's enriched prompt:

- This task requires a decision not covered by linked ADRs
- Completing this would require modifying AGENTS.md, an ADR, or a skill
- Three or more attempts at the same problem without progress
- Acceptance criteria are ambiguous or contradictory
- A declared dependency is complete but its output is missing or incorrect
- A security or performance concern not addressed in the constitution has been discovered
- Completing this task would require expanding the declared scope
- No test data generator exists for this concept
- AC cannot be expressed as a single testable assertion
- Required test level (unit / integration / e2e) is unclear

When a Builder hits any of these, the task pauses and the loop routes the upstream change through governance via `/off-course` (build-phase tooling — out of scope for this document).

## ADRs and the promotion rule

Not every decision becomes a canonical ADR. The promotion rule:

<div class="callout">
<div class="callout-label">ADR promotion rule</div>
<p>A decision becomes a canonical ADR if (a) it would <em>surprise a future contributor</em> and (b) alternatives were <em>genuinely considered</em>.</p>
</div>

```mermaid
flowchart TD
    Conv[Conversation reaches a decision] --> A{Would it surprise<br/>a future contributor?}
    A -->|Yes| B{Were alternatives<br/>genuinely considered?}
    A -->|No| Informal["Record as informal<br/>decision in session log"]
    B -->|Yes| Announce["Announce to human:<br/>'I'd promote this to an ADR — OK?'"]
    B -->|No| Informal
    Announce -->|Human approves| Draft[Architect drafts ADR<br/>using project's ADR template]
    Announce -->|Human declines| Informal
    Draft --> Review{Human approves<br/>draft?}
    Review -->|Yes| Land[Land in docs/adr/<br/>+ store in gbrain]
    Review -->|No| Edit[Edit per human feedback]
    Edit --> Review

    style Conv fill:#C84B31,color:#fff
    style A fill:#fff4e0
    style B fill:#fff4e0
    style Land fill:#e0f0f8
```

<div class="diagram-caption">ADR promotion — never silent</div>

Both conditions must hold. "We picked Postgres because of course we picked Postgres" fails (b). "We changed the variable name from `userId` to `user_id`" fails (a).

The Architect role tracks the rule continuously and surfaces candidates as the conversation proceeds. Drafts inline. Human accepts/edits/rejects. Accepted → `/docs/adr/` + gbrain. Rejected → informal note in the chat log.

ADRs are append-only — superseded, never edited.

## Testing strategy

Bottom-heavy pyramid, grounded in the project's domain-modelling and architecture ADRs (most projects benefit from a repository-pattern style separation).

```mermaid
flowchart TB
    E2E["End-to-end<br/>(few — critical custody flows)"]
    INT["Integration with testcontainers<br/>(more — real Postgres, River, MinIO, Ory)"]
    PROP["Property-based tests<br/>(value object invariants — pgregory.net/rapid)"]
    UNIT["Domain unit tests<br/>(most — pure Go, no infrastructure)"]

    E2E --- INT
    INT --- PROP
    PROP --- UNIT

    style UNIT fill:#e0f0f8
    style PROP fill:#fff4e0
    style INT fill:#f4e8f4
    style E2E fill:#e8f4e8
```

<div class="diagram-caption">The testing pyramid — bottom-heavy by design</div>

### Named test categories

- **Tenant isolation tests** — every endpoint touching tenant data has a "wrong-tenant returns no rows" adversarial test
- **Hash chain integrity tests** — any audit-touching story
- **Audit-event-emitted tests** — every mutation tests the audit event emitted in the *same transaction*
- **Compliance-tagged tests** — each test optionally carries SOC 2 / ISO 27001 control evidence tags

### TDD via the Test Author / Builder split

```mermaid
sequenceDiagram
    participant H as Human
    participant TA as Test Author
    participant V as Verifier
    participant C as Critic
    participant B as Builder

    H->>TA: story + AC + design + ADRs (no implementation)
    TA->>TA: write failing test
    TA->>V: test file
    V->>V: run test — confirm fails on assertion
    V-->>H: test ready (or block if fails on compile)
    H->>C: review test
    C->>C: test-critique pass
    C-->>H: findings or pass
    H->>B: green-light implementation
    B->>B: write minimum code to pass
    B->>V: PR
    V->>V: run test — confirm passes + race detector clean
    V->>C: code-critique pass
    C-->>H: findings or pass
    H->>H: merge
```

<div class="diagram-caption">TDD enforced by separate agent contexts</div>

The hard split is what makes TDD work with agents. The discipline isn't a process the team has to follow — it's enforced by the agents' separate contexts.

## Compliance baked in

Three practices, each tied to a role that ensures genuine engagement (not theatre):

```mermaid
flowchart LR
    subgraph Practices["Compliance practices"]
        TM[Threat Modelling]
        PI[Privacy Impact]
        RC[Risk Capture]
    end

    subgraph Enforcement["Enforced by"]
        TMRole[Threat Modeller<br/>interview mode]
        AnRole[Analyst<br/>privacy lens]
        ArRole[Architect<br/>alongside ADR]
    end

    subgraph Evidence["Evidence produced"]
        TMA[Threat model<br/>transcript + structured doc<br/>signed off by human]
        PIA[Privacy assessment<br/>per story]
        RCA[Risk register<br/>in ADR]
    end

    TM --> TMRole --> TMA
    PI --> AnRole --> PIA
    RC --> ArRole --> RCA

    TMA --> Manifest[(Compliance manifest<br/>per epic)]
    PIA --> Manifest
    RCA --> Manifest

    Manifest --> Audit[SOC 2 / ISO 27001<br/>evidence pack]

    style Practices fill:#f4e8f4
    style Manifest fill:#e0f0f8
    style Audit fill:#C84B31,color:#fff
```

<div class="diagram-caption">Compliance baked in — engagement produces evidence as a side effect</div>

| Practice | Triggered when | Role |
|---|---|---|
| **Threat modelling** | Every epic kickoff | Threat Modeller (interview) |
| **Privacy impact** | Any node touching Confidential / Restricted data | Analyst (privacy lens) |
| **Risk capture** | Any architectural decision with material risk | Architect (alongside ADR) |

### The compliance manifest

Every completed epic plan ships with a manifest that falls out of the refinement system automatically:

```yaml
epic: cross-tenant-bulk-export
threat_model:
  performed_at: 2026-06-08T14:23Z
  drafted_by: threat-modeller-agent
  reviewed_by: engineer@yourorg
  transcript: plans/cross-tenant-bulk-export/threat-model.md
  evidence_quality: human-engaged
privacy_impacts:
  - story: STORY-142
    classification: Confidential
    reviewed_by: engineer@yourorg
adrs_produced: [ADR-021, ADR-022]
critic_findings_addressed: 3
test_coverage:
  unit: 47
  integration: 12
  property: 4
  e2e: 2
  evidenced_controls:
    soc2: [CC6.1, CC6.6, CC7.2]
    iso27001: [A.5.15, A.5.34, A.8.3]
```

**Tag priority** (June 2026 posture): SOC 2 Trust Services Criteria and ISO 27001 Annex A controls primary. NIST 800-53 tags optional, added when a FedRAMP engagement is actually triggered.

## Team pattern — convene, drive, disperse

The refinement system is inherently 1:1 — one agent talking to one human. Team alignment happens around it.

```mermaid
flowchart LR
    subgraph Convene["CONVENE (optional, ~60 min)"]
        C1[All PEs + CTPO in one room]
        C2[Drive top 1-3 layers of tree together]
        C3[Lock in scope, threat model, big ADRs]
    end

    subgraph Drive["DRIVE (solo, async)"]
        D1[Initiative Lead<br/>takes session to completion]
        D2[Agent runs in their chat]
        D3[tracker updates in real-time]
    end

    subgraph Disperse["DISPERSE (PR-shaped review)"]
        DI1[Plan-as-PR<br/>plans/epic/ directory]
        DI2[Other PEs review tree, ADRs, tests]
        DI3[Driver runs /plan resume per affected branch]
        DI4[Final plan merged]
    end

    Convene --> Drive
    Drive --> Disperse

    style Convene fill:#f4e8f4
    style Drive fill:#fff4e0
    style Disperse fill:#e0f0f8
```

<div class="diagram-caption">Team pattern — async by default, sync only when stakes warrant</div>

**Single driver by default. Convene synchronously when stakes warrant. Async review always.**

- **Convene** is for high-stakes initiatives only — rebuild kickoff, major refactor, new product surface. Skip for bug fixes, small features.
- **Drive** — Initiative Lead solo. tracker updates in real-time so the rest of the team can observe.
- **Disperse** — plan lands as a git artifact. PR-style review. Driver runs `/plan resume <node>` for affected branches.

## Memory via gbrain

gbrain is the persistence layer, accessed via MCP. Three rings:

```mermaid
flowchart TB
    subgraph Org["ORG RING (broadest)"]
        O1[Patterns across projects]
        O2[What worked, what didn't]
        O3[Prompt templates that proved out]
    end

    subgraph Project["PROJECT RING (per-project)"]
        P1[Canonical ADRs]
        P2[The constitution — AGENTS.md]
        P3[Past plans on this project]
        P4[Accepted threat models]
    end

    subgraph Session["SESSION RING (in-flight)"]
        S1[Current plan in progress]
        S2[Open questions]
        S3[Recent decisions]
        S4[Live chat log]
    end

    Org -.referenced by.-> Project
    Project -.referenced by.-> Session

    Session --> Loop[Unified loop<br/>queries on need]
    Project --> Loop
    Org --> Loop

    style Loop fill:#C84B31,color:#fff
    style Org fill:#f4e8f4
    style Project fill:#fff4e0
    style Session fill:#e0f0f8
```

<div class="diagram-caption">Memory rings — outer rings inform inner-ring decisions</div>

The coordinator pulls outer-ring context into inner-ring decisions:

> "This decomposition looks structurally like the auth-migration plan you did 4 months ago — want me to factor that in?"

At session start: coordinator queries gbrain for relevant past plans, ADRs, patterns. During the loop: agents query as needed. At session end: plan + ADRs + lessons-learned written back to gbrain.

### gbrain is scoped per project — never globally shared

<div class="callout">
<div class="callout-label">Default scoping</div>
<p>gbrain is <em>per-project</em>. The brain that holds Project A's memory does not hold Project B's memory. Even within the same developer's local machine, each project the Method is installed into gets its own gbrain instance.</p>
</div>

When you work on multiple projects (especially for different clients), sharing a single gbrain across them creates real problems:

- **Confidentiality.** Client A's threat models and architecture decisions show up as "similar past patterns" while you're refining Client B's work.
- **Pattern confusion.** Past plans from unrelated projects surface as if they're relevant, and they aren't.
- **Audit trail mixing.** Compliance evidence (which is per-project) becomes harder to extract cleanly.

The Method's install (`AGENT_INSTALL.md` Step 6a) sets gbrain up scoped to the current project by default. Two valid backends:

| Backend | Use when |
|---|---|
| **Local PGLite** | Solo work or single-machine development. Zero infrastructure. Isolated by default. |
| **Dedicated Supabase project** | Multi-dev team on this project. Brain is shared *among that project's team* — never across projects. |

The `.gbrain-source` pin file at the repo root is what scopes gbrain queries to this worktree. The global `~/.gbrain/config.json` may point at a different brain for a different project; gbrain reads the worktree-pinned config when you're in this directory.

**Anti-pattern:** pointing two different projects' `.gbrain-source` files at the same Supabase URL. Don't do this even if they're for the same employer — the org ring will leak patterns across the projects.

## The three-tier context model

Agents need information to make decisions. *Where* information lives shapes how the method behaves. The method uses three distinct tiers.

```mermaid
flowchart TB
    subgraph Always["TIER 1 — Always loaded"]
        A1[AGENTS.md constitution]
        A2[Triggered agent definition]
        A3[Triggered skill definition]
    end

    subgraph Structured["TIER 2 — Structured references"]
        S1[docs/schema.sql — DDL]
        S2[docs/openapi.yaml — API contracts]
        S3[docs/module-map.md — dependency graph]
        S4[docs/domain-types.md — value object registry]
        S5[docs/adr/INDEX.md — ADR titles + 1-line summaries]
    end

    subgraph OnDemand["TIER 3 — On-demand"]
        O1[Application code via Cartographer + file:line citations]
        O2[Full ADR text when referenced]
        O3[Specific test files when needed]
        O4[gbrain past-plan queries]
        O5[tracker story + AC details at dispatch time]
    end

    Loop[Unified loop] --> Always
    Loop --> Structured
    Loop -.queries.-> OnDemand

    style Loop fill:#C84B31,color:#fff
    style Always fill:#e0f0f8
    style Structured fill:#fff4e0
    style OnDemand fill:#f4e8f4
```

<div class="diagram-caption">Three tiers of context — different load patterns, different update cadences</div>

### Tier 1 — Always loaded

The baseline every agent sees from session start, regardless of task:

- `AGENTS.md` — the project's constitution
- The triggered agent's system prompt (e.g., `.claude/agents/architect.md`)
- The triggered skill's instructions (e.g., `.claude/commands/plan.md`)

Small (~10–20K tokens). Changes only when the constitution or a role definition is intentionally updated. Loaded mechanically.

### Tier 2 — Structured references

Project-specific files that **constrain** decisions without describing implementation detail. Loaded at session start when present.

| File | Why it's high-leverage |
|---|---|
| `docs/schema.sql` | The data shape constrains every domain decision. Designer can't accidentally specify a column that conflicts with reality. Builder writes code with accurate types. Test Author writes fixtures that match. Architect spots decisions that contradict the schema before drafting an ADR. |
| `docs/openapi.yaml` | Existing API contracts constrain every endpoint decision. The Designer adds endpoints consistent with current patterns; the Critic spots inconsistencies. |
| `docs/module-map.md` | The dependency graph constrains every cross-module decision. The Decomposer doesn't propose breaking module boundaries; the Critic catches violations. |
| `docs/domain-types.md` | The registry of value objects + domain primitives constrains every domain decision. New types added cleanly; existing types referenced precisely. |
| `docs/adr/INDEX.md` | An index of accepted decisions (titles + 1-line summaries) lets agents know which decisions exist without loading all of them. Full ADR text is loaded on-demand when referenced. |

Each file is small (~1–5K tokens). The whole structured reference layer is bounded (~20–50K tokens). Changes infrequently — typically auto-regenerated via CI on relevant code changes (e.g., `docs/schema.sql` regenerated after every Atlas migration).

**These files are project-specific.** The method *reads them when present*; the project *generates and maintains them*. If a file doesn't exist in a project, agents skip it without failing.

### Tier 3 — On-demand

Information loaded only when a specific need arises:

- **Application code** — read by the Cartographer with mandatory `file:line` citations. Application code is large and changes constantly; pre-loading it guarantees staleness and burns context. On-demand reads keep agents honest.
- **Full ADR text** — loaded when an ADR is referenced in conversation. The INDEX (Tier 2) tells agents which ADRs exist; the full text is loaded only when the conversation actually needs the rationale.
- **Specific test files** — read by Test Author or Critic when working on adjacent functionality.
- **gbrain queries** — past plans, similar threat models, prior decisions pulled in when the orchestrator detects a pattern match.
- **tracker story details** — fetched at dispatch time, not at session start.

### Why this matters

Two consequences:

**Schema-grounded refinement from the first turn.** Without Tier 2, the Cartographer has to grep the codebase every time someone asks "what does X look like in our data model?" With Tier 2, every agent sees the schema from session start. The Designer's first draft is grounded in reality; the Architect spots conflicts before drafting an ADR.

**Citation discipline preserved for application code.** Application code stays in Tier 3 specifically because the Cartographer's `file:line` citation pattern is more honest than "I remember reading this." Pre-loading code would erode that discipline; structured references in Tier 2 don't, because they're declarative not interpretive.

### Keeping structured references fresh

Each tier-2 file has an ideal refresh trigger:

| File | Refreshed when |
|---|---|
| `docs/schema.sql` | After every Atlas migration (or equivalent migration tool runs) |
| `docs/openapi.yaml` | On every API change (generated from code, or hand-maintained) |
| `docs/module-map.md` | On every cross-module dependency change (CI script) |
| `docs/domain-types.md` | On every value object / domain primitive change (CI script) |
| `docs/adr/INDEX.md` | On every ADR addition or supersession (auto-regenerated by `/adr` skill) |

CI hooks make this mechanical. A drift between code state and Tier 2 files is the project's bug to fix, not the method's responsibility.

## Failure modes and mitigations

The system will produce wrong things. Design for it.

### Known failure modes

- **AI confidence on wrong things.** Cartographer mis-reads code; Architect proposes a decision contradicting an existing ADR; Decomposer misses an obvious dependency; Critic dismisses a real issue.
- **Hallucinated alternatives.** Architect cites "option C" that doesn't really exist.
- **Consensus illusions.** Multiple agents trained on the same patterns agreeing on the same wrong thing.
- **Drift.** ADRs accepted, code drifts, no one notices.
- **Vacuous tests.** Test Author writes tests that compile and pass but don't exercise the behaviour they're meant to.
- **Interview drift.** Threat Modeller produces generic STRIDE output that doesn't engage the engineer's domain knowledge.

### Baked-in mitigations

- **Citation discipline.** Every claim about existing code carries a `file:line` reference. Every ADR reference carries the ADR ID. The orchestrator rejects unsourced claims.
- **Critic is adversarial by default**, not consensus. Two passes (test critique + code critique).
- **Verifier confirms tests fail for the right reason** before Builder is invoked.
- **Hash artifacts.** Every ADR, tree state, test file gets a content hash. Drift detection becomes mechanical.
- **Periodic constitution check.** `/audit-constitution` (v2) — Cartographer-led, flags ADRs whose stated invariants don't hold in code.
- **Trigger profiles are transparent.** Humans can read the conditions and tune them.
- **Anti-theatre check.** Threat Modeller refuses to produce a canonical threat model from a disengaged interview.

## Storage and artifacts

```
plans/{epic-slug}/
  tree.yaml            ← structured tree state, diffable in PR review
  conversation.md      ← full raw chat log (audit trail, not the artifact)
  scope.md             ← cleaned + signed scope brief
  threat-model.md      ← cleaned + signed threat model
  design.md            ← design doc from Designer
  decisions.md         ← informal decisions captured during the session
  tests/               ← failing test specs from Test Author
  manifest.yaml        ← compliance evidence pack

.method/handoffs/
  LATEST.md            ← pointer to the most recent handoff
  {ISO-timestamp}-{slug}.md  ← per-handoff snapshots, accumulate over time

docs/adr/
  ADR-XXX.md           ← promoted, accepted ADRs

AGENTS.md              ← the constitution (root)

.claude/
  agents/              ← role agent definitions
  commands/            ← skill definitions (internal capabilities)

.method/
  triggers.md          ← role invocation conditions
  promotion-rules.md   ← canonical artifact promotion rules

gbrain/
  (session / project / org rings, accessed via MCP)
```

```mermaid
flowchart TB
    subgraph tracker["tracker (operational state)"]
        L1[Epics]
        L2[Stories with AC + test notes]
        L3[Estimates]
        L4[Dependencies]
        L5[Assignments]
    end

    subgraph Git["Git (audit trail)"]
        G1[plans/.../tree.yaml]
        G2[plans/.../conversation.md raw]
        G3[plans/.../threat-model.md cleaned + signed]
        G4[plans/.../design.md]
        G5[plans/.../manifest.yaml]
        G6[docs/adr/ADR-XXX.md]
    end

    subgraph gbrain["gbrain (memory)"]
        GB1[Session ring]
        GB2[Project ring]
        GB3[Org ring]
    end

    Loop[Unified loop] --> tracker
    Loop --> Git
    Loop --> gbrain

    tracker -.bidirectional link.-> Git
    Git -.refines into.-> tracker

    style Loop fill:#C84B31,color:#fff
    style tracker fill:#e0f0f8
    style Git fill:#fff4e0
    style gbrain fill:#f4e8f4
```

<div class="diagram-caption">tracker holds operational state. Git holds the audit trail. gbrain holds memory.</div>

Bidirectional traceability: every tracker story has a link to its git plan artifact. Every tree.yaml leaf records its tracker story ID.

## The build phase

The method ships with both halves of the SDLC: refinement (turning intent into DoR-ready stories) and build (turning DoR-ready stories into merged PRs). The two halves share the role panel; the build loop is `/build`, with `/off-course` as the bridge back to refinement when a stop condition fires.

```mermaid
flowchart TB
    subgraph Refinement["Refinement loop"]
        R1[Type intent] --> R2[Triage]
        R2 --> R3[Recursive decomposition]
        R3 --> R4[tracker stories ready]
    end

    subgraph Build["Build loop"]
        B1[Story moves to In Progress]
        B1 --> B2[Builder in worktree]
        B2 --> B3[Verifier — tests + race]
        B3 --> B4[Critic — code critique]
        B4 --> B5[PR opens]
        B5 --> B6[Human review + merge]
    end

    R4 --> B1
    B2 -.stop condition.-> OC[/off-course bridge/]
    OC -.upstream change needed.-> R2
    R2 -.routes to amendment.-> Amend["Architect drafts ADR amendment<br/>OR Analyst clarifies AC<br/>OR Threat Modeller supplements"]
    Amend -.merged.-> Unblock[Story unblocks]
    Unblock --> B1

    style OC fill:#C84B31,color:#fff
    style Refinement fill:#f4e8f4
    style Build fill:#e0f0f8
```

### The build loop (`/build`)

When a story passes Definition of Ready during refinement and moves to `Ready` in tracker, `/build` picks it up. The flow:

```
Story (Ready) → worktree → Builder reads test + AC + linked ADRs + AGENTS.md
            → Builder writes minimum code to pass test
            → Verifier runs tests + race detector + broader suite
            → Critic code-critique pass
            → If clean: PR opens
            → tracker: In Review → human merges → Done
            → Downstream stories unblock
```

The Builder runs in **doing** mode — no human signoff in the moment. The human's signoff is at PR merge time.

### The off-course bridge

If Builder hits any stop condition mid-build, it does **not** try to work around. The build pauses; `/off-course` is invoked with the diagnostic.

`/off-course` diagnoses what kind of upstream change is needed and routes to the appropriate refinement role:

| Diagnosis | Refinement role | Upstream artifact |
|---|---|---|
| ADR gap or contradiction | Architect (interview) | New or superseding ADR |
| AC ambiguity | Analyst + Test Author | Updated AC + revised failing test |
| Threat model gap | Threat Modeller | Supplementary threat model |
| Missing existing-code context | Cartographer | Findings doc |
| Scope expansion needed | Analyst + Decomposer | Rescoped + split |
| Missing test data generator | Test Author | Generator code |
| Architectural boundary crossed | Decomposer | Story split |

Every off-course event produces a governed PR against the upstream artifact. Once merged, the original tracker story moves from `Blocked` back to `Ready`. The off-course event is recorded in the epic's manifest as audit-trail evidence — showing the team surfaced and routed the upstream issue rather than papering over it.

The off-course bridge is what makes the two halves of the SDLC live side-by-side rather than as a one-way pipeline. Build doesn't merely consume refinement output; build can require refinement to evolve, and the bridge handles that loop explicitly.

<a id="configuration"></a>
## Configuration

The Method's structured settings live in **`method.config.yaml`** at the project root. Constitution (prose, conventions, principles) lives in `AGENTS.md`. Credentials and MCP server registration live in `~/.claude/mcp.json` (per-user, never in git).

The three files have distinct responsibilities:

| File | Audience | What it holds | Committed to git? |
|---|---|---|---|
| **`method.config.yaml`** | Tooling + agents | Structured settings (tracker, story sizing, compliance, testing) | Yes — shared per project |
| **`AGENTS.md`** | Humans + agents | Prose constitution (principles, conventions, stack table) | Yes — shared per project |
| **`~/.claude/mcp.json`** | Claude Code | MCP server URLs, API tokens, auth | No — per-user, never git |

### `method.config.yaml` schema

Sensible defaults are embedded; any missing field falls through. A minimal config that uses no tracker is two lines:

```yaml
method_version: 1.2.0
tracker:
  type: none
```

Full schema:

```yaml
method_version: 1.2.0

# Operational tracker
tracker:
  type: linear            # linear | jira | github-issues | none
  mcp_server: linear      # MCP server name in ~/.claude/mcp.json

  # Tracker-specific blocks — only the block matching `type` is read
  linear:
    team_id: TEAM_ABC123

  jira:
    site: company.atlassian.net
    project_key: PROJ
    epic_issue_type: Epic
    story_issue_type: Story
    points_custom_field: customfield_10016

  github_issues:
    owner: your-org
    repo: your-repo
    epic_label: epic
    story_label: story

# Story sizing
story_points:
  scale: fibonacci        # fibonacci | t-shirt | custom
  ceiling: 3              # DoR rejects stories above this

# Story format
story_format: user-story  # user-story | technical | freeform

# Compliance (for test tagging — empty list = no tagging)
compliance:
  frameworks: []          # e.g. [soc2, iso27001, hipaa, fedramp]

# Testing
testing:
  race_detector_required: true
  property_tests_for_value_objects: true
```

### Defaults

| Setting | Default | When it kicks in |
|---|---|---|
| `tracker.type` | `none` | No remote tracker; tree.yaml is the operational state |
| `tracker.mcp_server` | `null` | Skip tracker MCP invocations |
| `story_points.scale` | `fibonacci` | Decomposer uses 1, 2, 3, 5, 8, 13 |
| `story_points.ceiling` | `3` | DoR rejects anything above |
| `story_format` | `user-story` | Decomposer drafts "As a..., I want..., so that..." |
| `compliance.frameworks` | `[]` | No test tagging |
| `testing.race_detector_required` | `true` | Verifier requires race-detector pass |
| `testing.property_tests_for_value_objects` | `true` | Verifier requires property tests on value objects |

If `method.config.yaml` is missing entirely, agents proceed with all defaults and skip any tracker MCP invocations.

### How agents use it

When an agent in a skill needs to invoke a tracker (e.g., `/plan` pushing a story to Linear):

1. Read `method.config.yaml`
2. See `tracker.type: linear`, `tracker.mcp_server: linear`
3. Pull the `tracker.linear` block for the team ID
4. Invoke the `linear` MCP server with the team ID + story payload

Skill prompts stay generic — *"push the story to the configured tracker"* — and agents translate to the tracker's native vocabulary when calling MCP.

### How tooling uses it

`install.sh`, `scripts/sync-*.sh`, and any future migration tools read `method.config.yaml` for project-specific settings. The config is structured YAML so any standard parser can read it. There's no validation layer yet; structural correctness is the user's responsibility.

## Distribution and versioning

The method ships as a set of markdown files (agent definitions, skill definitions, trigger profiles, templates) that install into a project's directory. Claude Code auto-discovers them; no plugin system or global install is needed.

### Install path

```bash
curl -sSL https://raw.githubusercontent.com/nlawstudio/ai-refinement-method/main/install.sh | sh
```

The script clones the method repo and copies the framework files into the target directory. Existing files (`AGENTS.md`, `docs/adr/`, live `plans/{epic}/` directories) are preserved.

See [INSTALL.md](INSTALL.md) for full setup including gbrain MCP and tracker MCP wiring.

### What ships

| Category | What |
|---|---|
| Role definitions | Ten agent files in `.claude/agents/` |
| Skill definitions | Ten skill files in `.claude/commands/` (refinement + build) |
| Trigger profiles | `.method/triggers.md` |
| Promotion rules | `.method/promotion-rules.md` |
| Templates | `plans/_templates/tree.yaml.example`, `plans/_templates/manifest.yaml.example` |
| Constitution skeleton | `AGENTS.template.md` (becomes `AGENTS.md` in the target if not already present) |
| Documentation | `METHOD.md`, `TUTORIAL.md`, `INSTALL.md` |

### What does NOT ship

| Category | Why not |
|---|---|
| Project-specific ADRs | They live in the project repo's `docs/adr/`, not in the method |
| Live `plans/{epic}/` directories | These accumulate as the method is used per-project |
| The method's own README and CHANGELOG | Those are for the method repo, not the target project |

### Versioning

Versions follow SemVer in `VERSION`. Major releases when the role panel or core loop changes; minor releases for new skills, new trigger conditions, or restructures; patch releases for prompt-tuning fixes.

| Version | Shape |
|---|---|
| **0.1.0** | Initial refinement-phase scaffold. Original validation project bundled. |
| **0.2.0** | Packaged tool. Refinement + build phase + off-course bridge. Validation instance separated; Method is project-agnostic. |
| **1.0.0** | Renamed from Harness to Method to disambiguate from agent-runtime "harness" vocabulary. |
| **1.1.0** | Tracker-agnostic (Linear / Jira / GitHub Issues / none). |
| **1.2.0** | Structured `method.config.yaml` config file; credentials separated to `~/.claude/mcp.json`. |
| **1.2.1** | Tutorial rewritten as a 15-minute quickstart. |
| 1.3.0+ | TBD as the Method is used and tuned |

`CHANGELOG.md` tracks what changed at each version. Git tags mark releases; GitHub releases include release notes.

### Upgrading

To upgrade an existing installation:

```bash
curl -sSL https://raw.githubusercontent.com/nlawstudio/ai-refinement-method/main/install.sh | sh
```

The script preserves your `AGENTS.md` and `docs/adr/`. It only overwrites the framework files. Check `CHANGELOG.md` before upgrading to see what changed.

## What's out of scope

Explicitly not addressed in this framework:

- **Sprint cadence.** Cycle structure, build-phase weekly rhythm, recovery time. Team decision.
- **Build-phase tooling beyond what supports refinement.** Builder is scoped here; CI integration, deployment automation, automated dispatch are follow-ups.
- **Hiring, business strategy, and operating model beyond the refinement system.**
- **The `/off-course` skill** — referenced in stop conditions but its implementation is build-phase scope.

## Open questions

These remain unresolved and are the agenda for the team's working sessions:

1. **Story format and point scale.** Team's current scale (Fibonacci, t-shirt, custom) and story format need to be locked before the Decomposer prompt is finalised.
2. **Definition of Ready today.** Does the team have a current DoR? If so, reconcile with the canonical version above.
3. **First epic for the method.** Probably the rebuild's first concrete piece (set up new repo with locked stack).
4. **Team review of this document.** The three other PEs haven't seen the design. The doing/deciding split, the role panel, the interview pattern all need their buy-in before going further.
5. **First real use.** Pick a small concrete task from the rebuild and run the loop end-to-end. Tune from what's learned.
6. **tracker MCP wiring.** Needs API key and workspace configuration before `/plan` can promote stories.

## Glossary

| Term | Definition |
|---|---|
| **ADR** | Architecture Decision Record. Append-only, immutable once accepted. |
| **AGENTS.md** | The constitution. Linux Foundation open standard for agent project instructions. |
| **Analyst** | Role: scope discovery (interviewing) and privacy lens (drafting). |
| **Architect** | Role: surfaces and resolves decisions; drafts ADRs. |
| **Builder** | Role: implements stories from failing tests. |
| **Cartographer** | Role: reads existing code, produces cited findings. |
| **Constitution** | The set of shared decisions encoded in AGENTS.md + ADRs. |
| **Critic** | Role: adversarial review on tests (first pass) and code (second pass). |
| **Decomposer** | Role: breaks design into DoR-ready story tree. |
| **Designer** | Role: produces design docs from brief + ADRs + Cartographer's map. |
| **DoR** | Definition of Ready. The eight-point checklist a leaf story must pass to exit refinement. |
| **Doing** | Agent mode: AI acts autonomously, no human signoff in the moment. |
| **Drafting** | Agent mode: AI generates a draft, human signs off. |
| **Epic** | A multi-week scoped outcome with a single owning metric. |
| **gbrain** | The memory layer. Three rings: session, project, org. Accessed via MCP. |
| **Initiative Lead** | The PE leading the current epic. Rotates per epic. |
| **Interviewing** | Agent mode: AI asks, human answers, AI cleans/structures/augments, human signs off. |
| **Loop** | The unified refinement loop — same shape, depth adapts to input. |
| **Mode** | One of doing / drafting / interviewing. |
| **Multi-epic decomposition** | Pre-step that runs when a goal is too big for a single epic. |
| **Off-course** | Skill (build-phase scope) routing deviations through governance. |
| **Plan-as-PR** | Pattern of treating refinement output as a versioned git artifact reviewed like code. |
| **Promotion rule** | The conditions under which a conversation produces a canonical artifact. |
| **Role** | An agent primitive. Ten exist in this framework. |
| **Skill** | An internal capability composing roles × modes. Not the user-facing surface. |
| **Story** | A leaf work item that meets DoR. Estimated at ≤3 points. |
| **Stop condition** | An explicit trigger that pauses an agent and routes to a human. |
| **Test Author** | Role: writes the failing test from AC, before Builder. Does not see implementation. |
| **Threat Modeller** | Role: drives STRIDE-style threat modelling interview at epic kickoff. |
| **Triage** | The first step of the unified loop — determining input shape and depth. |
| **Trigger profile** | The conditions under which a role gets invoked. Transparent to humans. |
| **Unified loop** | The single primary interaction pattern — triage → recursive decomposition → tracker + git. |
| **Verifier** | Role: DoR check (refinement) and behavioural check (build). |
