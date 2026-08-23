# quality/05 — checklist XONG: giai đoạn ĐÃ CÓ compiler

> Cập nhật **2026-08-24** · Lane sở hữu: **NON-CODE** · Trần của chính file: §5.
> Nhà duy nhất của câu hỏi **"task này XONG chưa"** cho task **có code**, kể từ khi lệnh máy chạy được.
> Giai đoạn chưa có compiler ở nhà khác — [rule mục 3](../.claude/rules/quan-ly-du-an.md) — và **vẫn còn
> hiệu lực** cho lane NON-CODE và BA. File này **tiếp nối** bốn vế của mục đó, **không** thay và không chép.
> Câu hỏi khác *"đầu ra có TỐT không"*: [guideline](00-guideline-chat-luong.md) — thang T0–T3 §3, năm trục
> §4, luật biên nhận âm §5 giữ nguyên hiệu lực ở đây, file này chỉ **thêm** vế mức code lên trên.
> Ba thứ không bao giờ thoả hiệp kể cả khi gấp:
> [prompt-fullstack §6.9](../project_preparation/prompt-fullstack.md) — trỏ, không chép.
> Chạy các vế này **lúc nào** là nhà của [rule mục 4](../.claude/rules/quan-ly-du-an.md) và
> [guideline §6](00-guideline-chat-luong.md): mỗi task → tầng 1. File này **không** mở nhịp thứ hai.

## §1 Bảy vế XONG — hai hạng, đừng trộn

Nguồn duy nhất: [prompt-fullstack §6.5](../project_preparation/prompt-fullstack.md). Bảy vế **không cùng
hạng**. Bốn vế hạng A áp mọi task có code. Ba vế hạng B mở đầu bằng *"…thì"*: chỉ áp khi task **chạm**
đúng thứ nó nêu — đòi `down` ở task không động vào DB là đẻ việc, bỏ qua nó ở task có migration là bỏ lọt.

**Hạng A — áp mọi task có code, không ngoại lệ:**

- [ ] Lệnh **tầng 1** xanh — build · lint · unit test · typecheck — và **output dán vào câu trả lời**.
- [ ] Có **≥ 1 test happy path** *và* **≥ 1 test case lỗi**. Chỉ một trong hai không tính là có test.
- [ ] Lỗi hiện ra cho người dùng bằng **tiếng Việt kèm hành động cụ thể** — quán đọc màn hình lúc đông khách, "lỗi hệ thống" không nói được phải làm gì tiếp.
- [ ] Log có **mã truy vết** đi theo một yêu cầu từ đầu tới cuối, đủ để debug **tại quán** mà không cần dựng lại ca đó.

**Hạng B — chỉ áp khi task chạm đúng thứ đó:**

- [ ] **Chạm DB** ⇒ migration có **cả `up` và `down`**, và `down` đã chạy thử thật một lần, không phải chỉ viết ra.
- [ ] **Đổi endpoint** ⇒ cập nhật hợp đồng API **và** FE **sinh lại type** từ hợp đồng mới; hai vế, thiếu một vế thì FE tin vào hình dạng cũ.
- [ ] **Có UI** ⇒ thử ở **375px** (khách) *và* **768px** (tablet). Số 375 là số owner chốt 2026-08-24 theo [§3.7](../project_preparation/prompt-fullstack.md); §6.5 còn ghi 360 — chỗ lệch đó là [F-27](../finding.md#f-27).

## §2 Vế nào đo bằng lệnh nào — cái gì chạy được hôm nay

| Vế | Lệnh | Chạy được chưa |
|---|---|---|
| tầng 1 (Go) | `go build ./...` · `go vet ./...` · `go test ./...` | ⚠️ repo chưa có `go.mod` — lane BE mở ở T-08 |
| tầng 1 (Next) | `npm run build` · `npm run lint` · `npx tsc --noEmit` | ⚠️ repo chưa có `package.json` — lane FE mở ở T-09 |
| happy path + case lỗi | `go test -run 'Happy\|Loi' -v ./...` — đếm **hai** tên test, không đếm số dòng PASS | ⚠️ cùng điều kiện với tầng 1 (Go) |
| `up` + `down` | chạy `down` rồi `up` lại trên bản restore, so hai lần dump | ⚠️ lane DB mở ở T-07 |
| sinh lại type | `git status --short` sau khi sinh type: **rỗng** ⇒ type đang khớp hợp đồng | ⚠️ lane FE mở ở T-09 |
| 375px + 768px | chụp hai bề rộng, đính vào câu trả lời — mắt người, không có lệnh | ⚠️ lane FE mở ở T-09 |
| tiếng Việt + mã truy vết | `grep -rn` mẫu thông báo lỗi và mẫu mã truy vết trong handler | ⚠️ lane BE mở ở T-08 |
| cổng tài liệu | `make check` | ✅ chạy được từ `9699f1c` — nhưng nó **không** phải tầng 1: nó rà sổ và trần, không build gì cả |

⚠️ ở cột cuối nghĩa là **chưa được khai làm biên nhận** ([CLAUDE.md §7](../CLAUDE.md)). `go` và `npm` **có
trên máy**; thứ còn thiếu là `go.mod`/`package.json` và code — vế nào còn ⚠️ thì lane sinh ra nó gỡ ⚠️ ngay
trong task mở lane. Hai chỗ luật còn khai `make` là ⚠️ trong khi nó đã xanh: [F-23](../finding.md#f-23).

## §3 Cái gì **không** tính là XONG ở giai đoạn này

Lệnh chưa chạy mà khai xanh · dán lệnh không dán output · test chỉ-xanh cho một task **sửa lỗi**
(phải có đỏ trước, xanh sau, dán cả hai — [§6.7](../project_preparation/prompt-fullstack.md)) ·
tầng 1 xanh nhưng vế hạng B bị bỏ qua trong khi task có chạm DB/endpoint/UI ·
đủ bảy vế nhưng thiếu ba thứ của [CLAUDE.md §4](../CLAUDE.md) (biên nhận + commit + `finding.md` đổi trạng thái).

Bảy vế ở §1 trả lời **XONG**, không trả lời **TỐT**: đủ cả bảy mà đầu ra vẫn có thể đạt T0 rồi dừng ở đó.
Sàn ✅ tối thiểu **T2** là luật của [guideline §3](00-guideline-chat-luong.md), file này không nới nó.

## §4 Ranh giới — file này **không** sở hữu cái gì

Nhịp chạy (rule mục 4) · thang T0–T3 và năm trục (guideline §3 §4) · ba thứ không thoả hiệp (§6.9) ·
định nghĩa XONG cho task **không có code** (rule mục 3) · vế riêng của từng pha — đó là **tầng pha**
`quality/0n-pha-<n>-<tên>.md` ([guideline §7](00-guideline-chat-luong.md)), mở sau khi lane của pha mở,
và tầng pha chỉ được **thêm** vào bảy vế này, cấm viết lại chúng.

## §5 Trần của chính file

Trần: **75 dòng** · mỗi mục ≤ 20 dòng · mỗi dòng ≤ 400 byte. Ba lệnh kiểm:

```bash
wc -l < quality/05-checklist.md              # ≤ 75
awk 'length > 400' quality/05-checklist.md   # rỗng
grep -c '^- \[ \]' quality/05-checklist.md   # đúng 7 — bảy vế §6.5, không hơn không kém
```
