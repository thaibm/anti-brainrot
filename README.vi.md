[🇬🇧 English](README.md) | 🇻🇳 Tiếng Việt

# anti-brainrot

**AI lo gõ phím, bạn lo tư duy.**

Bộ rules biến AI coding agent thành một mentor khó tính. AI vẫn viết code cho bạn, nhưng chỉ sau khi bạn đã hiểu phải làm gì và vì sao.

Dùng được với **Claude Code, Codex, Antigravity và Cursor**.

```text
Bạn: Viết API đăng ký user.
AI:  Chưa đủ để mình viết. Bạn mới nêu tính năng.
     Còn thiếu: (1) các bước chính, và (2) một điều bạn đã cân nhắc
     hoặc (3) chỗ bạn chưa chắc.
Bạn: (1) POST email/pass → kiểm tra trùng email → hash pass → lưu DB.
     (3) Chưa biết chống 2 request đăng ký cùng email cùng lúc.
AI:  Đủ rồi. Trước khi viết: "kiểm tra trùng rồi mới lưu" không chặn
     được 2 request đồng thời. DB của bạn có unique constraint trên email chưa?
```

Sau khi AI viết code, bạn trả lời 2–3 câu hỏi kiểu "nếu… thì sao?". AI chỉ commit khi bạn trả lời đúng hết.

## Cài đặt

```bash
git clone <repo-url> ~/Projects/anti-brainrot
cd ~/Projects/anti-brainrot
./install.sh          # cài rules, rồi chạy survey khoảng 5 phút
```

## Tài liệu

| | 🇻🇳 Tiếng Việt | 🇬🇧 English |
|---|---|---|
| Đây là gì, có nên dùng không | [01 · Giới thiệu](docs/vi/01-introduction.md) | [01 · Introduction](docs/en/01-introduction.md) |
| Cài đặt và session đầu tiên | [02 · Bắt đầu](docs/vi/02-getting-started.md) | [02 · Getting started](docs/en/02-getting-started.md) |
| Một ngày làm việc với rules | [03 · Làm việc hằng ngày](docs/vi/03-daily-workflow.md) | [03 · Daily workflow](docs/en/03-daily-workflow.md) |
| Lệnh, tiêu chí, file, FAQ | [04 · Tra cứu](docs/vi/04-reference.md) | [04 · Reference](docs/en/04-reference.md) |
| Người duy trì: requirements, decisions, testing | [maintainers/](docs/vi/maintainers/requirements.md) | [maintainers/](docs/en/maintainers/requirements.md) |

Các thay đổi về hành vi được ghi trong [CHANGELOG.md](CHANGELOG.md). Tài liệu tiếng Việt là bản gốc, tiếng Anh được dịch theo.
