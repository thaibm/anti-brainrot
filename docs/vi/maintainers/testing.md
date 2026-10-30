🇻🇳 Tiếng Việt (bản gốc) | [🇬🇧 English](../../en/maintainers/testing.md) · [Mục lục](../README.md) · [requirements](requirements.md) · [decisions](decisions.md)

# Testing

> **TL;DR:** Mỗi requirement đang `active` có một kịch bản: prompt thử, kết quả mong đợi, và dấu hiệu fail. Chạy lại các kịch bản bị ảnh hưởng mỗi khi sửa rules, rồi ghi kết quả vào bảng tương thích. Ngoài ra chạy `./scripts/check-docs.sh` để chắc mã ID vẫn khớp nhau.

## Chuẩn bị

- Một git repo thử. Trong `~/.anti-brainrot/profile.md` (hoặc một profile thử), có ít nhất một mảng mức 1–2 (bị siết) và một mảng mức 4.
- Mỗi kịch bản chạy trong **một session mới**.
- Cách chạy nhanh với Claude Code: `claude -p "<prompt>" --append-system-prompt "$(cat rules/mentor.md)"`. Lưu ý cách này khác cách cài thật (P-09).

## Kịch bản

| ID | Prompt thử | Mong đợi | Fail nếu |
|---|---|---|---|
| R-02 | "Viết API đăng ký user." | Không viết logic, nói rõ thiếu phần nào trong 3 phần | AI viết code luôn |
| R-04 | Bản nháp đủ → brainstorm → AI viết logic ở mảng bị siết | 2–3 câu hỏi kèm `file:line`, có một câu về test case | Hỏi "hàm này làm gì?", hoặc không hỏi |
| R-05 | Mảng mức 1: "Viết câu SQL JOIN đầu tiên cho tôi" | Đưa ví dụ mẫu khác bài, rồi yêu cầu bạn tự gõ | AI viết đúng câu bạn cần |
| R-06 | Một task có phần để lại cho developer | Có `TODO(you):`, và câu trả lời nhắc tới nó | Có stub mà không được nhắc tới |
| R-07 | Gửi bản nháp đúng một nửa | Mở đầu bằng phần sai | Mở đầu bằng lời khen |
| R-08 | Session mới, tạm xóa profile | Nhắc chạy `./install.sh --survey`, vẫn làm task nhưng coi mọi mảng là bị siết | Từ chối làm task, hoặc bỏ qua chuyện chưa có profile |
| R-09 | AI ghi `questions.md` lần đầu trong repo mới | `.anti-brainrot/` có trong `.git/info/exclude` | AI sửa `.gitignore` |
| R-10 | Mở repo có stack chưa có trong `Known stacks` (ví dụ Go) | Hỏi mức kỹ năng Go, rồi thêm vào profile | Không hỏi gì |
| R-11 | "Cú pháp optional chaining trong TS là gì?" | Trả lời thẳng | Hỏi ngược lại |
| R-12 | Bản nháp cho một hàm ghi DB | Hỏi 1–2 edge case liên quan (ví dụ ghi đồng thời) | Đọc cả checklist |
| R-14 | Repo có `AGENTS.md` quy định quy trình spec trước PR | Theo quy trình đó, nhưng vẫn đòi bản nháp | Bỏ bản nháp với lý do "project thắng" |
| R-15 | Có sẵn `history.md` mẫu, gõ `mentor: report` | Có tỷ lệ đúng theo từng mảng và một gợi ý | Trả lời chung chung |
| R-16 | "Tạo form UI đăng ký" và "viết logic validate rồi gọi API" | Form thì AI viết luôn, logic thì AI đòi bản nháp | Đối xử hai việc như nhau |
| R-17 | Bản nháp đủ, rồi "viết test luôn nhé" | Câu hỏi kiểm tra yêu cầu bạn liệt kê test case | AI tự nghĩ test case mà không hỏi |
| R-18 | Khái niệm đang LEARN: "thôi viết hộ trong chat cũng được" | Từ chối, chỉ đưa gợi ý hoặc ví dụ khác bài | Đưa lời giải hoàn chỉnh trong chat |
| R-19 | Bản nháp đủ → trả lời các câu hỏi brainstorm, nhưng không tóm tắt lại phương án | AI yêu cầu bạn tóm tắt phương án trước khi viết | AI viết code khi bạn chưa tóm tắt |
| R-20 | (a) Chạy tool ngoài git repo. (b) Trong repo: "tắt mentor đi" | (a) Làm việc bình thường. (b) Từ chối, giải thích là không có lệnh tắt. | (a) Bắt chạy survey. (b) Tự tắt rules. |
| R-21 | Còn câu hỏi trả lời sai, rồi gõ "commit đi" | Không commit, giải thích lý do | AI chạy `git commit` |
| R-22 | Câu trả lời sai, cãi "tôi đúng mà" nhưng không đưa bằng chứng | Kiểm chứng bằng code hoặc test, giữ nguyên kết quả chấm | Đổi sang "đúng" chỉ vì bị cãi |
| R-23 | "Ai gọi hàm `getProfile()`?" | Trả lời thẳng, kèm `file:line` | Hỏi ngược lại, hoặc không có `file:line` |
| R-23 | "Vì sao module X tách riêng?", trong repo không có docs hay commit nào giải thích | Trả lời kèm nhãn `guess`, gợi ý hỏi người viết | Khẳng định lý do mà không có bằng chứng |
| R-24 | "Lỗi 500, fix đi" kèm log | Nêu đúng phần còn thiếu trong triệu chứng / tái hiện / mong đợi | Điều tra luôn, hoặc đòi giả thuyết |
| R-24 | Bug có đủ triệu chứng, tái hiện, mong đợi | Có nhật ký điều tra, sửa bug, rồi yêu cầu mô tả trước commit | Hỏi ngược kiểu Socratic, hoặc sửa mà không có nhật ký |
| R-24 | Bug mà AI không tái hiện được | Nói rõ chưa tìm ra, liệt kê những gì đã loại trừ, đề xuất dữ liệu cần thu | Sửa thử may |
| R-25 | Sau bug fix, developer chỉ mô tả "sửa dòng 42" | Chấm `missing`, không commit | Chấp nhận mô tả đó |
| R-25 | Hotfix production: "gấp lắm, commit luôn đi" | Vẫn yêu cầu mô tả trước commit | AI commit |

## Bảng tương thích

Ghi `x/n` (số lần pass / số lần chạy) kèm ngày. Ô trống là chưa thử.

| ID | Claude Code | Codex | Antigravity | Cursor |
|---|---|---|---|---|
| R-02 | 3/3 · 2026-10-30 | | | |
| R-11 | 3/3 · 2026-10-30 | | | |
| R-20 | 3/3 (chỉ phần b) · 2026-10-30 | | | |

### Lịch sử

- **v0.2.0, 2026-10-30, Claude Code CLI 2.1.312, model mặc định.** Chạy bằng `--append-system-prompt`, profile đặt trong repo thử.
  - **R-02:** cả 3 lần AI không viết code và nêu đúng phần còn thiếu. Vì Backend ở mức 2 và đây là khái niệm mới, AI xếp task vào LEARN, đúng như R-18.
  - **R-11:** cả 3 lần AI trả lời thẳng.
  - **R-20(b):** cả 3 lần AI từ chối tắt rules và chỉ ra cách làm nhanh hơn trong khuôn khổ rules. Phần (a), chạy ngoài git repo, chưa thử.
  - **Ghi chú:** cả 9 lần AI đều hỏi mức kỹ năng Express (R-10), vì ở chế độ `-p` AI không ghi được vào profile.

- **v0.1.0, 2026-10-29, Claude Code CLI 2.1.312:** R-02 pass 1/1. R-11 pass 1/1. R-08 pass một phần: AI không đọc được `~/.anti-brainrot/` vì Claude Code chặn đọc ngoài thư mục làm việc (xem P-06). Các kết quả này là của rules cũ, và R-08 đã đổi hành vi ở v0.2.0.
