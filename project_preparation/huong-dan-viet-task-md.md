# Hướng dẫn viết task — **mỗi dòng task là một prompt hoàn chỉnh**

> Cập nhật **2026-08-23**. File này là **luật viết sổ task**, không phải sổ task.
> Nền lý thuyết: [cau-truc-prompt-tot.md](../prompt/huong_dan_prompt/cau-truc-prompt-tot.md) (11 thành phần
> của một prompt tốt) · Luật dự án: [prompt-fullstack.md §5–§8](prompt-fullstack.md) ·
> Định nghĩa "TỐT" + thang tầng T0–T3: [quality/00-guideline-chat-luong.md](../quality/00-guideline-chat-luong.md) ·
> Mẫu đã chạy thật: [reference/task.md](../reference/task.md) + [reference/CLAUDE_rẻence.md](../reference/CLAUDE_rẻence.md).
> File này lệch prompt-fullstack ⇒ **prompt-fullstack thắng**, dòng ở đây là bug phải sửa ngay.
>
> **Đọc file này một lần, không nạp lúc làm.** File này trả lời *"vì sao có ô đó, và điền nó bằng quy
> trình nào"*. Cái *"ô đó viết đúng cú pháp gì"* nằm ở [.claude/rules/quan-ly-du-an.md](../.claude/rules/quan-ly-du-an.md)
> §1 §1.1 — file `paths:` tự nạp đúng lúc bạn đang gõ vào `task.md`. Hai file lệch ⇒ **rule thắng**.
> Ranh giới đó vẫn đang là [F-04](../finding.md#f-04) 🔴 MỞ; T-12 là task cắt dứt điểm nó.

---

## Phần I — Task là gì

### 1.1 Định nghĩa

> **Task = một prompt hoàn chỉnh, đóng gói sẵn đủ 11 thành phần, để một session Claude Code
> trí nhớ trắng mở ra là làm được, làm xong trong một phiên, và để lại bằng chứng máy đọc được
> rằng nó đã xong.**

Ba chữ trong định nghĩa này gánh toàn bộ phần còn lại của file:

- **prompt hoàn chỉnh** — dòng task không phải nhãn dán việc, nó là **đầu vào của một session**.
  Thiếu thành phần nào thì session phải tự bịa thành phần đó, và nó bịa rất trôi chảy.
- **trí nhớ trắng** — người đọc dòng task **không có** hội thoại hôm qua, không biết bạn đã quyết gì.
  Mọi thứ không nằm trong file coi như không tồn tại.
- **bằng chứng máy đọc được** — "đã làm" không phải trạng thái, nó là **output của một lệnh**.

### 1.2 Bốn vế kích cỡ — vượt vế nào cũng phải chẻ trước khi làm

**1 lane · ≤ 3 file · 1 đầu ra kiểm chứng được · vừa một phiên làm việc** ([§5.2](prompt-fullstack.md)).

Dấu hiệu sai kích cỡ, chẻ ngay đừng thương lượng ([§5.6](prompt-fullstack.md)):
mô tả có chữ **"và"** nối hai danh từ khác nhau · chạm 2 tầng · không nói nổi biên nhận bằng **một**
lệnh · phải mở > 3 file mới hiểu · ước lượng vượt một phiên.

Lý do vế thứ tư ("vừa một phiên") là vế cứng nhất: task không vừa một phiên sẽ bị **tóm tắt context
giữa chừng**, và sau khi tóm tắt thì session mất chính xác thứ nó cần nhất — các quyết định nhỏ đã
đưa ra ở nửa đầu. Task đó không chậm hơn, nó **sai** hơn.

### 1.3 Phép thử "đây có phải task không" — hỏi trước khi gõ dòng nào

| Câu hỏi | Trả lời "không" ⇒ |
|---|---|
| Nó đẩy được **lát cắt A/B/C** ([§5.1](prompt-fullstack.md)) tiến thêm một đoạn? | Việc của pha sau, hoặc việc không cần làm ⇒ **xoá** |
| Tôi viết được **một lệnh** chứng minh nó xong? | Đây là **ý kiến**, không phải task ⇒ viết lại hoặc bỏ |
| Chạy hết kế hoạch y như nó viết thì dòng này **mất đi**? | Nó **còn** ⇒ đây là **finding**, không phải task (mục 2) |

---

## Phần II — Task khác finding chỗ nào

### 2.1 Hai sổ đo hai đại lượng khác nhau

| | **Task** | **Finding** |
|---|---|---|
| Đo cái gì | **xong / chưa** | **đúng / sai** |
| Bản chất | việc **chưa tới lượt xây** | cái **đang sai ngay bây giờ** |
| Câu mở đầu điển hình | *"chưa có X"*, *"cần thêm X"* | *"X và Y nói hai điều khác nhau"*, *"code khác thiết kế"* |
| Đóng bằng | **biên nhận** của lane: lệnh chạy thật + output | **mệnh đề sai hết đúng** + lệnh chứng minh |
| Bắt buộc để lại | commit + dấu ✅ | một dòng **`Bài học giữ lại:`** — luật nào đổi để không tái phát |
| Nhà | `task.md` (mỗi pha một sổ khi đã tách) | `finding.md` (mỗi pha một sổ khi đã tách) |
| Quan hệ | một finding **đẻ ra nhiều task** được | task **không bao giờ** nằm trong sổ finding |

### 2.2 Phép thử một câu ([§5.5](prompt-fullstack.md))

> Chạy hết kế hoạch đang viết (`step.md` + `task.md`) **y như nó viết** — dòng này **còn** không?
>
> **Còn** ⇒ **finding**. Kế hoạch không nói tới nó, nên nó không tự mất đi.
> **Mất** ⇒ **task**. Kế hoạch chạy xong là nó biến mất, tức nó chỉ là việc chưa tới lượt.

Ba ví dụ chạy phép thử:

| Dòng | Chạy hết kế hoạch thì | Kết luận |
|---|---|---|
| "Chưa có `Makefile` để chạy test" | Kế hoạch có task tạo `Makefile` ⇒ **mất** | **Task** |
| "`open_key` cho phép 2 phiên mở cùng bàn khi status = `billing`" | Kế hoạch không nhắc ⇒ **còn**, và vẫn thu sai tiền | **Finding** |
| "Tài liệu ghi đã sửa nhưng code chưa sửa" | **Còn**, mãi mãi | **Finding** ⚠️ MỞ LẠI |

### 2.3 Vì sao tuyệt đối không trộn hai sổ

Trộn thì mất cả hai cơ chế: **finding nằm trong sổ task sẽ bị đánh ✅ khi hết giờ** (vì sổ task đo
*xong/chưa*, mà "hết giờ" trông rất giống "xong"), còn **task nằm trong sổ finding sẽ không bao giờ
đóng được** (vì sổ finding đòi mệnh đề sai hết đúng, mà "chưa có X" thì không có mệnh đề nào sai).

Hệ quả viết lách trong `task.md`: **chỉ ghi mã `F-xx`, cấm mô tả lại nội dung finding.** Mô tả lại =
đẻ nhà thứ hai, và nhà thứ hai luôn trôi trong im lặng.

---

## Phần III — Vì sao một task phải mang đủ cấu trúc của một prompt tốt

Nguyên lý nền của [cau-truc-prompt-tot.md](../prompt/huong_dan_prompt/cau-truc-prompt-tot.md):
**bạn không ra lệnh cho model, bạn thu hẹp không gian câu trả lời.** Mỗi thành phần là một nhát cắt.

Với dự án nhiều phiên, điều đó đổi thành một câu gắt hơn:

> **Cái gì bạn không cắt trong dòng task, session sẽ tự chọn thay bạn — và nó chọn rất tự tin.**

| Thành phần thiếu trong dòng task | Session tự chọn cái gì | Hậu quả ở quán |
|---|---|---|
| Lane | tự đoán mình được sửa file nào | sửa file của lane khác, `git add -A` nuốt việc dở của người khác |
| Lý do ("hỏng thì mất gì") | coi mọi task quan trọng như nhau | làm task dễ trước, task dính tiền để lại cuối |
| Tiêu chí kiểm chứng | *"trông có vẻ đầy đủ"* | báo xong mà không lệnh nào chạy |
| Phạm vi | *"làm tốt = làm nhiều"* | sửa 1 bug, đổi 14 file |
| Xử lý bất định | trả lời khớp giả định của bạn | tài liệu ghi tên bảng không tồn tại, nghe rất hợp lý |

---

## Phần IV — Bảng ánh xạ: 11 thành phần prompt → 14 trường → 11 cột

Ba con số khác nhau, đừng lẫn: **11 thành phần** là lý thuyết prompt · **14 trường** là số sự thật một
dòng task phải mang · **11 cột** là số ô thật trong bảng, vì ba trường gộp vào ô `#` và ba mẩu gộp vào
ô `Context`. Phép trừ: `14 − 2` (mã+trạng thái+`Ưu tiên` → một ô `#`) `− 1` (`Nạp`+`Đã chốt`+`Bẫy` →
một ô `Context`) `= 11`.

| TP | Thành phần prompt | Trường trong dòng task | Cột thật | Bắt buộc? |
|---|---|---|---|---|
| — | *(không có trong 11 TP — thêm theo reference)* | **mã + trạng thái** | `#` | **Bắt buộc** |
| — | *(thêm theo reference)* | **`Ưu tiên` 🔺** | `#` (gộp) | Khi task chặn task khác |
| 1 | Vai trò và người đọc | **`Lane`** | `Lane` | **Bắt buộc** |
| 3 | Nhiệm vụ (động từ hành động) | **`Task`** | `Task` | **Bắt buộc** |
| 5 | Dữ liệu đầu vào và vị trí | **`Nạp`** | `Context` (gộp) | **Bắt buộc** |
| 2 | Bối cảnh (phần "đã biết") | **`Đã chốt`** | `Context` (gộp) | Nên có |
| 10 | Xử lý bất định | **`Bẫy`** + luật ⚠️ ở cột đầu ra | `Context` (gộp) | **Bắt buộc** |
| 9 | Quy trình (thứ tự ngoài) | **`Cần xong trước`** | `Cần xong trước` | Khi có phụ thuộc |
| 6 | Phạm vi và ràng buộc + **van xả** | **`Finding phải đóng`** + luật kích cỡ 1.2 | `Finding phải đóng` | **Bắt buộc** |
| 4 + 7 | Tiêu chí thành công + Định dạng đầu ra | **`Đầu ra kiểm chứng được`** — hỏi *hiện trạng đúng chưa* | `Đầu ra kiểm chứng được` | **Bắt buộc** |
| 11 | Tự kiểm tra — **nửa người** | **`Owner kiểm tra`** — hỏi *vừa đổi đúng chỗ không* | `Owner kiểm tra` | **Bắt buộc** (5.13) |
| 4 *(tầng hai)* | Tiêu chí thành công — mức **TỐT**, không phải mức XONG | **`Chất lượng`** — hỏi *phiên sau dùng được không* | `Chất lượng` | **Bắt buộc** (5.14) |
| 2 | Lý do ("vì...") | **`Hỏng thì mất gì`** | `Hỏng thì mất gì` | **Bắt buộc** |
| 8 | Ví dụ (few-shot) | **`Prompt mở session`** (3 dòng đầu là mẫu) | `Prompt mở session` | Khi task sắp giao |
| 11 | Tự kiểm tra — **nửa máy** | *không thành cột* — là **bốn thứ để đánh ✅** ở [CLAUDE.md §4](../CLAUDE.md) | — | Luôn |

**Ba ô cuối bảng hỏi ba câu khác nhau — gộp chúng là mất cả ba.** Đây là chỗ dễ sai nhất khi bê khuôn
này sang dự án mới:

| Ô | Câu hỏi nó trả lời | Thời điểm chạy | Ai đọc kết quả |
|---|---|---|---|
| `Đầu ra kiểm chứng được` | **hiện trạng** đúng chưa | trước khi đánh ✅ | phiên đang làm |
| `Owner kiểm tra` | **vừa đổi** cái gì, có đúng phạm vi đã hứa không | ngay sau khi ✅ | owner |
| `Chất lượng` | **phiên sau** dùng được không | trước khi đóng một pha | phiên sau, và owner |

Một task **XONG mà không TỐT trông y hệt một task tốt** — cả hai đều có lệnh xanh và một commit. Đó là
lý do cột thứ ba tồn tại, và là lý do lệnh trong bảng `cl-T-xx` bắt buộc phải **khác** lệnh ở ô biên
nhận (xem 5.14).

**Khuôn đang dùng thật không nằm ở file này.** Nhà của nó là
[.claude/rules/quan-ly-du-an.md](../.claude/rules/quan-ly-du-an.md) §1 — file này giữ **vì sao có ô đó
và điền nó bằng quy trình nào** (Phần V), rule giữ **ô đang dùng và cú pháp viết nó**.

Khuôn hiện tại là **11 cột** (rule §1, cập nhật 2026-08-23 khi ô `Chất lượng` được thêm; ô
`Owner kiểm tra` thêm 2026-08-22). Kiểm bằng lệnh, đừng tin con số ở đây:

```bash
sed -n '/^| # | Lane |/p' task.md | awk -F'|' '{print NF-2}'   # ra 11
grep -c '^| # | Lane |' .claude/rules/quan-ly-du-an.md task.md  # ra 1 và 1 — hai bản phải khớp
```

Số cột sẽ còn đổi; đọc rule, đừng đọc con số ở đây. ⚠️ Ranh giới giữa file này và rule §1.1 chưa được
cắt — xem [finding.md F-04](../finding.md#f-04); lệch thì **rule thắng**.

---

## Phần V — Đặc tả từng trường

> Mỗi trường trình bày theo đúng bốn phần của [cau-truc-prompt-tot.md](../prompt/huong_dan_prompt/cau-truc-prompt-tot.md),
> cộng một phần thứ năm do dự án này thêm vào:
> **Trường** → **Lý do tồn tại** → **Ví dụ SAI / ĐÚNG** → **Cách thực hiện** → **Session hiểu và làm gì**.

**Phần "Cách thực hiện" là quy trình, không phải khuôn.** Nó trả lời *"ngồi trước ô rỗng thì làm gì
theo thứ tự nào để ra được nội dung"* — hỏi câu nào, chạy `grep` nào, đối chiếu với file nào, và **dừng
lại ở đâu**. Cú pháp cuối cùng của ô (dấu gì, bọc `**` chỗ nào, link dạng nào) **không** ở đây: nó ở
[rule §1.1](../.claude/rules/quan-ly-du-an.md), và rule thắng khi hai bên lệch. Ranh giới này là cách
[F-04](../finding.md#f-04) đề xuất cắt hai nhà; giữ đúng nó khi bê bộ khung sang dự án sau.

**Đọc theo thứ tự nào.** 5.1–5.12 là mười hai trường điền lúc **mở** một dòng task. 5.13 và 5.14 là hai
ô điền lúc **đóng** nó — chúng không phải chỗ mô tả việc, mà là chỗ khai *bằng chứng nào chứng minh việc
đã làm đúng và làm tốt*. Hai ô cuối là phần mới nhất của bộ khung và cũng là phần hay bị bỏ nhất, vì
chúng đòi công **sau** lúc code đã chạy — đúng lúc người viết đã thấy mình xong rồi.

### 5.1 `#` — mã task kiêm trạng thái · *(thêm theo reference)*

**Lý do tồn tại.** Trạng thái ghi ở hai chỗ thì hai chỗ sẽ lệch. Mã hoá trạng thái vào chính ô mã
để **một lệnh `grep` ra được việc còn lại**, và để không ai phải cập nhật một bảng tổng hợp thứ hai.

**Ví dụ.**

| | |
|---|---|
| ❌ SAI | có thêm cột `Trạng thái` ghi `đang làm` — không lệnh nào đọc được, và luôn trễ một phiên |
| ✅ ĐÚNG | `| **T-08**` chưa làm · `| ~~**T-08**~~ ✅` xong · `| ~~**T-08**~~ ❌ huỷ: <lý do>` |

**Cách thực hiện.**

1. Lấy mã kế tiếp bằng lệnh, đừng đếm bằng mắt: `grep -o '\*\*T-[0-9]*\*\*' task.md | sort -u | tail -1`.
   Cộng một. Mã **cấp tăng dần, không tái sử dụng**, kể cả khi task bị huỷ.
2. Viết `| **T-xx**` cho task chưa làm. Đừng thêm gì khác vào ô này lúc mở.
3. Task này **chặn** task khác (không xong thì mọi phiên sau đều sai) ⇒ thêm `🔺`. Không chặn ai ⇒ để
   trống, đừng gắn 🔺 cho có: [rule §1.2b](../.claude/rules/quan-ly-du-an.md) đã chỉ ra cơ chế *"mọi
   dòng cùng một giá trị thì cột đó lọc đúng bằng không"* — 🔺 cũng chết theo cách đó.
4. Lúc đóng: bọc `~~` hai đầu và thêm dấu kết — `~~**T-08**~~ ✅` xong · `~~**T-08**~~ ❌ huỷ: <lý do>`.
   Huỷ **phải kèm lý do ngay trong ô**, vì đó là thứ duy nhất còn lại giải thích khoảng trống trong dãy mã.
5. Rà lại: `grep -o '\*\*T-[0-9]*\*\*' task.md | sort | uniq -d` phải **rỗng** (không mã trùng).

**Session hiểu và làm gì.** `grep '^| \*\*T-' task.md` ra **đúng** danh sách việc còn lại, vì dòng
xong bắt đầu bằng `| ~~**T-` nên tự bị loại. Mã **cấp tăng dần, không tái sử dụng**, kể cả khi huỷ —
tái sử dụng mã làm commit message cũ trỏ sang việc khác.

### 5.2 `Lane` — TP1: vai trò và người đọc

**Lý do tồn tại.** Đây là thành phần **hiệu quả cao nhất trên mỗi ký tự bỏ ra**. Lane trả lời cùng lúc
bốn câu: session **được sửa file nào**, **phải nạp gói nào**, **biên nhận là lệnh gì**, và **được phép
bỏ qua cái gì**. Không khai lane, session phải chọn một "mức trung bình an toàn" — tức đọc lan man rồi
sửa lan man.

**Ví dụ.**

| | |
|---|---|
| ❌ SAI | `Fullstack` — không có gói nạp, không có biên nhận, không có ranh giới file |
| ❌ SAI | `BE ⚠️+FE` — tự thú task chạm 2 lane ⇒ **chẻ trước khi làm**, không phải ghi chú rồi làm tiếp |
| ✅ ĐÚNG | `BE` · `DB` · `FE` · `DEVOPS` · `BA` · `NON-CODE` |

**Cách thực hiện.**

1. Đọc ô `Task` đã viết (hoặc câu người dùng vừa giao) và hỏi **một** câu: *đầu ra kiểm chứng được của
   việc này nằm ở file nào?* Lane là lane **sở hữu file đó** trong bảng [CLAUDE.md §1](../CLAUDE.md).
2. Ra **hai** lane trở lên ⇒ **dừng, chẻ ngay**, đừng ghi `BE ⚠️+FE` rồi làm tiếp. Cách chẻ: giữ lại
   phần thuộc lane của đầu ra kiểm chứng được, phần còn lại thành **một dòng task mới ngay lúc đó** —
   nếu để "ghi sau" thì nó không bao giờ được ghi.
3. Không nghĩ ra lane nào ⇒ ghi `NON-CODE`. Đó là mặc định an toàn vì lane đó chỉ đọc và đối chiếu.
4. Lane chưa mở (bảng §1 còn ⚠️) ⇒ ô `Cần xong trước` phải trỏ tới task **mở lane đó**, không được để `—`.
5. Rà lại: lane vừa ghi phải `grep` ra được trong `CLAUDE.md` §1 — `grep -c '^| \*\*<LANE>\*\*' CLAUDE.md`
   ra `1`. Ra `0` là bịa tên lane.

**Session hiểu và làm gì.** Đọc lane → mở `CLAUDE.md §1` → nạp đúng gói → khai một dòng mở đầu
(`Lane: BE · task T-08 · nạp: ... · biên nhận: make check`) để owner chặn được ngay nếu định tuyến sai.
**Không rõ lane ⇒ `NON-CODE`**, vì lane đó không sửa code: đọc, đối chiếu, hỏi lại một câu gọn.
Sổ task **không chép** gói nạp và biên nhận của lane — `CLAUDE.md §1` là nhà của chúng.

### 5.3 `Task` — TP3: nhiệm vụ bằng động từ hành động

**Lý do tồn tại.** Model **bám sát nghĩa đen**. Câu hỏi dạng "có nên / xem giúp" sinh ra **thông tin**;
câu mệnh lệnh có tân ngữ cụ thể mới kích hoạt **tool call**. Một dòng task viết theo thói quen lịch sự
sẽ nhận về một bản phân tích, không phải một commit.

**Ví dụ.**

| | |
|---|---|
| ❌ SAI | `Xem lại cách tính giá xem có vấn đề gì không` → session liệt kê vấn đề, không sửa |
| ❌ SAI | `Hoàn thiện module đặt đơn` → "hoàn thiện" không có điểm dừng |
| ✅ ĐÚNG | `Viết service/order.go: hàm tính lại tổng phiên, gọi trong cùng transaction` |
| ✅ ĐÚNG | `Migration 000004_fix_open_key + .down.sql: UNIQUE(open_key) gồm cả trạng thái billing` |

**Cách thực hiện.**

1. Viết theo đúng ba mẩu, đúng thứ tự: **động từ** (Viết · Sửa · Thêm · Xoá · Chốt · Tách) + **tân ngữ
   cụ thể** + **file sẽ sửa**. Thiếu mẩu thứ ba là thiếu thứ khiến phiên khỏi phải đi dò.
2. Đọc lại câu vừa viết và tìm chữ **"và"**. "và" nối hai danh từ khác nhau ⇒ hai biên nhận khác nhau
   ⇒ **hai task**. Chẻ trước khi làm, đừng thương lượng.
3. Thử phát biểu **một** lệnh chứng minh nó xong. Không phát biểu nổi ⇒ câu này còn quá to hoặc còn là
   ý kiến; viết lại cho hẹp đến khi phát biểu được.
4. Gạch mọi từ không có điểm dừng: *hoàn thiện · cải thiện · tối ưu · xem lại · rà soát cho ổn*. Thay
   bằng trạng thái quan sát được (*"ra đủ 8 dòng"*, *"còn 0 issues"*).
5. Đếm file sẽ chạm. Quá **3** ⇒ vượt kích cỡ [1.2](#12-bốn-vế-kích-cỡ--vượt-vế-nào-cũng-phải-chẻ-trước-khi-làm), chẻ.

**Session hiểu và làm gì.** Động từ + tân ngữ cụ thể → sinh tool call ngay. Có tên file trong ô Task
thì bước PLAN chỉ còn là xác nhận, không phải đi dò. Chữ **"và"** nối hai danh từ khác nhau ⇒ hai
task, vì hai danh từ đó gần như luôn có hai biên nhận khác nhau.

### 5.4 `Context › Nạp` — TP5: dữ liệu đầu vào và vị trí đặt nó

**Lý do tồn tại.** Với đầu vào dài, **đặt dữ liệu ở trên và chỉ dẫn ở dưới** cải thiện chất lượng
đáng kể — và trong dự án nhiều phiên, "dữ liệu" chính là các file phải đọc **trước khi sửa dòng đầu
tiên**. Ô này tồn tại để session không phải dò lại lịch sử chat, và cũng để **chặn nạp thừa**:
`step.md` 1.330 dòng, đọc trọn là đốt sạch context cho việc chưa làm.

**Ví dụ.**

| | |
|---|---|
| ❌ SAI | `Đọc lại tài liệu dự án để nắm tình hình` — không file nào, mỗi phiên hiểu một kiểu |
| ❌ SAI | `Nạp: step.md` — 1.330 dòng, và 1.300 dòng trong đó không liên quan |
| ✅ ĐÚNG | `Nạp: design/backend/04-yeu-cau.md §3 · code/be/api/openapi.yaml (chỉ mục /orders)` |

**Cách thực hiện.**

1. Liệt kê file **phải đọc trước khi gõ ký tự đầu tiên** — không phải file "liên quan". Phép thử: bỏ
   file này ra thì phiên có phải đoán không? Không phải đoán ⇒ bỏ nó khỏi ô.
2. Với mỗi file, **thu hẹp xuống mục**: `§3`, `mục /orders`, `dòng 40–70`. Trỏ trọn một file là cách
   nhanh nhất đốt hết context trước khi làm được gì.
3. **Kiểm từng con trỏ ngay lúc viết**, đừng để phiên sau đi tìm hộ:

   ```bash
   test -e <file> && grep -c '§3' <file>      # ra >= 1; ra 0 nghĩa là con trỏ bịa
   ```

   Quy trình đầy đủ ở [rule §5.2c](../.claude/rules/quan-ly-du-an.md).
4. Quá **3** file ⇒ dừng: hoặc task quá to (chẻ), hoặc bạn đang liệt kê file "cho chắc" (cắt bớt).
5. Ô này **cấm** chứa "thế nào là xong". Thấy mình đang viết tiêu chí ⇒ chuyển câu đó sang ô
   `Đầu ra kiểm chứng được`.

**Session hiểu và làm gì.** Mở đúng file, đúng mục, rồi mới viết. Cần file **thứ 4** ngoài gói lane ⇒
**nói ra lý do trước khi mở**. Ô này **cấm** chứa "thế nào là xong" — vế đó là cột `Đầu ra kiểm chứng
được`. Đầu vào và đầu ra là hai sự thật khác nhau, mỗi cái một ô.

### 5.5 `Context › Đã chốt` — TP2: bối cảnh, phần "đã biết rồi"

**Lý do tồn tại.** Quyết định **đã có nhà** mà không được trỏ tới sẽ bị quyết lại — và lần quyết thứ
hai gần như luôn ra kết quả khác lần đầu. Ô này không chép quyết định, nó **trỏ**, đúng luật một sự
thật một nhà.

**Ví dụ.**

| | |
|---|---|
| ❌ SAI | `Đã chốt: dùng MySQL, giá lấy từ bảng menu_items, tính bằng hàm CalcTotal...` — chép = nhà thứ hai |
| ✅ ĐÚNG | `Đã chốt: nguồn thời gian (design/01 §2) · snapshot giá vào chi tiết đơn (I7)` |

**Cách thực hiện.**

1. Hỏi: *task này có thể bị phiên làm nó quyết lại điều gì đã quyết rồi?* Mỗi điều như thế là một mẩu
   `Đã chốt`.
2. Với mỗi mẩu, tìm **nhà thật** của nó (bảng [CLAUDE.md §2](../CLAUDE.md) liệt kê các nhà). Ghi
   **tên + con trỏ**, ví dụ `nguồn thời gian (design/01 §2)` — không chép nội dung quyết định.
3. Không tìm được nhà ⇒ **quyết định đó chưa có nhà**. Đây không phải chỗ tạo nhà mới: mở một dòng task
   tạo nhà, hoặc một finding nếu nó đang mâu thuẫn với chỗ khác.
4. Phép thử cuối: xoá mọi tính từ và con số khỏi ô, chỉ chừa tên + con trỏ. Ô vẫn dùng được ⇒ đúng.
   Ô mất nghĩa ⇒ bạn đã chép, và bản chép đó sẽ lệch với bản gốc.

**Session hiểu và làm gì.** Thấy quyết định đã có nhà thì **không mở lại tranh luận**, chỉ đọc và
tuân theo. Muốn đổi ⇒ mở finding, không tự đổi giữa task.

### 5.6 `Context › Bẫy` — TP10: xử lý bất định

**Lý do tồn tại.** Đây là **thành phần bị bỏ quên nhiều nhất và tốn kém nhất**. Model sinh văn bản
khớp với giả định trong đề bài, vì văn bản khớp có xác suất cao hơn văn bản phản bác. Ô *Bẫy* là chỗ
**cấp phép tường minh** cho hành vi ngược lại: dừng lại, nói ra chỗ lệch, thay vì làm cho trôi.

**Ví dụ.**

| | |
|---|---|
| ❌ SAI | *(để trống trong khi biết rõ chỗ này đã cắn 2 lần)* |
| ✅ ĐÚNG | `Bẫy: migration 2 có đoạn giống hệt — ĐỪNG COPY, nó thiếu billing (gốc F-01)` |
| ✅ ĐÚNG | `Bẫy: FE không được tự tính giá; lệch với BE thì mở finding, không sửa cho khớp` |
| ✅ ĐÚNG | `Bẫy: chưa có DB thật; lệnh cần compiler phải đánh ⚠️, không viết như thể chạy được` |

**Cách thực hiện.** Bẫy đến từ **ba nguồn**, dò lần lượt cả ba, đừng ngồi nghĩ ra:

1. **`finding.md`** — finding còn 🔴 MỞ mà chạm file task này sẽ sửa. Lấy một câu + **mã gốc**:
   `Bẫy: ... (gốc F-01)`.
2. **`git log`** — chỗ đã sửa đi sửa lại. `git log --oneline -- <file> | wc -l` ra số lớn bất thường
   nghĩa là chỗ đó đã cắn ai đó rồi.
3. **Hiện trạng repo** — thứ chưa tồn tại mà đề bài nói như thể đã có (chưa có DB, chưa có `Makefile`).
   Đây là nguồn của luật ⚠️ ở ô đầu ra.
4. Mỗi bẫy viết đủ **hai vế**: *chỗ sẽ cắn* + **cách xử**. Chỉ có vế đầu là báo động suông; vế thứ hai
   ("thì mở finding, đừng sửa cho khớp") mới là thứ đổi hành vi.
5. Cả ba nguồn đều rỗng ⇒ **để trống**. Bẫy bịa làm loãng bẫy thật, và sau ba dòng bịa thì không ai
   đọc ô này nữa.

**Session hiểu và làm gì.** Ba thay đổi: (1) **"không đủ dữ kiện" thành nước đi hợp lệ**; (2) **phản
bác đề bài thành hành vi tuân thủ** — thấy code khác mô tả thì nói ra, không viết theo mô tả; (3)
**đổi thứ tự hành động** — đọc file thật trước, kết luận sau. Không có bẫy thật thì **để trống**,
đừng bịa: bẫy bịa làm loãng bẫy thật.

### 5.7 `Hỏng thì mất gì` — TP2: **lý do**, thành phần đắt nhất trên một dòng chữ

**Lý do tồn tại.** *"Một câu **vì...** sinh ra hàng chục quy tắc bạn chưa kịp viết."* Mệnh lệnh trần
chỉ áp đúng ca bạn nêu tên và **im lặng ở mọi ca bạn quên nêu**; mệnh lệnh kèm lý do biến thành **hàm
mục tiêu**, từ đó session tự suy ra các ca chưa liệt kê. Đây cũng là **cột quyết định thứ tự ưu tiên**
([§5.3](prompt-fullstack.md)): hai task không phụ thuộc nhau thì task dính tiền đi trước.

**Ví dụ.** Viết bằng **hậu quả ở quán**, không bằng thuật ngữ:

| | |
|---|---|
| ❌ SAI | `Ảnh hưởng tới tính toàn vẹn dữ liệu` — thuật ngữ, không ai xếp ưu tiên được bằng nó |
| ✅ ĐÚNG | `Thu thiếu tiền bàn 5: khách gọi thêm lượt 2 mà hoá đơn chỉ có lượt 1` |
| ✅ ĐÚNG | `Bếp làm thiếu 4 bánh mỗi suất trứng ⇒ khách chờ món không bao giờ tới` |

**Cách thực hiện.** Hỏi bốn câu, dừng ở câu đầu tiên trả lời được:

1. *Ai mất tiền, mất bao nhiêu?* — `Thu thiếu tiền bàn 5: khách gọi lượt 2 mà hoá đơn chỉ có lượt 1`.
2. *Ai phải làm lại việc, làm lại mấy lần?* — `Phiên thứ mười có hai phiên bản sự thật, làm lại hai lần`.
3. *Khách nhìn thấy gì?* — `Khách chờ món không bao giờ tới`.
4. *Cơ chế nào chết trong im lặng?* — dùng cho task NON-CODE: `Sổ trông xanh trong khi không lệnh nào chạy`.

Rồi lọc lại hai lượt:

5. **Xoá mọi thuật ngữ.** "toàn vẹn dữ liệu", "ảnh hưởng chất lượng", "khó bảo trì" — thay bằng cảnh
   xảy ra ở quán. Thuật ngữ làm mọi task trông quan trọng như nhau, và lúc đó ưu tiên thành cảm tính.
6. **Đọc ô này của hai task cạnh nhau và thử xếp thứ tự.** Xếp không nổi ⇒ ít nhất một trong hai ô còn
   viết bằng thuật ngữ. Đây là phép thử duy nhất chứng minh ô này đang làm việc của nó.

**Session hiểu và làm gì.** Câu *"thu thiếu tiền bàn 5"* cho session một hàm mục tiêu, nên nó tự thêm
ca test bạn chưa liệt kê (lượt gọi thứ hai, phiên đang `billing`, đơn bị huỷ giữa chừng) — đúng cơ chế
"viết một câu, nhận về hàng chục quy tắc". Ô này rỗng ⇒ mọi task trông quan trọng như nhau ⇒ session
làm task dễ trước.

### 5.8 `Cần xong trước` — TP9: quy trình, thứ tự **ngoài**

**Lý do tồn tại.** Quy định model **làm gì theo thứ tự nào** thì tốt; quy định model **nghĩ thế nào**
thì có hại. Ô này chỉ giữ thứ tự ngoài, quan sát được: cái **tạo ra** dữ liệu đứng trước cái **đọc**
dữ liệu đó ([§5.4](prompt-fullstack.md)).

**Ví dụ.**

| | |
|---|---|
| ❌ SAI | `Trước hết hãy liệt kê mọi biến, vẽ bảng giá trị từng vòng lặp, sau đó...` — kê cách nghĩ, nhốt session vào một lối phân tích |
| ❌ SAI | `Sau khi hiểu rõ hệ thống` — không phải trạng thái quan sát được, không ai biết khi nào đạt |
| ✅ ĐÚNG | `T-02` · `T-13 (OpenAPI phải sinh xong thì FE mới có type)` |

**Cách thực hiện.**

1. Chỉ hỏi **một** loại câu: *task này đọc dữ liệu / file do task nào tạo ra?* Cái **tạo ra** đứng
   trước cái **đọc**. Đó là toàn bộ luật.
2. Ghi **mã task**, không ghi câu mô tả. Cần giải thích thì để trong ngoặc, ngắn:
   `T-13 (OpenAPI phải sinh xong thì FE mới có type)`.
3. Không phụ thuộc ai ⇒ ghi `—`. Ô rỗng và ô `—` khác nhau: `—` nghĩa là *đã kiểm và không có*, rỗng
   nghĩa là *chưa ai kiểm*.
4. **Cấm** các mẩu không quan sát được: *"sau khi hiểu rõ hệ thống"*, *"khi backend ổn định"*. Không ai
   biết khi nào chúng đạt, nên chúng chặn task mãi mãi hoặc không chặn gì cả.
5. **Cấm** kê cách nghĩ ("trước hết hãy liệt kê mọi biến, sau đó..."). Thứ tự **ngoài** thì ghi, thứ tự
   **trong đầu** thì không — nhốt phiên vào một lối phân tích làm nó bỏ lối tốt hơn.
6. Rà vòng lặp phụ thuộc: đi theo chuỗi `Cần xong trước` từ dòng này; quay về chính nó ⇒ hai task đang
   chặn nhau, phải chẻ một trong hai.

**Session hiểu và làm gì.** Đọc mã, kiểm `~~**T-02**~~ ✅` trong sổ; chưa ✅ ⇒ **task này chưa mở**,
chọn task khác chứ không "tạm mock". Lý do phụ thuộc không viết ở đây — nó nằm ở cây phụ thuộc và
dòng **đường găng**.

### 5.9 `Finding phải đóng` — TP6: phạm vi, ràng buộc, và **van xả** · *(thêm theo reference)*

**Lý do tồn tại.** Hai việc trong một ô. Thứ nhất, **cổng vào**: finding còn 🔓 MỞ / ⚠️ MỞ LẠI thì task
chưa được bắt đầu, dù trông có vẻ làm được — làm trên nền đang sai là làm hai lần. Thứ hai, đây là chỗ
hiện thực hoá **van xả** của TP6: *"thấy vấn đề khác thì liệt kê ở cuối thay vì tự sửa"*.

Không có van xả, session kẹt giữa hai lối thoát đều tệ: **lờ đi** (bạn mất thông tin) hoặc **lén sửa**
(bạn mất kiểm soát phạm vi — đây chính là cách `git add -A` nuốt file của lane khác).

**Ví dụ.**

| | |
|---|---|
| ❌ SAI | `F-01: bảng sessions cho phép 2 phiên mở cùng bàn khi billing...` — mô tả lại = sổ finding thứ hai |
| ✅ ĐÚNG | `[F-01](finding.md#f-01) ✅` (cổng vào) · ở cột đầu ra: `→ đóng F-24` |

**Cách thực hiện.**

1. Chạy `grep -n 'MỞ' finding.md` rồi soi: finding nào **chạm file** task này sẽ sửa? Mỗi cái là một mã
   phải ghi vào ô.
2. Ghi **chỉ mã + link**: `[F-01](finding.md#f-01)`. Không mô tả lại nội dung — mô tả lại là đẻ sổ
   finding thứ hai, và bản thứ hai sẽ lệch.
3. Phân biệt hai vai của cùng một mã, đây là chỗ hay lẫn:
   - **cổng vào** (ô này): finding phải ✅ ĐÓNG **trước** thì task mới được bắt đầu.
   - **cổng ra** (ô `Đầu ra kiểm chứng được`): `→ đóng F-24` — task này làm xong thì finding đó tắt.
4. Không finding nào liên quan ⇒ `—`.
5. Đóng một finding thì phải để lại dòng **`Bài học giữ lại:`** — luật nào đổi để nó không tái phát.
   Khuôn đầy đủ + hai cổng kiểm: [.claude/rules/chat-luong-finding.md](../.claude/rules/chat-luong-finding.md) §1 §3.

**Session hiểu và làm gì.** Gặp vấn đề mới giữa chừng ⇒ **thêm một dòng vào `finding.md` ngay**, kèm
**cách sửa đề xuất** (nêu vấn đề mà không nêu lối ra là đẩy việc ngược cho owner), rồi **quay lại việc
đang làm**. Không sửa kèm. Phạm vi được giữ, thông tin không mất.

### 5.10 `Đầu ra kiểm chứng được` — TP4 + TP7: tiêu chí thành công **và** định dạng

**Lý do tồn tại.** Không có tiêu chí, session vẫn phải tự đặt một tiêu chí ngầm để biết khi nào dừng,
và tiêu chí nó hay chọn là **"trông có vẻ đầy đủ"**. Thiếu ô này thì dòng đó là **ý kiến**, không phải
task. Ô này đồng thời chốt **hình dạng đầu ra**: kết quả ghi vào file nào, mục nào — output đúng nội
dung mà sai chỗ thì phiên sau không tìm thấy.

**Ví dụ.**

| | |
|---|---|
| ❌ SAI | `Viết xong service tính giá, test đầy đủ` — không chứng minh được, cũng không bác được |
| ❌ SAI | `make check xanh` *(khi repo chưa có Makefile)* — biên nhận là lời hứa |
| ✅ ĐÚNG | `go test ./internal/menu/` ra đủ 11 ca giá §9.3, ca *Chay + Nhiều nhân* phải **LỖI** |
| ✅ ĐÚNG | `make lint`: 7 issues → `0 issues.`; `make check` EXIT=0 → đóng **F-24** |
| ✅ ĐÚNG *(NON-CODE)* | `grep -c '^| I' design/01-thiet-ke.md` ra `8`; `sed -n '/§6.2/,/^##/p'` in ra bảng 3 cột |

**Bốn luật của ô này:**

1. **Sửa lỗi ⇒ test ĐỎ trên code cũ, XANH trên code mới, dán cả hai output.** Test chỉ-xanh không
   chứng minh được gì ([§6.7](prompt-fullstack.md)).
2. **Lane NON-CODE không có compiler** ⇒ biên nhận là **lệnh đọc lại**: `grep` ra đúng số hit đã khai,
   `sed -n` in ra đoạn vừa sửa, `git log -1 -- <file>`. Không có lệnh ⇒ chưa xong.
3. **Lệnh chưa tồn tại thì đánh ⚠️** và phải có task tạo ra nó đứng trước. Dự án hiện **chưa có
   `Makefile`, chưa có DB, chưa có code** ⇒ mọi biên nhận kiểu `make check` đang là lời hứa.
4. **Nói cái NÊN ra, đừng nói cái KHÔNG NÊN.** `0 issues.` là hình mẫu tích cực; "không còn lỗi lint"
   là vùng cấm, và vùng cấm thì session trôi ra khỏi lúc nào không hay.

**Cách thực hiện.**

1. Viết mệnh đề *"xong nghĩa là gì"* bằng **một câu khẳng định về hiện trạng file**, chưa nghĩ tới lệnh.
   Ví dụ: *"bảng bất biến trong `design/01` có đủ 8 dòng"*.
2. Dịch câu đó sang **một lệnh + kết quả kỳ vọng**: `grep -c '^| I' design/01-thiet-ke.md` ra `8`.
   Dịch không nổi ⇒ mệnh đề còn mơ hồ, quay lại bước 1 — đừng hạ chuẩn xuống "trông có vẻ đầy đủ".
3. Chọn **ngưỡng hay hằng số**: thứ **còn được sửa tiếp** viết bằng ngưỡng (`<= 120`), thứ **đã đóng
   băng** mới viết hằng số (`ra 8`). Hằng số đặt lên thứ còn sống sẽ đỏ giả ở phiên sau, và biên nhận
   đỏ giả bị bỏ qua sau hai lần.
4. Lệnh **chưa tồn tại** (`make check`, `go test`, `npm run build` ở giai đoạn chưa có compiler) ⇒ đánh
   **⚠️** và ô `Cần xong trước` phải trỏ task tạo ra nó. Dò sót bằng [rule §5.3](../.claude/rules/quan-ly-du-an.md) dòng 2.
5. Task **sửa lỗi** ⇒ khai luôn **hai** output: ĐỎ trên commit cũ, XANH trên commit mới. Test chỉ-xanh
   không chứng minh bug đã từng tồn tại.
6. Task **đóng finding** ⇒ nối `→ đóng **F-nn**` vào cuối ô. Đó là cổng ra, đối xứng với cổng vào ở 5.9.
7. **Chạy thử lệnh ngay lúc viết ô này**, đừng đợi tới lúc làm. Lệnh sai cú pháp hoặc ra rỗng thì ô này
   là biên nhận giả, và biên nhận giả tệ hơn ô rỗng: ô rỗng ai cũng thấy là thiếu.

**Session hiểu và làm gì.** Ô này trở thành **danh sách rà lại trước khi kết thúc**, và cho owner một
ngôn ngữ chung để phản hồi: thay vì "chưa ổn lắm", nói "vế thứ 2 của cột đầu ra chưa đạt" — sửa đúng
chỗ ngay vòng đầu.

### 5.11 `Prompt mở session` — TP8: ví dụ (few-shot) + ràng buộc hẹp nhất

**Lý do tồn tại.** *Một ví dụ là bằng chứng, một lời mô tả chỉ là ý định.* Ô này giữ **dòng đầu tiên
owner dán vào session mới** — vế mà `CLAUDE.md §1` bắt khai nhưng chưa file nào giữ hộ. Nó cũng là chỗ
duy nhất chứa **câu "dừng khi nào"**, thứ chặn session làm lấn sang task kế.

**Ví dụ.**

| | |
|---|---|
| ❌ SAI | chép lại cả *Nạp* + *Bẫy* + danh sách lệnh vào ô này — đẻ nhà thứ hai, và sửa luật là phải sửa 78 dòng |
| ✅ ĐÚNG | `Lane BE · T-08 · sed -n '/T-08/p' task.md · chỉ chạm internal/order/** · xong service thì DỪNG, chưa viết handler` |

**Cách thực hiện.**

1. Ghép đúng **năm mẩu**, đúng thứ tự: `Lane <X>` · `<mã task>` · `<lệnh mở đúng dòng>` ·
   `chỉ chạm <path>` · `xong <X> thì DỪNG, chưa <Y>`.
2. Mẩu thứ ba là **lệnh**, không phải nội dung: `sed -n '/T-08/p' task.md`. Chép nội dung dòng task vào
   đây là đẻ nhà thứ hai, và bản chép sẽ lệch ngay lần sửa đầu tiên.
3. Mẩu thứ tư lấy từ [CLAUDE.md §1](../CLAUDE.md) (lane sở hữu path nào), hẹp thêm nếu task chỉ chạm
   một thư mục con.
4. Mẩu thứ năm — **câu DỪNG** — viết bằng cặp *đã làm gì thì dừng* + *chưa được làm gì*. Vế thứ hai
   quan trọng hơn: nó gọi tên đúng task kế tiếp mà phiên hay gánh luôn.
5. **Chỉ điền khi task sắp được giao.** Điền sẵn cho cả sổ nghĩa là mỗi lần đổi luật phải sửa từng ấy
   dòng. Ba dòng đầu điền đủ để làm mẫu few-shot cho các dòng sau.

**Session hiểu và làm gì.** Chỉ chứa 5 mẩu: **lane · mã task · lệnh mở đúng dòng · ràng buộc hẹp nhất
· câu dừng**. **Chỉ điền khi task sắp được giao** — 78 dòng đều có prompt là 78 dòng phải sửa mỗi lần
đổi luật; ba dòng đầu tiên để làm **mẫu few-shot** cho các dòng viết sau. Khi có `make prompt T=T-xx`
thì ô này **sinh được bằng lệnh**, lúc đó dòng chưa điền không còn là thiếu sót.

Bẫy few-shot cần tránh khi viết 3 dòng mẫu: **đừng để cả ba cùng một dạng**. Ba dòng mẫu giống nhau sẽ
ngầm dạy rằng mọi task đều là task BE sửa 1 file — hãy cho một dòng NON-CODE, một dòng có câu dừng
gắt, một dòng task bị chặn bởi finding.

### 5.12 `Ưu tiên` 🔺 — thứ tự thi công · *(thêm theo reference, gộp vào ô `#`)*

**Lý do tồn tại.** Bảng task xếp theo pha, mà **thứ tự file ≠ thứ tự ưu tiên**. Không có ký hiệu ưu
tiên, session lấy dòng đầu tiên đọc được — thường là dòng dễ nhất.

**Hai tầng đang dùng thật trong `task.md`**, đọc từ trên xuống:

1. **🔺 chặn** — không xong thì mọi phiên sau đều sai. Làm trước, bất kể nó ở pha nào.
2. **Thứ tự dòng trong sổ** — hết 🔺 thì lấy **dòng chưa xong đầu tiên**, vì dòng xong mở đầu bằng
   `| ~~**T-` nên tự bị loại.

Hai lệnh ở mục *"Task tiếp theo — làm ngay"* đầu `task.md` là hiện thân đúng của hai tầng này:

```bash
grep -n '^| \*\*T-' task.md | grep '🔺' | head -1   # 1. 🔺 chặn task khác ⇒ làm trước
grep -n '^| \*\*T-' task.md | head -1               # 2. hết 🔺 thì lấy dòng chưa xong đầu tiên
```

**Hai tầng chưa mở**, chép sang dự án sau thì mở khi cần, đừng mở trước: **đường găng** (một dòng ghi
dãy task quyết định ngày lên sóng) và **`⚑n`** (thứ tự owner tự chọn cho phần còn lại). Repo này chưa
dùng cái nào — `grep -c '⚑' task.md` ra `0` — nên đừng viết như thể chúng đang chạy.

**Cách thực hiện.**

1. Gắn 🔺 khi và chỉ khi trả lời được: *task nào sẽ sai nếu task này chưa xong?* Nêu được **tên task cụ
   thể** ⇒ gắn. Chỉ thấy "nó quan trọng" ⇒ không gắn.
2. Đếm 🔺 sau mỗi lần sửa sổ: `grep -c '🔺' task.md`. Con số trườn lên quá vài dòng nghĩa là 🔺 đang mất
   nghĩa — mọi dòng cùng một giá trị thì cột đó lọc đúng bằng không.
3. Task hết chặn ai (task bị chặn đã xong hoặc bị huỷ) ⇒ **gỡ 🔺**. Không gỡ thì tầng 1 đầy dần và
   lệnh dò task tiếp theo trả về dòng sai.
4. Cần chen một việc gấp ⇒ gắn 🔺 cho nó, **đừng đánh số lại** các mã khác. Mã là khoá tra (5.1).

**Session hiểu và làm gì.** Mục *"Task tiếp theo — làm ngay"* ở đầu sổ phải là **lệnh chạy được** dò
theo đúng các tầng này, **không phải** câu "tiếp theo làm T-08". Chép tên task ra đó ⇒ mỗi lần xong một
task phải sửa hai chỗ, và chỗ thứ hai sẽ quên.

### 5.13 `Owner kiểm tra` — TP11 nửa người: *vừa đổi cái gì, có đúng chỗ đã hứa không*

**Lý do tồn tại — trước hết, nửa máy.** Câu "hãy tự kiểm tra lại" bắt lỗi tốt với model cũ, nhưng
**Opus 5 tự verify sẵn**, và mang câu verify từ prompt cũ sang gây **over-verification** — tốn token,
tốn thời gian, không thêm độ đúng. Tài liệu khuyên **xoá** những câu đó, đừng viết lại chúng.

Nên trong sổ task, nửa máy của TP11 không tồn tại dưới dạng chữ nhắc nhở, và cũng **không thành cột**.
Nó tồn tại dưới dạng **cổng ra bằng bằng chứng** ở [CLAUDE.md §4](../CLAUDE.md): đánh ✅ cần đủ **bốn**
thứ, thiếu một ⇒ vẫn là đang làm ("đã viết code" ≠ "đã chạy"):

1. **biên nhận của lane chạy thật + output dán vào**;
2. **commit** chứa thay đổi — `git add <đường dẫn cụ thể>`, **cấm `git add -A`**, **cấm `--no-verify`**;
   message theo khuôn `<LANE>/<T-xx>: <file đã sửa>, đóng <F-yy>`;
3. `finding.md` đổi trạng thái kèm **ngày + cách kiểm chứng** (nếu task có đóng finding);
4. **bảng thay đổi cuối phiên**, dán **trước** khi commit, mỗi file đã đụng một dòng — khuôn ở
   [.claude/rules/bao-cao-thay-doi.md](../.claude/rules/bao-cao-thay-doi.md) §1. *(Vế thứ tư thêm
   2026-08-22; bộ khung nào chép lại "ba thứ" là đang chép bản cũ.)*

Đây cũng là lý do cụm *"và nêu rõ tiêu chí nào chưa đạt"* được thay bằng máy: bằng chứng là output
của lệnh, không phải câu tự khen "đã hoàn thành đầy đủ yêu cầu".

**Lý do tồn tại — nửa người, và vì sao nó phải là một cột.** Bốn thứ trên chứng minh *lệnh chạy xanh*;
chúng **không** trả lời được *phiên vừa rồi có đụng đúng những chỗ nó hứa sẽ đụng không*. Một phiên
hoàn toàn có thể chạy xanh biên nhận **và** tiện tay sửa thêm bốn file của lane khác — `git status`
thấy, nhưng không lệnh nào trong sổ task thấy. Câu đó thuộc owner, và nó cần một chỗ ký tên.

**Ô `Owner kiểm tra` giữ đúng hai thứ**, không hơn:

- **dấu ai ký** — `👤` owner phải nhìn tận mắt trước khi phiên sau đi tiếp · `🤖` biên nhận của lane đã
  đủ (luật chọn dấu: [rule §1.2b](../.claude/rules/quan-ly-du-an.md)). Lý do ký để trong ngoặc *nghiêng*.
- **link xuống bảng soi**: `[bảng soi ↓](#owner-t-xx)`.

**Chi tiết nằm ở bảng soi ba cột** `### owner-T-xx` trong §Owner kiểm tra của `task.md` — mỗi task một
bảng: *thay đổi cái gì · câu lệnh để thấy thay đổi · ở đâu*, cộng một dòng `**Đạt khi:**`. Khuôn bảng:
[bao-cao-thay-doi.md](../.claude/rules/bao-cao-thay-doi.md) §2.

**Bảng soi là lời khai trước khi làm, không phải báo cáo sau khi làm.** Đây là điểm dễ hiểu sai nhất.
Viết bảng lúc **mở** task nghĩa là task tự hứa sẽ chạm đúng những chỗ đó; owner chỉ việc đối chiếu nó
với bảng thay đổi phiên dán ra lúc kết. **Lệch ra một file không có trong bảng = phiên đã lấn phạm vi**,
và đó là một dòng `finding.md`. Viết bảng sau khi làm thì nó chỉ chép lại `git status` — không chặn được
gì, vì cái nó đo và cái nó bị đo bằng là cùng một thứ.

**Ví dụ.**

| | |
|---|---|
| ❌ SAI | `👤 · git show --stat HEAD` — nhét lệnh vào ô; sổ phình ngang, và ba cột của bảng soi bị ép thành một dòng |
| ❌ SAI | mọi dòng đều `👤` — cột đó lọc đúng bằng không, owner bỏ qua từ dòng thứ năm |
| ❌ SAI | bảng soi viết sau khi commit, chép lại `git status` — không chặn được lấn phạm vi |
| ✅ ĐÚNG | `👤 · [bảng soi ↓](#owner-t-01)` · `🤖 · [bảng soi ↓](#owner-t-11)` |
| ✅ ĐÚNG *(có lý do ký)* | `👤 *(mở lane đầu tiên, đặt tiền lệ cho T-06→T-09)* · [bảng soi ↓](#owner-t-02)` |

**Cách thực hiện — viết bảng soi lúc MỞ task, năm bước:**

1. **Chọn dấu.** Task sửa luật, mở lane, đụng tiền thật, hoặc đặt tiền lệ cho task sau ⇒ `👤` kèm lý do
   trong ngoặc nghiêng. Còn lại ⇒ `🤖`. Kiểm cột còn lọc được không: `grep -c '👤' task.md` so với tổng
   số dòng — hai số bằng nhau là cột đã chết.
2. **Liệt kê mỗi file sẽ chạm thành một hàng.** Cột *Thay đổi cái gì* viết **một câu về nội dung**, không
   phải tên file — tên file đã ở cột thứ ba.
3. **Cột lệnh phải in ra THAY ĐỔI, không phải hiện trạng.** `git show <sha> -- <path>` · `git diff --stat`
   · `git show --stat HEAD -- <thư mục>`. Đây là ranh giới với ô `Đầu ra kiểm chứng được`, vốn in ra hiện
   trạng. Chạy thử từng lệnh: cái nào ra **rỗng** là lệnh sai (thường gặp: thay đổi đã vào commit mà cột
   vẫn ghi `git diff` — tra sha rồi đổi sang `git show`).
4. **Cột *Ở đâu* trỏ tới mục**, không chỉ file: `[CLAUDE.md](CLAUDE.md) §1 bảng lane › **đúng một dòng BA**`.
   Đánh dấu `**(mới)**` cho file được tạo ra trong task này.
5. **Đóng bảng bằng dòng `**Đạt khi:**`** — điều kiện owner nhìn để nói *nhận* hay *trả lại*, viết bằng
   **số đếm được**: `git show --stat <sha>` ra **đúng 4 file**; xuất hiện file thứ năm ⇒ lấn phạm vi.
   ⚠️ Viết đúng `**Đạt khi:**` — thường, không viết hoa. Lệnh (c) ở
   [bao-cao-thay-doi.md](../.claude/rules/bao-cao-thay-doi.md) §3 đếm ba số phải bằng nhau bằng chuỗi
   `^\*\*Đạt khi:\*\*`; viết giống dòng `**ĐẠT khi:**` của bảng chất lượng (5.14) thì lệnh đó ra số
   gấp đôi và **cơ chế đếm chết trong im lặng**.

**Session hiểu và làm gì.** Phiên nhận task đọc bảng soi như **hợp đồng phạm vi**: chạm ngoài danh sách
đó ⇒ không sửa lặng lẽ, mở một dòng `finding.md`. Owner soi lại một task vừa ✅ bằng cách chạy từng lệnh
cột 2 rồi đọc `**Đạt khi:**` — nhịp này ở [rule §4](../.claude/rules/quan-ly-du-an.md).

### 5.14 `Chất lượng` — TP4 tầng hai: *phiên sau có dùng được không*

**Lý do tồn tại.** Mười hai ô trước trả lời **XONG**. Không ô nào trả lời **TỐT**, và hai câu đó khác
nhau: một task xong là *lệnh đã xanh*, một task tốt là *phiên sau nạp file đó rồi làm tiếp được mà
không phải hỏi ai*. Cột này được thêm 2026-08-23 sau [F-13](../finding.md#f-13), khi phát hiện **cả 16
dòng `task.md` lúc đó đều dừng ở "tồn tại + hình dạng"** — không dòng nào khai *đỏ khi*, nghĩa là không
biên nhận nào trong repo đo được chất lượng.

Đây là loại lỗi tự che: **task XONG mà không TỐT trông y hệt task tốt**. Cả hai có lệnh xanh, có commit,
có dấu ✅. Khác biệt chỉ lộ ra ở phiên thứ mười, khi ai đó nạp file và phát hiện nó chỉ hiểu được nếu
đã dự cuộc hội thoại hôm viết nó — và lúc đó người viết đã không còn ở đây.

**Ô này giữ đúng ba thứ**, không hơn:

- **dấu trạng thái** — `⬜` chưa đo tới sàn · `✅` đạt sàn (ngày ghi trong bảng) · `❌` trả lại (kèm mã finding);
- **tầng sàn** — `T0` tồn tại · `T1` hình dạng · `T2` nhất quán · `T3` dùng được lạnh;
- **link xuống bảng**: `[soi ↓](#cl-t-xx)`.

Thang tầng, **năm trục đo**, và **luật biên nhận âm** không ở đây và cũng không ở `task.md` — nhà của
chúng là [quality/00-guideline-chat-luong.md](../quality/00-guideline-chat-luong.md) §3 §4 §5. Sổ task
chỉ **áp chúng xuống từng mã**.

**Chi tiết nằm ở bảng bốn cột** `### cl-T-xx` trong §Chất lượng đầu ra của `task.md`: *trục §4 · mệnh đề
phải đúng · lệnh soi · đỏ khi*, đóng bằng hai dòng `**ĐẠT khi:**` và `**Đã thử làm đỏ:**`.

**Hai luật làm nên giá trị của cột này** — bỏ luật nào thì cột thành trang trí:

1. **Lệnh soi phải khác lệnh ở ô biên nhận, và phải chạm ≥ 2 file.** Lệnh chỉ chạm đúng file mình vừa gõ
   chứng minh được *"tôi đã gõ"*, không chứng minh *"đúng"* (guideline §5.2). Chất lượng là câu hỏi về
   **quan hệ giữa file này và phần còn lại của repo**, nên lệnh đo nó phải bắc qua ít nhất hai file.
2. **Mỗi hàng khai một vế *"đỏ khi …"*, và phải thử làm nó đỏ đúng một lần** trước khi commit: sửa hỏng
   tạm → chạy → thấy đỏ → `git checkout -- <file>` khôi phục. Dòng `**Đã thử làm đỏ:**` là **chỗ duy
   nhất** ghi lại việc đó. Chưa thấy một lệnh đỏ lần nào thì chưa ai biết nó đang đo cái gì — và ô đó
   phải để `⬜` cho thật, đừng làm tròn lên ✅.

**Ví dụ.**

| | |
|---|---|
| ❌ SAI | `✅` không tầng, không link — không ai biết "đạt" là đạt tới đâu |
| ❌ SAI | lệnh soi `wc -l < CLAUDE.md` — trùng ô biên nhận, và chỉ chạm một file: chứng minh "tôi đã gõ" |
| ❌ SAI | `**Đã thử làm đỏ:** ✅` mà không nói **làm hỏng cái gì** — không tái hiện được thì không phải bằng chứng |
| ❌ SAI | mọi dòng đều sàn `T3` — sàn không loại được file nào thì nó không phải bộ lọc ([F-14](../finding.md#f-14) 🔴 MỞ) |
| ✅ ĐÚNG | `⬜ T3 · [soi ↓](#cl-t-01)` · `⬜ T2 · [soi ↓](#cl-t-03)` |
| ✅ ĐÚNG *(một hàng bảng)* | Trục **Một nhà** · *khuôn cột chỉ sống ở rule* · `grep -c 'Prompt mở session' CLAUDE.md .claude/rules/quan-ly-du-an.md` → `0` và `>= 1` · **đỏ khi** `CLAUDE.md` ra `>= 1` |
| ✅ ĐÚNG *(dòng chốt)* | `**Đã thử làm đỏ:** ✅ 2026-08-23 — bản sao ở scratchpad, chèn 'Prompt mở session' vào CLAUDE.md → hàng 1 ra 1 thay vì 0, đỏ thật` |

**Cách thực hiện — sáu bước, làm lúc MỞ task và chốt lúc đóng:**

1. **Chọn tầng sàn theo vai của file**, không theo độ khó của task. File mà **phiên khác sẽ nạp**
   (`CLAUDE.md`, `.claude/rules/lane-*.md`, `quality/**`, file đứng trong ô `Nạp` của một dòng chưa làm)
   ⇒ **T3**. File chỉ được **chạy** hoặc chỉ được **tra cứu** ⇒ **T2**. Đánh ✅ dưới T2 là không hợp lệ:
   T0/T1 một mình chỉ chứng minh *"đã tạo file"*.
   ⚠️ Trong repo chỉ-có-tài-liệu, vị ngữ *"file phiên khác sẽ nạp"* không loại được gì và 21/23 dòng
   nhận T3 — đó là [F-14](../finding.md#f-14), còn 🔴 MỞ. Dự án sau nên hẹp vị ngữ **trước** khi áp.
2. **Chọn 1–2 trục** trong năm trục §4 (Đúng · Đủ · Một nhà · Rẻ để đọc · Dùng được lạnh) — chọn trục
   mà task này **dễ hỏng nhất**, không chọn cả năm. Năm hàng cho mỗi task nghĩa là không hàng nào được đo.
3. **Viết mệnh đề trước, lệnh sau.** Mệnh đề là một câu khẳng định có thể sai: *"mọi con trỏ trong
   `CLAUDE.md` giải được ra file thật"*. Câu không thể sai thì không đo được gì.
4. **Dịch mệnh đề thành lệnh chạm ≥ 2 file**, khác lệnh ở ô biên nhận. Dịch không nổi ⇒ mệnh đề còn là
   cảm nhận; viết lại cho tới khi nó chạm được vào hai file thật.
5. **Viết vế *"đỏ khi"* bằng hiện tượng quan sát được** — `CLAUDE.md ra >= 1 ⇒ khuôn có bản chép thứ
   hai`. Không phải "khi sai" — "sai" không phải hiện tượng.
6. **Làm nó đỏ một lần, rồi ghi lại.** Chép file ra scratchpad hoặc sửa hỏng tạm rồi `git checkout --`.
   Ghi vào `**Đã thử làm đỏ:**` đủ **ba mẩu**: ngày · làm hỏng cái gì · lệnh ra gì thay vì gì. Chưa làm
   ⇒ `⬜ chưa`, và ô `Chất lượng` ở sổ vẫn `⬜`.

⚠️ **Dòng chốt viết hoa: `**ĐẠT khi:**`** — cố ý khác `**Đạt khi:**` của bảng soi owner (5.13), vì lệnh
đếm (c) ở [bao-cao-thay-doi.md](../.claude/rules/bao-cao-thay-doi.md) §3 phân biệt hai bảng bằng đúng
chữ hoa đó.

**Task chạm `finding.md`** thì **hai cổng** ở
[.claude/rules/chat-luong-finding.md](../.claude/rules/chat-luong-finding.md) §3 là một hàng **bắt buộc**
trong bảng của nó — mục 🔴 MỞ thiếu vế bắt buộc, và mục khai ĐÓNG mà không có `Bài học giữ lại`.

**Session hiểu và làm gì.** Không được tự đổi `⬜` thành `✅` cho xong phiên: chưa đạt tầng sàn ⇒ để `❌`
+ mở finding ([rule §4](../.claude/rules/quan-ly-du-an.md)). Ba tầng chất lượng (chung → pha → step) ở
[guideline §7](../quality/00-guideline-chat-luong.md) quyết định đo lúc nào; cột này chỉ là chỗ ghi kết quả.

---

## Phần VI — Thứ tự lắp ráp

Nguyên tắc của prompt: **thông tin ổn định ở trên, dữ liệu lớn ở giữa, chỉ dẫn hành động ở dưới cùng**.
Ánh xạ sang hệ file của dự án, một dòng task được "lắp ráp" thành prompt như sau:

```
┌─ ỔN ĐỊNH — không nằm trong sổ task, session tự đọc mỗi phiên ──────────┐
│  CLAUDE.md §1 định tuyến lane · §2 một sự thật một nhà · §3 vòng lặp    │  ← TP1, TP6, TP9
│  quality/ định nghĩa XONG · §6.9 ba thứ không thoả hiệp                 │  ← TP4
└────────────────────────────────────────────────────────────────────────┘
┌─ DỮ LIỆU — ô Context của dòng task ────────────────────────────────────┐
│  Nạp (file + đúng mục) · Đã chốt (trỏ) · Bẫy                            │  ← TP5, TP2, TP10
└────────────────────────────────────────────────────────────────────────┘
┌─ CHỈ DẪN HÀNH ĐỘNG — cuối cùng, gần chỗ session bắt đầu sinh chữ ──────┐
│  Task (động từ) → Cần xong trước → Đầu ra kiểm chứng được →            │  ← TP3, TP9, TP4+TP7
│  Hỏng thì mất gì → Prompt mở session (câu "dừng khi nào")               │  ← TP2, TP8
└────────────────────────────────────────────────────────────────────────┘
┌─ CỔNG RA — không nằm trên dòng task, nằm ở hai mục riêng cuối sổ ──────┐
│  ### owner-T-xx  bảng 3 cột + **Đạt khi:**    (đổi cái gì)             │  ← TP11 nửa người
│  ### cl-T-xx     bảng 4 cột + **ĐẠT khi:**    (phiên sau dùng được?)   │  ← TP4 tầng hai
│  dòng task chỉ giữ **dấu + link** trỏ xuống hai mục này                 │
└────────────────────────────────────────────────────────────────────────┘
```

Điểm mấu chốt: **sổ task chỉ giữ tầng giữa và tầng dưới.** Tầng trên là `CLAUDE.md` — chép nó vào từng
dòng task là nhân bản luật lên 78 lần, và bản thứ 78 sẽ khác bản gốc.

Điểm mấu chốt thứ hai, mới từ 2026-08-22: **tầng cổng ra không nằm trên dòng task.** Hai ô
`Owner kiểm tra` và `Chất lượng` chỉ giữ *dấu + link*; nội dung ở hai mục neo `### owner-T-xx` và
`### cl-T-xx` cuối sổ. Lý do là chiều ngang: một bảng 3 cột và một bảng 4 cột nhét vào hai ô của một
hàng markdown thì hàng đó dài vài nghìn byte, `grep -n` hết thay được việc đọc, và không ai sửa nổi
một ô mà không vỡ ô bên cạnh. Đổi lại, sổ phải giữ **quan hệ một-một**: mỗi dòng task một bảng, mỗi
bảng một dòng task — hai vòng lặp kiểm ở [bao-cao-thay-doi.md](../.claude/rules/bao-cao-thay-doi.md) §3 (b).

### Khuôn một dòng task — 11 cột

```
| **T-xx** 🔺 | BE | <động từ + tân ngữ + file sẽ sửa> | **Nạp:** <file §mục> · **Đã chốt:** <trỏ> · **Bẫy:** <chỗ sẽ cắn> | T-yy | [F-zz](finding.md#f-zz) ✅ | `<lệnh>` ra `<kết quả kỳ vọng>` → đóng **F-nn** | 👤 · [bảng soi ↓](#owner-t-xx) | ⬜ T3 · [soi ↓](#cl-t-xx) | <hậu quả ở quán> | `Lane BE · T-xx · <lệnh mở dòng> · chỉ chạm <path> · xong <X> thì DỪNG` |
```

Kèm theo, **hai khối bắt buộc** ở cuối sổ — thiếu một khối là dòng task chưa hoàn chỉnh:

```
### owner-T-xx
**<tên task>** · ai ký: 👤
| Thay đổi cái gì | Câu lệnh để thấy thay đổi | Ở đâu |
|---|---|---|
| <một câu về nội dung> | `git show <sha> -- <path>` | <link tới file> **(mới)** › §mục |
**Đạt khi:** <điều kiện đếm được> — vượt ra ⇒ lấn phạm vi, ghi finding.

### cl-T-xx
**<tên task>** · sàn **T3** · ⬜ chưa đo
| Trục §4 | Mệnh đề phải đúng | Lệnh soi (≥ 2 file, khác ô biên nhận) | Đỏ khi |
|---|---|---|---|
| Một nhà | <mệnh đề có thể sai> | `grep -c '<chuỗi>' <fileA> <fileB>` → `0` và `>= 1` | <hiện tượng quan sát được> |
**ĐẠT khi:** <điều kiện>. · **Đã thử làm đỏ:** ⬜ chưa
```

⚠️ Neo `#owner-t-xx` và `#cl-t-xx` **viết thường** trong link, `### owner-T-xx` **viết hoa T** trong
tiêu đề — GitHub hạ chữ hoa khi sinh neo. Sai chỗ này thì link im lặng không nhảy, không lệnh nào đỏ.

---

## Phần VII — Bỏ bớt trường nào cho loại task nào

Không phải task nào cũng cần đủ 14 trường. Task giấy tờ mà viết 11 ô đầy chữ thì bạn đang tốn thời gian
của chính mình. Bốn trường **không bao giờ được bỏ**: `Lane` · `Task` · `Đầu ra kiểm chứng được` ·
`Hỏng thì mất gì` ([rule §1.2](../.claude/rules/quan-ly-du-an.md)).

Nhưng **hai ô cổng ra không nằm trong danh sách bỏ được của bất kỳ loại nào.** `Owner kiểm tra` và
`Chất lượng` là hai ô chống lại hai lỗi mà chính task nhỏ mắc nhiều nhất: task nhỏ hay lấn phạm vi (vì
"tiện tay"), và task nhỏ hay bị làm cho xong (vì "có đáng gì đâu"). Task càng nhỏ, hai ô đó càng rẻ để
điền — một dấu và một link.

| Loại task | Trường tối thiểu | Bỏ được |
|---|---|---|
| Giấy tờ (chốt thiết kế, sửa tài liệu) | 4 bắt buộc + `Nạp` + `Owner kiểm tra` + `Chất lượng` | `Bẫy`, `Cần xong trước`, `Prompt` |
| Sửa lỗi (đóng một finding) | 4 bắt buộc + `Finding phải đóng` + `Bẫy` + 2 ô cổng ra | `Đã chốt` |
| Xây mới một lát cắt | 4 bắt buộc + `Nạp` + `Cần xong trước` + `Prompt` + 2 ô cổng ra | `Bẫy` nếu chưa từng cắn |
| Task 🔺 (chặn task khác) | **đủ 14 trường** | — |
| Task mở một lane mới | **đủ 14 trường** + dấu `👤` + sàn `T3` | — |
| Task DEVOPS đụng tiền thật (deploy, backup) | **đủ 14 trường** + câu dừng gắt trong `Prompt` | — |

---

## Phần VIII — Ví dụ tổng hợp: một dòng task tồi → tốt

**Bản gốc:**

```
| T-08 | BE | Làm chức năng đặt món | | | | Xong khi chạy được | |
```

Bốn lỗi: không biết **được sửa file nào** (Lane có mà không có phạm vi), không biết **thế nào là xong**,
không biết **hỏng thì mất gì** nên không xếp được ưu tiên, và không nói **phải làm gì khi tài liệu lệch
với code**.

**Bản viết lại, chú thích từng ô:**

```
| **T-08** 🔺                                          ← 5.1: mã + ưu tiên, chặn mọi task BE sau
| BE                                                   ← TP1: lane ⇒ gói nạp + biên nhận ở CLAUDE.md §1
| Viết internal/order/service.go: hàm RecalcSession     ← TP3: động từ + tân ngữ + file
  tính lại tổng phiên trong cùng transaction
| Nạp: design/backend/04-yeu-cau.md §3 · design/        ← TP5: file + ĐÚNG MỤC, không nạp trọn step.md
  data_base/01 §bảng sessions
  Đã chốt: BE luôn tính lại giá từ DB (§6.9)            ← TP2: trỏ, không chép
  Bẫy: FE có gửi kèm total — KHÔNG tin, tính lại từ     ← TP10: cấp phép phản bác đề bài
  DB; lệch thì mở finding, đừng sửa cho khớp
| T-BA-15                                              ← TP9: thứ tự ngoài, quan sát được
| F-01 ✅                                               ← TP6: cổng vào + van xả
| go test -run TestRecalcSession ./internal/order/ ra   ← TP4+TP7: lệnh + kết quả kỳ vọng
  3 ca (thêm lượt, huỷ món, phiên billing) PASS,
  và FAIL trên commit trước → đóng F-16
| 👤 · [bảng soi ↓](#owner-t-08)                        ← 5.13: chỉ dấu + link, chi tiết ở bảng 3 cột
| ⬜ T2 · [soi ↓](#cl-t-08)                             ← 5.14: sàn T2 vì service.go không phiên nào NẠP
| Thu thiếu tiền bàn 5: khách gọi lượt 2 mà hoá đơn     ← TP2: LÝ DO, viết bằng hậu quả ở quán
  chỉ có lượt 1
| Lane BE · T-08 · sed -n '/T-08/p' task.md · chỉ       ← TP8: mẫu + ràng buộc hẹp + câu DỪNG
  chạm internal/order/** · xong service thì DỪNG,
  chưa viết handler (đó là T-10)                        |
```

**Hai khối cổng ra đi kèm** (cuối sổ, không nằm trên dòng task):

```
### owner-T-08                        ← 5.13: lời khai TRƯỚC khi làm, owner đối chiếu lúc kết
| Thay đổi cái gì | Câu lệnh để thấy thay đổi | Ở đâu |
| Hàm tính lại tổng phiên, chạy trong cùng transaction với ghi đơn
                  | git show HEAD -- internal/order/service.go
                                              | internal/order/service.go (mới) › RecalcSession |
| Ca test chứng minh bug từng tồn tại
                  | git show HEAD -- internal/order/service_test.go
                                              | internal/order/service_test.go › 3 ca |
**Đạt khi:** git show --stat HEAD ra ĐÚNG 2 file, cả hai trong internal/order/.
             File thứ ba ⇒ lấn phạm vi, đừng nhận.

### cl-T-08                           ← 5.14: lệnh chạm ≥ 2 file, khác ô biên nhận
| Trục §4 | Mệnh đề phải đúng | Lệnh soi | Đỏ khi |
| Một nhà | chỉ BE tính giá; FE không có phép nhân giá nào
          | grep -rn 'price *\*' internal/ web/ | grep -v internal/order
                                       | ra bất kỳ dòng nào ở web/ ⇒ có bản tính giá thứ hai |
**ĐẠT khi:** hàng trên xanh. · **Đã thử làm đỏ:** ⬜ chưa
```

**Mỗi ô thêm vào loại bỏ hành vi xấu nào:**

| Ô | Chặn được gì |
|---|---|
| `chỉ chạm internal/order/**` | Diff 14 file kèm refactor "tiện thể" |
| `FE có gửi kèm total — KHÔNG tin` | Session viết code tin FE, lỗi chỉ lộ ra khi có khách sửa request |
| `và FAIL trên commit trước` | Test chỉ-xanh, không chứng minh được bug đã từng tồn tại |
| `Thu thiếu tiền bàn 5` | Task này bị xếp sau mấy task giao diện dễ làm |
| `Đạt khi: ĐÚNG 2 file` (bảng soi) | Diff xanh nhưng kèm 4 file lane khác — owner nhận nhầm vì "test pass mà" |
| `Đỏ khi: có phép nhân giá ở web/` (bảng cl) | Task XONG mà FE vẫn giữ bản tính giá thứ hai — lệnh biên nhận không bao giờ thấy |
| `xong service thì DỪNG, chưa viết handler` ⭐ | Session gánh luôn T-10, diff phình, không ai rà nổi |
| `lệch thì mở finding, đừng sửa cho khớp` ⭐ | **Session sửa tài liệu cho khớp code sai — sai lặng lẽ, không lệnh nào đỏ** |

Hai dòng ⭐ là hai dòng đáng giá nhất, và cũng là hai dòng hay bị bỏ nhất. Hai dòng cổng ra là hai dòng
**mới nhất** — chúng chặn đúng loại lỗi mà mười hai ô kia không thấy được: lỗi ở **ngoài** phạm vi đã
khai, và lỗi lộ ra **sau** khi phiên đã đóng.

---

## Phần IX — Tự rà `task.md` trước khi commit

Chạy từ gốc repo; ra kết quả khác kỳ vọng là **lỗi của `task.md`**, sửa ngay:

```bash
# 1. Dòng nào thiếu biên nhận (ô đầu ra rỗng) ⇒ là ý kiến, không phải task
grep '^| \*\*T-' task.md | awk -F'|' 'length($8) < 12 {print $2}'

# 2. Task nào chạm 2 lane ⇒ phải chẻ trước khi làm
grep '^| \*\*T-' task.md | grep '⚠️+'

# 3. Finding đang mở mà không task nào đóng ⇒ bị bỏ rơi
for f in $(grep '^| \[F-' finding.md | grep -v '✅ ĐÓNG' | grep -o 'F-[0-9]*' | sort -u); do
  grep -q "finding.md#$(echo $f | tr 'A-Z' 'a-z'))" task.md || echo "BỎ RƠI: $f"
done

# 4. Mã task trùng
grep -o '\*\*T-[0-9]*\*\*' task.md | sort | uniq -d

# 5. Mọi dòng task phải cùng số cột với dòng tiêu đề — ra đúng MỘT giá trị, và bằng 13
#    (13 = 11 cột + 2 ô rỗng hai đầu). sed thay dấu | ĐÃ THOÁT trong ô, nếu không awk đếm cả chúng
#    và lệnh ra 13/14/15/16 — đỏ vĩnh viễn, đúng cái bẫy F-05 + F-09 đã mô tả.
grep '^| ~*\*\*T-' task.md | sed 's/\\|/@/g' | awk -F'|' '{print NF}' | sort -u

# 6. Mỗi dòng task một bảng soi và một bảng chất lượng — ba số phải bằng nhau
grep -c '^| ~*\*\*T-' task.md      # số dòng task
grep -c '^### owner-T-' task.md      # số bảng soi owner
grep -c '^### cl-T-' task.md         # số bảng chất lượng

# 7. Dòng chốt của hai loại bảng — hai số cũng phải bằng số dòng task, và phải KHÁC CHỮ HOA
grep -c '^\*\*Đạt khi:\*\*' task.md   # bảng soi owner — chữ thường
grep -c '^\*\*ĐẠT khi:\*\*' task.md   # bảng chất lượng — CHỮ HOA

# 8. Ô Chất lượng phải có đủ ba mẩu: dấu + tầng + link. Số này cũng phải bằng số dòng task
grep -c '\(⬜\|✅\|❌\) T[0-3] · \[soi ↓\]' task.md

# 9. Hai cột dấu có còn lọc được không — mọi dòng cùng một giá trị nghĩa là cột đã chết.
#    Lọc '^| ~*\*\*T-' trước, nếu không đếm nhầm cả dấu nằm trong hai mục bảng cuối sổ.
grep -o 'sàn \*\*T[0-3]\*\*' task.md | sort | uniq -c        # tầng sàn: ra >= 2 nhóm
grep '^| ~*\*\*T-' task.md | grep -c '👤'                    # dấu ai ký: hai số phải
grep '^| ~*\*\*T-' task.md | grep -c '🤖'                    # đều khác 0 và khác tổng
```

Lệnh 5–9 là phần thêm 2026-08-23. Chúng không đo *nội dung đúng chưa* mà đo **cơ chế còn sống không**:
một bảng thiếu, một dòng chốt viết sai chữ hoa, hay một cột mà mọi dòng cùng giá trị — cả ba đều làm
cơ chế chết **trong im lặng**, và im lặng là kiểu hỏng đắt nhất.

**Mỗi lệnh phải khai vế *đỏ khi***, đúng luật biên nhận âm ([guideline §5](../quality/00-guideline-chat-luong.md)):

| Lệnh | Ra gì là xanh | **Đỏ khi** |
|---|---|---|
| 5 | đúng một giá trị `13` | ra ≥ 2 giá trị ⇒ có dòng vỡ cột, và mọi lệnh `awk -F'\|'` khác đang đọc nhầm ô |
| 6 | ba số bằng nhau | lệch ⇒ có dòng task không bảng, hoặc bảng mồ côi trỏ tới task đã xoá |
| 7 | hai số bằng số ở lệnh 6 | một trong hai ra gấp đôi ⇒ hai loại bảng viết cùng chữ hoa, lệnh (c) ở `bao-cao-thay-doi.md` §3 hết phân biệt được |
| 8 | bằng số ở lệnh 6 | nhỏ hơn ⇒ có ô `Chất lượng` thiếu dấu, thiếu tầng, hoặc thiếu link |
| 9 | ≥ 2 nhóm tầng; cả `👤` lẫn `🤖` khác 0 | một nhóm duy nhất ⇒ cột đó lọc đúng bằng không, xem [F-14](../finding.md#f-14) |

Bảy câu không có lệnh, hỏi bằng đầu:
dòng nào **chép** lại thứ đã có nhà khác? · dòng nào **mô tả finding** thay vì trỏ mã? · biên nhận nào
dùng lệnh **chưa tồn tại** mà không đánh ⚠️? · dòng nào không đẩy **lát cắt A/B/C** nào? · ô `Hỏng thì
mất gì` nào viết bằng **thuật ngữ** thay vì hậu quả ở quán? · bảng `cl-T-xx` nào có **lệnh soi trùng**
lệnh ở ô biên nhận, hoặc chỉ chạm **một** file? · bảng `owner-T-xx` nào có cột lệnh in ra **hiện trạng**
thay vì **thay đổi**?

---

## Phần X — Bốn quyết định đã chốt

Các mục dưới đây từng để ngỏ. Chúng đã được chốt và **đã có nhà thật** — bảng này chỉ trỏ, không chép
lại lý do; đọc lý do ở nhà của nó. Mã `G1 G2 G3` giữ nguyên vì [F-01](../finding.md#f-01) trỏ tới chúng;
`G4` chốt sau, 2026-08-23.

| # | Vấn đề | Đã chốt | Nhà giữ quyết định + lệnh kiểm chứng |
|---|---|---|---|
| G1 | "Giai đoạn" hay "Pha" | **6 Pha** của [§7](prompt-fullstack.md) | [finding.md#f-01](../finding.md#f-01) ✅ ĐÓNG — lệnh: `grep -c 'Giai đoạn [0-9]'` trên 4 file khung ra `0` |
| G2 | Giữ hay bỏ cột `Hỏng thì mất gì` | **Giữ** — nó là TP2 (lý do), căn cứ duy nhất để xếp ưu tiên | [.claude/rules/quan-ly-du-an.md](../.claude/rules/quan-ly-du-an.md) §1 + §1.2 (bốn trường không bao giờ bỏ) |
| G3 | Biên nhận khi chưa có compiler | **Lệnh đọc lại**; `make`/`go test`/`npm` phải mang ⚠️ | rule §3 (định nghĩa XONG bốn vế) + [CLAUDE.md](../CLAUDE.md) §7 — lệnh dò: rule §5.3 dòng 2 |
| G4 | Đo **TỐT** bằng gì, và đặt kết quả ở đâu *(2026-08-23)* | **Thang tầng T0–T3 + năm trục + luật biên nhận âm**; kết quả đặt ở cột thứ 11 `Chất lượng` + bảng `### cl-T-xx` | [quality/00-guideline-chat-luong.md](../quality/00-guideline-chat-luong.md) §3 §4 §5 (thang) + rule §1.1 dòng `Chất lượng` (khuôn ô) + 5.14 file này (vì sao) — gốc: [F-13](../finding.md#f-13) |

Bốn quyết định này đã đi vào `task.md` rồi: ô `Đã chốt` của T-02 mang G1, ô `Đầu ra kiểm chứng được`
của T-03 mang ⚠️ theo G3, và cả 23 dòng đều mang một ô `Chất lượng` theo G4. Muốn đổi một trong bốn ⇒
mở finding, đừng sửa thẳng ở đây: file này là bản đồ, sửa bản đồ mà không sửa lãnh thổ là cách hai bên
trôi khỏi nhau.

**G4 chưa yên.** Vị ngữ của luật sàn còn quá rộng — 21/23 dòng nhận T3, nên cột chưa lọc được gì. Đó là
[F-14](../finding.md#f-14) 🔴 MỞ. Dự án sau bê G4 sang thì **hẹp vị ngữ trước khi áp**, đừng bê cả lỗi:
T3 cho file đứng trong **gói nạp của một lane**, T2 cho file chỉ được tra cứu.

---

## Bốn câu tóm tắt

1. **Một dòng task là một prompt**, không phải một nhãn dán việc. Thành phần nào bạn không viết,
   session sẽ tự chọn thay bạn — và nó chọn rất tự tin.
2. **Ô `Hỏng thì mất gì` (lý do) và ô `Bẫy` (xử lý bất định) là hai ô hay bị bỏ nhất**, đồng thời là
   hai ô chặn hai loại lỗi tốn kém nhất: xếp sai ưu tiên, và làm sai một cách nghe rất hợp lý.
3. **Task đo *xong/chưa*, finding đo *đúng/sai*.** Trộn hai sổ là mất cả hai cơ chế: finding sẽ bị
   đánh ✅ khi hết giờ, task sẽ không bao giờ đóng được.
4. **XONG và TỐT là hai câu hỏi, nên là hai ô.** Mười hai ô đầu chứng minh việc đã làm; `Owner kiểm tra`
   chứng minh nó đã làm **đúng chỗ**, `Chất lượng` chứng minh nó **dùng được ở phiên sau**. Bỏ hai ô
   cuối thì sổ vẫn xanh — chỉ là nó không còn đo cái gì nữa.
