[🇻🇳 Tiếng Việt](../vi/04-reference.md) | 🇬🇧 English · [Contents](README.md)

*Translated from [docs/vi/04-reference.md](../vi/04-reference.md), synced at 2026-10-30.*

# 04 · Reference

## Commands

Type these in your AI tool's chat:

| Command | Effect |
|---|---|
| `mentor: status` | Show the rules version, strict areas, concepts in LEARN and passed, unanswered questions |
| `mentor: lang <language>` | Change the reply language for the current repository |
| `mentor: report` | Show the first-try correct rate per area, last 4 weeks vs. before |
| `mentor: survey` | The AI reminds you to re-run `./install.sh --survey` |

There is no command to turn the rules off or change mode. That's deliberate.

## Criteria

### A sufficient draft

It needs at least **2 of these 3**:
1. The main steps (3–5 lines).
2. Something already considered (where the data goes, or an edge case).
3. Where you're unsure (a specific question).

Exception: a LEARN concept in an area rated **1** only needs item 3, plus what you want to achieve.

| Request | Enough? |
|---|---|
| "Build login, probably JWT." | No. It only names a technology. |
| "Login: POST email/pass → check DB → JWT in an httpOnly cookie. Not sure about refresh tokens." | Yes |
If you paste a spec longer than ~30 lines with less than one sentence of your own analysis, the AI asks you to analyse it first.

Bugs don't need a draft, only the **symptom, how to reproduce it and the expected result**:

| Bug report | Enough? |
|---|---|
| "500 error, fix it" plus a log | No. Missing how to reproduce it and the expected result. |
| "The profile page returns 500 for new users. To reproduce: sign up, then open /profile. Expected: an empty profile page." | Yes, and this also works for a hotfix |

### Question types

The AI asks in order and stops at the first match:

| Order | Type | Example | What the AI does |
|---|---|---|---|
| 1 | Bug | "The profile page returns 500 for new users" | Investigates with a log and fixes it; you explain the cause and the fix before committing |
| 2 | Design | "Cache on the frontend or the backend?" | Answers the context part directly. The decision goes through the draft and the brainstorm |
| 3 | Review | "Is my code OK?" | Asks for its inputs and outputs, one way it can fail and the test cases it needs. Then states the problems directly, with `file:line` |
| 4 | Explanation | "When does `useEffect` cleanup run?" | Answers directly. For a concept in LEARN, explains with a different example |
| 5 | Codebase context | "What calls `getProfile()`?", "Why is this module separate?" | Answers directly with `file:line`, a commit or a PR. A "why" with no evidence is labelled `guess` |
| 6 | Lookup | Syntax, an API name, a flag | Answers directly, with a source |

A question that mixes types is split, and each part is handled by its type.

### Logic and shell

Code is **logic** if it does at least one of these: branches on data, changes state, has side effects (API calls, DB writes, timers, storage), or transforms data. Everything else is **shell**.

| Code | Kind |
|---|---|
| A component that only renders props as static markup and classes | Shell |
| `useState`, `useEffect`, conditional rendering on fetched data, an `onSubmit` handler | Logic |
| A Tailwind or CSS change, `tsconfig`, a route list with no guards | Shell |
| Form validation, a route guard, mapping an API response into view data | Logic |

### Check questions

| Case | Questions |
|---|---|
| Logic in a strict area | 2–3 |
| Logic in an area you know well | 1 |
| A change under ~10 lines of logic | 0 |
| A bug fix of any size, hotfixes included | Explain the cause and the fix, plus 1 test-case question |

- Asked once per **task or commit**, not after every edit.
- Always "why" or "what if", never "what does this do". At least one is about test cases. Questions you can answer by predicting the result, then running it, are preferred.
- Grading has three levels: **correct**, **missing a point**, **wrong because…**.
- While any answer is empty or wrong, the AI won't run `git commit` or `git push` itself.

### Strict areas and LEARN

- **A strict area** is one rated 1–2 in your profile, or one you marked strict yourself.
- **A new concept in a strict area runs as LEARN:**
  1. Study a worked example that is similar but not the same.
  2. Close it and type about 15–40 lines yourself, about 60 minutes at most.
  3. Answer the check questions.
- **You pass** when your code works and every answer is correct. The concept goes into `Concepts passed` and runs as BUILD from then on.

## Data files

| Path | Contents | Committed? |
|---|---|---|
| `~/.anti-brainrot/profile.md` | Skill levels, stacks, concepts passed, level history | No, outside any repository |
| `~/.anti-brainrot/templates/` | Profile and repo templates | No |
| `<repo>/.anti-brainrot/repo.md` | Optional per-repo reply language | No, listed in `.git/info/exclude` |
| `<repo>/.anti-brainrot/questions.md` | The current task's check questions | No |
| `<repo>/.anti-brainrot/history.md` | Check-question results | No |
| Each tool's global file | The rules, between the `anti-brainrot:begin` and `anti-brainrot:end` lines | Not a repository |

## FAQ

**Will it slow me down?**
Yes, on logic and when you meet a new concept. The extra time is the time you spend understanding the code. Shell work isn't slower.

**Really no way to turn it off?**
Right. A hotfix also needs a developer who understands the fix: the AI finds and fixes the bug, but you have to explain the cause and the fix before committing. To stop for good, run `./install.sh --uninstall`.

**Why isn't forgetting syntax treated strictly?**
Forgetting syntax does far less harm than not bothering to design the flow. Lookup questions get a direct answer.

**What about company repositories with their own workflow?**
On conventions and process (code structure, tests, PRs, commits), the project wins. The draft, brainstorm and check questions still apply unless the project explicitly forbids them.

**Is my profile private?**
It's never committed and never shared with the team. It is, however, sent to your AI provider in each session, like anything else you put into the tool.

## Known limitations

- **Text rules can't enforce anything absolutely.** The longer the session, the more the model drifts back to doing the work for you. Enforcement hooks are in the backlog.
- **Cursor:** you paste the rules by hand, and paste them again after each update.
- **Claude Code** asks for permission to read or write `~/.anti-brainrot/`. Approve it.
- **Sandboxed Codex** may not be able to write to `~/.anti-brainrot/`. In that case the AI writes into a folder inside the repository and asks you to move it. There is a [report](https://github.com/openai/codex/issues/8759) that Codex 0.77 doesn't read the global `AGENTS.md`.
- **Antigravity and Gemini CLI** share `~/.gemini/GEMINI.md`, so both get the rules.
- The tools' global file paths were checked in October 2026.
