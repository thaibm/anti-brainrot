# Changelog

Behaviour changes to `rules/mentor.md`. IDs refer to [requirements](docs/vi/maintainers/requirements.md).
Thay đổi hành vi của `rules/mentor.md`. Mã ID tham chiếu tới [requirements](docs/vi/maintainers/requirements.md).

## 0.3.0 — 2026-10-30

- **EN:**
  - Removed the hint ladder (R-03 dropped, D-19). It only worked when the AI already knew the answer, and newcomers to a repository couldn't answer rung 1.
  - Questions are classified by problem: Bug, Design, Review, Explanation, Codebase context, Lookup. Codebase context and explanations get a direct answer with `file:line` (R-23, D-20).
  - Bugs are solved first: the developer gives the symptom, reproduction and expected result, no hypothesis needed. The AI investigates with a visible log and fixes. It doesn't guess when it can't find the cause (R-24).
  - Every bug fix, hotfixes included, needs the developer to explain the cause and why the fix works, plus one test-case question, before committing (R-25).
- **VI:**
  - Bỏ thang gợi ý (R-03 chuyển sang dropped, D-19). Thang chỉ hợp khi AI đã biết đáp án, và người mới vào repo không trả lời được nấc 1.
  - Câu hỏi được phân loại theo vấn đề: Bug, Thiết kế, Review, Giải thích, Ngữ cảnh codebase, Tra cứu. Ngữ cảnh codebase và giải thích được trả lời thẳng, kèm `file:line` (R-23, D-20).
  - Bug được xử lý trước: developer đưa triệu chứng, cách tái hiện, kết quả mong muốn, không cần giả thuyết. AI điều tra kèm nhật ký và sửa. Chưa tìm ra nguyên nhân thì AI không đoán (R-24).
  - Mọi bug fix, kể cả hotfix, đều cần developer mô tả nguyên nhân và vì sao cách sửa đúng, cộng 1 câu về test case, trước khi commit (R-25).

## 0.2.0 — 2026-10-30

- **EN:**
  - Renamed the project to **anti-brainrot**: data folders are now `~/.anti-brainrot/` and `.anti-brainrot/`, and the markers are `anti-brainrot:begin/end`. The `mentor:` commands are unchanged.
  - Removed SHIP and per-repo modes (D-13). Every task runs as BUILD; a new concept in a strict area runs as LEARN until passed (R-18).
  - No off command; rules only run inside git repositories (R-20).
  - Added a brainstorm with a stop condition (R-19).
  - Check questions are now asked per task or commit, and how many depends on the area. They include test cases, and the AI won't commit while any answer is open (R-04, R-21). Grades change only on evidence (R-22).
  - Logic vs shell is defined by concrete signals (R-16). Project rules win only on conventions and process (R-14).
  - The survey moved into `install.sh --survey` and no longer blocks the first session (R-08). The profile keeps `Known stacks` (R-10).
  - Docs reorganised by reader journey, with a separate maintainers section (D-18).
- **VI:**
  - Đổi tên dự án thành **anti-brainrot**: thư mục dữ liệu giờ là `~/.anti-brainrot/` và `.anti-brainrot/`, dòng đánh dấu là `anti-brainrot:begin/end`. Các lệnh `mentor:` giữ nguyên.
  - Bỏ SHIP và bỏ mode theo repo (D-13). Mọi task chạy BUILD. Khái niệm mới ở mảng bị siết chạy LEARN cho tới khi vượt qua (R-18).
  - Không có lệnh tắt. Rules chỉ chạy trong git repo (R-20).
  - Thêm bước brainstorm có điều kiện dừng (R-19).
  - Câu hỏi kiểm tra giờ hỏi theo task hoặc commit, số câu tùy theo mảng. Có câu về test case, và AI không commit khi còn câu chưa xong (R-04, R-21). Kết quả chấm chỉ đổi khi có bằng chứng (R-22).
  - Ranh giới logic và vỏ có dấu hiệu cụ thể (R-16). Rule của project chỉ thắng về convention và quy trình (R-14).
  - Survey chuyển vào `install.sh --survey`, không còn chặn session đầu tiên (R-08). Profile có thêm mục `Known stacks` (R-10).
  - Docs tổ chức lại theo hành trình người đọc, tách riêng phần cho người duy trì (D-18).

## 0.1.0 — 2026-10-29

- **EN:** First version: LEARN / BUILD / SHIP modes, draft requirement, hint ladder, check questions, chat-based survey.
- **VI:** Phiên bản đầu tiên: mode LEARN / BUILD / SHIP, bản nháp bắt buộc, thang gợi ý, câu hỏi kiểm tra, survey trong chat.
