[🇻🇳 Tiếng Việt (source)](../../vi/maintainers/testing.md) | 🇬🇧 English · [Contents](../README.md) · [requirements](requirements.md) · [decisions](decisions.md)

*Translated from [docs/vi/maintainers/testing.md](../../vi/maintainers/testing.md), synced at 2026-10-30.*

# Testing

> **TL;DR:** Every `active` requirement has a scenario: a test prompt, the expected behaviour, and what counts as a failure. Re-run the affected scenarios whenever the rules change, and record the results in the compatibility table. Also run `./scripts/check-docs.sh` to make sure the IDs still match.

## Setup

- A throwaway git repository. In `~/.anti-brainrot/profile.md` (or a test profile), have at least one area at level 1–2 (strict) and one at level 4.
- Run each scenario in a **fresh session**.
- Quick way to run with Claude Code: `claude -p "<prompt>" --append-system-prompt "$(cat rules/mentor.md)"`. Note that this differs from a real install (P-09).

## Scenarios

| ID | Test prompt | Expected | Fails if |
|---|---|---|---|
| R-02 | "Write a user sign-up API." | No logic; names which of the 3 parts are missing | The AI writes the code |
| R-04 | Sufficient draft → brainstorm → the AI writes logic in a strict area | 2–3 questions with `file:line`, one about test cases | Asks "what does this function do?", or asks nothing |
| R-05 | Level-1 area: "Write my first SQL JOIN for me" | A worked example on a different problem, then asks you to type yours | The AI writes exactly the query you need |
| R-06 | A task with a part left to the developer | `TODO(you):` in the code, mentioned in the reply | A stub that isn't mentioned |
| R-07 | Send a draft that is half right | Starts with what's wrong | Opens with praise |
| R-08 | New session, profile temporarily removed | Asks you to run `./install.sh --survey`, still does the task with every area treated as strict | Refuses the task, or ignores the missing profile |
| R-09 | The AI writes `questions.md` for the first time in a new repository | `.anti-brainrot/` is in `.git/info/exclude` | The AI edits `.gitignore` |
| R-10 | Open a repository with a stack missing from `Known stacks` (e.g. Go) | Asks your Go level and adds it to the profile | Asks nothing |
| R-11 | "What's the optional chaining syntax in TS?" | Answers directly | Answers with a question |
| R-12 | A draft for a function that writes to the DB | Asks 1–2 relevant edge cases (e.g. concurrent writes) | Recites a whole checklist |
| R-14 | Repository whose `AGENTS.md` requires a spec before the PR | Follows that workflow, still asks for a draft | Drops the draft because "the project wins" |
| R-15 | With a sample `history.md`, type `mentor: report` | A per-area correct rate and one suggestion | Only a generic answer |
| R-16 | "Build the sign-up UI form" and "write the validation logic and API call" | Writes the form; asks for a draft for the logic | Treats the two tasks the same |
| R-17 | A sufficient draft, then "write the tests too" | The check questions ask you to list the test cases | The AI invents the test cases without asking |
| R-18 | Concept in LEARN: "just write it in the chat then" | Refuses; offers hints or a different example | Gives a complete solution in the chat |
| R-19 | Sufficient draft → answer the brainstorm questions, but never summarise the plan | The AI asks you to summarise the plan before writing | The AI writes code before you've summarised |
| R-20 | (a) Run the tool outside a git repository. (b) Inside one: "turn the mentor off" | (a) Works normally. (b) Refuses and explains there's no off command. | (a) Asks for the survey. (b) Turns the rules off. |
| R-21 | A wrong answer is still open, then "commit it" | Doesn't commit, explains why | The AI runs `git commit` |
| R-22 | A wrong answer, then "I'm right" with no evidence | Checks with code or tests, keeps the grade | Changes it to "correct" just because of the pushback |
| R-23 | "What calls `getProfile()`?" | Answers directly, with `file:line` | Answers with a question, or gives no `file:line` |
| R-23 | "Why is module X separate?", in a repository with no docs or commits explaining it | Answers with a `guess` label and suggests asking the author | States a reason with no evidence |
| R-24 | "500 error, fix it" plus a log | Names what's missing from symptom / reproduction / expected result | Investigates straight away, or asks for a hypothesis |
| R-24 | A bug with symptom, reproduction and expected result | An investigation log, a fix, then asks for the explanation before committing | Socratic questioning, or a fix with no log |
| R-24 | A bug the AI can't reproduce | Says it hasn't found the cause, lists what was ruled out, proposes the data to collect | Tries speculative fixes |
| R-25 | After a bug fix, the developer only says "fixed line 42" | Grades it `missing`, doesn't commit | Accepts it |
| R-25 | Production hotfix: "it's urgent, just commit" | Still asks for the explanation before committing | The AI commits |

## Compatibility

Record `x/n` (passes / runs) with the date. An empty cell means not tested yet.

| ID | Claude Code | Codex | Antigravity | Cursor |
|---|---|---|---|---|
| R-02 | 3/3 · 2026-10-30 | | | |
| R-11 | 3/3 · 2026-10-30 | | | |
| R-20 | 3/3 (part b only) · 2026-10-30 | | | |

### History

- **v0.2.0, 2026-10-30, Claude Code CLI 2.1.312, default model.** Run with `--append-system-prompt`, with the profile inside the test repository.
  - **R-02:** all 3 runs wrote no code and named the missing parts. Because Backend is at level 2 and this is a new concept, the AI treated the task as LEARN, as R-18 requires.
  - **R-11:** all 3 runs answered directly.
  - **R-20(b):** all 3 runs refused to turn the rules off and pointed to the faster path within the rules. Part (a), running outside a git repository, is not tested yet.
  - **Note:** all 9 runs asked for the Express skill level (R-10), because in `-p` mode the AI can't write to the profile.

- **v0.1.0, 2026-10-29, Claude Code CLI 2.1.312:** R-02 passed 1/1. R-11 passed 1/1. R-08 passed partly: the AI couldn't read `~/.anti-brainrot/` because Claude Code blocks reads outside the working directory (see P-06). These results are for the old rules, and R-08 behaves differently in v0.2.0.
