🇻🇳 Tiếng Việt (bản gốc) | [🇬🇧 English](../../en/maintainers/decisions.md) · [Mục lục](../README.md) · [requirements](requirements.md) · [testing](testing.md)

# Decision log

> **TL;DR:** Ghi lại mỗi quyết định thiết kế, lý do, và phương án đã loại. Quyết định cũ bị thay thế thì không xóa, mà ghi "thay bằng D-xx".

| # | Quyết định | Lý do | Phương án đã loại | Trạng thái |
|---|---|---|---|---|
| D-01 | Rules dạng văn bản trước, hook sau | Văn bản dùng được với mọi tool. Hook phụ thuộc từng tool (trừ git hook). | Làm hook ngay từ đầu | active |
| D-02 | Chép nguyên văn rules vào file global, giữa 2 dòng đánh dấu | Codex không hỗ trợ import. Dùng một cách cho mọi tool thì script đơn giản hơn. | `@import`, symlink | active |
| D-03 | Rules theo chuẩn `AGENTS.md`, viết bằng tiếng Anh | Nhiều tool đọc chuẩn này. Model làm theo tiếng Anh ổn định hơn. Ngôn ngữ trả lời chọn riêng. | Viết rules bằng tiếng Việt | active |
| D-04 | Kit có script cài global | Template chỉ áp được cho repo mới | GitHub template | active |
| D-05 | Exclude bằng `.git/info/exclude` | Không phải sửa file chung của team | `.gitignore` | active |
| D-06 | SHIP là lối thoát, có ghi log | Một cơ chế thay vì hai | Lệnh `OVERRIDE` | thay bằng D-13 |
| D-07 | Code luôn viết đầy đủ, rồi đặt câu hỏi kiểm tra | Cố tình để hổng logic dễ lọt bug vào commit | Rule gốc "cố tình để hổng logic" | active |
| D-08 | Bài tập bắt lỗi phải báo trước | AI ngầm nói sai thì developer có thể học luôn điều sai | AI cố tình nói sai mà không báo | active |
| D-09 | Làm lại survey mỗi khoảng 4 tuần | Đơn giản hơn việc theo dõi log liên tục | Fading tự động | active |
| D-10 | Ranh giới logic và vỏ dựa trên loại việc, có dấu hiệu cụ thể | Xem R-16 | Ranh giới theo công nghệ | active |
| D-11 | Không siết chuyện quên syntax | Xem R-11 | Bắt tự tra syntax | active |
| D-12 | Profile ở `~/.anti-brainrot/`, không gắn với tool nào | Mọi tool đều đọc được | `~/.claude/` | active |
| D-13 | **Bỏ SHIP và bỏ mode theo repo** | SHIP rẻ và "dính", nên sẽ thành mode chính (F-01). Mode theo repo không còn cần khi LEARN đi theo khái niệm. | Để SHIP tự hết hạn sau mỗi task | active |
| D-14 | LEARN áp theo khái niệm, vượt qua thì chuyển sang BUILD | Học diễn ra theo từng khái niệm, không theo từng repo (F-03) | LEARN theo repo | active |
| D-15 | Không có lệnh tắt rules | Hotfix cũng cần hiểu cách sửa (C2). Lối thoát duy nhất là gỡ cài đặt. | `mentor: off` có ghi log | active |
| D-16 | Survey chạy trên terminal lúc cài đặt | Không chặn session AI đầu tiên. Không cần AI ghi file vào `~` để tạo profile (F-07). | Survey trong chat | active |
| D-17 | Brainstorm dừng khi developer tự nói lại được phương án và AI hết câu hỏi | Giữ yêu cầu "hai bên thống nhất" nhưng có điểm dừng (C3) | Giới hạn cứng 3 câu hỏi | active |
| D-18 | Docs chia theo hành trình người đọc (01–04) và tách riêng `maintainers/`, cả hai ngôn ngữ | Người dùng không cần đọc R-xx. Người mới cần thứ tự đọc rõ ràng. | 4 file chia theo loại tài liệu (v0.1.0) | active |
| D-19 | **Bug: AI xử lý trước, developer phải hiểu và giải thích được trước khi commit** | Thang gợi ý giả định AI đã biết đáp án, và người mới vào repo không trả lời được nấc 1. Trong công việc thật, bug phải được xử lý trước. | Thang gợi ý 3 nấc (R-03). Thẻ bài học 3 lớp tech / dự án / business, sổ `learnings.md` và lệnh `mentor: drill`: quá rườm rà. | active |
| D-20 | Phân loại câu hỏi theo vấn đề, câu ngữ cảnh codebase được trả lời thẳng | Xem R-23 | Gộp mọi câu "vì sao" vào một loại | active |
