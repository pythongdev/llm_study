# quality/01 — chất lượng NỘI DUNG: đầu ra có phải thứ đáng xây không

> Cập nhật **2026-08-25** · Lane sở hữu: **NON-CODE** · Trần của chính file: §8.
> Nhà duy nhất của câu hỏi **"nội dung này có ĐÚNG ĐỂ XÂY không"**. *XONG chưa* ở nhà khác
> ([rule mục 3](../.claude/rules/quan-ly-du-an.md) · [quality/05](05-checklist.md)), *có TỐT không* cũng vậy
> ([guideline](00-guideline-chat-luong.md)). File này **kế thừa nguyên** thang T0–T3 (§3), năm trục (§4),
> luật biên nhận âm (§5) của guideline và **chỉ thêm** sáu trục nội dung N1–N6 — chép lại chúng là đẻ nhà
> thứ hai ([CLAUDE.md §2](../CLAUDE.md)).

## §1 Ba câu hỏi, không phải hai — câu thứ ba chưa từng có nhà

| | **XONG?** | **TỐT?** | **ĐÚNG ĐỂ XÂY?** |
|---|---|---|---|
| Đo cái gì | phiên đã chạy đủ vế quy trình chưa | phiên **sau** dùng lại được không | đầu ra có phải **thứ được giao**, ở **pha này**, cho **quán này** không |
| Nhà | [rule mục 3](../.claude/rules/quan-ly-du-an.md) · [quality/05](05-checklist.md) | [guideline](00-guideline-chat-luong.md) | **file này** |
| Bỏ nó thì mất gì | phiên đánh ✅ khi hết giờ | repo đầy file **có mặt** mà không ai dùng được | repo đầy file sạch, nhất quán, dùng được — và **sai thứ** |

**XONG + TỐT mà không ĐÚNG** là dạng hỏng đắt nhất: nó qua mọi cổng đang có, được commit, rồi **thành nhà thật** cho phiên sau xây lên trên — chi phí hiện ở phiên thứ ba, dưới dạng *"làm lại từ đầu"*.
[F-33](../finding.md#f-33) là ca đã bắt được: 7/7 vế vệ sinh xanh, cái sai duy nhất là **thứ đã xây**.

## §2 Vì sao mọi phép đo đọc-bề-mặt đều mù với nội dung máy sinh

Văn trôi chảy, đủ mục, đúng khuôn, con trỏ giải được là thứ **rẻ nhất** mà máy sinh ra — nên `test -e`,
đếm mục, đếm gạch đầu dòng, vòng lặp con trỏ đang đo đúng cái máy **giỏi nhất** và mù với cái nó **dở nhất**.
Người làm sai việc thường sai cả cách làm nên bị bắt ở tầng 1; máy làm rất sạch đúng thứ nó hiểu nhầm.

**Luật gốc:** *không chấm nội dung bằng cách đọc lại* — đọc lại chỉ để phiên vừa viết xác nhận **ý định
của chính nó**. Chấm bằng **ánh xạ ngược về ô `Task`** và **lệnh in ra số dòng**; mỗi trục dưới đây có ít
nhất một trong hai. `<đầu ra>` là placeholder văn xuôi, thay bằng đường dẫn thật — và **chạy trên đầu ra
của task, không trên file này**: bốn probe dò đúng từ khoá mà §3 §4 liệt kê, chạy lên nhà của danh sách thì đỏ giả 100% ([F-11](../finding.md#f-11)).

## §3 N1–N3 · đúng việc · đúng pha · đúng cỡ quán

**N1 · Ánh xạ hai chiều với ô `Task`.** Mỗi vế của ô `Task` có một chỗ trong đầu ra **và** mỗi mục của đầu
ra truy ngược được về một vế. Chiều thuận đã có nhà ([guideline §4](00-guideline-chat-luong.md) trục *Đủ*);
chiều **nghịch** — đầu ra **dư** thứ không ai giao — chưa có nhà nào, và đó là chiều máy hỏng: nó xây rất
sạch một thứ **kề bên** thứ được giao.
· *Probe:* `grep -n '^## §' <đầu ra>` — cạnh mỗi dòng in ra phải nói được **vế nào** của ô `Task` đẻ ra nó.
· *Đỏ khi:* ≥ 1 mục không truy về vế nào (dư), hoặc ≥ 1 vế không có mục nào (thiếu).

**N2 · Đúng pha — không lấn, không hụt.** Đầu ra không chứa từ khoá của **pha sau**, và có đủ mục ở cột
*Đầu ra* của pha mình ([prompt-fullstack §7](../project_preparation/prompt-fullstack.md)). Máy biết cả
stack nên viết luồng nghiệp vụ pha 0 mà gọi thẳng tên bảng, tên cột, tên endpoint: nội dung đúng, **pha
sai**, và pha 2 thừa kế một thiết kế chưa ai duyệt.
· *Probe:* `grep -nE 'bảng |cột |migration|endpoint|/api/|SELECT|UNIQUE|CHECK\(' <đầu ra>` — pha 0 và pha 1 phải ra **rỗng**.
· *Đỏ khi:* ra ≥ 1 dòng ở pha 0/1, hoặc thiếu ≥ 1 mục cột *Đầu ra*. **Danh sách từ cấm từng pha** là của **tầng pha** `quality/0n-pha-<n>-<tên>.md` ([guideline §7](00-guideline-chat-luong.md)); file này giữ **cơ chế**, không giữ danh sách.

**N3 · Đúng cỡ quán — mỗi cơ chế phải có người dùng thật.** Mỗi cơ chế truy được về **một dòng**
[00-scope.md](../project_preparation/00-scope.md), **một ràng buộc** §4 hoặc **một bất biến** §6.2 của
[prompt-fullstack](../project_preparation/prompt-fullstack.md). Truy không ra ⇒ nó phục vụ một quán không
tồn tại. Corpus của máy toàn hệ lớn nên **mặc định của nó là hệ lớn**, và mỗi thứ nó thêm tự nó hợp lý — nên duyệt-bằng-đọc luôn gật.
· *Probe:* `grep -rniE 'multi-tenant|microservice|kafka|redis|cache|i18n|đa ngôn ngữ|event sourc|CQRS|replica|autoscal|OAuth|SSO|RBAC' <đầu ra>`
· *Đỏ khi:* một dòng in ra **không** kèm dòng `Vì:` trỏ nguồn giải được. §6.8 đã chốt **không hàng đợi · không cache · 1 instance · 1 VPS**: nghịch bốn dòng đó là **phá ràng buộc kiến trúc**, không phải "cải tiến".

## §4 N4–N6 · đúng nguồn · đối chiếu ngoài · có quyết định

**N4 · Không có số mồ côi.** Mọi **số, ngưỡng, tên trạng thái, tên vai** hoặc khớp nhà thật
([guideline §4](00-guideline-chat-luong.md) trục *Đúng*), hoặc mang nhãn `GIẢ ĐỊNH:` + mức rủi ro + ai chốt được — **không có ô thứ ba**.
Chế độ hỏng đắt nhất: máy không để trống chỗ nó không biết, nó điền một giá trị hợp lý — `20 giây`, `3 lần thử lại`, `15%`, `pending/confirmed/done` — trông y hệt giá trị đã chốt. Ba phiên sau, số đó **là** nhà thật vì không ai còn nhớ nó từ đâu ra.
· *Probe:* `grep -noE '[0-9]+ *(giây|phút|giờ|ngày|đ|%|px|lần|món|bàn)' <đầu ra> | sort -u` — mỗi số phải `grep` ra được ở nhà thật, hoặc nằm cùng đoạn với `GIẢ ĐỊNH:`.
· *Đỏ khi:* ≥ 1 số không ở cả hai chỗ. Nhãn tại chỗ là **cờ**, không phải nhà; nhà của giả định đã gom là [00-scope.md §6](../project_preparation/00-scope.md).

**N5 · Đối chiếu ngoài — nêu tên, hoặc khai chưa tra.** Mỗi **quyết định thiết kế** có một dòng ba vế:
`Ngoài: <tên gọi được của chuẩn/thực hành/hệ đã dùng> · Ta: <ta làm gì> · Vì: <lý do gắn với cỡ quán>`.
Một dòng bắt **cả hai chiều sai**: *tự nghĩ lại* thứ thế giới đã giải (thiếu vế `Ngoài:`) và *bê nguyên*
một chuẩn dự án không cần (vế `Vì:` trống hoặc chung chung). **Cấm viện dẫn vô danh** — *"chuẩn ngành",
"best practice", "người ta thường"* mà không kèm tên gọi được là **bịa có thẩm quyền**, dạng bịa khó cãi
nhất vì nó mượn uy tín của một nguồn không tồn tại. Không tra được ⇒ `Ngoài: ⚠️ chưa tra` + mở finding.
· *Probe:* `grep -nEi 'best practice|chuẩn ngành|thông lệ|người ta thường|industry standard' <đầu ra> | grep -v 'Ngoài:'`
· *Đỏ khi:* lệnh trên in ra ≥ 1 dòng, hoặc số dòng `Ngoài:` ít hơn số quyết định thiết kế trong file.

**N6 · Có quyết định — nước đôi là việc chưa làm.** Chỗ cần một quyết định thì đầu ra **chốt một** phương
án, phương án bị loại nêu kèm **lý do loại**; để ngỏ chỉ hợp lệ khi kèm **mã task hoặc mã finding** nhận việc chốt.
Máy né rủi ro bằng cách kết *"tuỳ nhu cầu"*: đọc thì thấy đủ, phiên sau vẫn phải quyết lại, chi phí đó **không hiện ở đâu**.
· *Probe:* `grep -nEi 'có thể (dùng|chọn|cân nhắc)|tuỳ (nhu cầu|trường hợp|bạn)|nên cân nhắc|linh hoạt' <đầu ra> | grep -vE 'T-[0-9]+|F-[0-9]+'`
· *Đỏ khi:* in ra ≥ 1 dòng.

## §5 Thủ tục chấm — bốn bước, không bước nào là "đọc lại"

1. **Trước khi gõ.** Tách ô `Task` thành **vế đánh số**, dán vào phiên. Không tách nổi ⇒ task vượt kích cỡ
   ([CLAUDE.md §6](../CLAUDE.md)), chẻ trước khi gõ chứ không chấm sau.
2. **Sau khi gõ, trước biên nhận.** Chạy **cả sáu** probe, **dán output**, kể cả output rỗng — rỗng là một
   kết quả, không phải lý do bỏ qua. Bỏ một probe = khai trục đó ĐẠT mà không đo.
3. **Viết phiếu sáu dòng** vào câu trả lời, cạnh bảng thay đổi ([bao-cao-thay-doi.md §1](../.claude/rules/bao-cao-thay-doi.md)):
   mỗi dòng `N<i> · ĐẠT|KHÔNG ĐẠT · dẫn chứng`, dẫn chứng là **số dòng hoặc output** — chữ *"đã rà"* không
   phải dẫn chứng. Phiếu không cần lưu vào sổ vì sáu probe **chạy lại được**; đó là chỗ nó khác lời khai.
4. **Phán quyết** theo §6.

Sáu probe đều là lệnh đọc lại nên chạy được **ngay ở giai đoạn chưa có compiler** ([CLAUDE.md §7](../CLAUDE.md)) — không vế nào của file này là lời hứa.

## §6 Phán quyết và ba nhãn tại chỗ

**Một trục KHÔNG ĐẠT ⇒ đầu ra bị trả lại.** Không có nợ, không có *"7/10 đi tiếp"* —
[guideline §2](00-guideline-chat-luong.md) đã cấm thang điểm, file này không nới. Sửa không xong trong phiên
thì **để lại nhãn tại chỗ**, đúng một trong ba, ngay dòng đang sai, **và** mở một dòng [finding.md](../finding.md) — im lặng đi tiếp là vi phạm vai trò khai ở [CLAUDE.md](../CLAUDE.md).

| Nhãn | Đặt khi | Trục | Ai gỡ |
|---|---|---|---|
| `GIẢ ĐỊNH:` | số/tên chưa có nhà thật, phiên tự điền | N4 | người dùng chốt ([CLAUDE.md §7](../CLAUDE.md)) |
| `THỪA?:` | cơ chế không truy về được scope/ràng buộc/bất biến | N3 | phiên sau, khi scope mở rộng hoặc khi xoá |
| `⚠️ chưa tra` | quyết định thiết kế chưa đối chiếu được nguồn ngoài | N5 | phiên có mạng, hoặc người dùng |

Nhãn là **cờ đỏ có hạn**, không phải chỗ trú: nhãn nào sống qua hai phiên mà không có mã finding đi kèm thì nó đã thành một lời nói dối yên tĩnh — đúng thứ cả bộ khung này dựng lên để chặn.

## §7 Ranh giới — file này **không** sở hữu cái gì

Thang T0–T3 · năm trục · biên nhận âm → [guideline §3 §4 §5](00-guideline-chat-luong.md) · định nghĩa XONG →
[rule mục 3](../.claude/rules/quan-ly-du-an.md) + [quality/05](05-checklist.md) · **từ cấm của từng pha** →
tầng pha `quality/0n-pha-<n>-<tên>.md` · phạm vi bán, giá, suất bán →
[00-scope.md](../project_preparation/00-scope.md) · ràng buộc kiến trúc ẩn → §6.8, nhà riêng mở ở
[T-33](../task.md) · **nhịp chạy** → [rule mục 4](../.claude/rules/quan-ly-du-an.md); file này **không** mở
nhịp thứ hai.

File này là **luật chữ**, tức một lời đề nghị. Cưỡng chế sáu probe thuộc hook `Stop` ([CLAUDE.md §8](../CLAUDE.md)) — việc đó là [T-35](../task.md), chưa làm.

## §8 Trần của chính file

Trần: **125 dòng** · mỗi mục **≤ 24 dòng** · mỗi dòng ≤ 400 byte. Ba lệnh kiểm:

```bash
wc -l < quality/01-chat-luong-noi-dung.md              # <= 125
awk 'length > 400' quality/01-chat-luong-noi-dung.md   # rỗng
awk '/^## §/{if(s&&n>24)print "VƯỢT TRẦN MỤC: "s" ("n")"; s=$0; n=0} {n++} \
     END{if(s&&n>24)print "VƯỢT TRẦN MỤC: "s" ("n")"}' quality/01-chat-luong-noi-dung.md
```
