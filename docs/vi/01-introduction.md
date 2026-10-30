🇻🇳 Tiếng Việt | [🇬🇧 English](../en/01-introduction.md) · [Mục lục](README.md) · Tiếp: [02 · Bắt đầu](02-getting-started.md)

# 01 · Giới thiệu

> **TL;DR**
> - Giao hết việc cho AI làm developer mất dần khả năng hiểu và debug code. Hiện tượng này gọi vui là "nhũn não".
> - anti-brainrot **không cấm dùng AI**. AI vẫn viết code, nhưng bạn luôn giữ phần tư duy: định nghĩa vấn đề, thiết kế, review.
> - Không có nút tắt. Hotfix production cũng cần developer hiểu cách sửa.

## Vấn đề

Một kiểu dùng AI rất phổ biến: dán yêu cầu vào, nhận code về, chạy được thì commit. Cách này nhanh. Nhưng dần dần nhiều developer nhận ra mình:
- không debug được nếu không có AI;
- không giải thích được đoạn code vừa commit;
- lười tự nghĩ ra giải pháp hay flow, chờ AI đề xuất.

Thứ bị mất **không phải là kỹ năng gõ code**. Thứ bị mất là kỹ năng **đánh giá code**. Mà trong thời AI, đánh giá code lại chính là việc quan trọng nhất: AI viết 500 dòng trong một phút, còn người quyết định có dùng 500 dòng đó hay không là bạn.

## Bằng chứng

| Nghiên cứu | Kết quả chính | Hạn chế |
|---|---|---|
| [Anthropic, RCT 01/2026](https://www.anthropic.com/research/AI-assistance-coding-skills) | 52 kỹ sư học một thư viện Python mới. Nhóm dùng AI đạt khoảng **50%** bài kiểm tra hiểu bài, nhóm tự gõ khoảng **67%**. Chênh lệch lớn nhất ở câu hỏi **debug**. Người dùng AI để *hỏi khái niệm* vẫn đạt khoảng 65% trở lên. | Phiên học ngắn, đo ngay sau khi làm, chưa đo khả năng nhớ lâu dài. |
| [Microsoft & CMU, CHI 2025](https://www.theregister.com/2025/02/11/microsoft_study_ai_critical_thinking/) | Khảo sát 319 knowledge worker. Ai càng tin AI thì càng bỏ ít công sức vào tư duy phản biện. | Dữ liệu tự khai, chỉ cho thấy tương quan. |
| [Chen, Kalyuga & Sweller, 2016](https://repository.lboro.ac.uk/articles/journal_contribution/The_worked_example_effect_the_generation_effect_and_element_interactivity/12053721) | Người mới gặp bài phức tạp học tốt hơn khi xem ví dụ mẫu trước rồi mới tự làm. | Nghiên cứu về học nói chung, không riêng về lập trình. |

Điều rút ra: **không phải cứ dùng AI là hại, cách dùng mới là vấn đề.** Giao hẳn việc cho AI làm bạn học kém đi. Còn dùng AI để hỏi, rồi tự kiểm chứng câu trả lời, thì vẫn học được.

## Cách anti-brainrot giải quyết

**Siết phần tư duy, không siết việc gõ phím.** Ở mọi task, bạn luôn giữ 3 việc:

| Việc | Bạn làm | AI làm |
|---|---|---|
| Định nghĩa vấn đề | Bài toán là gì, khi nào thì coi là xong | Hỏi lại chỗ mơ hồ |
| Thiết kế | Viết bản nháp, rồi brainstorm với AI cho tới khi tự nói lại được phương án | Đưa thông tin bạn còn thiếu, hỏi để lộ ra điểm mù |
| Review | Trả lời câu hỏi kiểm tra, kể cả câu "cần những test case nào?" | Đặt câu hỏi, chấm câu trả lời, không cho commit khi còn câu sai |

Có hai cách làm việc, và AI tự áp dụng theo profile của bạn:
- **BUILD** (mặc định): AI viết code sau khi bạn và AI đã thống nhất phương án.
- **LEARN** (tự bật cho **khái niệm mới ở mảng bạn còn yếu**): bạn xem ví dụ mẫu, rồi tự gõ phiên bản đầu tiên. Vượt qua rồi thì khái niệm đó chuyển sang BUILD.

Chi tiết từng bước ở [03 · Làm việc hằng ngày](03-daily-workflow.md).

## Là gì, và không phải là gì

| Là | Không phải |
|---|---|
| Rules dạng văn bản, cài vào file instruction global của từng tool AI | Công cụ cấm hay giới hạn số lần dùng AI |
| Một mentor khó tính ngồi cạnh bạn | Công cụ giám sát. Profile và lịch sử trả lời không bị commit, và không chia sẻ với team. |
| Áp lên *cách* AI làm việc với bạn | Thứ thay thế convention hay quy trình của project. Về convention và quy trình thì rule của project thắng. |

## Có hợp với bạn không?

**Hợp nếu bạn:**
- muốn vừa dùng AI hằng ngày vừa giữ và nâng kỹ năng;
- đang học một mảng mới, ví dụ frontend chuyển sang backend hay AI/LLM;
- chấp nhận chậm hơn một chút ở phần logic để đổi lấy việc hiểu code mình commit.

**Không hợp nếu bạn:**
- chỉ cần AI làm nhanh nhất có thể. Rules không có nút tắt, muốn bỏ thì phải gỡ cài đặt.
- muốn dùng nó để ép người khác. Rules chỉ hiệu quả với người tự muốn được "kèm".

## Dành cho team lead

- Mỗi người tự cài và tự làm survey. **Profile là thông tin cá nhân**, không dùng để đánh giá hay giám sát ai.
- Cách giới thiệu hiệu quả nhất: cho cả team đọc [03 · Làm việc hằng ngày](03-daily-workflow.md), rồi để mỗi người thử khoảng 1 tuần.
- Quy trình delivery của team (spec, PR template…) được giữ nguyên. Bản nháp và câu hỏi kiểm tra vẫn áp dụng bên trong quy trình đó.
