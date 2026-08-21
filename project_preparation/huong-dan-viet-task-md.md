# Hướng dẫn viết `task.md` — đặc tả trước khi viết

> Cập nhật **2026-08-21**. File này **không phải** sổ task. Nó là **luật viết sổ task**:
> mỗi cột nghĩa là gì, viết thế nào thì đạt, thế nào thì phải viết lại.
> Nguồn của mọi luật dưới đây: [prompt-fullstack.md §5–§8](prompt-fullstack.md) ·
> mẫu đã chạy thật: [reference/task.md](../reference/task.md) + [reference/CLAUDE_rẻence.md](../reference/CLAUDE_rẻence.md).
> Guideline lệch prompt-fullstack ⇒ **prompt-fullstack thắng**, dòng ở đây là bug phải sửa.

---

## 1. `task.md` trả lời đúng một câu hỏi

**"Việc tiếp theo là gì, và tôi có được phép bắt đầu nó chưa?"**

Nó không giữ sự thật nào khác. Bốn file bên cạnh giữ bốn sự thật khác nhau:

| Câu hỏi | Nhà thật | `task.md` được làm gì |
|---|---|---|
| Xây thế nào, thiết kế ra sao | `step.md` / `design/**` | **trỏ tới đúng mục**, cấm chép |
| Hệ thống **hiện** có gì | `status/` + code | không nhắc tới |
| Cái gì **đang sai** ngay bây giờ | `finding.md` | **chỉ trỏ bằng mã `F-xx`**, cấm mô tả lại |
| "XONG" nghĩa là gì (chung) | `quality/05-checklist.md` | trỏ tới, cấm chép lại checklist |
| Làm gì tiếp, **theo thứ tự nào** | **`task.md`** | đây là nhà duy nhất |

Hệ quả bắt buộc — đây là luật hay bị vi phạm nhất, và vi phạm nó thì sổ chết âm thầm:

1. **Cấm chép.** Cần lại một sự thật ⇒ đặt link. Chép = đẻ nhà thứ hai, nhà thứ hai luôn trôi.
2. **Cấm sổ finding thứ hai.** Không mô tả lỗi trong `task.md`, chỉ ghi mã.
3. **Suy ra được bằng lệnh thì cấm chép thành bảng.** Cần bảng ⇒ ghi **lệnh sinh ra bảng đó**.
   (Mẫu: mục *Đối chiếu finding → task* của reference đã bị thay bằng một vòng `for` 3 dòng.)

---

## 2. Bố cục file — đúng 6 mục, theo thứ tự này

```
1. Header  : ngày cập nhật + 5 dòng "file nào giữ sự thật nào"
2. Task tiếp theo — làm ngay   : LỆNH tìm ra dòng task kế, không phải tên task chép tay
3. Cách đọc các cột            : ngữ nghĩa từng cột (phần 3 của guideline này)
4. Bảng task                   : chia theo Giai đoạn, mỗi giai đoạn một bảng
5. Phụ thuộc — nhìn nhanh      : cây ASCII + một dòng ĐƯỜNG GĂNG
6. Quy tắc dùng file này       : 5 luật vòng đời + 3 thứ không thoả hiệp
```

Mục 2 là mục quan trọng nhất và cũng là mục dễ viết sai nhất: nó phải là **lệnh chạy được**
(`grep`/`sed` ra dòng task), **không phải** câu "tiếp theo làm T-08". Chép tên task ra đây =
mỗi lần xong một task lại phải sửa hai chỗ, và chỗ thứ hai sẽ quên.

---

## 3. Đặc tả từng cột

Khuôn 8 cột (mở rộng từ 7 cột của [§5.3](prompt-fullstack.md), thêm *Context* · *Finding phải đóng* ·
*Prompt mở session*; *Trạng thái* không còn là cột riêng — xem 3.1):

```
| # | Lane | Task | Context | Cần xong trước | Finding phải đóng | Đầu ra kiểm chứng được | Prompt mở session |
```

### 3.1 `#` — mã task **kiêm** trạng thái

- Mã `T-xx` cấp **tăng dần, không tái sử dụng**, kể cả khi task bị huỷ (huỷ ⇒ ghi `~~T-xx~~ ❌ + lý do`).
- Trạng thái mã hoá ngay trong ô, để `grep` một lần ra được việc còn lại:
  `| **T-08**` = chưa làm · `| ~~**T-08**~~ ✅` = xong · `🔺` = chặn mọi session sau ⇒ làm trước ·
  `⚑n` = thứ tự owner tự chọn cho việc **ngoài** đường găng.
- Không có cột "Trạng thái" riêng: hai chỗ ghi trạng thái thì chúng sẽ lệch nhau.
- Task tách ra từ task khác ⇒ mã mới + một chữ "tách khỏi T-yy", không sửa mã cũ.

### 3.2 `Lane` — tầng sở hữu file mà task này chạm

`BA · DB · BE · FE · DEVOPS · NON-CODE`. Đây là **khoá tra**: gói file phải nạp và biên nhận của
mỗi lane nằm ở `CLAUDE.md §1`, sổ task **không chép lại**.

- **Một task = đúng một lane.** Viết `BE ⚠️+FE` là tự thú task sai kích cỡ ⇒ **chẻ trước khi làm**.
- Không rõ lane ⇒ `NON-CODE` (lane không sửa code: đọc, đối chiếu, chốt giấy tờ).

### 3.3 `Task` — động từ + tân ngữ cụ thể

- Có chữ **"và"** nối hai danh từ khác nhau ⇒ chẻ ([§5.6](prompt-fullstack.md)).
- Nêu **file/mục sẽ sửa** nếu đã biết: `Migration 000004_fix_open_key + .down.sql`.
- Task không đẩy được **lát cắt A/B/C** ([§5.1](prompt-fullstack.md)) tiến lên một đoạn ⇒ hoặc là
  việc của pha sau, hoặc là việc không cần làm. Xoá, đừng để dành.

### 3.4 `Context` — **đầu vào** của task, đúng 3 mẩu

```
Nạp: <file + đúng mục> · Đã chốt: <quyết định đã có nhà, trỏ tới> · Bẫy: <chỗ đã cắn hoặc sẽ cắn>
```

- Đủ để một session **chưa từng đọc repo** mở task mà không phải dò lịch sử chat.
- **Cấm** viết "thế nào là xong" ở đây — vế đó là cột 7. Đầu vào và đầu ra là hai sự thật khác nhau.
- *Bẫy* thường là lý do task này **từng bị làm sai**; không có bẫy thì để trống, đừng bịa.

### 3.5 `Cần xong trước` — phụ thuộc **dữ liệu**, không phải sở thích

- Cái gì **tạo ra** dữ liệu đứng trước cái gì **đọc** dữ liệu đó ([§5.4](prompt-fullstack.md)).
- Hai task không phụ thuộc nhau ⇒ ưu tiên task **dính tới tiền**.
- Chỉ ghi mã task (`T-02`), không giải thích lại lý do — lý do nằm ở cây phụ thuộc (mục 5).

### 3.6 `Finding phải đóng` — cổng vào của task

- Ghi mã `F-xx` phải ở trạng thái ✅ ĐÓNG **trước khi bắt đầu** task. Còn 🔓 MỞ / ⚠️ MỞ LẠI ⇒ task
  chưa được mở, dù trông có vẻ làm được.
- **Phép thử task hay finding**, hỏi trước khi thêm bất kỳ dòng nào ([§5.5](prompt-fullstack.md)):
  chạy hết kế hoạch **y như nó viết** — dòng này còn không?
  **Còn** ⇒ finding (đang sai ngay bây giờ) · **Mất** ⇒ task (chưa tới lượt xây).
  Câu mở đầu bằng *"chưa có X"* gần như luôn là **task**.

### 3.7 `Đầu ra kiểm chứng được` — cột quyết định file này có giá trị hay không

Thiếu cột này thì dòng đó là **ý kiến**, không phải task. Khuôn: **lệnh + kết quả kỳ vọng**.

| | Ví dụ |
|---|---|
| ❌ SAI | "Viết xong service tính giá, test đầy đủ" — không ai chứng minh được, không ai bác được |
| ✅ ĐÚNG | "`go test ./internal/menu/` ra đủ 11 ca giá §9.3, ca 'Chay + Nhiều nhân' phải **LỖI**" |
| ✅ ĐÚNG | "`make lint`: 7 issues → `0 issues.`; `make check` EXIT=0 → đóng **F-24**" |

Bốn luật của cột này:

1. **Sửa lỗi ⇒ test phải ĐỎ trên code cũ, XANH trên code mới, dán cả hai output.** Test chỉ-xanh
   không chứng minh được gì ([§6.7](prompt-fullstack.md)).
2. Lane **NON-CODE không có compiler** ⇒ biên nhận là **lệnh đọc lại**: `grep` ra đúng số hit đã khai,
   `sed -n` in ra đoạn vừa sửa, `git log -1 -- <file>`. Không có lệnh ⇒ chưa xong.
3. **Lệnh chưa tồn tại thì đánh dấu ⚠️**, đừng viết như thể nó chạy được. Dự án hiện chưa có
   `Makefile`, chưa có DB ⇒ mọi biên nhận kiểu `make check` là **lời hứa**, phải có task tạo ra nó trước.
4. Task đóng finding ⇒ ghi luôn `→ đóng F-xx` ở cuối ô. Chiều ngược lại (finding nào bị bỏ rơi)
   **dò bằng lệnh**, không chép thành bảng.

### 3.8 `Prompt mở session` — con trỏ, không phải bản sao

Một dòng owner dán vào session mới. Chỉ chứa: **lane · mã task · lệnh mở đúng dòng · ràng buộc hẹp
nhất · câu "dừng khi nào"**.

```
Lane BE · T-08 · sed -n '/T-08/p' task.md · chỉ chạm internal/order/** · xong service thì DỪNG, không viết handler
```

- **Cấm** chép lại *Nạp* / *Bẫy* / danh sách lệnh vào đây.
- **Chỉ điền khi task sắp được giao.** 78 dòng đều có prompt = 78 dòng phải sửa mỗi lần đổi luật.

---

## 4. Kích cỡ một dòng task — 4 vế, vượt vế nào cũng phải chẻ

**1 lane · ≤ 3 file · 1 đầu ra kiểm chứng được · vừa một phiên làm việc** ([§5.2](prompt-fullstack.md)).

Dấu hiệu sai kích cỡ, chẻ ngay đừng thương lượng: mô tả có "và" nối hai danh từ · chạm 2 tầng ·
không nói nổi biên nhận bằng **một** lệnh · phải mở > 3 file mới hiểu · ước lượng vượt một phiên.

Task **giấy tờ** cũng phải có đầu ra kiểm chứng được: **viết vào file nào, mục nào**. Không có thì
nó là ý kiến, không phải task.

---

## 5. Thứ tự thi công — 3 tầng ưu tiên, đọc từ trên xuống

1. **🔺 chặn** — không xong thì mọi session sau đều sai. Làm trước, bất kể nó ở giai đoạn nào.
2. **Đường găng** — dãy task nối tiếp quyết định ngày lên sóng. Ghi **đúng một dòng** ở mục 5:
   `T-01 → T-02 → T-36 → T-BA-14 → T-08 → T-16 → T-20 → T-28 → T-31`.
   Mọi task ngoài dãy này trượt vài ngày không ảnh hưởng ngày chạy thật.
3. **`⚑n`** — thứ tự owner tự chọn cho phần còn lại; lấy `⚑` nhỏ nhất **chưa xong** và **mở được**.

**Thứ tự file ≠ thứ tự ưu tiên.** Giai đoạn 0 xếp trước vì nó là **nền**, không phải vì nó gấp hơn.

---

## 6. Vòng đời một dòng task

```
THÊM DÒNG → (qua phép thử 3.6) → MỞ (finding đã đóng + cần-xong-trước đã ✅)
          → LÀM (1 session, 1 lane) → BIÊN NHẬN chạy thật → GHI SỔ → ✅
```

Đánh ✅ cần đủ **ba** thứ, thiếu một ⇒ vẫn là đang làm ("đã viết code" ≠ "đã chạy"):

1. biên nhận của lane chạy thật + **output dán vào**;
2. **commit** chứa thay đổi (message ghi lane + mã task + finding đã đóng);
3. `finding.md` đổi trạng thái kèm ngày + cách kiểm chứng (nếu task có đóng finding).

Và ghi **một lần vào một nhà**: dấu ✅ + biên nhận ⇒ **chỉ** dòng task · trạng thái finding ⇒ **chỉ**
`finding.md` · ảnh chụp hệ thống ⇒ **chỉ** `status/` của đúng lane.

---

## 7. Tự rà trước khi commit `task.md`

Chạy từ gốc repo; ra kết quả khác kỳ vọng là **lỗi của `task.md`**, sửa ngay:

```bash
# 1. Dòng task nào thiếu biên nhận (ô thứ 7 rỗng) ⇒ đó là ý kiến, không phải task
grep '^| \*\*T-' task.md | awk -F'|' 'length($8) < 12 {print $2}'

# 2. Task nào chạm 2 lane ⇒ phải chẻ trước khi làm
grep '^| \*\*T-' task.md | grep '⚠️+'

# 3. Finding đang mở mà không task nào đóng ⇒ finding bị bỏ rơi
for f in $(grep '^| \[F-' finding.md | grep -v '✅ ĐÓNG' | grep -o 'F-[0-9]*' | sort -u); do
  grep -q "finding.md#$(echo $f | tr 'A-Z' 'a-z'))" task.md || echo "BỎ RƠI: $f"
done

# 4. Mã task trùng
grep -o '\*\*T-[0-9]*\*\*' task.md | sort | uniq -d
```

Bốn câu hỏi tự rà không có lệnh, hỏi bằng đầu:
dòng nào chép lại thứ đã có nhà khác? · dòng nào mô tả **lỗi** thay vì trỏ mã? ·
biên nhận nào dùng lệnh **chưa tồn tại** mà không đánh ⚠️? · dòng nào không đẩy lát cắt A/B/C nào?

---

## 8. Ba chỗ tôi phải chốt trước khi viết `task.md` thật

| # | Vấn đề | Phương án tôi đề xuất | Rủi ro nếu chọn sai |
|---|---|---|---|
| G1 | **"Giai đoạn" hay "Pha"?** reference chia 5 *Giai đoạn*; [§7](prompt-fullstack.md) chia **6 Pha** (0 BA → 5 Deploy) | Dùng **6 Pha của §7** làm tiêu đề bảng, vì ranh giới cứng giữa các pha là thứ chặn Claude trôi | Hai hệ tên ⇒ mỗi session hiểu một kiểu, `grep` không ra |
| G2 | **Cột *Hỏng thì mất gì*** — §5.3 bắt buộc; reference đã bỏ, thay bằng 🔺/⚑ | **Giữ lại**, viết bằng hậu quả ở quán ("thu thiếu tiền bàn 5"), vì §5.3 nói đây là cột quyết định ưu tiên. 9 cột | Bỏ ⇒ mất căn cứ khách quan để xếp ưu tiên, chỉ còn cảm tính của owner |
| G3 | **Biên nhận cho giai đoạn chưa có code** — chưa `Makefile`, chưa DB, chưa repo code | Pha 0–1 dùng **lệnh đọc lại** (`grep`/`sed`), đánh ⚠️ mọi biên nhận cần compiler + có task tạo `Makefile` trước | Viết `make check` khi chưa có `Makefile` ⇒ sổ trông xanh mà không lệnh nào chạy được |

Chưa chốt 3 mục này thì bảng task viết ra sẽ phải sửa lại toàn bộ.
