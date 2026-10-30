[🇻🇳 Tiếng Việt (source)](../../vi/maintainers/requirements.md) | 🇬🇧 English · [Contents](../README.md) · [decisions](decisions.md) · [testing](testing.md)

*Translated from [docs/vi/maintainers/requirements.md](../../vi/maintainers/requirements.md), synced at 2026-10-30.*

# Requirements

> **TL;DR**
> - Each requirement has an `R-xx` ID, a rationale, and its location in [rules/mentor.md](../../../rules/mentor.md). The test scenarios are in [testing.md](testing.md).
> - To change behaviour, change the requirement first, then the rule (see the process at the end).
> - The Vietnamese version is the source.

## Requirements

**Status:** `active` is in effect, `dropped` was removed. Dropped rows are kept so the reason isn't lost. Each section of `rules/mentor.md` has a `<!-- R-xx -->` comment that points back here.

| ID | Requirement | Why / evidence | Rule | Status |
|---|---|---|---|---|
| <a id="r-01"></a>R-01 | ~~Only the developer changes the mode~~ | There are no per-repo modes any more ([D-13](decisions.md)) | — | dropped |
| <a id="r-02"></a>R-02 | Logic is written only after a draft with 2 of 3: main steps, something considered, where unsure. A LEARN concept in a level-1 area only needs item 3. Bug fixes need no draft (R-24). | "Too lazy to come up with a solution or flow" is the top sign. Novices can't list the steps yet (Sweller). | §3 | active |
| <a id="r-03"></a>R-03 | ~~Reasoning questions use a 3-rung hint ladder~~ | Replaced by R-23, R-24, R-25 ([D-19](decisions.md)). The ladder only works when the AI already knows the answer, and a newcomer to the repository can't answer rung 1. | — | dropped |
| <a id="r-04"></a>R-04 | Check questions per task or commit. How many depends on the area: 2–3 / 1 / 0. "Why / what if" form, one about test cases, prefer predict-then-run. | A "what" question can be answered without understanding. Asking after every edit causes fatigue (F-05). Verification is folded into review. | §5 | active |
| <a id="r-05"></a>R-05 | LEARN concept: study a worked example on a different problem, then type about 15–40 lines yourself, ~60 minutes max | Anthropic's RCT: the hand-coding group understood better (67% vs 50%). Sweller: novices should see a worked example first. **The 15–40 figure is an estimate.** | §6 | active |
| <a id="r-06"></a>R-06 | No silent gaps. Anything left for the developer is marked `TODO(you):` | Silent gaps slip into commits as bugs | §8 | active |
| <a id="r-07"></a>R-07 | No default praise. When something is partly right, start with what's wrong. | Models tend to praise | §9 | active |
| <a id="r-08"></a>R-08 | The survey runs at install time. Without a profile the AI still works, treating every area as level 1. Areas self-rated 3–4 must pass one check question. | Don't block work in the first session (F-07). People tend to overrate themselves. | §0 | active |
| <a id="r-09"></a>R-09 | Never commit personal data. `.anti-brainrot/` is added to `.git/info/exclude`. | The team's `.gitignore` shouldn't have to change | §0 | active |
| <a id="r-10"></a>R-10 | When a stack is missing from `Known stacks`, the AI asks for the skill level and adds it | Needs a clear definition of a "new stack" (F-14) | §0 | active |
| <a id="r-11"></a>R-11 | Lookup questions get a direct answer, with a source | Forgetting syntax does less harm than not designing the flow | §7 | active |
| <a id="r-12"></a>R-12 | Ask only the 1–2 riskiest edge cases, never a checklist | A checklist every time gets skipped | §4 | active |
| <a id="r-13"></a>R-13 | ~~Log switches to SHIP~~ | SHIP was removed ([D-13](decisions.md)) | — | dropped |
| <a id="r-14"></a>R-14 | The project wins on conventions and process. The draft, brainstorm and check questions still apply unless the project explicitly forbids them. | Otherwise the rules have no effect in company repositories (F-12) | top of file | active |
| <a id="r-15"></a>R-15 | Results go to `history.md` with the area. `mentor: report` shows the first-try correct rate per area. | We need to know whether the rules help. A no-AI check is planned for phase 2 (P-07). | §5, §10 | active |
| <a id="r-16"></a>R-16 | Logic vs shell is decided by concrete signals: branching, state changes, side effects, data transformation. With React examples. | Frontend code mixes both, so the AI would classify it inconsistently (F-09) | §1 | active |
| <a id="r-17"></a>R-17 | The developer keeps three duties: define the problem, design, review (verification is folded into review) | In the AI era, judging code matters more than typing it | §2 | active |
| <a id="r-18"></a>R-18 | LEARN applies per **concept**: a new concept in a strict area. Once passed, it goes into `Concepts passed` and moves to BUILD. While in LEARN, the AI never gives complete logic, not even in chat. | The author's decision (F-03). Closes the copy-paste-from-chat loophole. | §1, §6 | active |
| <a id="r-19"></a>R-19 | Brainstorm before writing logic: the AI gives missing information and asks questions that expose blind spots. It ends when the developer restates the plan and the AI has no questions left. | The author's decision (C3). The stop condition keeps it from dragging on. | §4 | active |
| <a id="r-20"></a>R-20 | The rules run only inside git repositories. There is no command to turn them off or change mode. | A hotfix also needs the fix understood (C2). The scope limit avoids getting in the way outside repositories (F-13). | §0 | active |
| <a id="r-21"></a>R-21 | The AI never runs `git commit` or `git push` while any check question is unanswered or wrong. `questions.md` holds only the current task's questions. | In agentic tools, the AI is often the one who commits (F-11) | §5 | active |
| <a id="r-22"></a>R-22 | When the developer disputes a grade, the AI checks with code or tests, changes the grade only on evidence, and admits its own mistakes | Sycophancy has two faces: easy praise, and caving under pushback (F-10) | §5 | active |
| <a id="r-23"></a>R-23 | Questions are classified by problem: ask in order and stop at the first match (Bug, Design, Review, Explanation, Codebase context, Lookup). Explanations and codebase context get a direct answer with `file:line`, a commit or a PR. A "why was it built this way" with no evidence is labelled `guess`. | A newcomer lacks context, not reasoning. Context is a fact already in the code and git ([D-20](decisions.md)). | §7 | active |
| <a id="r-24"></a>R-24 | Bugs: the developer gives the symptom, how to reproduce it and the expected result, no hypothesis needed. The AI investigates with a log (hypothesis → evidence → verdict), then fixes. If it can't find the cause it says so and doesn't try speculative fixes. A fix that must ship unconfirmed is labelled `cause unconfirmed`. A bug in LEARN code: point it out, don't write the fix. | Bugs must get solved first, or developers work around the rules under pressure. The hint ladder assumed the AI already knew the answer ([D-19](decisions.md)). | §7 | active |
| <a id="r-25"></a>R-25 | Every bug fix, hotfixes and fixes under 10 lines included: before committing, the developer explains the condition that causes the bug and why the fix prevents it, plus exactly one test-case question. This replaces the usual §5 check questions. | A one-line fix can still have a deep cause. The two required points stop the developer from just repeating the AI's log. No exception for hotfixes (D-15). | §5 | active |

## Backlog

| ID | Idea | Status / reason |
|---|---|---|
| P-01 | Pre-commit hook that blocks commits while `questions.md` has unanswered questions | Later. A git hook works with every tool. |
| P-02 | Claude `UserPromptSubmit` hook that restates the status every turn | Later. Works only in Claude Code. |
| P-03 | Predict the output before running | **Folded into R-04** (predict-then-run questions) |
| P-04 | Announced bug-hunt exercises | Later |
| P-05 | "Rule didn't work" issue template | Once there are outside users |
| P-06 | `install.sh` grants Claude Code read/write permission on `~/.anti-brainrot/**` | Later. It means editing the user's `settings.json`. |
| P-07 | A no-AI check every 4 weeks (F-06) | Phase 2 |
| P-08 | Make clear the evidence is about learning new skills, not losing existing ones (F-15) | Phase 2 |
| P-09 | Run scenarios 3 times, with the rules placed as in a real install (F-16) | Phase 2 |
| P-10 | Small fixes: the exclude path in git worktrees, a status line on every code-changing reply (F-17) | Phase 2 |

## Update process

1. **Requirement:** edit the table above (Vietnamese version). For a removed requirement, set it to `dropped` instead of deleting the row.
2. **Decision:** if the change comes from a new decision, record it in [decisions.md](decisions.md).
3. **Rule:** edit `rules/mentor.md`, keeping the `<!-- R-xx -->` comment.
4. **Scenario:** update [testing.md](testing.md), re-run on at least one tool, record the result.
5. **User docs:** edit the affected pages in `docs/vi/`, then `docs/en/`.
6. **Version:** bump `Version:` in the rules (minor for a behaviour change, patch for wording). Record it in [CHANGELOG.md](../../../CHANGELOG.md).
7. **Check:** run `./scripts/check-docs.sh`.
8. **Commit:** use a message like `rules(R-04): …`.
