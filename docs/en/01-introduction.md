[🇻🇳 Tiếng Việt](../vi/01-introduction.md) | 🇬🇧 English · [Contents](README.md) · Next: [02 · Getting started](02-getting-started.md)

*Translated from [docs/vi/01-introduction.md](../vi/01-introduction.md), synced at 2026-10-30.*

# 01 · Introduction

> **TL;DR**
> - Handing everything to AI slowly erodes a developer's ability to understand and debug code ("nhũn não", roughly "brain-rot").
> - anti-brainrot **does not ban AI**. The AI still writes the code, but you always keep the thinking: defining the problem, design, review.
> - There is no off switch. A production hotfix also needs a developer who understands the fix.

## The problem

A very common way to use AI: paste the request, get code back, commit it if it runs. That's fast. But over time many developers notice they:
- can't debug without AI;
- can't explain the code they just committed;
- don't bother working out a solution or flow, and wait for the AI to propose one.

What gets lost **isn't the skill of typing code**. It's the skill of **judging code**. In the AI era, judging code is the most important part of the job: the AI writes 500 lines in a minute, and you are the one who decides whether those 500 lines get used.

## Evidence

| Study | Main result | Limitations |
|---|---|---|
| [Anthropic, RCT, Jan 2026](https://www.anthropic.com/research/AI-assistance-coding-skills) | 52 engineers learned a new Python library. The AI group scored about **50%** on a comprehension quiz, the hand-coding group about **67%**. The biggest gap was on **debugging** questions. People who used AI to *ask conceptual questions* still scored about 65% or more. | Short session, measured right after the task, no long-term retention. |
| [Microsoft & CMU, CHI 2025](https://www.theregister.com/2025/02/11/microsoft_study_ai_critical_thinking/) | Survey of 319 knowledge workers. The more people trusted AI, the less effort they put into critical thinking. | Self-reported, correlation only. |
| [Chen, Kalyuga & Sweller, 2016](https://repository.lboro.ac.uk/articles/journal_contribution/The_worked_example_effect_the_generation_effect_and_element_interactivity/12053721) | Novices facing complex material learn better from a worked example first, then trying it themselves. | Learning research in general, not programming-specific. |

The takeaway: **using AI isn't harmful in itself; how you use it is what matters.** Handing work over completely makes you learn less. Using AI to ask questions, then checking the answers yourself, still lets you learn.

## How anti-brainrot addresses it

**Be strict about thinking, not about typing.** In every task you keep three duties:

| Duty | You do | The AI does |
|---|---|---|
| Define the problem | What is being solved, and when it counts as done | Asks about anything vague |
| Design | Write a draft, then brainstorm with the AI until you can restate the plan yourself | Gives you the information you're missing, asks questions that expose your blind spots |
| Review | Answer the check questions, including "which test cases must exist?" | Asks, grades, and won't commit while any answer is wrong |

There are two ways of working, and the AI applies them automatically from your profile:
- **BUILD** (the default): the AI writes the code once you and the AI have agreed on the plan.
- **LEARN** (switches on for **a new concept in an area where you're still weak**): you study a worked example, then type the first version yourself. Once you pass, that concept moves to BUILD.

Each step is described in [03 · Daily workflow](03-daily-workflow.md).

## What it is, and what it isn't

| It is | It isn't |
|---|---|
| Plain-text rules installed into each AI tool's global instruction file | A tool that bans AI or limits how much you use it |
| A demanding mentor sitting next to you | A monitoring tool. Your profile and answer history are never committed and never shared with the team. |
| Applied to *how* the AI works with you | A replacement for the project's conventions or workflow. On conventions and process, the project's rules win. |

## Is it for you?

**It's a good fit if you:**
- want to use AI every day while keeping and growing your skills;
- are learning a new area, for example moving from frontend into backend or AI/LLM work;
- accept being a little slower on logic in exchange for understanding the code you commit.

**It's not a good fit if you:**
- only want the AI to be as fast as possible. There's no off switch; to stop, you uninstall.
- want to use it to force other people. It only works for people who want to be mentored.

## For team leads

- Everyone installs it and does the survey themselves. **Profiles are personal** and must not be used to evaluate or monitor anyone.
- The most effective way to introduce it: have the team read [03 · Daily workflow](03-daily-workflow.md), then let each person try it for about a week.
- The team's delivery workflow (specs, PR templates…) stays as it is. The draft and the check questions still apply inside that workflow.
