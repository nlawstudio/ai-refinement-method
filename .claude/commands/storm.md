---
description: Facilitate an event-storming-style domain discovery session via the Explorer. Maps domain events, commands, actors, policies, and hotspots; proposes bounded contexts; captures ubiquitous language. Use at the front of an epic when the shape of the domain itself is the open question.
---

# /storm

A facilitated event-storming session, run as a conversation. The Explorer maps the domain — what happens, who triggers it, what rules govern it, where it's contested — before anyone decides what to build. The output is a domain map, a set of hotspots, candidate bounded contexts, and an updated ubiquitous-language glossary.

This is the front of refinement. Storm first, then scope, then decide, then design, then decompose.

## Usage

```
/storm <domain or epic area>
```

Examples:

```
/storm the custody transfer lifecycle for seized assets
/storm how bulk export should work end to end
/storm we're rebuilding case management from scratch — map the domain
```

## When to use this vs other skills

| Use this | When |
|---|---|
| `/storm` | The shape of the domain is unclear — you need to find the real events, rules, and boundaries before scoping |
| `/explain` | The question is "how does the *current code* work?" (Cartographer reads what's built) |
| `/plan` | You already understand the domain and want to refine a specific epic into stories |
| `/decide` / `/adr` | You have a specific decision to make, not a domain to map |

If the domain is well understood and you just need stories, skip storming and go straight to `/plan`. Storming is for when the model itself is the open question — greenfield, rebuilds, contested territory, or a team that doesn't yet share a model.

## The flow

1. **Pull context.** The Explorer loads `docs/domain-glossary.md` (if it exists), any past domain maps from gbrain for adjacent territory, and the Cartographer's findings if existing code already encodes part of this domain.

2. **Run the session.** The Explorer facilitates the event-storming conversation — domain events, commands and actors, policies, read models, hotspots, and pivotal events / bounded contexts. It brings, surfaces, and pushes back throughout; it does not transcribe. (See the Explorer agent definition for the full facilitation method.)

3. **Keep the language honest.** Every domain term gets captured in the glossary. Drift — two words for one concept, one word for two — gets caught and resolved in the session, not later.

4. **Surface hotspots.** Every point of contention, uncertainty, or disagreement is named and tagged with what it needs next: an ADR, a threat model, a scoping decision, or a spike.

5. **Propose bounded contexts.** As the map fills in, the Explorer proposes the seams it sees and why, for the human to confirm or move.

6. **Sign-off.** The human approves the domain map and the glossary additions.

## Output

- `plans/{epic}/domain-map.md` — events, commands, policies, read models, hotspots, proposed bounded contexts
- `docs/domain-glossary.md` — updated with every new term (created if it doesn't exist)
- Raw chat preserved in `plans/{epic}/conversation.md`

## How it feeds the rest of refinement

The storm is upstream of everything else:

- **Hotspots** become the Architect's decisions (`/decide`, `/adr`), the Threat Modeller's focus areas, and the Analyst's scoping questions.
- **Bounded contexts** shape the epic structure — `/plan` aligns epics to the seams the storm surfaced.
- **The glossary** flows into every downstream agent as the project's ubiquitous language.
- **The domain map** is the context the Designer builds the data model and contracts from.

## When invoked inside `/plan`

If `/storm` runs while a `/plan` session is active (or `/plan` decides the domain needs mapping first):

- The domain map is saved to the active epic's `plans/{epic}/domain-map.md`
- Hotspots are carried into the plan as nodes needing decisions, threat models, or scoping
- Proposed bounded contexts inform how the epic decomposes

## Quality bar

- The map is in the language of the domain, not technical jargon ("Wallet Linked", not "POST /wallets 200")
- Every hotspot is named, not smoothed over, and tagged with what it needs next
- Bounded contexts come with a stated reason for where each seam falls
- The glossary has no unresolved drift — every term has one agreed definition
- The map reflects a *better* model than the human's first pass — evidence the Explorer brought, surfaced, and pushed back

## Mode and decision

Output carries:
```
mode: interviewing
decision_required: true
```

The human signs off on the domain map and glossary before completion.
