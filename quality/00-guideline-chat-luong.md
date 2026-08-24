# quality/00 — guideline chất lượng: "TỐT" nghĩa là gì và đo bằng lệnh nào

> Cập nhật **2026-08-25** · Lane sở hữu: **NON-CODE** · Trần của chính file: §8.
> Nhà duy nhất của câu hỏi **"đầu ra có TỐT không"**. Câu hỏi **"task XONG chưa"** ở nhà khác —
> [rule §3](../.claude/rules/quan-ly-du-an.md); §1 nói vì sao hai câu hỏi không được trộn.
> Câu hỏi thứ ba — **nội dung có ĐÚNG ĐỂ XÂY không** (đúng việc được giao · đúng pha · đúng cỡ quán) — ở
> [quality/01-chat-luong-noi-dung.md](01-chat-luong-noi-dung.md): sáu trục N1–N6, kế thừa §3 §4 §5 dưới đây.
> File này **trỏ, không chép**: chép là đẻ nhà thứ hai, và bản chép sẽ lệch trong im lặng
> ([CLAUDE.md §2](../CLAUDE.md)).

## §1 XONG và TỐT là hai câu hỏi — trộn thì mất cả hai

| | **XONG?** | **TỐT?** |
|---|---|---|
| Đo cái gì | một phiên đã chạy đủ 4 vế quy trình chưa | đầu ra có dùng được cho phiên **sau** không |
| Nhà | [rule §3](../.claude/rules/quan-ly-du-an.md) | file này |
| Ai trả lời | phiên đang làm, ngay trước commit | phiên sau — nên phải đo trước, bằng lệnh |
| Bỏ nó thì mất gì | phiên đánh ✅ khi hết giờ | repo đầy file **có mặt** mà **không ai dùng được** |

Một task **XONG mà không TỐT** trông y hệt một task tốt: `test -e` xanh, `grep -c '^- '` ra `3` xanh —
trong khi ba dòng đó là ba dòng rác. Vế 2 của rule §3 (*nội dung đúng hình dạng*) đo đúng cái nó hứa:
**hình dạng**. Nó không đo nội dung, và không định đo. Lỗ đó là lý do file này tồn tại.

## §2 Định nghĩa chất lượng — một câu, không có thang điểm

**Một đầu ra là TỐT khi một phiên mới — chỉ được nạp gói của nó, không được hỏi người — làm tiếp được
việc kế tiếp mà không phải quay lại hỏi.** Mọi luật dưới đây chỉ là cách đo câu đó bằng lệnh.

Chỉ có **ĐẠT / KHÔNG ĐẠT**, không chấm điểm 1–10. Điểm số mời gọi câu *"7/10 là đủ rồi, đi tiếp"*, và
"đi tiếp" đó chính là lúc nợ chất lượng vào repo mà không dòng nào ghi lại.

## §3 Thang biên nhận — bốn tầng, mỗi tầng lọt một loại rác khác nhau

| Tầng | Trả lời câu | Lệnh mẫu | Cái gì **lọt qua được** nó |
|---|---|---|---|
| **T0 · tồn tại** | file có thật không | `test -e` · `wc -l` > 0 | file rỗng nghĩa; file chép nguyên từ chỗ khác |
| **T1 · hình dạng** | có đủ mục, cột, ngưỡng không | `grep -c '^## '` · đếm cột · `head -6` frontmatter · `awk 'length > 400'` | đủ mục nhưng nội dung bịa hoặc sai |
| **T2 · nhất quán** | có khớp phần còn lại của repo không | vòng lặp con trỏ [rule §5.1](../.claude/rules/quan-ly-du-an.md) · `grep` đối chiếu **hai** file · ngày khai so `git log -1 --format=%ad -- <file>` | nhất quán nhưng thiếu đúng thứ phiên sau cần |
| **T3 · dùng được lạnh** | phiên mới có làm tiếp được không | **diễn tập**: phiên mới chỉ nạp gói, làm thử bước kế tiếp, ghi lại mọi chỗ nó phải hỏi | — (đỏ khi còn **một** câu hỏi) |

**Luật sàn.** Đánh ✅ tối thiểu ở **T2**. T0/T1 một mình chỉ chứng minh *"đã tạo file"*, không phải *"xong"*.
**T3 bắt buộc** cho file mà phiên khác sẽ nạp: `CLAUDE.md`, mọi `.claude/rules/**`, mọi `quality/**`, và
mọi file đứng trong ô `Nạp` của một dòng [task.md](../task.md).

## §4 Năm trục đo — áp cho mọi đầu ra, mọi pha, mọi step

| Trục | Mệnh đề phải đúng | Sai điển hình | Họ lệnh đo | Tầng |
|---|---|---|---|---|
| **Đúng** | mọi mệnh đề khớp nhà thật của nó ([CLAUDE.md §2](../CLAUDE.md)) | chép số liệu theo trí nhớ của phiên trước | `grep` cùng chuỗi trên **cả hai** file, so số ra | T2 |
| **Đủ** | đủ mọi vế đã hứa ở ô `Task`, không dư vế nào | làm 2 trong 3 vế rồi đánh ✅ | đếm từng vế bằng mẫu riêng của vế đó | T1 |
| **Một nhà** | không tồn tại bản chép thứ hai của cùng một sự thật | "trỏ cho tiện" rồi chép luôn nội dung | `grep -rn '<câu đặc trưng>' .` ra đúng **1** file | T2 |
| **Rẻ để đọc** | trong trần dòng/byte; `grep -n` thay được việc đọc cả file | mục phình dần, không lệnh nào thấy | `wc -l` · `awk 'length > N'` · đếm dòng **từng mục** (§8) | T1 |
| **Dùng được lạnh** | phiên mới không phải hỏi thêm gì | file chỉ hiểu được nếu đã dự hội thoại hôm nay | diễn tập T3 | T3 |

## §5 Luật biên nhận âm — biên nhận không đỏ được là biên nhận giả

Mỗi biên nhận phải khai kèm một vế **"đỏ khi …"**, và người viết phải **thử làm nó đỏ đúng một lần**
trước khi commit: sửa hỏng tạm → chạy → thấy đỏ → `git checkout -- <file>` khôi phục. Chưa thấy nó đỏ
lần nào thì chưa ai biết nó đang đo cái gì.

1. **Ngưỡng dưới đặt trên thứ dễ đẻ** — `grep -c '^- ' >= 3`: ba dòng rác cũng xanh, và xanh **vĩnh viễn**.
   Sửa: đếm thứ **khó bịa** (con trỏ giải được, mã khớp nhà thật), hoặc kèm một lệnh đối chiếu.
2. **Chỉ chạm một file — đúng cái file mình vừa gõ.** Nó chứng minh *"tôi đã gõ"*, không chứng minh
   *"đúng"*. Sửa: biên nhận T2 phải chạm **≥ 2 file**, một trong đó là nhà thật của mệnh đề.
3. **Không bao giờ xanh được** — hỏng theo chiều ngược lại, xem [F-11](../finding.md#f-11). Biên nhận
   luôn đỏ bị bỏ qua sau hai lần, và từ lần thứ ba nó không còn là cơ chế gì nữa.

## §6 Ba cổng — đo lúc nào, không mở nhịp mới

| Cổng | Trước khi | Đạt khi |
|---|---|---|
| **nạp** | gõ ký tự đầu tiên | mọi đường dẫn trong gói `test -e` ra thật · finding 🔴 chạm file này đã đọc ([CLAUDE.md §3](../CLAUDE.md) bước 3) |
| **commit** | `git commit` | biên nhận đạt **T2**, output dán vào · bảng thay đổi ([bao-cao-thay-doi.md](../.claude/rules/bao-cao-thay-doi.md) §1) |
| **rà** | theo nhịp, không theo hứng | đúng nhịp [rule §4](../.claude/rules/quan-ly-du-an.md) — file này **không** mở nhịp thứ hai |

Ba thứ không bao giờ thoả hiệp kể cả khi gấp:
[prompt-fullstack.md](../project_preparation/prompt-fullstack.md) §6.9 — trỏ, không chép.

## §7 Ba tầng chất lượng — chung → pha → step

File này là **tầng chung**. Hai tầng dưới kế thừa nguyên §3 §4 §5 và **chỉ được thêm**, cấm chép lại:

- **Tầng pha** — `quality/0n-pha-<n>-<tên>.md`: (a) mệnh đề riêng của pha · (b) lệnh đo riêng ·
  (c) **ranh giới pha** — nhắc tới cái gì là đã lấn pha sau
  ([prompt-fullstack §7](../project_preparation/prompt-fullstack.md)).
- **Tầng step** — hai ô của một dòng [task.md](../task.md): `Đầu ra kiểm chứng được` = `<lệnh>` + `đỏ khi
  <…>` (§5), số vế ≥ số trục §4 task chạm · ô `Chất lượng` + bảng `### cl-T-xx` = tầng sàn §3 + trục §4 +
  lệnh soi chạm ≥ 2 file + dòng `**Đã thử làm đỏ:**`, chỗ duy nhất ghi lại việc §5 đòi.

Nhà chất lượng từng pha — **cả sáu ⚠️ chưa có**, mỗi cái mở sau khi lane của pha mở ([CLAUDE.md §1](../CLAUDE.md)):
**0 · BA** sau [T-02](../task.md) · **1 · System design** ⚠️ chưa có task mở lane · **2 · DB** sau [T-07](../task.md) ·
**3 · BE** sau [T-08](../task.md) · **4 · FE** sau [T-09](../task.md) · **5 · Deploy** sau [T-03](../task.md) + [T-06](../task.md).

Khi `Makefile` đã có, định nghĩa XONG mức compiler về `quality/05-checklist.md` ([T-04](../task.md));
file đó **tiếp nối** thang §3 ở T1/T2, không thay nó.

## §8 Trần của chính file

Trần: **115 dòng** · mỗi mục **≤ 18 dòng** · mỗi dòng ≤ 400 byte. Ba lệnh kiểm:

```bash
wc -l < quality/00-guideline-chat-luong.md              # ≤ 115
awk 'length > 400' quality/00-guideline-chat-luong.md   # rỗng
awk '/^## §/{if(s&&n>18)print "VƯỢT TRẦN MỤC: "s" ("n")"; s=$0; n=0} {n++} \
     END{if(s&&n>18)print "VƯỢT TRẦN MỤC: "s" ("n")"}' quality/00-guideline-chat-luong.md
```

Lệnh thứ ba là thứ [CLAUDE.md §8](../CLAUDE.md) đang thiếu ([F-08](../finding.md#f-08)): trần đặt cho
từng mục mà không có lệnh kiểm từng mục thì không phải trần, chỉ là lời chúc.
