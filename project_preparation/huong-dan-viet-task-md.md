# Hướng dẫn viết task — **mỗi dòng task là một prompt hoàn chỉnh**

> Cập nhật **2026-08-22**. File này là **luật viết sổ task**, không phải sổ task.
> Nền lý thuyết: [cau-truc-prompt-tot.md](../prompt/huong_dan_prompt/cau-truc-prompt-tot.md) (11 thành phần
> của một prompt tốt) · Luật dự án: [prompt-fullstack.md §5–§8](prompt-fullstack.md) ·
> Mẫu đã chạy thật: [reference/task.md](../reference/task.md) + [reference/CLAUDE_rẻence.md](../reference/CLAUDE_rẻence.md).
> File này lệch prompt-fullstack ⇒ **prompt-fullstack thắng**, dòng ở đây là bug phải sửa ngay.

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

## Phần IV — Bảng ánh xạ: 11 thành phần prompt → 12 trường của một task

| TP | Thành phần prompt | Trường trong dòng task | Bắt buộc? |
|---|---|---|---|
| — | *(không có trong 11 TP — thêm theo reference)* | **`#` mã + trạng thái** | **Bắt buộc** |
| 1 | Vai trò và người đọc | **`Lane`** | **Bắt buộc** |
| 3 | Nhiệm vụ (động từ hành động) | **`Task`** | **Bắt buộc** |
| 5 | Dữ liệu đầu vào và vị trí | **`Context › Nạp`** | **Bắt buộc** |
| 2 | Bối cảnh (phần "đã biết") | **`Context › Đã chốt`** | Nên có |
| 10 | Xử lý bất định | **`Context › Bẫy`** + luật ⚠️ ở cột đầu ra | **Bắt buộc** |
| 2 | Lý do ("vì...") | **`Hỏng thì mất gì`** | **Bắt buộc** |
| 9 | Quy trình (thứ tự ngoài) | **`Cần xong trước`** | Khi có phụ thuộc |
| 6 | Phạm vi và ràng buộc + **van xả** | **`Finding phải đóng`** + luật kích cỡ 1.2 | **Bắt buộc** |
| 4 + 7 | Tiêu chí thành công + Định dạng đầu ra | **`Đầu ra kiểm chứng được`** | **Bắt buộc** |
| 8 | Ví dụ (few-shot) | **`Prompt mở session`** (3 dòng đầu là mẫu) | Khi task sắp giao |
| — | *(thêm theo reference)* | **`Ưu tiên` 🔺 / ⚑n** | Khi ngoài đường găng |
| 11 | Tự kiểm tra | **nửa máy** không thành cột (ba thứ đánh ✅) · **nửa người** là ô `Owner kiểm tra` | Xem 5.13 |

**Khuôn đang dùng thật không nằm ở file này.** Nhà của nó là
[.claude/rules/quan-ly-du-an.md](../.claude/rules/quan-ly-du-an.md) §1 — file này giữ **vì sao có ô đó**
(Phần V), rule giữ **ô đang dùng và viết thế nào**. Số cột đổi theo rule, không đổi theo bảng trên:
12 trường xếp vào các cột bằng cách gộp (`Ưu tiên` + `Trạng thái` vào ô `#`, ba mẩu vào ô `Context`).

Khuôn hiện tại là **10 cột** (rule §1, cập nhật 2026-08-22 khi ô `Owner kiểm tra` được thêm). Số cột
sẽ còn đổi; đọc rule, đừng đọc con số ở đây. ⚠️ Ranh giới giữa file này và rule §1.1 chưa được cắt —
xem [finding.md F-04](../finding.md#f-04); lệch thì **rule thắng**.

---

## Phần V — Đặc tả từng trường

> Mỗi trường trình bày theo đúng bốn phần của [cau-truc-prompt-tot.md](../prompt/huong_dan_prompt/cau-truc-prompt-tot.md):
> **Trường** → **Lý do tồn tại** → **Ví dụ SAI / ĐÚNG** → **Session hiểu và làm gì**.

### 5.1 `#` — mã task kiêm trạng thái · *(thêm theo reference)*

**Lý do tồn tại.** Trạng thái ghi ở hai chỗ thì hai chỗ sẽ lệch. Mã hoá trạng thái vào chính ô mã
để **một lệnh `grep` ra được việc còn lại**, và để không ai phải cập nhật một bảng tổng hợp thứ hai.

**Ví dụ.**

| | |
|---|---|
| ❌ SAI | có thêm cột `Trạng thái` ghi `đang làm` — không lệnh nào đọc được, và luôn trễ một phiên |
| ✅ ĐÚNG | `| **T-08**` chưa làm · `| ~~**T-08**~~ ✅` xong · `| ~~**T-08**~~ ❌ huỷ: <lý do>` |

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

**Session hiểu và làm gì.** Chỉ chứa 5 mẩu: **lane · mã task · lệnh mở đúng dòng · ràng buộc hẹp nhất
· câu dừng**. **Chỉ điền khi task sắp được giao** — 78 dòng đều có prompt là 78 dòng phải sửa mỗi lần
đổi luật; ba dòng đầu tiên để làm **mẫu few-shot** cho các dòng viết sau. Khi có `make prompt T=T-xx`
thì ô này **sinh được bằng lệnh**, lúc đó dòng chưa điền không còn là thiếu sót.

Bẫy few-shot cần tránh khi viết 3 dòng mẫu: **đừng để cả ba cùng một dạng**. Ba dòng mẫu giống nhau sẽ
ngầm dạy rằng mọi task đều là task BE sửa 1 file — hãy cho một dòng NON-CODE, một dòng có câu dừng
gắt, một dòng task bị chặn bởi finding.

### 5.12 `Ưu tiên` 🔺 / ⚑n — thứ tự thi công · *(thêm theo reference)*

**Lý do tồn tại.** Bảng task xếp theo giai đoạn, mà **thứ tự file ≠ thứ tự ưu tiên**. Không có ký hiệu
ưu tiên, session lấy dòng đầu tiên đọc được — thường là dòng dễ nhất.

**Ba tầng, đọc từ trên xuống:**

1. **🔺 chặn** — không xong thì mọi session sau đều sai. Làm trước, bất kể nó ở giai đoạn nào.
2. **Đường găng** — dãy task nối tiếp quyết định ngày lên sóng, ghi **đúng một dòng**:
   `T-01 → T-02 → T-36 → T-BA-14 → T-08 → T-16 → T-20 → T-28 → T-31`.
3. **`⚑n`** — thứ tự owner tự chọn cho phần còn lại; lấy `⚑` nhỏ nhất **chưa xong** và **mở được**.

**Session hiểu và làm gì.** Mục *"Task tiếp theo — làm ngay"* ở đầu sổ phải là **lệnh chạy được** dò
theo đúng ba tầng này, **không phải** câu "tiếp theo làm T-08". Chép tên task ra đó ⇒ mỗi lần xong một
task phải sửa hai chỗ, và chỗ thứ hai sẽ quên.

### 5.13 TP11 — Tự kiểm tra: nửa máy thành ba thứ để đánh ✅, nửa người thành ô `Owner kiểm tra`

**Lý do tồn tại.** Câu "hãy tự kiểm tra lại" bắt lỗi tốt với model cũ, nhưng **Opus 5 tự verify sẵn**,
và mang câu verify từ prompt cũ sang gây **over-verification** — tốn token, tốn thời gian, không thêm
độ đúng. Tài liệu khuyên **xoá** những câu đó, đừng viết lại chúng.

Nên trong sổ task, TP11 không tồn tại dưới dạng chữ nhắc nhở. Nó tồn tại dưới dạng **cổng ra bằng
bằng chứng**: đánh ✅ cần đủ **ba** thứ, thiếu một ⇒ vẫn là đang làm ("đã viết code" ≠ "đã chạy"):

1. **biên nhận của lane chạy thật + output dán vào**;
2. **commit** chứa thay đổi — `git add <đường dẫn cụ thể>`, **cấm `git add -A`**, **cấm `--no-verify`**;
   message ghi lane + mã task + finding đã đóng: `BE/T-08: service/order.go, đóng F-16 F-17`;
3. `finding.md` đổi trạng thái kèm **ngày + cách kiểm chứng** (nếu task có đóng finding).

Đây cũng là lý do cụm *"và nêu rõ tiêu chí nào chưa đạt"* được thay bằng máy: bằng chứng là output
của lệnh, không phải câu tự khen "đã hoàn thành đầy đủ yêu cầu".

**Nhưng máy chỉ verify được nửa dưới.** Ba thứ trên chứng minh *lệnh chạy xanh*; chúng không trả lời
được *thay đổi này có được nhận không* — câu đó thuộc owner. Nửa người của TP11 vì vậy có nhà riêng: ô
**`Owner kiểm tra`** (thêm 2026-08-22), giữ `👤`/`🤖` + **một lệnh in ra thay đổi** (`git show --stat`,
`git diff --stat`, giới hạn `-- <path lane sở hữu>`), khác hẳn ô `Đầu ra kiểm chứng được` vốn in ra
*hiện trạng*. Đặc tả ô này ở [rule §1.1](../.claude/rules/quan-ly-du-an.md) — file này không chép lại.

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
```

Điểm mấu chốt: **sổ task chỉ giữ tầng giữa và tầng dưới.** Tầng trên là `CLAUDE.md` — chép nó vào từng
dòng task là nhân bản luật lên 78 lần, và bản thứ 78 sẽ khác bản gốc.

### Khuôn một dòng task

```
| **T-xx** ⚑2 | BE | <động từ + tân ngữ + file sẽ sửa> | **Nạp:** <file §mục> · **Đã chốt:** <trỏ> · **Bẫy:** <chỗ sẽ cắn> | T-yy | [F-zz](finding.md#f-zz) ✅ | `<lệnh>` ra `<kết quả kỳ vọng>` → đóng **F-nn** | <hậu quả ở quán> | `Lane BE · T-xx · <lệnh mở dòng> · chỉ chạm <path> · xong <X> thì DỪNG` |
```

---

## Phần VII — Bỏ bớt trường nào cho loại task nào

Không phải task nào cũng cần đủ 12 trường. Task giấy tờ mà viết 9 ô đầy chữ thì bạn đang tốn thời gian
của chính mình. Bốn trường **không bao giờ được bỏ**: `Lane` · `Task` · `Đầu ra kiểm chứng được` ·
`Hỏng thì mất gì`.

| Loại task | Trường tối thiểu | Bỏ được |
|---|---|---|
| Giấy tờ (chốt thiết kế, sửa tài liệu) | 4 trường bắt buộc + `Nạp` | `Bẫy`, `Cần xong trước`, `Prompt` |
| Sửa lỗi (đóng một finding) | 4 bắt buộc + `Finding phải đóng` + `Bẫy` | `Đã chốt` |
| Xây mới một lát cắt | 4 bắt buộc + `Nạp` + `Cần xong trước` + `Prompt` | `Bẫy` nếu chưa từng cắn |
| Task trên đường găng / 🔺 | **đủ 12 trường** | — |
| Task DEVOPS đụng tiền thật (deploy, backup) | **đủ 12 trường** + câu dừng gắt trong `Prompt` | — |

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
| Thu thiếu tiền bàn 5: khách gọi lượt 2 mà hoá đơn     ← TP2: LÝ DO, viết bằng hậu quả ở quán
  chỉ có lượt 1
| Lane BE · T-08 · sed -n '/T-08/p' task.md · chỉ       ← TP8: mẫu + ràng buộc hẹp + câu DỪNG
  chạm internal/order/** · xong service thì DỪNG,
  chưa viết handler (đó là T-10)                        |
```

**Mỗi ô thêm vào loại bỏ hành vi xấu nào:**

| Ô | Chặn được gì |
|---|---|
| `chỉ chạm internal/order/**` | Diff 14 file kèm refactor "tiện thể" |
| `FE có gửi kèm total — KHÔNG tin` | Session viết code tin FE, lỗi chỉ lộ ra khi có khách sửa request |
| `và FAIL trên commit trước` | Test chỉ-xanh, không chứng minh được bug đã từng tồn tại |
| `Thu thiếu tiền bàn 5` | Task này bị xếp sau mấy task giao diện dễ làm |
| `xong service thì DỪNG, chưa viết handler` ⭐ | Session gánh luôn T-10, diff phình, không ai rà nổi |
| `lệch thì mở finding, đừng sửa cho khớp` ⭐ | **Session sửa tài liệu cho khớp code sai — sai lặng lẽ, không lệnh nào đỏ** |

Hai dòng ⭐ là hai dòng đáng giá nhất, và cũng là hai dòng hay bị bỏ nhất.

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
```

Năm câu không có lệnh, hỏi bằng đầu:
dòng nào **chép** lại thứ đã có nhà khác? · dòng nào **mô tả finding** thay vì trỏ mã? · biên nhận nào
dùng lệnh **chưa tồn tại** mà không đánh ⚠️? · dòng nào không đẩy **lát cắt A/B/C** nào? · ô `Hỏng thì
mất gì` nào viết bằng **thuật ngữ** thay vì hậu quả ở quán?

---

## Phần X — Ba quyết định đã chốt (2026-08-22)

Ba mục dưới đây từng để ngỏ. Chúng đã được chốt và **đã có nhà thật** — bảng này chỉ trỏ, không chép
lại lý do; đọc lý do ở nhà của nó. Mã `G1 G2 G3` giữ nguyên vì [F-01](../finding.md#f-01) trỏ tới chúng.

| # | Vấn đề | Đã chốt | Nhà giữ quyết định + lệnh kiểm chứng |
|---|---|---|---|
| G1 | "Giai đoạn" hay "Pha" | **6 Pha** của [§7](prompt-fullstack.md) | [finding.md#f-01](../finding.md#f-01) ✅ ĐÓNG — lệnh: `grep -c 'Giai đoạn [0-9]'` trên 4 file khung ra `0` |
| G2 | Giữ hay bỏ cột `Hỏng thì mất gì` | **Giữ** — nó là TP2 (lý do), căn cứ duy nhất để xếp ưu tiên | [.claude/rules/quan-ly-du-an.md](../.claude/rules/quan-ly-du-an.md) §1 + §1.2 (bốn trường không bao giờ bỏ) |
| G3 | Biên nhận khi chưa có compiler | **Lệnh đọc lại**; `make`/`go test`/`npm` phải mang ⚠️ | rule §3 (định nghĩa XONG bốn vế) + [CLAUDE.md](../CLAUDE.md) §7 — lệnh dò: rule §5.3 dòng 2 |

Ba quyết định này đã đi vào `task.md` rồi: ô `Đã chốt` của T-02 mang G1, ô `Đầu ra kiểm chứng được`
của T-03 mang ⚠️ theo G3. Muốn đổi một trong ba ⇒ mở finding, đừng sửa thẳng ở đây: file này là bản đồ,
sửa bản đồ mà không sửa lãnh thổ là cách hai bên trôi khỏi nhau.

---

## Ba câu tóm tắt

1. **Một dòng task là một prompt**, không phải một nhãn dán việc. Thành phần nào bạn không viết,
   session sẽ tự chọn thay bạn — và nó chọn rất tự tin.
2. **Ô `Hỏng thì mất gì` (lý do) và ô `Bẫy` (xử lý bất định) là hai ô hay bị bỏ nhất**, đồng thời là
   hai ô chặn hai loại lỗi tốn kém nhất: xếp sai ưu tiên, và làm sai một cách nghe rất hợp lý.
3. **Task đo *xong/chưa*, finding đo *đúng/sai*.** Trộn hai sổ là mất cả hai cơ chế: finding sẽ bị
   đánh ✅ khi hết giờ, task sẽ không bao giờ đóng được.
