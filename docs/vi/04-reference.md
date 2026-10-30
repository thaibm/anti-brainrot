🇻🇳 Tiếng Việt | [🇬🇧 English](../en/04-reference.md) · [Mục lục](README.md)

# 04 · Tra cứu

## Lệnh

Gõ trong chat của tool AI:

| Lệnh | Tác dụng |
|---|---|
| `mentor: status` | Xem version rules, mảng đang bị siết, khái niệm đang LEARN và đã vượt qua, câu hỏi chưa trả lời |
| `mentor: lang <ngôn ngữ>` | Đổi ngôn ngữ trả lời cho repo hiện tại |
| `mentor: report` | Xem tỷ lệ trả lời đúng ngay lần đầu, theo từng mảng, so sánh 4 tuần gần nhất với trước đó |
| `mentor: survey` | AI nhắc bạn chạy lại `./install.sh --survey` |

Không có lệnh tắt rules hay đổi mode. Đây là chủ ý.

## Tiêu chí

### Bản nháp đủ

Cần ít nhất **2 trong 3**:
1. Các bước chính (3–5 dòng).
2. Một điều đã cân nhắc (dữ liệu đi qua đâu, hoặc một edge case).
3. Chỗ chưa chắc (một câu hỏi cụ thể).

Ngoại lệ: khái niệm LEARN ở mảng **mức 1** chỉ cần mục 3, cộng với việc bạn muốn làm được gì.

| Yêu cầu | Đủ chưa? |
|---|---|
| "Làm login đi, chắc dùng JWT." | Chưa. Mới chỉ nêu tên công nghệ. |
| "Login: POST email/pass → check DB → trả JWT cookie httpOnly. Chưa biết refresh token." | Đủ |
Dán spec dài hơn ~30 dòng mà phần phân tích của bạn chưa tới 1 câu thì AI yêu cầu bạn phân tích trước.

Bug không cần bản nháp, chỉ cần **triệu chứng, cách tái hiện và kết quả mong muốn**:

| Báo bug | Đủ chưa? |
|---|---|
| "Lỗi 500, fix đi" kèm log | Chưa. Thiếu cách tái hiện và kết quả mong muốn. |
| "Trang profile lỗi 500 với user mới đăng ký. Tái hiện: đăng ký rồi mở /profile. Mong đợi: hiện trang profile trống." | Đủ, dùng được cả cho hotfix |

### Loại câu hỏi

AI hỏi lần lượt và dừng ở loại đầu tiên khớp:

| Thứ tự | Loại | Ví dụ | AI làm gì |
|---|---|---|---|
| 1 | Bug | "Trang profile lỗi 500 với user mới" | Điều tra kèm nhật ký, sửa, rồi bạn mô tả nguyên nhân và cách sửa trước khi commit |
| 2 | Thiết kế | "Nên cache ở FE hay BE?" | Phần ngữ cảnh trả lời thẳng. Phần quyết định đi qua bản nháp và brainstorm |
| 3 | Review | "Code mình viết ổn không?" | Hỏi bạn input/output, một cách nó có thể hỏng, test case cần có. Sau đó chỉ thẳng vấn đề, kèm `file:line` |
| 4 | Giải thích | "`useEffect` cleanup chạy lúc nào?" | Trả lời thẳng. Khái niệm đang LEARN thì giải thích bằng ví dụ khác bài |
| 5 | Ngữ cảnh codebase | "Ai gọi `getProfile()`?", "Vì sao module này tách riêng?" | Trả lời thẳng, kèm `file:line`, commit hoặc PR. Không có bằng chứng cho câu "vì sao" thì ghi `guess` |
| 6 | Tra cứu | Syntax, tên API, flag | Trả lời thẳng, kèm nguồn |

Câu hỏi gộp nhiều loại thì được tách ra, xử lý từng phần theo đúng loại.

### Logic và vỏ

Code là **logic** nếu có ít nhất một trong các đặc điểm: rẽ nhánh theo dữ liệu, thay đổi state, có side effect (gọi API, ghi DB, timer, storage), hoặc biến đổi dữ liệu. Phần còn lại là **vỏ**.

| Code | Loại |
|---|---|
| Component chỉ render props ra markup tĩnh và class | Vỏ |
| `useState`, `useEffect`, render có điều kiện theo dữ liệu fetch về, handler `onSubmit` | Logic |
| Sửa Tailwind hoặc CSS, `tsconfig`, danh sách route không có guard | Vỏ |
| Validate form, route guard, map response API sang dữ liệu hiển thị | Logic |

### Câu hỏi kiểm tra

| Trường hợp | Số câu hỏi |
|---|---|
| Logic ở mảng bị siết | 2–3 |
| Logic ở mảng đã thạo | 1 |
| Thay đổi dưới ~10 dòng logic | 0 |
| Bug fix, mọi kích cỡ, kể cả hotfix | Mô tả nguyên nhân và cách sửa, cộng 1 câu về test case |

- Hỏi theo **task hoặc commit**, không hỏi sau mỗi lần sửa.
- Câu hỏi luôn ở dạng "vì sao" hoặc "nếu… thì sao", không bao giờ ở dạng "đoạn này làm gì". Có ít nhất một câu về test case. Ưu tiên câu mà bạn có thể đoán kết quả rồi chạy thử để kiểm chứng.
- Kết quả chấm có 3 mức: **đúng**, **thiếu ý gì**, **sai vì sao**.
- Còn câu chưa trả lời hoặc trả lời sai thì AI không tự `git commit` hay `git push`.

### Mảng bị siết và LEARN

- **Mảng bị siết** là mảng chấm 1–2 trong profile, hoặc mảng bạn tự đánh dấu là siết.
- **Khái niệm mới ở mảng bị siết chạy LEARN:**
  1. Xem ví dụ mẫu tương tự nhưng khác bài.
  2. Đóng ví dụ lại, tự gõ khoảng 15–40 dòng, tối đa khoảng 60 phút.
  3. Trả lời câu hỏi kiểm tra.
- **Vượt qua** khi code chạy được và bạn trả lời đúng hết. Khái niệm đó được ghi vào `Concepts passed` và từ đó chạy BUILD.

## File dữ liệu

| Đường dẫn | Nội dung | Có bị commit không? |
|---|---|---|
| `~/.anti-brainrot/profile.md` | Mức kỹ năng, stack, khái niệm đã vượt qua, lịch sử thay đổi mức | Không, nằm ngoài repo |
| `~/.anti-brainrot/templates/` | Template profile và repo | Không |
| `<repo>/.anti-brainrot/repo.md` | Ngôn ngữ trả lời riêng của repo (không bắt buộc) | Không, có trong `.git/info/exclude` |
| `<repo>/.anti-brainrot/questions.md` | Câu hỏi kiểm tra của task hiện tại | Không |
| `<repo>/.anti-brainrot/history.md` | Kết quả câu hỏi kiểm tra | Không |
| File global của từng tool | Rules, nằm giữa hai dòng `anti-brainrot:begin` và `anti-brainrot:end` | Không phải repo |

## FAQ

**Có làm tôi chậm hơn không?**
Có, ở phần logic và khi gặp khái niệm mới. Thời gian thêm vào chính là thời gian bạn hiểu code. Phần vỏ không chậm hơn.

**Không tắt được thật à?**
Đúng vậy. Hotfix cũng cần developer hiểu cách sửa: AI tìm và sửa bug, nhưng bạn phải giải thích được nguyên nhân và cách sửa trước khi commit. Muốn bỏ hẳn thì chạy `./install.sh --uninstall`.

**Vì sao không siết chuyện quên syntax?**
Quên syntax ít hại hơn nhiều so với lười nghĩ ra flow. Câu tra cứu được trả lời thẳng.

**Repo công ty có quy trình riêng thì sao?**
Về convention và quy trình (cấu trúc code, test, PR, commit), project thắng. Bản nháp, brainstorm và câu hỏi kiểm tra vẫn áp dụng, trừ khi project cấm rõ ràng.

**Profile của tôi có riêng tư không?**
Profile không bị commit và không chia sẻ với team. Tuy vậy, nội dung profile vẫn được gửi tới nhà cung cấp AI trong mỗi session, giống như mọi nội dung khác bạn đưa vào tool.

## Giới hạn đã biết

- **Rules dạng văn bản không ép buộc tuyệt đối.** Session càng dài thì model càng dễ trôi về thói quen làm hộ. Hook để ép buộc đang nằm trong backlog.
- **Cursor:** phải dán rules bằng tay, và mỗi lần cập nhật rules phải dán lại.
- **Claude Code** hỏi quyền khi đọc hoặc ghi `~/.anti-brainrot/`. Hãy bấm cho phép.
- **Codex** chạy trong sandbox có thể không ghi được vào `~/.anti-brainrot/`. Khi đó AI ghi vào thư mục trong repo và nhờ bạn chuyển ra ngoài. Có [báo cáo](https://github.com/openai/codex/issues/8759) rằng Codex 0.77 không đọc `AGENTS.md` global.
- **Antigravity và Gemini CLI** dùng chung `~/.gemini/GEMINI.md`, nên cả hai đều nhận rules.
- Đường dẫn file global của các tool được kiểm tra vào 10/2026.
