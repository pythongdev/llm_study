---
paths:
  - "finding.md"
---

# Chất lượng một mục finding — nạp khi chạm `finding.md`

> Cập nhật **2026-08-23** · Lane sở hữu: **NON-CODE** · Trần của chính file: §5.
> Nhà của đúng hai thứ chưa có nhà: **khuôn một mục `### F-xx`** và **lệnh cổng của sổ lỗi**.
> Bốn thứ có nhà rồi, ở đây **trỏ, không chép** — chép là đẻ nhà thứ hai, đúng gốc của
> `F-04`:
>
> - *finding hay task* → `CLAUDE.md` §5 (phép thử một câu)
> - *hai sổ khác nhau chỗ nào* → `.claude/rules/quan-ly-du-an.md` §2
> - *ba vế để đóng một finding* → phần mở đầu của chính `finding.md`
> - *thang biên nhận T0–T3 · năm trục đo · luật biên nhận âm* → `quality/00-guideline-chat-luong.md`
>   §3 §4 §5. File này là **tầng dưới** của guideline đó: chỉ được **thêm**, cấm chép lại.

## 1. Khuôn một mục — bốn vế khi mở, sáu vế khi đóng

Khuôn dưới đây **không phải phát minh mới**: nó là khuôn 13 mục hiện có đang dùng, viết ra thành luật
để mục thứ 14 không trôi. Tiêu đề in đậm phải viết **đúng từng ký tự** — lệnh cổng §3 dò theo chuỗi.

| Vế | Bắt buộc khi | Viết cái gì | Bỏ nó thì mất gì |
|---|---|---|---|
| `**Mệnh đề sai.**` | **mở** | đúng **một** mệnh đề đang sai, ở thì hiện tại, có chủ ngữ là file/cơ chế cụ thể | không có mệnh đề thì không có gì để "hết đúng" ⇒ finding không bao giờ đóng được |
| `**Vì sao nó không tự mất đi.**` | **mở** | chạy hết `task.md` y như nó viết thì dòng này còn không, và **vì sao còn** | đây là chỗ duy nhất chứng minh nó là finding chứ không phải task (`CLAUDE.md` §5) |
| `**Lệnh tái hiện.**` | **mở** | lệnh chạy được **hôm nay**, in ra đúng cái sai — không phải mô tả cái sai | không lệnh ⇒ người sau phải tin lời khai; và khi nó hết đúng, không ai biết |
| `**Cách sửa đề xuất.**` | **mở** | sửa ở đâu, thành gì, gắn vào task nào. Chưa đề xuất được thì thay bằng `**Chưa đề xuất được vì:**` + lý do | không có vế này thì finding thành lời than; task đóng nó sẽ tự bịa cách sửa |
| `**Kiểm chứng.**` | **đóng** | lệnh chứng minh mệnh đề đã **hết đúng**, kèm output | "đã sửa rồi" không phải trạng thái, nó là output của một lệnh |
| `**Bài học giữ lại:**` | **đóng** | **luật nào đổi** để nó không tái phát, và luật đó nằm ở file nào | đóng mà không đổi luật nào ⇒ chỉ dọn hậu quả, nguyên nhân còn nguyên |

Hai vế tuỳ chọn, dùng khi có: `**Bẫy khi sửa.**` (chỗ người sửa dễ sửa nhầm sang hướng làm hỏng thêm) ·
`**Vì sao nó nguy hiểm hơn nó trông.**` (khi hậu quả không lộ ra ở chỗ phát hiện).

## 2. Bốn phép thử một mệnh đề — trượt một là chưa được ghi vào sổ

| Phép thử | Đạt khi | Trượt trông thế nào | Gốc |
|---|---|---|---|
| **Có mệnh đề** | nói **cái gì đang sai**, không phải cái gì nên tốt hơn | "nên cải thiện cách đặt tên" — không mệnh đề nào sai, không gì để đóng | `CLAUDE.md` §5 |
| **Tái hiện được** | một lệnh, chạy hôm nay, ra bằng chứng | "đọc thấy không ổn" · "có vẻ lệch" | guideline §3 tầng T2 |
| **Sống sót phép thử một câu** | chạy hết `task.md` mà dòng này còn | mở đầu bằng *"chưa có X"* — gần như luôn là **task**, ghi nhầm sổ | `CLAUDE.md` §5 |
| **Một nguyên nhân một mã** | một mã `F-xx` gói đúng **một** nguyên nhân | gói hai vế vào một mã ⇒ một vế hết đúng, vế kia còn, mã kẹt giữa 🔴 và ✅ | quan sát thật: `F-05` phải đẻ ra `F-09` đúng vì lý do này |

Phép thử thứ tư là phép thử đắt nhất và hay bị bỏ nhất. Dấu hiệu vi phạm giống hệt dấu hiệu vượt kích cỡ
task (`CLAUDE.md` §6): mô tả phải dùng chữ **"và"** nối hai danh từ khác nhau mới nói hết.

## 3. Cổng — hai lệnh, chạy từ gốc repo trước khi commit `finding.md`

Mỗi cổng khai kèm vế **`đỏ khi`** theo guideline §5, và người viết phải **thử làm nó đỏ một lần** rồi
`git checkout -- finding.md` khôi phục — chưa thấy nó đỏ lần nào thì chưa ai biết nó đang đo cái gì.

```bash
# (a) mục ĐANG MỞ thiếu vế bắt buộc — đỏ khi một mục 🔴 thiếu 1 trong 4 vế §1
for f in $(grep -o '^| \[F-[0-9]*\].*🔴 MỞ' finding.md | grep -o 'F-[0-9]*'); do
  s=$(sed -n "/^### $f\$/,/^### F-/p" finding.md); m=""
  echo "$s" | grep -q '^\*\*Mệnh đề sai\.\*\*'               || m="$m Mệnh-đề-sai"
  echo "$s" | grep -q '^\*\*Vì sao nó không tự mất đi\.\*\*' || m="$m Vì-sao-không-tự-mất"
  echo "$s" | grep -q '^\*\*Lệnh tái hiện\.\*\*'             || m="$m Lệnh-tái-hiện"
  echo "$s" | grep -qE '^\*\*(Cách sửa đề xuất\.|Chưa đề xuất được vì:)\*\*' || m="$m Cách-sửa"
  [ -n "$m" ] && echo "THIẾU VẾ: $f$m"; done
# (b) mục khai ĐÓNG mà không có bài học — đỏ khi đóng một finding không đổi luật nào
for f in $(grep -o '^| \[F-[0-9]*\].*✅ ĐÓNG' finding.md | grep -o 'F-[0-9]*'); do \
  sed -n "/^### $f\$/,/^### F-/p" finding.md | grep -q '^\*\*Bài học giữ lại:\*\*' \
  || echo "ĐÓNG KHÔNG BÀI HỌC: $f"; done
```

Mục đã đóng không qua cổng (a) — nó chuyển sang khuôn đóng ở §1. Tính duy nhất của mã `F-xx` không ở đây: nó về `quan-ly-du-an.md` §5.2 theo `T-16`.

## 4. Khi nào **không** mở finding

Ba trường hợp hay bị ghi nhầm vào sổ lỗi, ghi nhầm là mất luôn cơ chế của cả hai sổ
(`quan-ly-du-an.md` §2):

- **"Chưa có X."** → dòng `task.md`, không phải finding. Sổ lỗi không có cách nào đóng một cái chưa tồn tại.
- **Sở thích cách viết.** Không mệnh đề nào sai ⇒ không có gì để chứng minh hết đúng.
- **Hậu quả của một finding đã có.** Ghi thêm vào mục cũ, đừng đẻ mã mới: hai mã cùng một nguyên nhân
  thì đóng một mã còn mã kia treo, và bài học bị gắn nhầm chỗ.

Thấy một thứ vừa là finding vừa đẻ ra việc: ghi **một** finding, rồi mở **một hoặc nhiều** dòng task trỏ
về mã đó. Chiều ngược lại không tồn tại — task không bao giờ nằm trong sổ lỗi.

## 5. Trần của chính file

Trần: **95 dòng** · mỗi mục **≤ 22 dòng** · mỗi dòng ≤ 400 byte.

```bash
wc -l < .claude/rules/chat-luong-finding.md              # ≤ 95
awk 'length > 400' .claude/rules/chat-luong-finding.md   # rỗng
awk '/^## /{if(s&&n>22)print "VƯỢT TRẦN MỤC: "s" ("n")"; s=$0; n=0} {n++} \
     END{if(s&&n>22)print "VƯỢT TRẦN MỤC: "s" ("n")"}' .claude/rules/chat-luong-finding.md
```
