🇬🇧 English | [🇻🇳 Tiếng Việt](README.vi.md)

# anti-brainrot

**AI does the typing. You do the thinking.**

Rules that turn your AI coding agent into a demanding mentor. The AI still writes your code, but only after you have understood what to build and why.

Works with **Claude Code, Codex, Antigravity and Cursor**.

```text
You: Write a user sign-up API.
AI:  Not enough for me to write it. You've only named a feature.
     Missing: (1) the main steps, and either (2) something you've
     considered or (3) where you're unsure.
You: (1) POST email/pass → check for a duplicate email → hash → save.
     (3) Not sure how to stop two sign-ups with the same email at once.
AI:  That's enough. Before writing: "check, then insert" can't stop two
     concurrent requests. Does your DB have a unique constraint on email?
```

After the AI writes the code, you answer 2–3 "what if…?" questions. It won't commit until they're all correct.

## Install

```bash
git clone <repo-url> ~/Projects/anti-brainrot
cd ~/Projects/anti-brainrot
./install.sh          # installs the rules, then runs a ~5-minute survey
```

## Documentation

| | 🇬🇧 English | 🇻🇳 Tiếng Việt |
|---|---|---|
| What it is and whether to use it | [01 · Introduction](docs/en/01-introduction.md) | [01 · Giới thiệu](docs/vi/01-introduction.md) |
| Install and first session | [02 · Getting started](docs/en/02-getting-started.md) | [02 · Bắt đầu](docs/vi/02-getting-started.md) |
| A working day with the rules | [03 · Daily workflow](docs/en/03-daily-workflow.md) | [03 · Làm việc hằng ngày](docs/vi/03-daily-workflow.md) |
| Commands, criteria, files, FAQ | [04 · Reference](docs/en/04-reference.md) | [04 · Tra cứu](docs/vi/04-reference.md) |
| Maintainers: requirements, decisions, testing | [maintainers/](docs/en/maintainers/requirements.md) | [maintainers/](docs/vi/maintainers/requirements.md) |

Behaviour changes are listed in [CHANGELOG.md](CHANGELOG.md). The Vietnamese docs are the source; the English docs are translated from them.
