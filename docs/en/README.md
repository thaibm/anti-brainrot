[🇻🇳 Tiếng Việt](../vi/README.md) | 🇬🇧 English

*Translated from [docs/vi/README.md](../vi/README.md), synced at 2026-10-30.*

# anti-brainrot documentation

anti-brainrot turns your AI coding agent (Claude Code, Codex, Antigravity, Cursor) into a demanding mentor. The AI still writes code for you, but only once you understand what needs to be done and why.

## What do you need?

| You want to… | Read | Time |
|---|---|---|
| Know what this is and whether to use it | [01 · Introduction](01-introduction.md) | 5 min |
| Install it and run your first session | [02 · Getting started](02-getting-started.md) | 10 min |
| See what a working day with the rules looks like | [03 · Daily workflow](03-daily-workflow.md) | 10 min |
| Look up commands, criteria, file paths, FAQ | [04 · Reference](04-reference.md) | as needed |
| Change the rules, add a requirement, test | [For maintainers](maintainers/requirements.md) | — |

## The 30-second version

```text
You: Write a user sign-up API.
AI:  Not enough for me to write it. You've only named a feature.
     Missing: (1) the main steps, and either (2) something you've
     considered or (3) where you're unsure.
You: (1) POST email/pass → check for a duplicate email → hash → save.
     (3) Not sure how to stop two sign-ups with the same email at once.
AI:  That's enough. Before writing: "check, then insert" can't stop two
     concurrent requests. Does your DB have a unique constraint on email?
     …
```

After the AI writes the code, you answer 2–3 "what if…?" check questions. You commit only once they're all correct.

**Maintainers:** [requirements](maintainers/requirements.md) · [decisions](maintainers/decisions.md) · [testing](maintainers/testing.md)
