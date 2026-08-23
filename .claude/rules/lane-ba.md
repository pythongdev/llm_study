---
paths:
  - "design/BA/**"
  - "design/BA/*"
---

# Lane BA — nạp khi chạm `design/BA/**`

> Cập nhật **2026-08-23**. Ở đây **chỉ** có luật riêng của lane BA. Luật áp cho mọi lane ở
> `CLAUDE.md` §1–§8; khuôn dòng task và định nghĩa XONG ở `.claude/rules/quan-ly-du-an.md` §1 §3.
> File này không chép lại vế nào của hai file đó — lệch thì hai file đó thắng.
>
> **Đường dẫn ở file này viết trong backtick, tính từ gốc repo,** không viết link markdown. Lý do:
> vòng lặp con trỏ §5.1 chạy `test -e` từ gốc repo, nên `../../CLAUDE.md` — đúng với editor — lại là
> một dòng `TRỎ HỤT` với lệnh. Backtick tránh được cả hai phía (họ hàng của `finding.md` F-11).

## 1. Lane này chốt xong đúng một câu hỏi

**Quán làm gì, ai thao tác, tiền đi đường nào** — nguyên văn ô *Câu hỏi pha này chốt xong* của dòng
`**0 · BA**`, `project_preparation/prompt-fullstack.md` §7. Bốn đầu ra bắt buộc nằm ở ô bên phải cùng
dòng đó; nhà của **yêu cầu chi tiết + biên nhận** là `design/BA/04-yeu-cau.md`.

Đầu ra của lane này viết bằng **tiếng của quán** — thứ chủ quán đọc rồi gật hoặc lắc được. Chủ quán
không gật được một sơ đồ có chữ `endpoint` trong đó, và không lắc được thứ mình không hiểu.

## 2. Ranh giới cứng — và lệnh bắt vi phạm

Nhà của ranh giới là §7 (`prompt-fullstack.md`, hai dòng ngay dưới bảng 6 pha). Nó nêu luật nhưng
**không** kèm lệnh nào. Lệnh là phần lane này thêm vào, chạy từ gốc repo:

```bash
grep -rniE 'bảng dữ liệu|migration|endpoint|/api/|schema|khoá ngoại|foreign key|primary key|component|useState|SELECT |INSERT ' design/BA/
```

Ra **rỗng** mới đạt. Mỗi dòng in ra là một câu của pha 2/3/4 đã lọt vào pha 0.

Vì sao ranh giới này đắt: chốt sớm một cái tên bảng là chốt luôn một hình dạng dữ liệu **trước khi**
biết luồng nghiệp vụ có bao nhiêu nhánh. Sửa lại sau đó không còn là sửa một dòng chữ, mà là sửa một
migration đã chạy trên dữ liệu thật.

## 3. Một dòng yêu cầu — bốn phép thử, trượt một là viết lại

| Phép thử | Đạt khi | Trượt trông thế nào |
|---|---|---|
| **Đơn nhất** | dòng nói **một** quy tắc | "khách quét QR **và** quầy xác nhận **và** bếp nhận" — ba quy tắc, tách ba dòng |
| **Kiểm chứng được** | có mốc đo: con số, khoảng giờ, hoặc *ai* là người quyết | "hệ thống xử lý nhanh" — không ai nói được nó xanh hay đỏ |
| **Không kẽ hở** | không "nếu có thể", "khi cần", "tuỳ trường hợp" | "kiểm tra tồn kho nếu có thể" — viết code kiểu gì cũng đúng |
| **Truy được nguồn** | trỏ mục nguồn (`§3.x`) hoặc mở đầu bằng `GIẢ ĐỊNH:` + mức rủi ro | không nguồn ⇒ phiên sau không biết được phép sửa hay không |

Bốn phép thử là bốn tính chất *singular · verifiable · unambiguous · traceable* của ISO/IEC/IEEE 29148;
ba kiểu trượt ở cột phải là ba *requirements smell* hay gặp nhất — **subjective language**, **loophole**,
**open-ended non-verifiable term**.

**Lệnh soi** — đây là **gợi ý đọc lại, không phải cổng**: nó in ra dòng đáng ngờ, người viết phán:

```bash
grep -rniE 'nếu có thể|khi cần|tuỳ trường hợp|nói chung|thường thì|hợp lý|phù hợp|dễ dùng|thân thiện|nhanh chóng|linh hoạt|tối ưu|v\.v\.' design/BA/
```

Phân biệt *cổng* với *lệnh soi* là cố ý. Gọi một lệnh soi là biên nhận thì sổ trông xanh trong khi
không lệnh nào thật sự kiểm gì — đúng thứ `CLAUDE.md` §7 cấm.

## 4. Biên nhận của lane

Danh sách chốt nằm ở `design/BA/04-yeu-cau.md` §2 — **một nhà, không chép sang đây**. Rule này chỉ nói
**loại**: lane BA chưa có compiler nên biên nhận là lệnh đọc lại (`test -e`, `grep -c`, `wc -l`), không
bao giờ là "đã đọc lại thấy ổn".

## 5. Cái gì KHÔNG thuộc lane BA

Tên bảng và cột → lane DB · endpoint và hàm tính giá → lane BE · route và component → lane FE ·
compose và backup → lane DEVOPS. Cần một trong bốn thứ đó mới viết tiếp được: **dừng, không viết**,
ghi một dòng `finding.md` hoặc mở dòng task cho lane kia, rồi quay lại (`CLAUDE.md` §1).

Giá món và thành phần suất bán là **quyền của owner**, không phải của lane này (`CLAUDE.md` §7): lane
BA được **trỏ** tới nhà của chúng, không được tự chốt một con số mới.
