[🇻🇳 Tiếng Việt (source)](../../vi/maintainers/decisions.md) | 🇬🇧 English · [Contents](../README.md) · [requirements](requirements.md) · [testing](testing.md)

*Translated from [docs/vi/maintainers/decisions.md](../../vi/maintainers/decisions.md), synced at 2026-10-30.*

# Decision log

> **TL;DR:** Each design decision, why it was made, and what was rejected. A superseded decision isn't deleted; it's marked "superseded by D-xx".

| # | Decision | Why | Rejected | Status |
|---|---|---|---|---|
| D-01 | Text rules first, hooks later | Text works with every tool. Hooks depend on the tool (except git hooks). | Hooks from day one | active |
| D-02 | Copy the rules inline into the global file, between 2 marker lines | Codex has no imports. One method for every tool keeps the script simple. | `@import`, symlinks | active |
| D-03 | Rules follow the `AGENTS.md` convention and are written in English | Many tools read the convention. Models follow English more reliably. The reply language is chosen separately. | Rules in Vietnamese | active |
| D-04 | A kit with a global install script | A template only reaches new repositories | GitHub template | active |
| D-05 | Exclude via `.git/info/exclude` | The team's shared file never changes | `.gitignore` | active |
| D-06 | SHIP is the escape hatch, and it is logged | One mechanism instead of two | An `OVERRIDE` command | superseded by D-13 |
| D-07 | Code is always complete, followed by check questions | Deliberate gaps slip bugs into commits | Original rule "deliberately leave logic gaps" | active |
| D-08 | Bug-hunt exercises must be announced | If the AI is silently wrong, the developer may learn the wrong thing | The AI being deliberately wrong without saying so | active |
| D-09 | Redo the survey about every 4 weeks | Simpler than tracking logs continuously | Automatic fading | active |
| D-10 | Logic vs shell is decided by kind of work, with concrete signals | See R-16 | Boundaries by technology | active |
| D-11 | Forgetting syntax isn't treated strictly | See R-11 | Making the developer look up syntax | active |
| D-12 | Profile in `~/.anti-brainrot/`, independent of any tool | Every tool can read it | `~/.claude/` | active |
| D-13 | **Remove SHIP and per-repo modes** | SHIP is cheap and sticky, so it would become the default (F-01). Per-repo modes aren't needed once LEARN is per concept. | SHIP that expires after each task | active |
| D-14 | LEARN applies per concept and moves to BUILD once passed | Learning happens concept by concept, not repository by repository (F-03) | LEARN per repository | active |
| D-15 | No command to turn the rules off | A hotfix also needs the fix understood (C2). The only way out is uninstalling. | `mentor: off` with logging | active |
| D-16 | The survey runs in the terminal at install time | Doesn't block the first AI session. The AI doesn't have to write to `~` to create the profile (F-07). | Survey in the chat | active |
| D-17 | The brainstorm ends when the developer restates the plan and the AI has no questions left | Keeps "both sides agree" but with a stop condition (C3) | A hard limit of 3 questions | active |
| D-18 | Docs follow the reader's journey (01–04), with a separate `maintainers/` folder, in both languages | Users don't need R-xx IDs. Newcomers need a clear reading order. | 4 files split by document type (v0.1.0) | active |
| D-19 | **Bugs: the AI solves them first; the developer must understand and explain the fix before committing** | The hint ladder assumed the AI already knew the answer, and a newcomer to the repository can't answer rung 1. In real work, the bug has to get solved first. | The 3-rung hint ladder (R-03). A lesson card with tech / project / business layers, a `learnings.md` log and a `mentor: drill` command: too heavy. | active |
| D-20 | Questions are classified by problem; codebase-context questions get a direct answer | See R-23 | One bucket for every "why" question | active |
