🇻🇳 Tiếng Việt (bản gốc) | [🇬🇧 English](../../en/maintainers/requirements.md) · [Mục lục](../README.md) · [decisions](decisions.md) · [testing](testing.md)

# Requirements

> **TL;DR**
> - Mỗi requirement có mã `R-xx`, lý do và vị trí rule trong [rules/mentor.md](../../../rules/mentor.md). Kịch bản kiểm tra nằm ở [testing.md](testing.md).
> - Muốn đổi hành vi thì sửa requirement trước, rồi mới sửa rule (xem quy trình ở cuối trang).
> - Bản tiếng Việt là bản gốc.

## Danh sách requirement

**Trạng thái:** `active` là đang áp dụng, `dropped` là đã bỏ. Dòng đã bỏ vẫn giữ lại để nhớ lý do. Mỗi section trong `rules/mentor.md` có comment `<!-- R-xx -->` để truy ngược về đây.

| ID | Requirement | Vì sao / bằng chứng | Rule | Trạng thái |
|---|---|---|---|---|
| <a id="r-01"></a>R-01 | ~~Chỉ developer được đổi mode~~ | Không còn mode theo repo ([D-13](decisions.md)) | — | dropped |
| <a id="r-02"></a>R-02 | Logic chỉ được viết sau bản nháp đủ 2/3: các bước chính, một điều đã cân nhắc, chỗ chưa chắc. Khái niệm LEARN ở mảng mức 1 chỉ cần mục 3. Bug fix không cần bản nháp (R-24). | "Lười đưa ra solution, flow" là dấu hiệu số 1. Người mới chưa thể tự liệt kê các bước (Sweller). | §3 | active |
| <a id="r-03"></a>R-03 | ~~Câu hỏi suy luận dùng thang gợi ý 3 nấc~~ | Thay bằng R-23, R-24, R-25 ([D-19](decisions.md)). Thang chỉ hợp khi AI đã biết đáp án, và người mới vào repo không trả lời được nấc 1. | — | dropped |
| <a id="r-04"></a>R-04 | Câu hỏi kiểm tra theo task hoặc commit. Số câu theo mảng: 2–3 / 1 / 0. Dạng "vì sao / nếu… thì sao", có câu về test case, ưu tiên câu đoán rồi chạy được. | Câu "làm gì" trả lời được mà không cần hiểu. Hỏi sau mỗi lần sửa gây mệt (F-05). Gộp việc kiểm chứng vào review. | §5 | active |
| <a id="r-05"></a>R-05 | Khái niệm LEARN: xem ví dụ mẫu khác bài, rồi tự gõ khoảng 15–40 dòng, tối đa ~60 phút | RCT Anthropic: nhóm tự gõ hiểu bài tốt hơn (67% so với 50%). Sweller: người mới nên xem ví dụ mẫu trước. **Con số 15–40 là ước lượng.** | §6 | active |
| <a id="r-06"></a>R-06 | Không để chỗ hổng ngầm. Phần để lại cho developer phải đánh dấu `TODO(you):` | Chỗ hổng ngầm dễ lọt vào commit thành bug | §8 | active |
| <a id="r-07"></a>R-07 | Không khen mặc định. Đúng một phần thì nói phần sai trước. | Model có xu hướng khen | §9 | active |
| <a id="r-08"></a>R-08 | Survey chạy lúc cài đặt. Chưa có profile thì AI vẫn làm việc, nhưng coi mọi mảng là mức 1. Mảng tự chấm 3–4 phải qua 1 câu kiểm tra. | Không chặn công việc ở session đầu (F-07). Người ta thường tự đánh giá quá cao. | §0 | active |
| <a id="r-09"></a>R-09 | Không commit dữ liệu cá nhân. `.anti-brainrot/` được thêm vào `.git/info/exclude`. | Không phải sửa `.gitignore` của team | §0 | active |
| <a id="r-10"></a>R-10 | Stack chưa có trong `Known stacks` thì AI hỏi mức kỹ năng, rồi thêm vào danh sách | Cần tiêu chí rõ thế nào là "stack mới" (F-14) | §0 | active |
| <a id="r-11"></a>R-11 | Câu tra cứu được trả lời thẳng, kèm nguồn | Quên syntax ít hại hơn lười nghĩ ra flow | §7 | active |
| <a id="r-12"></a>R-12 | Chỉ hỏi 1–2 edge case theo mức rủi ro, không đọc checklist | Đọc checklist thì developer sẽ bỏ qua luôn | §4 | active |
| <a id="r-13"></a>R-13 | ~~Ghi log khi chuyển sang SHIP~~ | Đã bỏ SHIP ([D-13](decisions.md)) | — | dropped |
| <a id="r-14"></a>R-14 | Về convention và quy trình thì project thắng. Bản nháp, brainstorm và câu hỏi kiểm tra vẫn áp dụng, trừ khi project cấm rõ ràng. | Nếu không, rules mất tác dụng ở repo công ty (F-12) | đầu file | active |
| <a id="r-15"></a>R-15 | Ghi kết quả vào `history.md` kèm mảng. `mentor: report` tính tỷ lệ đúng ngay lần đầu, theo từng mảng. | Cần biết rules có giúp được gì không. Bài kiểm tra không dùng AI để sang phase sau (P-07). | §5, §10 | active |
| <a id="r-16"></a>R-16 | Phân biệt logic và vỏ bằng dấu hiệu cụ thể: rẽ nhánh, thay đổi state, side effect, biến đổi dữ liệu. Kèm ví dụ cho React. | Code frontend trộn lẫn hai loại, AI sẽ phân loại mỗi lần một kiểu (F-09) | §1 | active |
| <a id="r-17"></a>R-17 | Developer giữ 3 việc: định nghĩa vấn đề, thiết kế, review (đã gộp kiểm chứng vào review) | Thời AI, đánh giá code quan trọng hơn gõ code | §2 | active |
| <a id="r-18"></a>R-18 | LEARN áp theo **khái niệm**: khái niệm mới ở mảng bị siết. Vượt qua thì ghi vào `Concepts passed` và chuyển sang BUILD. Đang LEARN thì AI không đưa logic hoàn chỉnh, kể cả trong chat. | Quyết định của tác giả (F-03). Đóng đường copy-paste từ chat. | §1, §6 | active |
| <a id="r-19"></a>R-19 | Brainstorm trước khi viết logic: AI đưa thông tin còn thiếu và hỏi để lộ ra điểm mù. Xong khi developer tự nói lại được phương án và AI hết câu hỏi. | Quyết định của tác giả (C3). Điều kiện dừng giúp brainstorm không kéo dài vô hạn. | §4 | active |
| <a id="r-20"></a>R-20 | Rules chỉ chạy trong git repo. Không có lệnh tắt hay đổi mode. | Hotfix cũng cần hiểu cách sửa (C2). Giới hạn phạm vi để không làm phiền khi dùng tool ngoài repo (F-13). | §0 | active |
| <a id="r-21"></a>R-21 | AI không tự `git commit` hay `git push` khi còn câu hỏi chưa trả lời hoặc trả lời sai. `questions.md` chỉ chứa câu hỏi của task hiện tại. | Trong tool agent, AI thường là người chạy commit (F-11) | §5 | active |
| <a id="r-22"></a>R-22 | Developer phản đối kết quả chấm thì AI kiểm chứng bằng code hoặc test, chỉ đổi kết quả khi có bằng chứng, và nhận sai khi chính nó sai | Thói nịnh có hai mặt: khen dễ dãi, và xuống nước khi bị cãi (F-10) | §5 | active |
| <a id="r-23"></a>R-23 | Phân loại câu hỏi theo vấn đề: hỏi lần lượt và dừng ở loại đầu tiên khớp (Bug, Thiết kế, Review, Giải thích, Ngữ cảnh codebase, Tra cứu). Giải thích và ngữ cảnh codebase được trả lời thẳng, kèm `file:line`, commit hoặc PR. Câu "vì sao thiết kế vậy" không có bằng chứng thì ghi `guess`. | Người mới vào repo thiếu ngữ cảnh chứ không thiếu khả năng suy luận. Ngữ cảnh là sự thật có sẵn trong code và git ([D-20](decisions.md)). | §7 | active |
| <a id="r-24"></a>R-24 | Bug: developer đưa triệu chứng, cách tái hiện, kết quả mong muốn, không cần giả thuyết. AI điều tra kèm nhật ký (giả thuyết → bằng chứng → kết luận) rồi sửa. Chưa tìm ra thì nói rõ và không sửa thử may. Fix phải ship khi chưa rõ nguyên nhân thì ghi `cause unconfirmed`. Bug trong code LEARN: chỉ ra chỗ sai, không viết fix. | Bug phải được xử lý trước, nếu không developer sẽ lách rules khi bị áp lực. Thang gợi ý giả định AI đã biết đáp án ([D-19](decisions.md)). | §7 | active |
| <a id="r-25"></a>R-25 | Mọi bug fix, kể cả hotfix và fix dưới 10 dòng: trước commit, developer tự mô tả điều kiện gây lỗi và vì sao cách sửa chặn được nó, cộng đúng 1 câu về test case. Phần này thay câu hỏi kiểm tra thường của §5. | Fix 1 dòng vẫn có thể có nguyên nhân sâu. Hai ý bắt buộc giúp chặn việc chép lại nhật ký của AI. Hotfix không có ngoại lệ (D-15). | §5 | active |

## Backlog

| ID | Ý tưởng | Trạng thái / lý do |
|---|---|---|
| P-01 | Pre-commit hook chặn commit khi `questions.md` còn câu chưa trả lời | Để sau. Git hook dùng được với mọi tool. |
| P-02 | Hook `UserPromptSubmit` của Claude nhắc lại trạng thái ở mỗi lượt | Để sau. Chỉ dùng được với Claude Code. |
| P-03 | Đoán output trước khi chạy | **Đã gộp vào R-04** (câu hỏi đoán rồi chạy) |
| P-04 | Bài tập bắt lỗi, có báo trước | Để sau |
| P-05 | Issue template "rule không hiệu quả" | Làm khi đã có người dùng ngoài |
| P-06 | `install.sh` cấp quyền cho Claude Code đọc và ghi `~/.anti-brainrot/**` | Để sau. Phải sửa `settings.json` của user. |
| P-07 | Bài kiểm tra không dùng AI mỗi 4 tuần (F-06) | Phase 2 |
| P-08 | Nói rõ bằng chứng là về học kỹ năng mới, không phải mất kỹ năng cũ (F-15) | Phase 2 |
| P-09 | Kịch bản chạy 3 lần, đặt rules ở đúng vị trí như khi cài thật (F-16) | Phase 2 |
| P-10 | Sửa nhỏ: đường dẫn exclude khi dùng git worktree, dòng trạng thái ở mỗi lần sửa code (F-17) | Phase 2 |

## Quy trình cập nhật

1. **Requirement:** sửa bảng ở trên (bản tiếng Việt). Requirement bỏ đi thì đổi sang `dropped`, không xóa dòng.
2. **Quyết định:** nếu thay đổi xuất phát từ một quyết định mới, ghi vào [decisions.md](decisions.md).
3. **Rule:** sửa `rules/mentor.md`, giữ comment `<!-- R-xx -->`.
4. **Kịch bản:** cập nhật [testing.md](testing.md), chạy lại trên ít nhất một tool, ghi kết quả.
5. **Docs người dùng:** sửa trang nào bị ảnh hưởng trong `docs/vi/`, rồi đến `docs/en/`.
6. **Version:** tăng `Version:` trong rules (thay đổi hành vi thì tăng minor, sửa chữ thì tăng patch). Ghi vào [CHANGELOG.md](../../../CHANGELOG.md).
7. **Kiểm tra:** chạy `./scripts/check-docs.sh`.
8. **Commit:** message dạng `rules(R-04): …`.
