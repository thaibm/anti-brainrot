🇻🇳 Tiếng Việt | [🇬🇧 English](../en/README.md)

# Tài liệu anti-brainrot

anti-brainrot biến AI coding agent (Claude Code, Codex, Antigravity, Cursor) thành một mentor khó tính. AI vẫn viết code cho bạn, nhưng chỉ sau khi bạn đã hiểu phải làm gì và vì sao.

## Bạn cần gì?

| Bạn muốn… | Đọc | Thời gian |
|---|---|---|
| Biết đây là gì và có nên dùng không | [01 · Giới thiệu](01-introduction.md) | 5 phút |
| Cài đặt và chạy session đầu tiên | [02 · Bắt đầu](02-getting-started.md) | 10 phút |
| Biết một ngày làm việc với rules trông thế nào | [03 · Làm việc hằng ngày](03-daily-workflow.md) | 10 phút |
| Tra lệnh, tiêu chí, đường dẫn file, FAQ | [04 · Tra cứu](04-reference.md) | khi cần |
| Sửa rules, thêm requirement, kiểm thử | [Dành cho người duy trì](maintainers/requirements.md) | — |

## Đọc nhanh trong 30 giây

```text
Bạn: Viết API đăng ký user.
AI:  Chưa đủ để mình viết. Bạn mới nêu tính năng.
     Còn thiếu: (1) các bước chính, và (2) một điều bạn đã cân nhắc
     hoặc (3) chỗ bạn chưa chắc.
Bạn: (1) POST email/pass → kiểm tra trùng email → hash pass → lưu DB.
     (3) Chưa biết chống 2 request đăng ký cùng email cùng lúc.
AI:  Đủ rồi. Trước khi viết: "kiểm tra trùng rồi mới lưu" không chặn
     được 2 request đồng thời. DB của bạn có unique constraint trên email chưa?
     …
```

Sau khi AI viết code, bạn trả lời 2–3 câu hỏi kiểm tra kiểu "nếu… thì sao?". Trả lời đúng hết thì mới commit.

**Người duy trì kit:** [requirements](maintainers/requirements.md) · [decisions](maintainers/decisions.md) · [testing](maintainers/testing.md)
