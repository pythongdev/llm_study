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
| [F-03](#f-03) | `paths:` của `.claude/rules/quan-ly-du-an.md` không khớp `CLAUDE.md`, nên phiên sửa `CLAUDE.md` §1 để mở lane không được nạp quy trình mở lane | T-01 · 2026-08-22 | ✅ ĐÓNG 2026-08-22 | T-11 |
| [F-04](#f-04) | Đặc tả *một ô của dòng task viết cái gì* sống ở **hai** nhà — rule §1.1 và `huong-dan-viet-task-md.md` Phần V — một sự thật đổi thì phải sửa hai file, không lệnh nào bắt được khi chỉ sửa một | rà guideline · 2026-08-22 | 🔴 MỞ | [T-12](task.md) |
| [F-05](#f-05) | Bốn lệnh tự rà ở rule §5.2 không đáng tin: dòng vỡ cột thì chúng đọc nhầm ô (T-05 có 11 cột vì dấu ngăn chưa thoát), và mẫu dò finding lỏng nên báo nhầm mã không tồn tại | T-12 · 2026-08-22 | 🔴 MỞ | [T-13](task.md) |
| [F-06](#f-06) | `finding.md` bị chèn thừa một khối `F-04` lai (mở đầu F-04, thân F-02) và một bản sao y hệt `### F-03`; hai mục cùng mã tồn tại 60 dòng mà không lệnh nào bắt được | T-11 · 2026-08-22 | 🔴 MỞ | [T-16](task.md) |
| [F-07](#f-07) | Hai phiên chạy cùng lúc trên một repo: [CLAUDE.md §3](CLAUDE.md) bước 4 bắt `commit` hoặc `git stash` khi cây bẩn, nhưng cây bẩn của **phiên khác** trông y hệt cây bẩn của chính mình ⇒ chạy đúng luật là nuốt việc dở của phiên kia | kiểm thử ngược · 2026-08-22 | 🔴 MỞ | ⚠️ chưa có task — **kiến trúc, chờ owner chốt** |
| [F-08](#f-08) | `CLAUDE.md` §8 đặt trần **mỗi mục ≤ 14 dòng** nhưng §1 đang 20 dòng và §2 đang 17 — §8 chỉ nêu lệnh kiểm `wc -l` toàn file và `awk length>400`, không lệnh nào kiểm trần từng mục | kiểm thử ngược lượt 2 · 2026-08-22 | 🔴 MỞ | ⚠️ chưa có task — **kiến trúc, chờ owner chốt** |
| [F-09](#f-09) | Cách sửa mà [F-05](#f-05) đề xuất **không làm lệnh đếm cột xanh được**: `awk -F'\|'` đếm cả dấu `\|` đã thoát, nên T-05 và T-11 — hai dòng đã thoát **đúng luật** §1.1 — vẫn bị báo vỡ cột vĩnh viễn; và vế *T-05 chưa thoát dấu* của F-05 nay đã hết đúng | rà bộ khung · 2026-08-22 | 🔴 MỞ | ⚠️ chưa có task — sửa kèm khi làm [T-13](task.md) |
| [F-10](#f-10) | Luật *sửa nội dung ⇒ đổi ngày trong cùng commit* ở [CLAUDE.md §2](CLAUDE.md) không có lệnh nào kiểm; bốn file `.md` đang khai ngày khác `git log`, trong đó `project_preparation/prompt-fullstack.md` lệch 2 ngày — không ai thấy | rà bộ khung · 2026-08-22 | 🔴 MỞ | ⚠️ chưa có task |
| [F-11](#f-11) | Vòng lặp con trỏ §5.1 **tự bắt chính mình**: chạy trên `.claude/rules/quan-ly-du-an.md` luôn in một dòng `TRỎ HỤT` rác lấy từ chính đoạn code của lệnh ⇒ vế 3 của định nghĩa XONG (§3) không bao giờ xanh được trên file luật | rà bộ khung · 2026-08-22 | 🔴 MỞ | ⚠️ chưa có task |
| [F-12](#f-12) | Cả bộ khung đặt cưỡng chế lên `paths:` của `.claude/rules/**` — nhưng **không lệnh nào trong repo chứng minh được một rule có thật sự được nạp**; `test -e` chỉ chứng minh file tồn tại, không chứng minh nó tới được phiên | rà bộ khung · 2026-08-22 | 🔴 MỞ | ⚠️ chưa có task — **kiến trúc, chờ owner chốt** |
| [F-13](#f-13) | Không biên nhận nào trong repo đo **chất lượng**: cả 16 dòng `task.md` dừng ở *tồn tại + hình dạng*, không dòng nào khai **đỏ khi** — nên ngưỡng dưới kiểu `grep -c '^- '` ra `>= 3` xanh **vĩnh viễn**, kể cả với ba dòng rác | owner nêu · 2026-08-23 | 🔴 MỞ | [T-20](task.md) + [T-21](task.md) |

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

**Đã đóng 2026-08-22 · T-11.** Owner duyệt thêm `"CLAUDE.md"` và `".claude/rules/**"` vào `paths:`.
Mệnh đề sai hết đúng: quy trình mở lane (rule §6) bắt sửa `CLAUDE.md` §1 và tạo `.claude/rules/lane-*.md`,
cả hai nay đều nằm trong `paths:` nên rule được nạp đúng lúc cần. Năm ô `Nạp` trỏ thẳng rule §6 ở
T-02/T-06/T-07/T-08/T-09 **giữ nguyên** — chúng vẫn đúng, chỉ không còn là chỗ dựa duy nhất.

**Kiểm chứng.** `head -10 .claude/rules/quan-ly-du-an.md` in ra 6 mục `paths:`, hai mục đầu là
`"CLAUDE.md"` và `".claude/rules/**"`. `git show --stat -- .claude/rules/quan-ly-du-an.md` ra `+2` dòng,
không dòng luật nào bị sửa kèm.

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

---

### F-06

**Mệnh đề sai.** `finding.md` có thể chứa **hai mục cùng một mã** mà không lệnh nào trong repo bắt được.
Đã xảy ra thật: commit `34b3171` để lại một khối `### F-04` **lai** — đoạn *Mệnh đề sai* của F-04 nối
thẳng vào phần *Lệnh tái hiện · Cách sửa · Bài học* của **F-02** — cộng thêm một bản sao **y hệt** của
`### F-03`. Tổng 60 dòng thừa, tồn tại qua một commit.

**Vì sao nó nguy hiểm hơn nó trông.** Sổ lỗi là nhà của *cái gì đang sai*. Hai mục cùng mã ⇒ đóng một
mục còn mục kia vẫn 🔴, và `grep '^### F-03' finding.md` vẫn ra kết quả nên phiên sau tin là chưa đóng.
Khối lai còn tệ hơn: nó gán **bài học của F-02** cho **F-04**, tức luật rút ra bị treo nhầm nguyên nhân.

**Lệnh tái hiện** (chạy trên `34b3171`):

```bash
git show 34b3171:finding.md | grep -o '^### F-[0-9]*' | sort | uniq -d   # ra: ### F-03, ### F-04
```

**Vì sao nó không tự mất đi.** Không dòng nào trong [task.md](task.md) rà tính duy nhất của mã finding.
Bốn lệnh tự rà ở rule §5.2 rà `task.md`, không rà `finding.md`. Chạy hết kế hoạch y như nó viết thì
mệnh đề vẫn đúng ⇒ finding, không phải task.

**Cách sửa đề xuất.** Thêm hai lệnh vào rule §5.2, chạy trước mỗi commit chạm `finding.md`:

```bash
grep -o '^### F-[0-9]*' finding.md | sort | uniq -d                      # mã finding trùng
grep -c '^### F-' finding.md; grep -c '^| \[F-' finding.md               # số mục = số dòng bảng
```

Lệnh thứ hai bắt được cả chiều ngược lại: mục có mà bảng thiếu, hoặc bảng có mà mục thiếu.

**Đã làm ở T-11.** 60 dòng thừa đã xoá; `grep -o '^### F-[0-9]*' finding.md | sort | uniq -d` ra rỗng.
Nội dung xoá là bản trùng và bản lai — bản F-04 đúng, đầy đủ vẫn còn, đối chiếu được bằng
`git show 34b3171:finding.md`. Finding này vẫn 🔴 vì **cơ chế** chặn tái phát chưa có, chỉ hậu quả
đã dọn — đóng vì "đã dọn xong" là đúng thứ [CLAUDE.md §4](CLAUDE.md) cấm.

---

### F-07

**Mệnh đề sai.** [CLAUDE.md §3](CLAUDE.md) bước 4 (ĐIỂM LÙI) nói: *"Cây bẩn ⇒ commit hoặc `git stash`
trước khi gõ ký tự đầu tiên."* Luật này giả định cây bẩn là **của chính phiên đang chạy**. Trong phiên
kiểm thử ngược hôm nay, `git status --short` ra ` M finding.md` — đó là việc dở của **một phiên khác đang
chạy song song** (nó đóng F-03, mở F-06, mở T-16). Một phiên trắng làm đúng bước 4 sẽ `git stash` hoặc
commit đè lên việc đó, và **không lệnh nào trong bộ khung đỏ**: `git status` sạch sau đó, biên nhận xanh,
`git log` có commit hợp khuôn. Mất mát chỉ lộ ra khi phiên kia quay lại và thấy file đã đổi dưới chân nó.

**Lệnh tái hiện.** `git status --short` ra file bẩn · `git log --oneline -1` ra commit của một mã task
**khác** mã task phiên này đang làm ⇒ có phiên thứ hai. Bộ khung hiện không có lệnh nào hỏi câu đó.

**Vì sao nó không tự mất đi.** Chạy hết T-02→T-16 y như sổ viết: không dòng nào tạo cơ chế phân biệt
"bẩn vì tôi" và "bẩn vì phiên khác". Dòng này **còn** ⇒ finding.

**Cách sửa đề xuất — kiến trúc, agent không tự làm ([CLAUDE.md §8](CLAUDE.md)).** Ba hướng, owner chọn:

1. **Hook `SessionStart` trong `.claude/settings.json`** ghi mã phiên + mã task vào một file khoá
   (`.claude/.phien-dang-chay`), hook `Stop` xoá. Bước 4 đọc file đó: có chủ khác ⇒ **dừng, hỏi owner**,
   không stash. Đây là hướng duy nhất **cưỡng chế** được — hợp với luật "cần chắc chắn thì nhà là hook".
2. **Một dòng luật ở `CLAUDE.md` §3 bước 4:** cây bẩn mà `git log -1` khai một mã task khác mã đang làm
   ⇒ coi là phiên khác, không stash, hỏi owner. Rẻ, nhưng vẫn là lời đề nghị.
3. **Một worktree một phiên** (`git worktree add`). Sạch nhất, nhưng đổi cách owner mở phiên.

**Chưa đóng được vì:** cả ba hướng đều đổi kiến trúc (thêm file khoá / thêm hook / đổi cách mở phiên),
mà theo [CLAUDE.md §7](CLAUDE.md) đó là quyền của owner. Chốt xong mới mở dòng task.

---

### F-08

**Mệnh đề sai.** [CLAUDE.md §8](CLAUDE.md) nói trần là *"**120 dòng**, mỗi mục ≤ 14 dòng, mỗi dòng ≤ 400 byte"*, rồi
nêu **hai** lệnh kiểm: `wc -l < CLAUDE.md` và `awk 'length > 400' CLAUDE.md`. Vế **mỗi mục ≤ 14 dòng** không có
lệnh nào. Nó đã bị vi phạm và không ai biết: §1 dài **20** dòng, §2 dài **18** dòng (17 cho tới `1e3c963`, hàng trỏ nhà chất lượng thêm dòng thứ 18).

**Lệnh tái hiện.**

```bash
awk '/^## §/{if(n)print n": "c; n=$2; c=0} {c++} END{print n": "c}' CLAUDE.md | awk '$2>14'
```

Ra `§1: 20` và `§2: 18`.

**Vì sao nó nguy hiểm hơn nó trông.** Trần từng mục là thứ giữ cho `grep -n` thay được việc đọc cả file — lý do
§8 tự nêu. Toàn file vẫn dưới 120 nên `wc -l` mãi mãi xanh, và mục phình ra chỉ lộ khi có người đếm tay. Mọi
phiên sau nạp `CLAUDE.md` ở **mọi request**, nên mục phình là khoản thuế mọi phiên đều trả.

**Vì sao nó không tự mất đi.** Chạy hết T-02→T-16 y như sổ viết: T-02/T-06/T-07/T-08/T-09 mỗi task còn **thêm**
nội dung thật vào một dòng bảng §1, T-15 thêm một dòng nữa. §1 chỉ dài ra. Không dòng task nào đo trần từng mục.
Dòng này **còn** ⇒ finding.

**Cách sửa đề xuất — kiến trúc, agent không tự làm ([CLAUDE.md §8](CLAUDE.md)).** Ba hướng, owner chọn:

1. **Nới trần từng mục** cho hai mục có bảng (§1 bảng lane 8 dòng, §2 bảng nhà 12 dòng): trần ≤ 14 vốn không
   ôm nổi một bảng, nên nó sai từ lúc viết ra, không phải bị vi phạm về sau.
2. **Tách bảng §1 và §2 sang một rule `paths: "**"`** (như `bao-cao-thay-doi.md`), để `CLAUDE.md` chỉ giữ luật
   chữ. Rẻ về trần, nhưng đẩy hai bảng nạp-mọi-phiên sang file khác — đúng thứ §8 muốn tránh.
3. **Giữ nguyên trần, thêm lệnh trên vào §8** rồi cắt §1/§2 cho vừa. Cắt gì là quyết định của owner.

Bất kể hướng nào, **lệnh tái hiện ở trên phải vào §8** — vế trần nào không có lệnh kiểm thì nó không phải trần,
nó là lời khuyên.

**Chưa đóng được vì:** cả ba hướng đều đổi kiến trúc file (đổi trần, hoặc tách rule mới), mà theo
[CLAUDE.md §7](CLAUDE.md) đó là quyền của owner.

---

### F-09

**Mệnh đề sai.** [F-05](#f-05) mở bằng câu *"Ô biên nhận của T-05 chứa `grep -c '^| '`"* và đề xuất sửa bằng
cách **thoát dấu** thành `\|`, rồi **thêm chính lệnh đếm cột đó vào rule §5.2**. Hai vế đều không còn đứng được:

1. **Vế hiện trạng đã hết đúng.** T-05 nay đã thoát: file chứa `grep -c '^\| '`. Đọc F-05 hôm nay sẽ đi sửa
   một thứ đã sửa rồi.
2. **Vế cách sửa thì sai từ đầu.** `awk -F'|'` cắt trường theo ký tự `|` **thô** — nó không biết gì về
   `\|`. Thoát dấu đúng luật §1.1 **không** làm số cột giảm. T-05 và T-11 hiện đều đã thoát đúng, và
   cả hai vẫn bị lệnh của F-05 báo vỡ cột. Làm [T-13](task.md) y như sổ viết ⇒ rule §5.2 nhận thêm một
   lệnh **đỏ vĩnh viễn**, và một lệnh không bao giờ xanh được là lệnh mọi phiên học cách bỏ qua.

**Lệnh tái hiện.**

```bash
grep '^| ~*\*\*T-' task.md | awk -F'|' '{ if (NF-2 != 10) print $2, NF-2 }'   # F-05 đề xuất
# ra: **T-05** 11 · ~~**T-11**~~ 12   — cả hai đều đã thoát \| ĐÚNG luật

grep -o 'sort .\{0,3\} uniq -d' task.md          # ra: sort \| uniq -d  ⇒ T-11 thoát đúng
```

**Cách đếm đúng — bỏ dấu đã thoát trước khi đếm:**

```bash
grep '^| ~*\*\*T-' task.md \
  | awk '{ l=$0; gsub(/\\\|/,"",l); n=gsub(/\|/,"",l); if (n-1 != 10) { match($0,/T-[0-9]+/); print substr($0,RSTART,RLENGTH), n-1 } }'
```

Chạy trên sổ hiện tại: **rỗng** — mọi dòng task đủ đúng 10 cột. Đó mới là hiện trạng thật.

**Vì sao nó không tự mất đi.** [T-13](task.md) ghi rõ *"thêm phép đếm cột"* và trỏ về mục *Lệnh tái hiện*
của F-05 để lấy lệnh. Chạy đúng như sổ viết thì lệnh sai được chép vào rule, không dòng nào ngăn. Dòng này
**còn** ⇒ finding.

**Cách sửa đề xuất.** Làm cùng [T-13](task.md), không mở task mới:

- Sửa **mục *Lệnh tái hiện* của [F-05](#f-05)** thành lệnh `gsub` ở trên, và ghi một câu nói rõ vế
  *T-05 chưa thoát* đã hết đúng — F-05 vẫn 🔴 vì vế *bốn lệnh tự rà không đáng tin* còn nguyên.
- Chỉ khi đó mới chép lệnh vào rule §5.2.

**Bẫy khi sửa.** Đừng "sửa" bằng cách bỏ dấu `\|` khỏi ô T-05/T-11 cho lệnh cũ xanh trở lại — đó là làm
hỏng bảng markdown để chiều một lệnh sai. Lệnh phục vụ sổ, không phải ngược lại.

---

### F-10

**Mệnh đề sai.** [CLAUDE.md §2](CLAUDE.md) ra hai luật về dòng `Cập nhật <ngày>`: *"Nghi một file cũ: so
dòng `Cập nhật <ngày>` trong file với `git log -1 --format=%ad -- <file>`"* và *"Sửa nội dung ⇒ đổi ngày
**trong cùng commit**"*. Cả hai đều là **thao tác tay khi đã nghi ngờ** — không có lệnh nào tự rà, nên
lệch chỉ lộ ra khi tình cờ có người đi so. Nó đang lệch thật:
`project_preparation/prompt-fullstack.md` khai `Cập nhật **2026-08-19**`, còn `git log` ra **2026-08-21**.

**Lệnh tái hiện.**

```bash
git ls-files -z '*.md' | while IFS= read -r -d '' f; do \
  d=$(grep -m1 -o 'Cập nhật \*\*[0-9-]\{10\}\*\*' "$f" | grep -o '[0-9-]\{10\}'); \
  [ -z "$d" ] && continue; \
  g=$(git log -1 --format=%ad --date=short -- "$f"); \
  [ "$d" = "$g" ] || echo "NGÀY LỆCH: $f khai $d, git ra $g"; done
```

**Phải dùng `-z` + `read -r -d ''`.** Bản `for f in $(git ls-files ...)` cắt đường dẫn ở khoảng trắng và
làm hỏng tên có dấu tiếng Việt — repo này có `prompt/prompt_quan_ly_dự_án/`, nên bản đó **bỏ sót**
đúng những file nó không đọc được, mà vẫn chạy im như thể đã rà hết.

Ra **bốn** dòng, không phải một:

```
project_preparation/prompt-fullstack.md   khai 2026-08-19, git ra 2026-08-21   <- nhà thật, phải sửa
prompt/prompt_quan_ly_dự_án/prompt-tao-claude-md.md  khai 2026-08-21, git 2026-08-22
reference/CLAUDE_rẻence.md                khai 2026-08-19, git ra 2026-08-21   <- dự án khác
reference/task.md                         khai 2026-08-19, git ra 2026-08-21   <- dự án khác
```

**Vì sao nó nguy hiểm hơn nó trông.** Dòng `Cập nhật` là thứ duy nhất một phiên dùng để quyết định
*có nên tin file này không* trước khi đọc nội dung. Ngày sai không làm phiên đọc nhầm một câu — nó làm
phiên **tin nhầm cả file**, hoặc ngược lại đi kiểm lại một file vốn đúng.

**Vì sao nó không tự mất đi.** Chạy hết T-02→T-16 y như sổ viết: mỗi task sửa nội dung một file và tự
nhớ đổi ngày, hoặc tự quên. Không dòng task nào tạo ra lệnh đo. Dòng này **còn** ⇒ finding.

**Cách sửa đề xuất.** Hai vế, rẻ, không đổi kiến trúc:

- Thêm lệnh trên vào [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) §5.3 (ba lệnh dò
  phiên trôi) — đúng chỗ, vì đây là dấu hiệu **phiên sửa nội dung mà không khai**.
- Sửa dòng `Cập nhật` của `project_preparation/prompt-fullstack.md` cho khớp `git log`, **không** sửa
  ngược lại lịch sử git. Hai file `reference/**` là **dự án khác** (bẫy của [T-01](task.md): lấy cấu trúc,
  không chép nội dung) — hoặc loại `reference/` khỏi phạm vi lệnh, hoặc chấp nhận chúng đỏ mãi; đừng sửa
  ngày của một dự án không phải của mình.

**Bẫy khi sửa.** File được **tạo** ở commit `6391af4` (2026-08-21) với ngày `2026-08-19` viết sẵn trong
nội dung — tức ngày ấy là ngày *soạn thảo*, không phải ngày vào repo. Đổi số cho khớp là đúng, nhưng đừng
kết luận có ai đó sửa lén: `git log --format='%h %ad %s' -- <file>` chỉ ra **một** commit.

---

### F-11

**Mệnh đề sai.** Vế 3 của định nghĩa XONG ([.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md)
§3) đòi: *"Chạy vòng lặp §5.1 dưới đây, output rỗng"*. Trên `.claude/rules/quan-ly-du-an.md` — file **chứa**
chính lệnh đó — output **không bao giờ rỗng được**: `grep -o '](...'` quét cả khối ```bash và bắt trúng
đoạn `](` trong mã nguồn của chính lệnh, rồi báo một `TRỎ HỤT` rác.

**Lệnh tái hiện.**

```bash
grep -o '](\([^)#]*\)' .claude/rules/quan-ly-du-an.md | sed 's/](//' | grep -v '^http' \
  | grep -v '^$' | sort -u | while read f; do [ -e "$f" ] || echo "TRỎ HỤT: $f"; done
```

Ra: `TRỎ HỤT: //' | grep -v '^http' | grep -v '^$' | sort -u ([^` — không phải một con trỏ, mà là mảnh
vỡ của chính dòng lệnh ở §5.1.

**Vì sao nó nguy hiểm hơn nó trông.** Một biên nhận **không bao giờ xanh được** không phải là biên nhận
chặt hơn — nó là biên nhận **bị bỏ qua**. Phiên nào chạy §5.1 trên file luật cũng thấy một dòng đỏ, học
được rằng dòng đỏ ở đây là bình thường, và lần sau một `TRỎ HỤT` **thật** nằm ngay cạnh sẽ trôi qua cùng nó.

**Vì sao nó không tự mất đi.** Chạy hết T-02→T-16 y như sổ viết: T-13 và T-16 còn **thêm** lệnh vào §5.2,
tức thêm mã nguồn có dấu `](` vào file. Nhiễu chỉ tăng. Dòng này **còn** ⇒ finding.

**Cách sửa đề xuất.** Bỏ khối mã ra khỏi phạm vi quét trước khi tìm con trỏ:

```bash
awk '/^```/{f=!f; next} !f' <file> | sed 's/`[^`]*`//g' | grep -o '](\([^)#]*\)' | sed 's/](//' \
  | grep -v '^http' | grep -v '^$' | sort -u | while read f; do [ -e "$f" ] || echo "TRỎ HỤT: $f"; done
```

**Cần cả hai vế lọc.** `awk` bỏ khối ```` ``` ````; `sed 's/`[^`]*`//g'` bỏ **mã inline** — thiếu vế thứ
hai thì `finding.md` vẫn ra ba dòng rác, vì mục này và [F-09](#f-09) nhắc tên lệnh ngay giữa câu văn.
Đã chạy trên cả năm file sổ sau khi thêm vế hai: **rỗng**.

Con trỏ nằm trong mã là **ví dụ**, không phải lời hứa về một file có thật — nên bỏ qua chúng là đúng
ngữ nghĩa, không phải nới lỏng. Sửa ở §5.1, và §3 vế 3 tự hết đỏ theo.

---

### F-12

**Mệnh đề sai.** Cưỡng chế của cả bộ khung dựa trên một giả định chưa ai kiểm: rằng file trong
`.claude/rules/` có `paths:` **được nạp vào phiên khi phiên chạm file khớp**. [CLAUDE.md §8](CLAUDE.md)
nói thẳng *"Luật chỉ đúng cho một loại file thì nhà của nó là `.claude/rules/` có `paths:`"*, và
[.claude/rules/bao-cao-thay-doi.md](.claude/rules/bao-cao-thay-doi.md) đặt `paths: "**"` với lý do
*"nó là điều kiện để một phiên được coi là đã báo cáo xong"*. Nhưng mọi biên nhận đang có chỉ là
`test -e` và `head -6` — chúng chứng minh **file tồn tại và có frontmatter**, không chứng minh **rule tới
được phiên**. Một rule không nạp và một rule nạp rồi bị lờ đi để lại **đúng cùng một dấu vết**: không có gì.

**Lệnh tái hiện.** Không có — và đó chính là mệnh đề. Không lệnh nào trong repo, kể cả §5.1–§5.3, trả lời
được câu *"rule này có được nạp không"*. Cách duy nhất hiện nay là **thử bằng người**:

1. Thêm vào cuối một rule một câu vô hại, dễ nhận: `Nếu bạn đọc được dòng này, mở đầu câu trả lời bằng
   RULE-OK-<mã>.`
2. Mở một phiên **mới** (không dán nội dung rule vào prompt), bảo nó sửa một file khớp `paths:`.
3. Không thấy `RULE-OK-<mã>` ⇒ rule không tới được phiên, và mọi luật đang sống ở `.claude/rules/**`
   là **luật không ai đọc**.

**Vì sao nó nguy hiểm hơn nó trông.** Nếu giả định sai thì hỏng không nằm ở một luật, mà ở **chỗ cất
luật**: `quan-ly-du-an.md` (206→237 dòng) và `bao-cao-thay-doi.md` (127 dòng) là hai file dài nhất của bộ
khung, và [CLAUDE.md](CLAUDE.md) cố ý **không** chép nội dung của chúng để giữ trần §8. Luật ở đó không tới
phiên nghĩa là bộ khung mỏng đi đúng phần dài nhất, trong khi mọi sổ vẫn xanh.

**Vì sao nó không tự mất đi.** Chạy hết T-02→T-16 y như sổ viết: T-06→T-09 **tạo thêm bốn** rule
`paths:` nữa. Kế hoạch hiện tại đang đặt thêm luật lên giả định chưa kiểm, chứ không đi kiểm nó. Dòng này
**còn** ⇒ finding.

**Cách sửa đề xuất — kiến trúc, agent không tự làm ([CLAUDE.md §7](CLAUDE.md)).** Ba hướng, owner chọn:

1. **Chạy phép thử ba bước ở trên một lần**, rồi ghi kết quả thành một dòng ở [CLAUDE.md §2](CLAUDE.md)
   (*"cơ chế nạp rule: đã kiểm ngày …"*). Rẻ nhất, và biến giả định thành sự thật có ngày tháng.
2. **Nếu rule KHÔNG nạp:** chuyển phần luật bắt buộc về `CLAUDE.md` (phải cắt chỗ khác cho vừa trần §8),
   hoặc về hook — xem [T-15](task.md).
3. **Nếu rule CÓ nạp:** thêm một dòng vào §5.3 để mọi phiên tự khai đã nạp rule nào, biến việc nạp thành
   thứ quan sát được thay vì tin tưởng.

**Chưa đóng được vì:** hướng 2 và 3 đều đổi chỗ cất luật của cả bộ khung, và [CLAUDE.md §7](CLAUDE.md)
xếp việc đó vào quyền của owner. Hướng 1 owner chạy được ngay trong một phiên trắng.

---

### F-13

**Mệnh đề sai.** Biên nhận của giai đoạn này ([rule §3](.claude/rules/quan-ly-du-an.md) vế 2) chỉ đòi
*"nội dung đúng hình dạng, đo bằng lệnh"*. Hình dạng không phải chất lượng: `test -e` xanh với một file
rỗng nghĩa, và một ngưỡng dưới đặt trên thứ dễ đẻ — `grep -c` một mẫu gạch đầu dòng ra `>= 3` — xanh
với ba dòng rác. Tệ hơn: nó xanh **vĩnh viễn**, vì không trạng thái hỏng nào của repo làm nó đỏ lại
được. Mười sáu dòng có trước ngày 2026-08-23 trong [task.md](task.md) dừng đúng ở đó.

**Lệnh tái hiện.**

```bash
grep '^| ~*\*\*T-' task.md | grep -c 'đỏ khi'   # ra 4 — chỉ 4 dòng mở ngày 2026-08-23
grep -c '^| ~*\*\*T-' task.md                   # ra 20 — mẫu số
```

**Vì sao nó nguy hiểm hơn nó trông.** Một biên nhận không đỏ được là **cơ chế trang trí**: nó tiêu công
viết, tiêu công đọc, và trả về đúng một chữ *"xanh"* trong mọi trạng thái của repo — kể cả trạng thái
hỏng nhất. Nó tệ hơn việc không có biên nhận, vì không-có thì còn thấy là thiếu, còn xanh-giả thì
[CLAUDE.md §4](CLAUDE.md) coi là đủ để đánh ✅. Càng nhiều dòng ✅, niềm tin sai càng lớn.

**Cách sửa đề xuất.** Thang T0–T3 và luật biên nhận âm đã có nhà ở
[quality/00-guideline-chat-luong.md](quality/00-guideline-chat-luong.md) §3 §5 (commit `1e3c963`).
Còn hai việc: đưa vế `đỏ khi` vào đặc tả ô ở rule §1.1 ([T-20](task.md)), rồi áp xuống mọi dòng đang có
([T-21](task.md)). Đóng được F-13 khi hai số của lệnh tái hiện bằng nhau — và khi mỗi vế âm đã **được
thử làm đỏ đúng một lần**, không chỉ được viết ra.
