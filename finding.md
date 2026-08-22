# finding.md — sổ lỗi

> Cập nhật **2026-08-22**. Đây là **sổ lỗi**: đo *đúng / sai*. Việc **chưa tới lượt xây** đi sổ khác —
> [task.md](task.md). Phép thử một câu và luật không trộn hai sổ ở [CLAUDE.md §5](CLAUDE.md);
> hai sổ khác nhau chỗ nào ở [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) §2.

**Cách dùng khuôn này.** Thấy hai chỗ trong repo nói hai điều khác nhau, hoặc thấy một cơ chế không
chạy được: thêm một dòng vào bảng, thêm một mục `### F-xx` bên dưới, rồi **quay lại việc đang làm** —
không sửa kèm. Trong [task.md](task.md) chỉ ghi **mã** `F-xx`, cấm mô tả lại nội dung.
Đóng một finding cần đủ ba vế: mệnh đề sai **hết đúng** · **lệnh** chứng minh · một dòng
`**Bài học giữ lại:**` nói **luật nào đổi**. Rút không ra luật ⇒ chưa hiểu nguyên nhân ⇒ chưa được đóng.

---

| # | Mệnh đề đang sai | Phát hiện lúc | Trạng thái | Task đóng nó |
|---|---|---|---|---|
| [F-01](#f-01) | Hai hệ tên cho cùng một trục chia việc: `reference/task.md` gọi *Giai đoạn*, `prompt-fullstack.md` §7 gọi *Pha* | T-01 · 2026-08-22 | ✅ ĐÓNG 2026-08-22 | T-01 |
| [F-02](#f-02) | `project_preparation/prompt-fullstack.md` trỏ tới 8 đường dẫn không tồn tại, không đường nào đánh ⚠️ | T-01 · 2026-08-22 | 🔴 MỞ | [T-10](task.md) |
| [F-03](#f-03) | `paths:` của `.claude/rules/quan-ly-du-an.md` không khớp `CLAUDE.md`, nên phiên sửa `CLAUDE.md` §1 để mở lane không được nạp quy trình mở lane | T-01 · 2026-08-22 | 🔴 MỞ | [T-11](task.md) |
| [F-04](#f-04) | Đặc tả *một ô của dòng task viết cái gì* sống ở **hai** nhà — rule §1.1 và `huong-dan-viet-task-md.md` Phần V — một sự thật đổi thì phải sửa hai file, không lệnh nào bắt được khi chỉ sửa một | rà guideline · 2026-08-22 | 🔴 MỞ | [T-12](task.md) |
| [F-05](#f-05) | Bốn lệnh tự rà ở rule §5.2 không đáng tin: dòng vỡ cột thì chúng đọc nhầm ô (T-05 có 11 cột vì dấu ngăn chưa thoát), và mẫu dò finding lỏng nên báo nhầm mã không tồn tại | T-12 · 2026-08-22 | 🔴 MỞ | [T-13](task.md) |

---

### F-01

**Mệnh đề sai.** Dự án chưa chốt một hệ tên cho trục chia việc lớn nhất.
`grep -c 'Giai đoạn [0-9]' reference/task.md` ra `6`; `prompt-fullstack.md` §7 chia **6 Pha** (0 BA → 5 Deploy).
`huong-dan-viet-task-md.md` Phần X mục G1 nêu ra chỗ lệch này và để ngỏ.

**Chốt.** Dùng **6 Pha của §7** làm hệ tên duy nhất. Lý do: ranh giới cứng giữa các pha (pha 0–1 không
nhắc tên bảng, pha 2 không nhắc endpoint, pha 3 không nhắc component) là cơ chế duy nhất chặn một phiên
làm việc của pha sau; hệ 5 Giai đoạn của `reference/` không mang ranh giới đó.

**Kiểm chứng.** `grep -c 'Giai đoạn [0-9]' CLAUDE.md task.md finding.md .claude/rules/quan-ly-du-an.md`
ra `0` trên cả bốn file — không file nào dùng hệ tên thứ hai làm trục chia việc. Lệnh bắt buộc có
`[0-9]`: chữ *giai đoạn* dùng theo nghĩa thường (tiêu đề [CLAUDE.md §7](CLAUDE.md)) không phải vi phạm,
chỉ `Giai đoạn <số>` mới là hệ tên thứ hai.
`reference/` không sửa: đó là mẫu của một dự án khác, không phải nguồn sự thật của dự án này.

**Bài học giữ lại:** `reference/` đóng vai **mẫu cấu trúc và giọng viết**, không bao giờ là nguồn sự
thật. Luật này đã vào ô `Bẫy` của T-01 trong [task.md](task.md) và vào cột *Ai thắng khi lệch* của
[CLAUDE.md §2](CLAUDE.md) — `reference/` không có mặt trong bảng đó, nên nó không thắng gì cả.

---

### F-02

**Mệnh đề sai.** `project_preparation/prompt-fullstack.md` là file đang có trong repo và được dùng làm
nguồn luật, nhưng nó trỏ tới 8 đường dẫn không tồn tại, không đường nào mang ⚠️:
`00-scope.md` · `CLAUDE.md` (dạng `../CLAUDE.md`, sai cả cấp thư mục) · `quality/prompt_guiline.md` ·
`quality/05-checklist.md` · `design/backend/01-thiet-ke.md` · `design/data_base/01-thiet-ke.md` ·
`design/frontend/01-thiet-ke.md` · `design/system_design/01-thiet-ke.md`.

3. Lệnh dò *finding bỏ rơi* dùng mẫu `F-` + `[0-9]*`, mẫu này khớp cả `NF-2` / `NF-3` trong một đoạn awk
   viết trong sổ — và báo `BỎ RƠI: F-2`, `BỎ RƠI: F-3` cho hai mã **không tồn tại**. Cảnh báo giả làm
   người đọc quen bỏ qua output, và lần có cảnh báo thật cũng bị bỏ qua nốt.

**Lệnh tái hiện.** Vòng lặp ở [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) §5.1
chạy trên `project_preparation/prompt-fullstack.md` — hiện in ra 8 dòng `TRỎ HỤT:`.

**Vì sao nó không tự mất đi.** Chạy hết mọi dòng trong [task.md](task.md) y như nó viết thì các file
`00-scope.md` và `quality/05-checklist.md` sẽ có, nhưng bốn con trỏ `design/*/01-thiet-ke.md` và
`quality/prompt_guiline.md` vẫn hụt, và con trỏ `../CLAUDE.md` vẫn sai cấp thư mục. Dòng này **còn**
⇒ finding, không phải task.

**Cách sửa đề xuất.** Đổi mỗi con trỏ hụt thành ⚠️ + mã task tạo ra nó, đúng như khuôn ở
[CLAUDE.md §2](CLAUDE.md). Không tạo file rỗng cho con trỏ giải được: file rỗng trông như đã có nhà,
và phiên sau sẽ tin nó.

**Bài học giữ lại:** mọi con trỏ phải giải được hoặc mang ⚠️ + mã task — không có lựa chọn thứ ba.
Luật này đã vào [CLAUDE.md §2](CLAUDE.md) (mỗi dòng trỏ file có thật hoặc mang ⚠️) và thành lệnh
tự rà ở rule §5.1, chạy mỗi lần sửa tài liệu.

---

### F-03

**Mệnh đề sai.** `.claude/rules/quan-ly-du-an.md` chỉ nạp khi phiên chạm file khớp `paths:`
(`task.md`, `finding.md`, `project_preparation/**`, `design/**`). `CLAUDE.md` và `.claude/rules/**`
không nằm trong danh sách. Nhưng quy trình mở một lane (rule §6) yêu cầu **sửa đúng một dòng ở
`CLAUDE.md` §1** và **tạo `.claude/rules/lane-<tên>.md`** — tức đúng lúc cần rule đó nhất thì nó
không được nạp.

**Lệnh tái hiện.** `sed -n '2,6p' .claude/rules/quan-ly-du-an.md` — không có dòng nào khớp `CLAUDE.md`
hay `.claude/rules/`. Đối chiếu với `grep -n 'CLAUDE.md §1' .claude/rules/quan-ly-du-an.md`, ra các
dòng của §6 đang yêu cầu sửa chính file không nằm trong `paths:`.

**Vì sao nó không tự mất đi.** Mọi task T-02, T-06, T-07, T-08, T-09 đều mở một lane, và cả năm task
đó đều chạy trong tình trạng này. Chạy hết kế hoạch thì mệnh đề vẫn đúng ⇒ finding.

**Cách sửa đề xuất.** Thêm `"CLAUDE.md"` và `".claude/rules/**"` vào `paths:`. Đây là đổi kiến trúc
file do người dùng chốt, nên [T-11](task.md) mở đầu bằng một câu hỏi cho người dùng, không tự sửa.
Giảm nhẹ tạm thời, đã làm ở T-01: ô `Nạp` của cả năm task mở lane trỏ thẳng tới rule §6, nên phiên
vẫn mở đúng file — nhưng đó là năm bản chép của cùng một con trỏ, sửa gốc vẫn tốt hơn.

**Bài học giữ lại:** một rule có `paths:` phải liệt kê **cả file mà quy trình bên trong nó bắt sửa**,
không chỉ file mà nó nói *về*. Luật này áp cho mọi `.claude/rules/lane-*.md` sắp tạo: `paths:` của
lane phải phủ đúng cột *Lane sở hữu file nào* ở [CLAUDE.md §1](CLAUDE.md), và đã vào vế 3 của quy trình
mở lane (rule §6).

---

### F-04

**Mệnh đề sai.** Cùng một sự thật — *"ô này của dòng task viết cái gì"* — có **hai** nhà, không nhà nào
trỏ nhà kia: `.claude/rules/quan-ly-du-an.md` §1.1 (bảng: viết cái gì · sai điển hình · vì sao ô đó tồn
tại) và `project_preparation/huong-dan-viet-task-md.md` Phần V (12 mục: lý do tồn tại · ví dụ SAI/ĐÚNG).
Bảng ánh xạ 11 thành phần prompt cũng hai bản: rule §7 và Phần IV. [CLAUDE.md §2](CLAUDE.md) cấp nhà cho
cả hai bằng hai dòng khác nhau (*"Khuôn dòng task"* → rule · *"Luật viết sổ task (11 TP → 12 trường)"* →
guideline) mà **không nói ranh giới giữa chúng ở đâu**.

**Chi phí đã hiện ra một lần, đo được.** Ngày 2026-08-22 cột thứ 10 `Owner kiểm tra` được thêm. Một sự
thật đổi ⇒ **bốn** file phải sửa: `task.md`, rule §1 §1.1 §1.2 §5.2 §7, và guideline Phần IV + 5.13. Trong
khoảng thời gian giữa các lần sửa đó, rule §7 đã khai TP11 có nửa người thành cột trong khi guideline vẫn
khai *"TP11 không thành cột"* — hai bản nói ngược nhau, và không lệnh nào trong repo bắt được. Hiện cả hai
đã khớp lại, nhưng chỉ vì tình cờ hai file cùng được đọc trong một phiên, không vì có cơ chế nào ép.

**Lệnh tái hiện.** Vòng lặp ở [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) §5.1
chạy trên `project_preparation/prompt-fullstack.md` — hiện in ra 8 dòng `TRỎ HỤT:`.

**Vì sao nó không tự mất đi.** Chạy hết mọi dòng trong [task.md](task.md) y như nó viết thì các file
`00-scope.md` và `quality/05-checklist.md` sẽ có, nhưng bốn con trỏ `design/*/01-thiet-ke.md` và
`quality/prompt_guiline.md` vẫn hụt, và con trỏ `../CLAUDE.md` vẫn sai cấp thư mục. Dòng này **còn**
⇒ finding, không phải task.

**Cách sửa đề xuất.** Đổi mỗi con trỏ hụt thành ⚠️ + mã task tạo ra nó, đúng như khuôn ở
[CLAUDE.md §2](CLAUDE.md). Không tạo file rỗng cho con trỏ giải được: file rỗng trông như đã có nhà,
và phiên sau sẽ tin nó.

**Bài học giữ lại:** mọi con trỏ phải giải được hoặc mang ⚠️ + mã task — không có lựa chọn thứ ba.
Luật này đã vào [CLAUDE.md §2](CLAUDE.md) (mỗi dòng trỏ file có thật hoặc mang ⚠️) và thành lệnh
tự rà ở rule §5.1, chạy mỗi lần sửa tài liệu.

---

### F-03

**Mệnh đề sai.** `.claude/rules/quan-ly-du-an.md` chỉ nạp khi phiên chạm file khớp `paths:`
(`task.md`, `finding.md`, `project_preparation/**`, `design/**`). `CLAUDE.md` và `.claude/rules/**`
không nằm trong danh sách. Nhưng quy trình mở một lane (rule §6) yêu cầu **sửa đúng một dòng ở
`CLAUDE.md` §1** và **tạo `.claude/rules/lane-<tên>.md`** — tức đúng lúc cần rule đó nhất thì nó
không được nạp.

**Lệnh tái hiện.** `sed -n '2,6p' .claude/rules/quan-ly-du-an.md` — không có dòng nào khớp `CLAUDE.md`
hay `.claude/rules/`. Đối chiếu với `grep -n 'CLAUDE.md §1' .claude/rules/quan-ly-du-an.md`, ra các
dòng của §6 đang yêu cầu sửa chính file không nằm trong `paths:`.

**Vì sao nó không tự mất đi.** Mọi task T-02, T-06, T-07, T-08, T-09 đều mở một lane, và cả năm task
đó đều chạy trong tình trạng này. Chạy hết kế hoạch thì mệnh đề vẫn đúng ⇒ finding.

**Cách sửa đề xuất.** Thêm `"CLAUDE.md"` và `".claude/rules/**"` vào `paths:`. Đây là đổi kiến trúc
file do người dùng chốt, nên [T-11](task.md) mở đầu bằng một câu hỏi cho người dùng, không tự sửa.
Giảm nhẹ tạm thời, đã làm ở T-01: ô `Nạp` của cả năm task mở lane trỏ thẳng tới rule §6, nên phiên
vẫn mở đúng file — nhưng đó là năm bản chép của cùng một con trỏ, sửa gốc vẫn tốt hơn.

**Bài học giữ lại:** một rule có `paths:` phải liệt kê **cả file mà quy trình bên trong nó bắt sửa**,
không chỉ file mà nó nói *về*. Luật này áp cho mọi `.claude/rules/lane-*.md` sắp tạo: `paths:` của
lane phải phủ đúng cột *Lane sở hữu file nào* ở [CLAUDE.md §1](CLAUDE.md), và đã vào vế 3 của quy trình
mở lane (rule §6).

---

### F-04

**Mệnh đề sai.** Cùng một sự thật — *"ô này của dòng task viết cái gì"* — có **hai** nhà, không nhà nào
trỏ nhà kia: `.claude/rules/quan-ly-du-an.md` §1.1 (bảng: viết cái gì · sai điển hình · vì sao ô đó tồn
tại) và `project_preparation/huong-dan-viet-task-md.md` Phần V (12 mục: lý do tồn tại · ví dụ SAI/ĐÚNG).
Bảng ánh xạ 11 thành phần prompt cũng hai bản: rule §7 và Phần IV. [CLAUDE.md §2](CLAUDE.md) cấp nhà cho
cả hai bằng hai dòng khác nhau (*"Khuôn dòng task"* → rule · *"Luật viết sổ task (11 TP → 12 trường)"* →
guideline) mà **không nói ranh giới giữa chúng ở đâu**.

**Hai bản đã lệch thật, không còn là rủi ro suông.** Ngày 2026-08-22 cột thứ 10 `Owner kiểm tra` được
thêm vào `task.md` và rule §1 §1.1 §7. Sau thay đổi đó:

| Câu hỏi | rule §7 (dòng TP11) | guideline 5.13 |
|---|---|---|
| TP11 *Tự kiểm tra* có thành một cột không? | **Có** — nửa người của TP11 là ô `Owner kiểm tra` | **Không** — "không thành cột, thay bằng ba thứ đánh ✅" |

**Lệnh tái hiện.**

```bash
grep -c 'Context › Bẫy' .claude/rules/quan-ly-du-an.md project_preparation/huong-dan-viet-task-md.md
grep -c '| 11 |' .claude/rules/quan-ly-du-an.md project_preparation/huong-dan-viet-task-md.md
```

Cả hai lệnh ra `>= 1` trên **cả hai** file — cùng một ô, cùng một bảng ánh xạ, hai nơi đặc tả.

**Vì sao nó không tự mất đi.** Chạy hết T-01→T-11 y như sổ viết: không dòng nào gộp hai bản, cũng không
dòng nào cấp ranh giới cho chúng. Lần lệch vừa rồi chỉ được phát hiện vì hai file tình cờ được đọc trong
cùng một phiên. Dòng này **còn** ⇒ finding, không phải task.

**Cách sửa đề xuất.** Cắt ranh giới theo **câu hỏi mà file trả lời**, không theo chủ đề:

- **rule** = *"ô này viết thế nào"* — khuôn đang dùng, sai điển hình, lệnh tự rà. Nạp khi **đang viết**
  một dòng task. Đây là nhà thắng khi lệch, vì nó là file `paths:` tự nạp đúng lúc sửa sổ.
- **guideline** = *"vì sao có ô này"* — 11 TP → 12 trường, ví dụ SAI/ĐÚNG, lý do tồn tại. Đọc **một lần**
  khi học cách viết, không nạp lúc làm.

Thi công: Phần V bỏ vế *viết cái gì*, để lại lý do + ví dụ, mở đầu bằng một dòng trỏ rule §1.1 · rule §7
bỏ bảng ánh xạ, thay bằng một dòng trỏ Phần IV · `CLAUDE.md` §2 sửa hai dòng nhà cho khớp ranh giới.
Kiểm: `grep -c 'Context › Bẫy'` chỉ còn ra `>= 1` trên **một** file.

**Bẫy khi sửa.** Ngày 2026-08-22 có **hai phiên chạy cùng lúc** trên repo này: một phiên thêm cột thứ 10,
một phiên rà guideline. Phiên đóng finding này phải chạy lại ba lệnh trên **ngay trước khi sửa** —
mệnh đề trên chụp lúc `git status` còn bốn file bẩn, và một finding chụp sai còn tệ hơn không có finding.

**Task đóng nó:** [T-12](task.md) — mở 2026-08-22, lane NON-CODE, chạm 3 file (rule, guideline,
`CLAUDE.md` §2). Dòng đó mang `👤` vì nó sửa luật ở `CLAUDE.md` §2 và ở rule có `paths:` rộng.

---

### F-05

**Mệnh đề sai.** Ô biên nhận của [T-05](task.md) chứa `grep -c '^| '` — dấu `|` giữa ô là **dấu ngăn cột**
của bảng markdown, nên dòng đó có **11** cột trong khi khuôn là 10. Hai hệ quả:

1. Lệnh trong ô ấy **không copy-chạy được** như nó hiện ra: nó bị cắt làm đôi ở giữa.
2. Bốn lệnh tự rà ở rule §5.2 định vị ô bằng **số thứ tự cột** (`$8`, `$(NF-3)`). Dòng vỡ cột làm chúng
   đọc sang ô bên cạnh. T-05 hiện **lọt** cả bốn lệnh — không phải vì nó đúng, mà vì cột thừa nằm trước
   ô `Owner kiểm tra` nên `$(NF-3)` tình cờ vẫn trúng.

**Lệnh tái hiện.**

```bash
grep '^| \*\*T-' task.md | awk -F'|' '{ if (NF-2 != 10) print $2, NF-2 }'   # ra: **T-05** 11
```

**Vì sao nó không tự mất đi.** Chạy hết T-01→T-12 y như sổ viết: không dòng nào thoát dấu `|`, không dòng
nào thêm phép đếm cột vào rule §5.2. Và dự án này là dự án tài liệu — biên nhận của lane NON-CODE gần như
luôn là `grep` trên bảng markdown, tức mọi dòng task sắp viết đều có thể dẫm lại. Dòng này **còn** ⇒ finding.

**Cách sửa đề xuất.** Hai vế, làm cùng một task:

- **Thoát dấu:** trong ô của bảng viết `\|` (hoặc đổi mẫu grep sang lớp ký tự `[|]`). Sửa T-05, rồi
  quét lại cả sổ bằng lệnh trên.
- **Thêm phép đếm cột vào rule §5.2** — chính lệnh tái hiện ở trên. Không có nó thì lần sau lại lọt:
  bốn lệnh tự rà hiện có đều **giả định** dòng đủ cột, không lệnh nào **kiểm** điều đó.
- **Siết mẫu dò finding** trong rule §5.2 thành hai chữ số có biên (`F-` + `[0-9]{2}` + `\b`), đúng khuôn
  mã đang dùng (`F-01`…`F-05`). Kiểm: chạy lệnh đó trên sổ hiện tại, không còn dòng `F-2` / `F-3` nào.

**Bẫy khi sửa.** Đừng sửa bằng cách bỏ dấu `|` khỏi lệnh grep — mẫu `'^| '` là thứ phân biệt dòng bảng với
dòng thường, bỏ nó đi là đổi ý nghĩa của biên nhận chứ không phải sửa lỗi trình bày.
