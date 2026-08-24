# task.md — việc tiếp theo là gì, theo thứ tự nào

> Cập nhật **2026-08-24**. Đây là **sổ task**: đo *xong / chưa*. Cái đang **sai** đi sổ khác —
> [finding.md](finding.md). Luật không trộn hai sổ ở [CLAUDE.md §5](CLAUDE.md).
> Khuôn 11 cột, đặc tả từng ô, và định nghĩa XONG của giai đoạn chưa-có-compiler nằm ở
> [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) §1 và §3 — file này **không** chép lại.

---

## Task tiếp theo — làm ngay

Đừng chép mã task ra đây; chép là hai chỗ phải sửa, và chỗ thứ hai sẽ quên. Chạy hai lệnh, đúng thứ tự:

```bash
grep -n '^| \*\*T-' task.md | grep '🔺' | head -1   # 1. 🔺 chặn task khác ⇒ làm trước
grep -n '^| \*\*T-' task.md | head -1               # 2. hết 🔺 thì lấy dòng chưa xong đầu tiên
```

Task đã xong mở đầu bằng `| ~~**T-` nên tự bị bỏ qua. Trước khi làm, đọc ô `Cần xong trước` của dòng
vừa dò ra: có mã task nào ở đó chưa xong thì làm mã đó trước.

Phiên trước đã làm gì: `git log --oneline -5` và [finding.md](finding.md).

**Owner soi một task:** ô `Owner kiểm tra` của dòng đó chỉ giữ **dấu ai ký** và link xuống
[§Owner kiểm tra](#owner-kiểm-tra--bảng-soi-thay-đổi-của-từng-task) — nơi mỗi task có một bảng ba cột:
**thay đổi cái gì · câu lệnh để thấy thay đổi · ở đâu**, cộng một dòng `**Đạt khi:**` để nói *nhận* hay
*trả lại*. Lệnh trong bảng in ra **thay đổi** (diff/stat), không phải hiện trạng — hiện trạng là việc của
ô `Đầu ra kiểm chứng được`, hai câu hỏi khác nhau.

**Soi chất lượng một task:** ô `Chất lượng` giữ **dấu trạng thái** (`⬜` chưa đo · `✅` đạt sàn · `❌` trả
lại) + **tầng sàn** `T0–T3` + link xuống [§Chất lượng đầu ra](#chất-lượng-đầu-ra--bảng-soi-chất-lượng-của-từng-task)
— nơi mỗi task có một bảng bốn cột: **trục §4 · mệnh đề phải đúng · lệnh soi · đỏ khi**. Thang tầng, năm
trục và luật biên nhận âm ở [quality/00-guideline-chat-luong.md](quality/00-guideline-chat-luong.md)
§3 §4 §5; sổ này chỉ áp chúng xuống từng mã. `Đầu ra kiểm chứng được` hỏi *hiện trạng đúng chưa*, ô này
hỏi *phiên sau dùng được không* — task **XONG mà không TỐT** trông y hệt task tốt.

---

## Sổ task

| # | Lane | Task | Context | Cần xong trước | Finding phải đóng | Đầu ra kiểm chứng được | Owner kiểm tra | Chất lượng | Hỏng thì mất gì | Prompt mở session |
|---|---|---|---|---|---|---|---|---|---|---|
| ~~**T-01**~~ | NON-CODE | Dựng bộ khung quản lý: `CLAUDE.md`, `.claude/rules/quan-ly-du-an.md`, `task.md`, `finding.md` | **Nạp:** `project_preparation/prompt-fullstack.md` §5 §6 §7 · `huong-dan-viet-task-md.md` Phần IV VII · `claude-md-huong-dan.md` Bước 3 Bước 6 · **Đã chốt:** kiến trúc tách file do người dùng chốt · **Bẫy:** `reference/` là dự án ở giai đoạn xa hơn — lấy cấu trúc, không chép nội dung | — | [F-01](finding.md#f-01) ✅ | `wc -l < CLAUDE.md` ra `<= 120` (trần §8), `awk 'length > 400' CLAUDE.md` rỗng, `head -6 .claude/rules/quan-ly-du-an.md` in ra frontmatter `paths:` | 👤 · [bảng soi ↓](#owner-t-01) | ⬜ T3 · [soi ↓](#cl-t-01) | Phiên thứ mười có hai phiên bản sự thật, làm lại hai lần, không ai chứng minh được cái gì đã xong | `Lane NON-CODE · T-01 · đọc 4 file ở project_preparation và prompt/ · chỉ chạm CLAUDE.md, .claude/rules/, task.md, finding.md · xong 4 file thì DỪNG, chưa mở lane nào` |
| ~~**T-02**~~ ✅ | BA | Mở lane BA: tạo `design/BA/` và `design/BA/04-yeu-cau.md` liệt kê lệnh đọc lại làm biên nhận của lane | **Nạp:** `project_preparation/prompt-fullstack.md` §3.3 · §7 dòng `**0 · BA**` (grep ra được — không có mục nào tên "pha 0") · [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) §6 · **Đã chốt:** hệ tên là **6 Pha** của §7, không dùng chữ "Giai đoạn" · **Bẫy:** pha 0 **không** được nhắc tên bảng dữ liệu; muốn nhắc là đã lấn sang pha 2 | — | — | **Đủ năm vế §6, thiếu vế nào thì lane chưa mở:** `test -e design/BA/04-yeu-cau.md` không kêu (vế 1) · `grep -c '^- .*\`' design/BA/04-yeu-cau.md` ra `>= 3` — đếm dòng gạch đầu dòng **có backtick lệnh**, không đếm gạch đầu dòng văn xuôi (vế 2) · `head -6 .claude/rules/lane-ba.md` in ra frontmatter `paths:` trỏ `design/BA/**` (vế 3) · dòng BA ở `CLAUDE.md` §1 hết ⚠️ và `grep -n 'design/BA' CLAUDE.md` ra `>= 1` (vế 4) · lệnh **§5.2b** của rule không in dòng `LANE NỬA VỜI: ba` nào (vế 3 + vế 5) | 👤 *(mở lane đầu tiên, đặt tiền lệ cho T-06→T-09)* · [bảng soi ↓](#owner-t-02) | ⬜ T3 · [soi ↓](#cl-t-02) | Pha 0 chạy xong mà đầu ra không có nhà ⇒ luồng nghiệp vụ sống trong hội thoại, phiên sau phải hỏi lại chủ quán từ đầu | `Lane BA · T-02 · đã xong ở commit 4851d17 · không mở lại — nội dung pha 0 là [T-25](#sổ-task)` |
| ~~**T-03**~~ ✅ | DEVOPS | Tạo `Makefile` ở gốc repo với đích `check` gom lệnh đọc lại hiện có (`wc -l`, `awk`, vòng lặp con trỏ) | **Nạp:** [CLAUDE.md §7](CLAUDE.md) · [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) §5 · **Đã chốt:** chưa có code ứng dụng nên `check` chỉ gọi lệnh đọc lại · **Bẫy:** đừng viết sẵn đích `test`/`build` gọi `go`/`npm` — chúng chưa cài, đích đỏ ngay lần đầu chạy làm cả `Makefile` mất tin cậy | — | — | ⚠️ `make check` chạy được lần đầu tiên và ra mã thoát `0`, output dán vào phiên; `test -e Makefile` không kêu | 👤 *(nền biên nhận của DB/BE/FE)* · [bảng soi ↓](#owner-t-03) | ✅ T2 · [soi ↓](#cl-t-03) | Không có `Makefile` thì DB/BE/FE không có biên nhận nào ngoài lời khai, và ba lane đó không mở được | `Lane DEVOPS · T-03 · đã xong ở commit 9699f1c · không mở lại — mở lane DEVOPS là [T-06](#sổ-task)` |
| ~~**T-04**~~ ✅ | NON-CODE | Tạo `quality/05-checklist.md` — nhà duy nhất của định nghĩa XONG khi đã có compiler | **Nạp:** `project_preparation/prompt-fullstack.md` §6.5 §6.6 §6.9 · [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) **mục 3** *(file đánh số `## 3.`, không có dấu §)* · **Đã chốt:** định nghĩa XONG của giai đoạn chưa-có-compiler đã có nhà ở rule mục 3 — file mới **tiếp nối**, không chép lại · checklist viết ở **mức luật chung**; DB/BE/FE/DEVOPS chưa mở nên phần riêng từng pha là **tầng pha** ([guideline §7](quality/00-guideline-chat-luong.md)) mở sau T-07…T-09 · **Bẫy:** §6.9 (ba thứ không thoả hiệp) là luật áp cho mọi lane ⇒ trỏ, đừng chép sang file mới · **§6.6 chỉ nạp để biết ranh giới** — nhịp đã có nhà ở rule mục 4 và [guideline §6](quality/00-guideline-chat-luong.md) cấm mở nhịp thứ hai ⇒ cấm viết mục *"trước deploy thì…"*, nhịp vận hành là lane DEVOPS (T-06) · **§6.5 có 7 vế không cùng hạng**: 4 vế áp mọi task, 3 vế mở đầu bằng *"…thì"* chỉ áp khi chạm DB/endpoint/UI ⇒ checklist phải tách hai nhóm · đọc [F-23](finding.md#f-23) 🔴 trước khi gõ — nó chạm đúng rule mục 3 và `CLAUDE.md` §7 mà ô này nạp | T-03 | — | `test -e quality/05-checklist.md` không kêu; `grep -c '^- \[ \]' quality/05-checklist.md` ra **đúng 7** (= 7 vế §6.5, **không** phải ngưỡng dưới); `awk '/tầng 1/{a=1}/happy/{b=1}/down/{c=1}/sinh lại type/{d=1}/768/{e=1}/tiếng Việt/{f=1}/truy vết/{g=1}END{print a+b+c+d+e+f+g}' quality/05-checklist.md` in ra `7`; dòng "Định nghĩa XONG khi đã có compiler" ở `CLAUDE.md` §2 hết ⚠️ · **đỏ khi:** đếm ra ≠ 7, hoặc `awk` in ra < 7 ⇒ có mục bịa hoặc thiếu vế §6.5 | 🤖 · [bảng soi ↓](#owner-t-04) | ⬜ T3 · [soi ↓](#cl-t-04) | Mỗi lane tự định nghĩa "xong" theo cách riêng ⇒ đánh ✅ khi hết giờ chứ không khi có bằng chứng | `Lane NON-CODE · T-04 · grep -n 'T-04' task.md · chỉ chạm quality/** và đúng một dòng CLAUDE.md §2 · xong checklist thì DỪNG, chưa đụng tới task.md` |
| **T-05** | NON-CODE | Tạo `project_preparation/00-scope.md` — nhà duy nhất của phạm vi bán và giá món | **Nạp:** `prompt-fullstack.md` §3.1 §3.2 · **Bẫy:** giá và thành phần suất bán là **quyền của người dùng**; chỗ nào tài liệu chưa chốt thì ghi một dòng `GIẢ ĐỊNH:` kèm mức rủi ro rồi hỏi, đừng tự chốt | — | — | `test -e project_preparation/00-scope.md` không kêu; `grep -c '^\| ' project_preparation/00-scope.md` ra `>= 8`; dòng "Phạm vi & giá món" ở `CLAUDE.md` §2 hết ⚠️ | 👤 *(giá món là quyền người dùng, [CLAUDE.md §7](CLAUDE.md))* · [bảng soi ↓](#owner-t-05) | ⬜ T3 · [soi ↓](#cl-t-05) | Giá món sống ở nhiều chỗ ⇒ backend tính một giá, menu hiện một giá, khách trả giá thứ ba | |
| **T-06** | DEVOPS | Mở lane DEVOPS: tạo `.claude/rules/lane-devops.md` có `paths:` trỏ `Makefile`, `deploy/**`, `.env*` | **Nạp:** [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) §6 · `prompt-fullstack.md` §6.9 · **Bẫy:** luật "không deploy trong giờ bán" mất đi giữa phiên là gây hỏng ⇒ nhà của nó là `CLAUDE.md`, không phải rule này | T-03 | — | `head -6 .claude/rules/lane-devops.md` in ra frontmatter `paths:`; dòng DEVOPS ở `CLAUDE.md` §1 hết ⚠️ | 🤖 · [bảng soi ↓](#owner-t-06) | ⬜ T3 · [soi ↓](#cl-t-06) | Lane deploy không có luật riêng ⇒ phiên nào đó đẩy bản mới lúc 7h sáng, quán đang đông | |
| **T-07** | DB | Mở lane DB: tạo `.claude/rules/lane-db.md` và thư mục `design/data_base/` | **Nạp:** [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) §6 · `prompt-fullstack.md` §6.2 (bất biến I1–I8) · **Bẫy:** bất biến nào chưa có cơ chế bảo vệ phải đánh ⚠️ **ngay trong bảng**, đừng để nó trông như đã xong | T-03 | — | `head -6 .claude/rules/lane-db.md` in ra frontmatter `paths:`; `test -e design/data_base` không kêu; dòng DB ở `CLAUDE.md` §1 hết ⚠️ | 🤖 · [bảng soi ↓](#owner-t-07) | ⬜ T3 · [soi ↓](#cl-t-07) | Migration viết ra mà không lane nào sở hữu ⇒ hai phiên sửa cùng một file `.sql` đã chạy, dữ liệu lệch không lùi được | |
| **T-08** | BE | Mở lane BE: tạo `.claude/rules/lane-be.md` và thư mục `design/backend/` | **Nạp:** [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) §6 · `prompt-fullstack.md` §4 (11 ràng buộc) · **Bẫy:** "giá luôn tính ở backend trong một hàm duy nhất" là ràng buộc kiến trúc ⇒ trỏ tới §4, đừng diễn giải lại bằng lời của mình | T-07 | — | `head -6 .claude/rules/lane-be.md` in ra frontmatter `paths:`; dòng BE ở `CLAUDE.md` §1 hết ⚠️ | 🤖 · [bảng soi ↓](#owner-t-08) | ⬜ T3 · [soi ↓](#cl-t-08) | Không có lane BE thì hàm tính giá không có chủ, và tiền thu sai chỉ lộ ra khi đối chiếu két cuối tháng | |
| **T-09** | FE | Mở lane FE: tạo `.claude/rules/lane-fe.md` và thư mục `design/frontend/` | **Nạp:** [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) §6 · `prompt-fullstack.md` §3.7 §7 pha 4 · **Bẫy:** pha 4 **không** được đổi hợp đồng API; cần đổi ⇒ ghi một dòng finding gửi ngược về lane BE | T-08 | — | `head -6 .claude/rules/lane-fe.md` in ra frontmatter `paths:`; dòng FE ở `CLAUDE.md` §1 hết ⚠️ | 🤖 · [bảng soi ↓](#owner-t-09) | ⬜ T3 · [soi ↓](#cl-t-09) | FE tự đoán hình dạng API ⇒ gõ tay type, lệch hợp đồng, lỗi chỉ lộ ra trên máy khách | |
| **T-10** | NON-CODE | Sửa 8 con trỏ hụt trong `project_preparation/prompt-fullstack.md` thành ⚠️ + mã task | **Nạp:** [finding.md#f-02](finding.md#f-02) · [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) §5.1 · **Bẫy:** đừng tạo file rỗng cho con trỏ giải được — file rỗng trông như đã có nhà; đánh ⚠️ và trỏ mã task tạo ra nó | T-04, T-05 | [F-02](finding.md#f-02) | Vòng lặp §5.1 chạy trên `project_preparation/prompt-fullstack.md` in ra rỗng, hoặc mỗi dòng in ra đều có ⚠️ + mã task tại chỗ trỏ | 🤖 · [bảng soi ↓](#owner-t-10) | ⬜ T3 · [soi ↓](#cl-t-10) | Phiên đọc file này đi tìm `design/backend/01-thiet-ke.md`, không thấy, rồi **tự tạo** một cấu trúc khác — im lặng, không lệnh nào đỏ | |
| ~~**T-11**~~ | NON-CODE | Thêm `"CLAUDE.md"` và `".claude/rules/**"` vào `paths:` của `.claude/rules/quan-ly-du-an.md` | **Nạp:** [finding.md#f-03](finding.md#f-03) · **Bẫy:** đây là đổi kiến trúc file do người dùng chốt ⇒ hỏi người dùng một câu trước khi sửa, đừng tự đổi | — | [F-03](finding.md#f-03) | `head -10 .claude/rules/quan-ly-du-an.md` ra **6 mục `paths:`**, hai mục đầu `"CLAUDE.md"` + `".claude/rules/**"` ✅ · `grep -o '^### F-[0-9]*' finding.md \| sort \| uniq -d` ra **rỗng** ✅ → đóng **F-03**, mở **F-06** | 👤 *(đổi kiến trúc file owner đã chốt)* · [bảng soi ↓](#owner-t-11) | ⬜ T3 · [soi ↓](#cl-t-11) | Phiên mở lane sửa `CLAUDE.md` §1 mà không được nạp quy trình mở lane ⇒ mở nửa vời: sửa bảng nhưng không tạo rule, không tạo dòng task | |
| **T-12** | NON-CODE | Cắt ranh giới hai nhà theo [F-04](finding.md#f-04): rule §1.1 giữ *viết thế nào*, `huong-dan-viet-task-md.md` Phần V giữ *vì sao có ô này*; rule §7 và Phần IV gộp về một bản | **Nạp:** [finding.md#f-04](finding.md#f-04) mục *Cách sửa đề xuất* · [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) §1.1 §7 · **Đã chốt:** rule thắng khi lệch — nó là file `paths:` tự nạp đúng lúc sửa sổ · **Bẫy:** đừng gộp bằng cách xoá bớt chữ ở một bên; bên nào giữ vế nào phải nói ra trong [CLAUDE.md §2](CLAUDE.md), nếu không lần sau lại mọc bản thứ hai | — | — | Chạy **hai lệnh ở mục *Lệnh tái hiện* của [F-04](finding.md#f-04)** — file này không chép lại chúng: mỗi lệnh phải ra `>= 1` trên **một** file và `0` trên file kia (hiện ra `>= 1` trên cả hai) → đóng **[F-04](finding.md#f-04)** | 👤 *(sửa luật ở `CLAUDE.md` §2 và rule có `paths:` rộng)* · [bảng soi ↓](#owner-t-12) | ⬜ T3 · [soi ↓](#cl-t-12) | Hai bản đặc tả trôi khỏi nhau trong im lặng: phiên viết dòng task tin bản nó đọc trước, và chỗ lệch chỉ lộ ra khi tình cờ có ai mở cả hai file trong một phiên | `Lane NON-CODE · T-12 · grep -n 'T-12' task.md · chỉ chạm .claude/rules/quan-ly-du-an.md, project_preparation/huong-dan-viet-task-md.md, CLAUDE.md · xong ba file thì DỪNG, không đụng task.md` |
| **T-13** | NON-CODE | Làm bốn lệnh tự rà ở rule §5.2 đáng tin theo [F-05](finding.md#f-05): thoát dấu ngăn cột ở ô biên nhận T-05, thêm phép đếm cột, siết mẫu dò finding | **Nạp:** [finding.md#f-05](finding.md#f-05) · [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) §5.2 · **Bẫy:** mẫu grep `'^` + dấu ngăn + `'` là thứ phân biệt dòng bảng với dòng thường — thoát nó, đừng bỏ nó | — | — | Lệnh ở mục *Lệnh tái hiện* của [F-05](finding.md#f-05) in ra **rỗng** (mọi dòng task đủ 10 cột) và có mặt trong rule §5.2; lệnh dò finding bỏ rơi của §5.2 không còn in mã hai chữ số nào không có trong bảng → đóng **[F-05](finding.md#f-05)** | 🤖 · [bảng soi ↓](#owner-t-13) | ⬜ T3 · [soi ↓](#cl-t-13) | Bốn lệnh tự rà của sổ đọc theo vị trí cột: một dòng vỡ cột là chúng đọc nhầm ô mà vẫn báo xanh — sổ trông sạch trong khi không ai kiểm gì | `Lane NON-CODE · T-13 · grep -n 'T-13' task.md · chỉ chạm task.md dòng T-05 và rule §5.2 · xong hai chỗ đó thì DỪNG, không rà lại nội dung task khác` |
| ~~**T-14**~~ | NON-CODE | Mở nhà cho luật *báo cáo thay đổi*: tạo `.claude/rules/bao-cao-thay-doi.md`, thêm phần **Sửa ở đâu** vào mọi ô `Owner kiểm tra`, nối con trỏ ở `CLAUDE.md` §2 §4 và rule §1.1 §4 §5.2 | **Nạp:** [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) §1.1 §4 §5.2 · [CLAUDE.md](CLAUDE.md) §2 §4 §8 · **Đã chốt:** owner yêu cầu thấy *file nào đổi + đổi chỗ nào*, kèm link bấm được — 2026-08-22 · **Bẫy:** đường dẫn **chưa tồn tại** phải viết backtick, **không** viết link markdown, nếu không vòng lặp con trỏ §5.1 báo `TRỎ HỤT` | — | — | `test -e .claude/rules/bao-cao-thay-doi.md` không kêu; ba lệnh **(b) (c) (d)** ở [.claude/rules/bao-cao-thay-doi.md](.claude/rules/bao-cao-thay-doi.md) §3 — dòng này **không chép lại** chúng: (b) in ra **rỗng**, (c) ra hai số bằng nhau, (d) không dòng `TRỎ HỤT` nào; `wc -l < CLAUDE.md` vẫn `<= 120` và `awk 'length > 400' CLAUDE.md` rỗng | 👤 *(sửa luật ở `CLAUDE.md` §4 — vế đánh ✅ đổi từ ba thành bốn, áp cho mọi phiên sau)* · [bảng soi ↓](#owner-t-14) | ⬜ T3 · [soi ↓](#cl-t-14) | Owner đọc xong một phiên vẫn không biết nó đã đụng vào đâu ⇒ phải tự mở `git diff` từng lần, và lần nào bận thì thay đổi trôi qua không ai soi | `Lane NON-CODE · T-14 · grep -n 'T-14' task.md · chỉ chạm .claude/rules/bao-cao-thay-doi.md, task.md, .claude/rules/quan-ly-du-an.md, CLAUDE.md · xong bốn file thì DỪNG, chưa viết hook` |
| **T-15** | NON-CODE | Cưỡng chế bảng thay đổi bằng hook `Stop` trong `.claude/settings.json` — luật chữ ở rule mới chỉ là lời đề nghị | **Nạp:** [.claude/rules/bao-cao-thay-doi.md](.claude/rules/bao-cao-thay-doi.md) §1 §3 · [CLAUDE.md §8](CLAUDE.md) · **Đã chốt:** [CLAUDE.md §8](CLAUDE.md) — luật cần **chắc chắn** xảy ra thì nhà của nó là hook, không phải câu chữ · **Bẫy:** `.claude/settings.json` **chưa có chủ** ở bảng lane `CLAUDE.md` §1 ⇒ task này phải sửa kèm **đúng một dòng** NON-CODE ở §1; và hook chặn (exit 2) mỗi lần kết phiên là cách nhanh nhất làm owner tắt hook — bản đầu chỉ **nhắc**, đừng chặn | T-14 | [F-17](finding.md#f-17) | `test -e .claude/settings.json` không kêu; `python3 -c 'import json;json.load(open(".claude/settings.json"))'` không kêu; chạy tay lệnh trong hook khi cây bẩn thì in ra danh sách file đổi, khi cây sạch thì im | 👤 *(hook chạy ở **mọi** phiên, hỏng là hỏng toàn cục)* · [bảng soi ↓](#owner-t-15) | ⬜ T2 · [soi ↓](#cl-t-15) | Luật báo cáo sống bằng thiện chí: phiên nào quên là owner mất đúng phiên đó, mà không dấu hiệu nào báo là đã mất | `Lane NON-CODE · T-15 · grep -n 'T-15' task.md · chỉ chạm .claude/settings.json và đúng một dòng CLAUDE.md §1 · hook chỉ NHẮC không CHẶN · xong thì DỪNG` |
| **T-16** | NON-CODE | Thêm hai lệnh rà tính duy nhất của mã finding vào rule §5.2: `uniq -d` trên `^### F-` và đối chiếu số mục với số dòng bảng | **Nạp:** [finding.md#f-06](finding.md#f-06) · [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) §5.2 · **Đã chốt:** hậu quả đã dọn ở T-11, task này chỉ dựng **cơ chế** chặn tái phát · **Bẫy:** [F-05](finding.md#f-05) nói chính bốn lệnh ở §5.2 đang không đáng tin ⇒ làm sau [T-13](task.md), đừng thêm lệnh mới vào một mục đang hỏng | T-13 | [F-06](finding.md#f-06) | `grep -c '^grep -o' .claude/rules/quan-ly-du-an.md` tăng thêm `1`; chạy khối §5.2 trên `git show 34b3171:finding.md` phải **bắt được** hai mã trùng → đóng **F-06** | 🤖 *(chỉ thêm lệnh rà, không đổi luật)* · [bảng soi ↓](#owner-t-16) | ⬜ T3 · [soi ↓](#cl-t-16) | Hai mục cùng mã trong sổ lỗi ⇒ đóng một mục còn mục kia vẫn 🔴, và bài học bị treo nhầm nguyên nhân | `Lane NON-CODE · T-16 · grep -n 'T-16' task.md · chỉ chạm rule §5.2 · xong hai lệnh thì DỪNG, không rà lại nội dung finding` |
| ~~**T-18**~~ ✅ | NON-CODE | Tạo `quality/00-guideline-chat-luong.md` — nhà duy nhất của câu hỏi *"đầu ra có TỐT không"*: thang biên nhận T0–T3, năm trục đo, luật biên nhận âm; nối vào khung bằng `CLAUDE.md` §1 §2 và `paths:` của rule | **Nạp:** [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) §3 §4 · [CLAUDE.md §2](CLAUDE.md) · **Đã chốt:** định nghĩa XONG ở rule §3 **không** chuyển nhà — file mới đo câu hỏi khác, XONG là quy trình, TỐT là đầu ra · **Bẫy:** đặt trần từng mục mà không kèm lệnh đếm từng mục là lặp lại đúng [F-08](finding.md#f-08) | — | — | `test -e quality/00-guideline-chat-luong.md` không kêu · `wc -l < quality/00-guideline-chat-luong.md` ra `<= 115` — **đỏ khi** file phình quá trần · lệnh đếm dòng **từng mục** ở §8 của chính file ra rỗng — **đỏ khi** một mục vượt 18 dòng (*đã thấy đỏ thật*: §7 từng 22 dòng, phải cắt bảng 6 pha thành đoạn văn) · vòng lặp con trỏ [rule §5.1](.claude/rules/quan-ly-du-an.md) chạy với tiền tố `quality/` ra rỗng — **đỏ khi** một link trong file trỏ hụt · `grep -c "quality/00-guideline" CLAUDE.md` ra `1` — **đỏ khi** nhà mới không được §2 trỏ tới · `grep -c "quality/" .claude/rules/quan-ly-du-an.md` ra `>= 1` ở khối `paths:` — **đỏ khi** phiên chạm `quality/` không được nạp sổ tay | 👤 *(sửa luật ở `CLAUDE.md` §1 §2 và `paths:` của rule — rule §1.2b)* · [bảng soi ↓](#owner-t-18) | ⬜ T3 · [soi ↓](#cl-t-18) | Sổ xanh hết mà không ai chứng minh được đầu ra **dùng được**: quán nhận về một chồng tài liệu đúng hình dạng, phiên sau vẫn phải hỏi chủ quán lại từ đầu | `Lane NON-CODE · T-18 · đã xong ở commit 1e3c963 · không mở lại` |
| **T-19** | NON-CODE | Tầng pha đầu tiên: tạo `quality/01-pha-0-ba.md` — chất lượng của **pha 0 · BA**, kế thừa §3 §4 §5 của guideline chung bằng con trỏ, chỉ thêm mệnh đề riêng của pha, lệnh đo riêng, và **ranh giới pha** | **Nạp:** [quality/00-guideline-chat-luong.md](quality/00-guideline-chat-luong.md) §7 · [project_preparation/prompt-fullstack.md](project_preparation/prompt-fullstack.md) §7 dòng `**0 · BA**` · **Đã chốt:** tầng pha **cấm chép** §3 §4 §5, chỉ được trỏ — chép là đẻ nhà thứ hai · **Bẫy:** nhắc tên bảng dữ liệu là đã lấn pha 2; ranh giới đó chính là thứ file này phải đo | T-02 | — | `test -e quality/01-pha-0-ba.md` không kêu · `grep -c "đỏ khi" quality/01-pha-0-ba.md` ra `>= 4` — **đỏ khi** có biên nhận không khai vế âm · `grep -c "00-guideline-chat-luong" quality/01-pha-0-ba.md` ra `>= 1` — **đỏ khi** file tự đứng một mình thay vì kế thừa · `grep -c "biên nhận âm" quality/01-pha-0-ba.md` ra `0` — **đỏ khi** §5 bị chép lại thay vì trỏ | 👤 *(task đầu tiên của tầng pha, đặt tiền lệ cho 5 pha còn lại — rule §1.2b)* · [bảng soi ↓](#owner-t-19) | ⬜ T3 · [soi ↓](#cl-t-19) | Mỗi pha tự nghĩ ra tiêu chuẩn riêng ⇒ đầu ra pha 0 tốt hay xấu thành chuyện cảm tính, và pha 1 xây lên trên nó không biết mình đang đứng trên cái gì | `Lane NON-CODE · T-19 · grep -n "T-19" task.md · chỉ chạm quality/01-pha-0-ba.md · xong file pha 0 thì DỪNG, năm pha còn lại là task khác` |
| **T-20** | NON-CODE | Tầng step — đưa **vế `đỏ khi`** vào đặc tả ô `Đầu ra kiểm chứng được` ở rule §1.1, và cho vế 2 của rule §3 trỏ sang thang T0–T3 thay vì dừng ở chữ "hình dạng" | **Nạp:** [quality/00-guideline-chat-luong.md](quality/00-guideline-chat-luong.md) §3 §5 · [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) §1.1 §3 · **Đã chốt:** rule **trỏ** sang thang, không chép thang · **Bẫy:** chỉ chạm 1 file — sửa luôn 16 dòng `task.md` là vượt kích cỡ [§6](CLAUDE.md), đó là T-21 | — | [F-13](finding.md#f-13) *(mở phần lệnh áp dụng, T-21 đóng)* | `grep -c "đỏ khi" .claude/rules/quan-ly-du-an.md` ra `>= 2` — **đỏ khi** luật được nhắc mà không vào đặc tả ô · `grep -c "00-guideline-chat-luong" .claude/rules/quan-ly-du-an.md` ra `>= 1` — **đỏ khi** vế 2 của §3 vẫn dừng ở "hình dạng" · `wc -l < CLAUDE.md` ra `<= 120` — **đỏ khi** luật bị nhét nhầm vào `CLAUDE.md` | 👤 *(sửa rule có `paths:` rộng — rule §1.2b)* · [bảng soi ↓](#owner-t-20) | ⬜ T3 · [soi ↓](#cl-t-20) | Luật chất lượng nằm trong `quality/` mà không có đường vào ô biên nhận ⇒ phiên sau vẫn viết biên nhận không đỏ được, và guideline thành file không ai áp | `Lane NON-CODE · T-20 · grep -n "T-20" task.md · chỉ chạm .claude/rules/quan-ly-du-an.md · xong §1.1 + §3 thì DỪNG, chưa đụng 16 dòng task.md` |
| **T-21** | NON-CODE | Áp vế `đỏ khi` xuống **mọi** dòng đang có trong `task.md`: mỗi ô `Đầu ra kiểm chứng được` khai rõ trạng thái hỏng nào làm nó đỏ | **Nạp:** [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) §1.1 *(sau T-20)* · [quality/00-guideline-chat-luong.md](quality/00-guideline-chat-luong.md) §5 · **Đã chốt:** không đổi lệnh đang có, chỉ **thêm** vế âm — đổi lệnh là đổi phạm vi task cũ · **Bẫy:** ba khuôn biên nhận giả ở §5 — gặp ngưỡng dưới trên thứ dễ đẻ thì ghi finding, đừng lặng lẽ sửa ngưỡng | T-20 | [F-13](finding.md#f-13) | Hai số phải bằng nhau: `grep -c "^\| ~*\*\*T-" task.md` và `grep "^\| ~*\*\*T-" task.md \| grep -c "đỏ khi"` — **đỏ khi** còn một dòng task chưa khai vế âm · khối lệnh tự rà [rule §5.2](.claude/rules/quan-ly-du-an.md) im — **đỏ khi** việc thêm chữ làm vỡ cột | 🤖 *(việc cơ khí, luật đã chốt ở T-20)* · [bảng soi ↓](#owner-t-21) | ⬜ T3 · [soi ↓](#cl-t-21) | Guideline có luật, rule có đặc tả, mà 16 dòng cũ vẫn xanh giả ⇒ luật mới chỉ áp cho task tương lai và repo giữ nguyên vùng mù đang có | `Lane NON-CODE · T-21 · grep -n "T-21" task.md · chỉ chạm task.md · xong khi hai số bằng nhau thì DỪNG` |
| ~~**T-22**~~ ✅ | NON-CODE | Tạo `.claude/rules/chat-luong-finding.md` — nhà duy nhất của **khuôn một mục `### F-xx`** (4 vế khi mở, 6 vế khi đóng) và **2 cổng lệnh** của sổ lỗi; nối vào khung bằng đúng một hàng `CLAUDE.md` §2 | **Nạp:** phần mở đầu [finding.md](finding.md) · [quality/00-guideline-chat-luong.md](quality/00-guideline-chat-luong.md) §3 §4 §5 · [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) §2 · **Đã chốt:** guideline T-18 là **tầng chung** — file này là tầng dưới, chỉ được **thêm** khuôn và lệnh, cấm chép thang T0–T3 · **Bẫy:** *ba vế để đóng* đã có nhà ở đầu `finding.md`, và *finding hay task* ở [CLAUDE.md §5](CLAUDE.md); chép một trong hai sang rule mới là lặp lại đúng [F-04](finding.md#f-04) | T-18 | — | `test -e .claude/rules/chat-luong-finding.md` không kêu · `wc -l` ra `<= 95` — **đỏ khi** file phình quá trần · lệnh đếm dòng **từng mục** ở §5 của chính file ra rỗng — **đỏ khi** một mục vượt 22 dòng (*đã thấy đỏ thật*: §3 từng 24 dòng, phải cắt hai lần) · cổng **(b)** ở §3 ra rỗng — **đỏ khi** một mục khai ✅ ĐÓNG mà không có `Bài học giữ lại` (*đã thấy đỏ thật* trên bản sao ở scratchpad, `finding.md` không bị đụng) · `grep -c 'chat-luong-finding' CLAUDE.md` ra `1` — **đỏ khi** nhà mới không được §2 trỏ tới | 👤 *(sửa luật ở `CLAUDE.md` §2 — rule §1.2b)* · [bảng soi ↓](#owner-t-22) | ⬜ T3 · [soi ↓](#cl-t-22) | Sổ lỗi phình thành chỗ than phiền: mục không tái hiện được thì không đóng được, mà không đóng được thì mã đó nằm đó mãi và mọi phiên sau đều phải đọc lại nó để kết luận *"không làm gì"* | `Lane NON-CODE · T-22 · xong ngay trong commit này · không mở lại` |
| **T-23** | NON-CODE | Vá **5 mục finding đang mở** cho cổng (a) xanh: thêm `Lệnh tái hiện.` cho F-06 · `Vì sao nó không tự mất đi.` cho F-13 · `Chưa đề xuất được vì:` cho F-07, F-08, F-12 | **Nạp:** [.claude/rules/chat-luong-finding.md](.claude/rules/chat-luong-finding.md) §1 §3 · **Đã chốt:** F-07, F-08, F-12 là **kiến trúc chờ owner**, nên chúng dùng vế thoát `Chưa đề xuất được vì:` chứ **không** bịa ra cách sửa · **Bẫy:** đừng viết vế cho có — vế `Lệnh tái hiện.` của F-06 phải là lệnh chạy được **hôm nay**, chạy thử trước khi dán | T-22 | — | Cổng **(a)** ở [rule §3](.claude/rules/chat-luong-finding.md) ra **rỗng** — **đỏ khi** còn một mục 🔴 thiếu 1 trong 4 vế (hiện đỏ với 5 mã: F-06, F-07, F-08, F-12, F-13); và `git show HEAD -- finding.md` chỉ có dòng `+`, không dòng `-` nào — **đỏ khi** phiên xoá nội dung cũ để lấy vế mới cho nhanh | 🤖 *(khuôn đã chốt ở T-22, việc còn lại là cơ khí)* · [bảng soi ↓](#owner-t-23) | ⬜ T3 · [soi ↓](#cl-t-23) | Cổng vừa dựng đã đỏ ngay từ ngày đầu; đỏ vĩnh viễn hai lần thì phiên thứ ba học cách bỏ qua nó, và luật khuôn finding chết trong im lặng | `Lane NON-CODE · T-23 · grep -n 'T-23' task.md · chỉ chạm finding.md · xong khi cổng (a) rỗng thì DỪNG, không sửa nội dung mệnh đề của mục nào` |
| ~~**T-24**~~ ✅ | NON-CODE | Thêm cột `Chất lượng` vào §Sổ task và mục §Chất lượng đầu ra — mỗi mã một bảng soi 4 cột áp [guideline](quality/00-guideline-chat-luong.md) §3 §4 §5 xuống từng task | **Nạp:** `quality/00-guideline-chat-luong.md` §3 §4 §5 §7 · `.claude/rules/chat-luong-finding.md` §3 · `.claude/rules/quan-ly-du-an.md` §1.1 §5.2 · **Đã chốt:** ô chỉ giữ dấu + tầng sàn + link, chi tiết xuống bảng soi — theo đúng tiền lệ ô `Owner kiểm tra` · **Bẫy:** thêm một cột làm lệch mọi lệnh `awk -F` dấu sổ đứng đếm ô **từ phải** ở rule §5.2 — `$(NF-4)` biên nhận thành `$(NF-5)`, `NF==12` thành `NF==13` | — | — | Ba biên nhận, chạy từ gốc repo: `awk '/^. ~*\*\*T-/ && !index($0,"[soi ↓](#cl-t-"){n++} END{print n+0}' task.md` ra `0` — **đỏ khi** một dòng task thiếu ô `Chất lượng` (*đã thấy đỏ thật* trên bản sao ở scratchpad: xoá ô của `T-05` ra `1`) · vòng lặp **THIẾU BẢNG SOI CL** ở [rule §5.2](.claude/rules/quan-ly-du-an.md) in ra **rỗng** — **đỏ khi** một mã không có mục `### cl-T-xx` (*đã thấy đỏ thật*: đổi tên `### cl-T-05` → in `THIẾU BẢNG SOI CL: T-05`) · hàng **Một nhà** ở [bảng soi cl-T-24](#cl-t-24) ra **đúng một** file là guideline — **đỏ khi** sổ task chép một hàng thang tầng thay vì trỏ (*đã thấy đỏ thật*: chép hàng `T0` vào bản sao → in ra hai file) | 👤 *(thêm cột vào khuôn dòng task — sửa luật ở rule có `paths:` rộng, rule §1.2b)* · [bảng soi ↓](#owner-t-24) | ⬜ T3 · [soi ↓](#cl-t-24) | Chất lượng đầu ra không có chỗ nào đo: phiên sau nhận một file **có mặt** mà không dùng được, và không dòng nào trong sổ nói được điều đó trước khi nó thành nợ | `Lane NON-CODE · T-24 · nạp guideline §3 §4 §5 §7 · chỉ chạm task.md, .claude/rules/quan-ly-du-an.md, quality/00-guideline-chat-luong.md · xong bảng soi thì DỪNG, không sửa nội dung task cũ` |
| **T-25** | BA | Pha 0 · Đ1: viết `design/BA/01-kenh-ban.md` — bảng **4 kênh bán**, mỗi kênh nói rõ *ai bấm* · *có gắn số bàn không* · *tiền thu ở khâu nào* | **Nạp:** [design/BA/04-yeu-cau.md](design/BA/04-yeu-cau.md) §1 hàng `Đ1` + §2 · [.claude/rules/lane-ba.md](.claude/rules/lane-ba.md) §2 §3 · `project_preparation/prompt-fullstack.md` §3.1 (đoạn *Bốn kênh bán* ngay dưới bảng — `grep -n 'Bốn kênh bán'` ra được) · **Đã chốt:** bốn kênh là `delivery` `pickup` `qr_table` `staff_pos`, §3.1 chốt **đúng bốn** — kênh thứ năm là đổi phạm vi, quyền owner ([CLAUDE.md §7](CLAUDE.md)) · **Bẫy:** ô *tiền thu ở khâu nào* nói **khâu** (quầy / khi giao / khi đặt), **không** nói số tiền — giá món chưa có nhà, [T-05](#sổ-task) mới tạo nó; và nhắc tên bảng dữ liệu là đã lấn pha 2 | — | — | Bốn lệnh, chạy từ gốc repo: `test -e design/BA/01-kenh-ban.md` — **đỏ khi** nhà của Đ1 chưa có · `grep -oE '(delivery\|pickup\|qr_table\|staff_pos)' design/BA/01-kenh-ban.md \| sort -u \| wc -l` ra **đúng `4`** — hằng số cố ý theo [rule §1.1](.claude/rules/quan-ly-du-an.md) (§3.1 chốt bốn), **đỏ khi** thiếu một kênh **hoặc** bịa kênh thứ năm · `grep -c '§3\.1\|GIẢ ĐỊNH:' design/BA/01-kenh-ban.md` ra `>= 4` — phép thử *Truy được nguồn* ở [lane-ba.md](.claude/rules/lane-ba.md) §3, **đỏ khi** một kênh không trỏ nguồn cũng không khai giả định · **lệnh ranh giới** ở [lane-ba.md](.claude/rules/lane-ba.md) §2 ra **rỗng** — dòng này không chép lại nó, **đỏ khi** một câu của pha 2/3/4 lọt vào | 👤 *(task nội dung đầu tiên của pha 0 — đặt tiền lệ cho Đ2 Đ3 và cho cả 5 pha sau, rule §1.2b)* · [bảng soi ↓](#owner-t-25) | ⬜ T3 · [soi ↓](#cl-t-25) | Bốn kênh bán là gốc của mọi thứ sau nó: pha 2 dựng bảng đơn theo số kênh, pha 3 tính tiền theo kênh. Sai một kênh ở đây thì quán thu thiếu tiền một kênh và chỉ lộ ra khi đối chiếu két | `Lane BA · T-25 · grep -n 'T-25' task.md · chỉ chạm design/BA/01-kenh-ban.md · xong bảng 4 kênh thì DỪNG, chưa vẽ sơ đồ luồng (Đ2 là task khác)` |
| ~~**T-26**~~ ✅ | NON-CODE | Vá lệnh **(e)** ở `.claude/rules/bao-cao-thay-doi.md` §3 thành vòng lặp chạy được và đưa nó vào bộ lệnh bắt buộc | **Nạp:** [finding.md#f-16](finding.md#f-16) mục *Cách sửa đề xuất* · [.claude/rules/bao-cao-thay-doi.md](.claude/rules/bao-cao-thay-doi.md) §3 · **Đã chốt:** bản vòng lặp **đã chạy thử** và nằm nguyên trong [F-16](finding.md#f-16) — dùng nó, đừng viết lại; viết lại là đẻ bản thứ hai · **Bẫy:** lệnh in rỗng cho **mọi** task chưa làm, và rỗng ở đó là **đúng** — chưa commit thì không có gì để chiếu. Không lọc theo dòng đã gạch (`^\| ~~\*\*T-`) thì nó thành 17 dòng nhiễu mỗi phiên, và nhiễu bị bỏ qua y như rỗng | — | [F-16](finding.md#f-16) | Ba lệnh: `grep -c '<path>' .claude/rules/bao-cao-thay-doi.md` ra `0` — **đỏ khi** chỗ trống còn nguyên · khối **(e)** chạy từ gốc repo **không** in mã nào của task chưa làm: `<khối e> \| grep -cE 'T-(0[3-9]\|1[0356]\|25)'` ra `0` — **đỏ khi** chưa lọc theo trạng thái dòng · `sed -n '/^## 3\./,/^## 4\./p' .claude/rules/bao-cao-thay-doi.md \| grep -c 'bắt buộc'` ra `>= 1` — **đỏ khi** (e) vẫn đứng ngoài bộ bắt buộc, đúng chỗ hụt mà F-16 mô tả | 🤖 *(thêm một lệnh rà vào rule đã có, không đổi luật nào)* · [bảng soi ↓](#owner-t-26) | ✅ T2 · [soi ↓](#cl-t-26) | Không có (e) thì [T-27](#sổ-task) phải sửa tay 15 lệnh và không cách nào biết đã sót cái nào — sót một cái là bảng soi của một task đã đóng im lặng hỏng tiếp | `Lane NON-CODE · T-26 · grep -n 'T-26' task.md · chỉ chạm .claude/rules/bao-cao-thay-doi.md §3 · xong lệnh (e) thì DỪNG, chưa sửa lệnh nào trong task.md (đó là T-27)` |
| **T-27** | NON-CODE | Ghim sha thay `HEAD` cho bảng soi của **task đã gạch**, và thêm vào [CLAUDE.md §4](CLAUDE.md) một vế: commit xong thì thay `HEAD` trong bảng soi của chính task đó bằng sha vừa tạo | **Nạp:** [finding.md#f-15](finding.md#f-15) · [.claude/rules/bao-cao-thay-doi.md](.claude/rules/bao-cao-thay-doi.md) §2 · [CLAUDE.md §4](CLAUDE.md) · **Đã chốt:** luật *đã commit ⇒ `git show <sha>`* **đã đúng sẵn** ở rule §2 — task này không viết luật mới, nó chỉ làm cho ví dụ và dữ liệu khớp luật · **Bẫy:** chỉ đổi lệnh của task **đã gạch** (12 lệnh ở `owner-T-14` `owner-T-22` `owner-T-24`); 44 lệnh còn lại thuộc task chưa làm, chưa có sha để ghim, và ghim bừa tạo ra lệnh đỏ vĩnh viễn — thứ mà `design/BA/04-yeu-cau.md` §2 gọi là *biên nhận đỏ vĩnh viễn thì phiên sau học cách bỏ qua nó* | T-26 | [F-15](finding.md#f-15) | Ba lệnh: khối **(e)** của [T-26](#sổ-task) in ra **rỗng** — **đỏ khi** còn một lệnh soi của task đã gạch in `0` dòng · `sed -n '/^### owner-T-14/,/^### owner-T-15/p' task.md \| grep -c HEAD` ra `0` — **đỏ khi** một task đã gạch còn ghim `HEAD` · `wc -l < CLAUDE.md` ra `<= 120` và `awk 'length > 400' CLAUDE.md` rỗng — **đỏ khi** vế mới làm vỡ trần §8 | 👤 *(sửa luật ở `CLAUDE.md` §4 — vế đánh ✅ áp cho mọi phiên sau, rule §1.2b)* · [bảng soi ↓](#owner-t-27) | ⬜ T3 · [soi ↓](#cl-t-27) | Owner mở bảng soi của một task đã đóng và thấy **rỗng** — trông y hệt *không lấn phạm vi*; hoặc tệ hơn, thấy diff **thật của task khác** rồi ký nhận một thay đổi mình chưa từng nhìn | `Lane NON-CODE · T-27 · grep -n 'T-27' task.md · chỉ chạm task.md, CLAUDE.md §4, .claude/rules/bao-cao-thay-doi.md §2 · xong 12 lệnh của task đã gạch thì DỪNG, không đụng lệnh của task chưa làm` |
| **T-28** | NON-CODE | Vá mẫu dò dòng task ở rule §5.2b thành `^\| ~*\*\*T-` và thêm vế thứ sáu vào quy trình mở lane §6: chỗ hụt phát hiện lúc mở lane ghi vào `finding.md`, không ghi vào file của lane | **Nạp:** [finding.md#f-19](finding.md#f-19) mục *Cách sửa đề xuất* · [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) §5.2b §6 · **Đã chốt:** khuôn `~*` đã được dùng **đúng** ở [bao-cao-thay-doi.md](.claude/rules/bao-cao-thay-doi.md) §3 lệnh (b) và (c) — chép khuôn đó, §5.2b chỉ là quên nó · **Bẫy:** vá mẫu mà bỏ vế 6 là dọn đúng một hậu quả — lane DB BE FE sẽ lặp lại nguyên xi, mỗi lane ghi chỗ hụt của mình vào `design/<lane>/` và không lane nào ngoài nó đọc được | — | [F-19](finding.md#f-19) | Ba lệnh: mẫu vá xanh khi `T-02` đã gạch — `grep -c '~\*' .claude/rules/quan-ly-du-an.md` tăng thêm `>= 1`, **đỏ khi** mẫu còn nguyên · khối §5.2b chạy trên bản sao **xoá hẳn dòng BA** in ra `LANE NỬA VỜI: ba` — **đỏ khi** bản vá nới lỏng đến mức không còn bắt được lane thật sự nửa vời · `sed -n '/^## 6\./,/^## 7\./p' .claude/rules/quan-ly-du-an.md \| grep -c '^6\. \*\*'` ra `1` và tiêu đề §6 hết chữ *năm vế* — **đỏ khi** vế 6 chưa vào quy trình, hoặc vào rồi mà tiêu đề vẫn dạy *năm* | 👤 *(sửa luật trong rule có `paths:` rộng — rule §1.2b)* · [bảng soi ↓](#owner-t-28) | ⬜ T3 · [soi ↓](#cl-t-28) | Lane BA đóng dòng task cuối cùng là lệnh §5.2b báo `LANE NỬA VỜI` cho một lane hoàn toàn lành — đỏ giả, và đỏ giả dạy phiên sau bỏ qua đúng cái lệnh canh việc mở lane | `Lane NON-CODE · T-28 · grep -n 'T-28' task.md · chỉ chạm .claude/rules/quan-ly-du-an.md §5.2b §6 · xong hai chỗ đó thì DỪNG, không rà lại lane nào` |
| **T-29** | NON-CODE | Vá lệnh của bảng `cl-T-02` cho ra được phán quyết, vá vế 3 ô biên nhận `T-02` thành lệnh có mã thoát, và sửa ví dụ khuôn `[^ )]*` ở guideline | **Nạp:** [finding.md#f-20](finding.md#f-20) mục *Cách sửa đề xuất* · [quality/00-guideline-chat-luong.md](quality/00-guideline-chat-luong.md) §5 · **Đã chốt:** cả hai bản vá **đã chạy thử** kèm vế âm, chép nguyên từ [F-20](finding.md#f-20) · **Bẫy:** sửa mỗi `cl-T-02` là dọn một dòng — khuôn `[^ )]*` là thứ 22 bảng `cl-T-xx` còn lại sẽ chép khi tới lượt chúng được đo; chỗ phải sửa cùng lúc là dòng ví dụ trong guideline | — | [F-20](finding.md#f-20) | Ba lệnh: lệnh vá của `cl-T-02` ra **đúng 2 dòng** trên repo hôm nay — **đỏ khi** ra `>= 3`, và bản sao đổi `paths:` sang `design/DB/**` phải ra `3` (*đã thử*) · vế 3 của ô biên nhận `T-02` có mã thoát: chạy nó trên bản sao đổi `paths:` phải **đỏ** — **đỏ khi** nó vẫn là `head -6` trần, vốn luôn thoát `0` · `grep -c '\[^ )\]\*' quality/00-guideline-chat-luong.md task.md` ra `0 0` — **đỏ khi** khuôn cũ còn sót chỗ nào | 🤖 *(vá lệnh đã có, không đổi thang tầng cũng không đổi luật)* · [bảng soi ↓](#owner-t-29) | ⬜ T2 · [soi ↓](#cl-t-29) | Ô `Chất lượng` của T-02 sẽ được chạy lần đầu đúng lúc có người định ký nhận — và nó luôn đỏ, nên người đó hoặc trả lại một lane lành, hoặc học cách bỏ qua cột chất lượng | `Lane NON-CODE · T-29 · grep -n 'T-29' task.md · chỉ chạm task.md (cl-T-02 + ô biên nhận T-02) và quality/00-guideline-chat-luong.md · xong ba chỗ thì DỪNG, không rà 22 bảng cl còn lại` |
| **T-30** | NON-CODE | Siết khuôn message commit ở [CLAUDE.md §4](CLAUDE.md) — tách commit **làm** một task khỏi commit **mở** task — rồi thêm cổng *sổ lệch git* vào rule §5.2 | **Nạp:** [finding.md#f-18](finding.md#f-18) mục *Cách sửa đề xuất* · [CLAUDE.md §4](CLAUDE.md) · [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) §5.2 §5.3 · **Đã chốt:** khuôn `<LANE>/ngoài-sổ:` **đã có sẵn** và đang được dùng đúng ở `0745429` và `1e3c963` — task này chỉ bắt buộc hoá nó, không phát minh khuôn mới · **Bẫy:** đừng `rebase` sửa message cũ cho sạch — nó viết lại sha, và mọi sha đã ghim trong bảng soi owner (`4e70569` `1e3c963` `c386219` `4851d17`) chết theo. Chỉ áp từ commit kế tiếp | T-27 | [F-18](finding.md#f-18) | Hai lệnh: cổng sổ-lệch-git ở [F-18](finding.md#f-18) chạy từ gốc repo in ra **rỗng** — **đỏ khi** một mã còn mở trong sổ mà git đã có commit **làm** nó (*đã thấy đỏ thật* trước [T-02](#sổ-task): in ra `T-02`) · `sed -n '/^## §4/,/^## §5/p' CLAUDE.md \| grep -c 'ngoài-sổ'` ra `>= 1` và `wc -l < CLAUDE.md` ra `<= 120` — **đỏ khi** khuôn mới chưa vào luật, hoặc vào rồi mà làm vỡ trần §8 | 👤 *(sửa luật ở `CLAUDE.md` §4 — khuôn message áp cho mọi commit sau, rule §1.2b)* · [bảng soi ↓](#owner-t-30) | ⬜ T3 · [soi ↓](#cl-t-30) | Một task xong trong git mà sổ còn mở thì bước 2 của §3 dò đúng vào nó, và phiên sau bỏ cả phiên làm lại việc đã xong — đúng chuyện vừa xảy ra với `T-02` | `Lane NON-CODE · T-30 · grep -n 'T-30' task.md · chỉ chạm CLAUDE.md §4 và .claude/rules/quan-ly-du-an.md §5.2 · xong khuôn + cổng thì DỪNG, không sửa message commit cũ` |
| **T-31** | NON-CODE | Thêm vế bắt buộc-khi-mở `**Đóng khi.**` vào khuôn §1 của `.claude/rules/chat-luong-finding.md`, kèm nhánh cổng **(c)** ở §3 cưỡng chế chính vế đó | **Nạp:** [finding.md#f-22](finding.md#f-22) mục *Cách sửa đề xuất* · [.claude/rules/chat-luong-finding.md](.claude/rules/chat-luong-finding.md) §1 §3 §5 · [quality/00-guideline-chat-luong.md](quality/00-guideline-chat-luong.md) §5 · **Đã chốt:** câu chữ của vế **đã viết sẵn** trong [F-22](finding.md#f-22) — dùng nguyên, viết lại là đẻ bản thứ hai · **Bẫy:** §3 đang **22/22 dòng**, kịch trần mục ở §5 của chính rule; thêm nhánh cổng là +1 dòng ⇒ phải **gộp** hai dòng có sẵn trong cùng commit, nới trần là chọn đường dễ. Vế mới chỉ áp cho mục mở **từ nay** — 18 mục cũ là [T-32](#sổ-task), gộp vào đây là vượt kích cỡ [§6](CLAUDE.md) | — | [F-22](finding.md#f-22) *(mở phần luật, T-32 đóng)* | Ba lệnh, chạy từ gốc repo: `sed -n '/^## 1\./,/^## 2\./p' .claude/rules/chat-luong-finding.md \| grep -c 'Đóng khi'` ra `>= 1` — **đỏ khi** vế mới chưa vào khuôn · cổng **(c)** chạy trên `finding.md` hôm nay in ra `>= 14` dòng `MỞ KHÔNG TIÊU CHÍ ĐÓNG` — **đỏ khi** in ra `0`, tức cổng viết ra mà mù trước nợ đang có · ba lệnh trần ở §5 của chính rule im và `wc -l` ra `<= 95` — **đỏ khi** vế mới làm vỡ trần | 👤 *(sửa khuôn trong rule có `paths:` — rule §1.2b)* · [bảng soi ↓](#owner-t-31) | ⬜ T3 · [soi ↓](#cl-t-31) | Mỗi finding chỉ đóng **một lần**; lệnh chứng minh chọn sau khi đã sửa thì lần đó luôn xanh, nên sổ lỗi đóng dần từng mã mà không mã nào thật sự được chứng minh | `Lane NON-CODE · T-31 · grep -n 'T-31' task.md · chỉ chạm .claude/rules/chat-luong-finding.md · xong vế + cổng (c) thì DỪNG, không sửa mục nào trong finding.md (đó là T-32)` |
| **T-32** | NON-CODE | Áp vế `**Đóng khi.**` xuống **mọi** mục 🔴 đang có trong `finding.md`: mỗi mục khai lệnh sẽ chứng minh mệnh đề hết đúng, kèm vế `đỏ khi` | **Nạp:** [.claude/rules/chat-luong-finding.md](.claude/rules/chat-luong-finding.md) §1 §3 *(sau T-31)* · [quality/00-guideline-chat-luong.md](quality/00-guideline-chat-luong.md) §5 · **Đã chốt:** chỉ **thêm** vế — cấm đổi mệnh đề hay lệnh tái hiện của mục cũ, đổi mệnh đề là đổi finding · **Bẫy:** ba khuôn biên nhận giả ở guideline §5; mục nào chưa nghĩ ra lệnh thì viết `**Chưa đóng được bằng lệnh vì:**` + lý do, đừng bịa một lệnh xanh sẵn cho đủ vế — vế bịa còn tệ hơn vế thiếu vì cổng (c) sẽ xanh | T-31 T-23 | [F-22](finding.md#f-22) | Ba lệnh: cổng **(c)** ra **rỗng** — **đỏ khi** còn một mục 🔴 chưa khai `Đóng khi.` (hiện đỏ với 14 mã) · cổng **(a)** vẫn ra **rỗng** — **đỏ khi** việc thêm vế làm hỏng bốn vế cũ · `git show HEAD -- finding.md \| grep -c '^-[^-]'` ra `0` — **đỏ khi** phiên xoá nội dung cũ để lấy chỗ cho vế mới | 🤖 *(khuôn đã chốt ở T-31, việc còn lại là cơ khí)* · [bảng soi ↓](#owner-t-32) | ⬜ T3 · [soi ↓](#cl-t-32) | Luật mới chỉ áp cho finding tương lai, còn 18 mã đang mở vẫn đóng được bằng lệnh tự chọn sau khi đã sửa — đúng vùng mù [F-22](finding.md#f-22) mô tả, ở khâu mỗi mã chỉ đi qua **một lần** | `Lane NON-CODE · T-32 · grep -n 'T-32' task.md · chỉ chạm finding.md · xong khi cổng (c) rỗng thì DỪNG, không sửa mệnh đề của mục nào` |

---

## Owner kiểm tra — bảng soi thay đổi của từng task

Một task một bảng, **ba cột theo đúng thứ tự owner đọc**: *đổi cái gì* → *lệnh nào bày nó ra* → *ở đâu*.
Cột `Owner kiểm tra` ở §Sổ task chỉ còn **dấu ai ký** và link xuống đây — `👤` = owner phải nhìn tận mắt
trước khi phiên sau đi tiếp, `🤖` = biên nhận của lane đã đủ, bảng vẫn để đó cho owner soi khi muốn
(luật chọn dấu: [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) §1.2b).

Bảng này là **lời khai trước khi làm**: task hứa sẽ chạm đúng những chỗ này. Owner đối chiếu nó với bảng
thay đổi phiên dán ra lúc kết ([.claude/rules/bao-cao-thay-doi.md](.claude/rules/bao-cao-thay-doi.md) §1)
— **lệch ra một file không có trong bảng là phiên đã lấn phạm vi**, và đó là một dòng
[finding.md](finding.md), không phải chuyện nhỏ bỏ qua. Dòng `**Đạt khi:**` dưới mỗi bảng là thứ owner
nhìn để nói *nhận* hay *trả lại*. Khuôn ba cột: [.claude/rules/bao-cao-thay-doi.md](.claude/rules/bao-cao-thay-doi.md) §2.

### owner-T-01

**Dựng bộ khung quản lý — đã ✅ ở commit `4e70569`** · ai ký: 👤

| Thay đổi cái gì | Câu lệnh để thấy thay đổi | Ở đâu |
|---|---|---|
| Bộ luật + con trỏ của mọi phiên: §1 định tuyến lane → §8 trần file | `git show 4e70569 -- CLAUDE.md` | [CLAUDE.md](CLAUDE.md) **(mới)** › §1–§8 |
| Sổ tay dài: khuôn dòng task, định nghĩa XONG, nhịp kiểm tra, lệnh tự rà | `git show 4e70569 -- .claude/rules/quan-ly-du-an.md` | [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) **(mới)** › §1–§7 |
| Sổ task rỗng + khuôn 10 cột + cách dò task tiếp theo | `git show 4e70569 -- task.md` | [task.md](task.md) **(mới)** › §Sổ task |
| Sổ lỗi + finding đầu tiên | `git show 4e70569 -- finding.md` | [finding.md](finding.md) **(mới)** › mục F-01 |

**Đạt khi:** `git show --stat 4e70569` ra **đúng 4 file**. File thứ năm ở commit đó ⇒ phiên đã lấn phạm vi, ghi [finding.md](finding.md).

### owner-T-02

**Mở lane BA** · ai ký: 👤 *(mở lane đầu tiên, đặt tiền lệ cho T-06→T-09)*

| Thay đổi cái gì | Câu lệnh để thấy thay đổi | Ở đâu |
|---|---|---|
| Nhà của lane BA + file yêu cầu pha 0, liệt kê lệnh đọc lại làm biên nhận | `git show --stat 4851d17 -- design/BA` | `design/BA/04-yeu-cau.md` **(mới)** › cả file |
| Rule riêng của lane, để phiên chạm `design/BA/**` tự được nạp luật lane | `git show 4851d17 -- .claude/rules/lane-ba.md` | `.claude/rules/lane-ba.md` **(mới)** › frontmatter `paths:` trỏ `design/BA/**` |
| Dòng BA hết ⚠️: có đường dẫn thật + gói nạp + biên nhận | `git show 4851d17 -- CLAUDE.md` | [CLAUDE.md](CLAUDE.md) §1 bảng lane › **đúng một dòng BA** |

**Đạt khi:** `CLAUDE.md` chỉ đổi **đúng một dòng**; mọi thứ khác nằm trong `design/BA/` và `.claude/rules/lane-ba.md`. Xuất hiện file thứ tư ⇒ lấn phạm vi, đừng nhận.

### owner-T-03

**Tạo `Makefile` với đích `check`** · ai ký: 👤 *(nền biên nhận của DB/BE/FE)*

| Thay đổi cái gì | Câu lệnh để thấy thay đổi | Ở đâu |
|---|---|---|
| Đích `check` gom lệnh đọc lại đang có (`wc -l`, `awk`, vòng lặp con trỏ) | `git show 9699f1c -- Makefile` | `Makefile` **(mới)** › đích `check` |

**Đạt khi:** Đọc **từng đích**: không đích nào gọi `go` hay `npm`. Hai thứ đó chưa cài — một đích đỏ ngay lần chạy đầu làm cả `Makefile` mất tin cậy, và ba lane DB/BE/FE mất nền biên nhận.

### owner-T-04

**Nhà của định nghĩa XONG khi đã có compiler** · ai ký: 🤖

| Thay đổi cái gì | Câu lệnh để thấy thay đổi | Ở đâu |
|---|---|---|
| Checklist XONG mức có compiler, tiếp nối rule §3 chứ không chép lại | `git show 97b25e0 -- quality/` | `quality/05-checklist.md` **(mới)** › cả file |
| Dòng *Định nghĩa XONG khi đã có compiler* hết ⚠️, trỏ vào nhà mới | `git show 97b25e0 -- CLAUDE.md` | [CLAUDE.md](CLAUDE.md) §2 › **đúng một dòng** bảng |

**Đạt khi:** `grep -c 'không kêu\|đã đọc lại thấy ổn\|hoàn thành đầy đủ yêu cầu\|lệnh đọc lại' quality/05-checklist.md` ra **0** — bốn cụm đó là câu đặc trưng của [rule mục 3](.claude/rules/quan-ly-du-an.md); ra `>= 1` nghĩa là đã chép, và bản chép sẽ lệch trong im lặng.

### owner-T-05

**Nhà của phạm vi bán và giá món** · ai ký: 👤 *(giá món là quyền người dùng, [CLAUDE.md §7](CLAUDE.md))*

| Thay đổi cái gì | Câu lệnh để thấy thay đổi | Ở đâu |
|---|---|---|
| Phạm vi bán + bảng giá món; chỗ tài liệu chưa chốt ghi `GIẢ ĐỊNH:` kèm mức rủi ro | `git show HEAD -- project_preparation/00-scope.md` | `project_preparation/00-scope.md` **(mới)** › cả file |
| Dòng *Phạm vi & giá món* hết ⚠️, trỏ vào nhà mới | `git show HEAD -- CLAUDE.md` | [CLAUDE.md](CLAUDE.md) §2 › **đúng một dòng** bảng |

**Đạt khi:** Soi **từng dòng** `GIẢ ĐỊNH:`: giá nào owner chưa chốt phải đứng nguyên ở `GIẢ ĐỊNH:`, không được biến thành số chắc nịch.

### owner-T-06

**Mở lane DEVOPS** · ai ký: 🤖

| Thay đổi cái gì | Câu lệnh để thấy thay đổi | Ở đâu |
|---|---|---|
| Rule riêng của lane deploy | `git show HEAD -- .claude/rules/lane-devops.md` | `.claude/rules/lane-devops.md` **(mới)** › frontmatter `paths:` trỏ `Makefile`, `deploy/**`, `.env*` |
| Dòng DEVOPS hết ⚠️ | `git show HEAD -- CLAUDE.md` | [CLAUDE.md](CLAUDE.md) §1 › **đúng một dòng** DEVOPS |

**Đạt khi:** `paths:` trỏ **đúng 3 mẫu**, và luật *không deploy trong giờ bán* **không** bị đem vào rule — luật đó mất giữa phiên là gây hỏng thật, nên nhà của nó là [CLAUDE.md](CLAUDE.md).

### owner-T-07

**Mở lane DB** · ai ký: 🤖

| Thay đổi cái gì | Câu lệnh để thấy thay đổi | Ở đâu |
|---|---|---|
| Rule riêng của lane dữ liệu | `git show HEAD -- .claude/rules/lane-db.md` | `.claude/rules/lane-db.md` **(mới)** › frontmatter `paths:` |
| Nhà của thiết kế dữ liệu | `git show --stat HEAD -- design/data_base` | `design/data_base/` **(mới)** |
| Dòng DB hết ⚠️ | `git show HEAD -- CLAUDE.md` | [CLAUDE.md](CLAUDE.md) §1 › **đúng một dòng** DB |

**Đạt khi:** Bất biến I1–I8 nào **chưa có cơ chế bảo vệ** phải mang ⚠️ ngay trong bảng — không được để nó trông như đã xong.

### owner-T-08

**Mở lane BE** · ai ký: 🤖

| Thay đổi cái gì | Câu lệnh để thấy thay đổi | Ở đâu |
|---|---|---|
| Rule riêng của lane backend | `git show HEAD -- .claude/rules/lane-be.md` | `.claude/rules/lane-be.md` **(mới)** › frontmatter `paths:` |
| Nhà của thiết kế backend | `git show --stat HEAD -- design/backend` | `design/backend/` **(mới)** |
| Dòng BE hết ⚠️ | `git show HEAD -- CLAUDE.md` | [CLAUDE.md](CLAUDE.md) §1 › **đúng một dòng** BE |

**Đạt khi:** Ràng buộc *giá luôn tính ở backend trong một hàm duy nhất* được **trỏ** tới `prompt-fullstack.md` §4, không diễn giải lại bằng lời khác — diễn giải lại là đẻ nhà thứ hai cho một ràng buộc đụng tiền.

### owner-T-09

**Mở lane FE** · ai ký: 🤖

| Thay đổi cái gì | Câu lệnh để thấy thay đổi | Ở đâu |
|---|---|---|
| Rule riêng của lane frontend | `git show HEAD -- .claude/rules/lane-fe.md` | `.claude/rules/lane-fe.md` **(mới)** › frontmatter `paths:` |
| Nhà của thiết kế frontend | `git show --stat HEAD -- design/frontend` | `design/frontend/` **(mới)** |
| Dòng FE hết ⚠️ | `git show HEAD -- CLAUDE.md` | [CLAUDE.md](CLAUDE.md) §1 › **đúng một dòng** FE |

**Đạt khi:** Rule **không** cho pha 4 đổi hợp đồng API: cần đổi thì ghi một dòng [finding.md](finding.md) gửi ngược về lane BE.

### owner-T-10

**Vá 8 con trỏ hụt — đóng [F-02](finding.md#f-02)** · ai ký: 🤖

| Thay đổi cái gì | Câu lệnh để thấy thay đổi | Ở đâu |
|---|---|---|
| Mỗi chỗ trỏ tới file chưa có được đánh ⚠️ + mã task tạo ra nó, **ngay tại chỗ trỏ** | `git show HEAD -- project_preparation/prompt-fullstack.md` | [project_preparation/prompt-fullstack.md](project_preparation/prompt-fullstack.md) › đúng 8 chỗ [F-02](finding.md#f-02) liệt kê |

**Đạt khi:** Mỗi hunk chỉ là *thêm ⚠️ + mã task*. Hunk nào đổi **nội dung** một § là việc khác lọt vào phiên — tách ra thành dòng task riêng.

### owner-T-11

**Nới `paths:` của rule quản lý — đã ✅, đóng [F-03](finding.md#f-03)** · ai ký: 👤 *(đổi kiến trúc file owner đã chốt)*

| Thay đổi cái gì | Câu lệnh để thấy thay đổi | Ở đâu |
|---|---|---|
| `paths:` nhận thêm `CLAUDE.md` và `.claude/rules/**`, để phiên mở lane được nạp quy trình §6 | `git show c386219 -- .claude/rules/quan-ly-du-an.md` | [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) › frontmatter `paths:` › thêm **đúng 2 dòng** |

**Đạt khi:** Đúng **hai** dòng `paths:` được thêm, không dòng luật nào bị sửa kèm.

### owner-T-12

**Cắt ranh giới hai nhà — đóng [F-04](finding.md#f-04)** · ai ký: 👤 *(sửa luật ở `CLAUDE.md` §2 và rule có `paths:` rộng)*

| Thay đổi cái gì | Câu lệnh để thấy thay đổi | Ở đâu |
|---|---|---|
| Rule giữ *viết thế nào*; §7 và Phần IV gộp về một bản | `git show HEAD -- .claude/rules/quan-ly-du-an.md` | [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) › §1.1 + §7 |
| Guideline giữ *vì sao có ô này* | `git show HEAD -- project_preparation/huong-dan-viet-task-md.md` | [project_preparation/huong-dan-viet-task-md.md](project_preparation/huong-dan-viet-task-md.md) › Phần IV + Phần V |
| Nói ra bên nào giữ vế nào, nếu không lần sau lại mọc bản thứ hai | `git show HEAD -- CLAUDE.md` | [CLAUDE.md](CLAUDE.md) §2 › **đúng 2 dòng** bảng |

**Đạt khi:** `git show --stat HEAD` ra **đúng 3 file**, và `CLAUDE.md` chỉ đổi hai dòng bảng §2 — **không** thêm mục mới (trần §8).

### owner-T-13

**Làm bốn lệnh tự rà đáng tin — đóng [F-05](finding.md#f-05)** · ai ký: 🤖

| Thay đổi cái gì | Câu lệnh để thấy thay đổi | Ở đâu |
|---|---|---|
| Thoát dấu ngăn cột trong ô biên nhận, để dòng đủ 10 cột trở lại | `git show HEAD -- task.md` | [task.md](task.md) › **đúng dòng T-05**, ô `Đầu ra kiểm chứng được` |
| Thêm phép đếm cột + siết mẫu dò finding thành hai chữ số có biên | `git show HEAD -- .claude/rules/quan-ly-du-an.md` | [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) › §5.2 |

**Đạt khi:** Diff của `task.md` chỉ chạm **một** dòng T-05. Chạm dòng thứ hai nghĩa là phiên đã rà lại nội dung task khác — việc đó không nằm trong dòng này.

### owner-T-14

**Mở nhà cho luật báo cáo thay đổi — đã ✅** · ai ký: 👤 *(sửa luật ở `CLAUDE.md` §4 — vế đánh ✅ đổi từ ba thành bốn, áp cho mọi phiên sau)*

| Thay đổi cái gì | Câu lệnh để thấy thay đổi | Ở đâu |
|---|---|---|
| Khuôn bảng thay đổi 5 cột, khuôn bảng soi của owner, lệnh tự rà — `paths: **` nên nạp ở mọi phiên | `git show HEAD -- .claude/rules/bao-cao-thay-doi.md` | [.claude/rules/bao-cao-thay-doi.md](.claude/rules/bao-cao-thay-doi.md) **(mới)** › §1 §2 §3 §4 |
| Mỗi task có một bảng soi ba cột thay cho ô chữ chạy dài | `git show HEAD -- task.md` | [task.md](task.md) › §Owner kiểm tra **(mục mới)** + 16 ô `Owner kiểm tra` rút gọn |
| Ô `Owner kiểm tra` đổi đặc tả; thêm một nhịp kiểm tra và một lệnh tự rà | `git show HEAD -- .claude/rules/quan-ly-du-an.md` | [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) › §1.1 + §1.2 + §4 + §5.2 |
| Vế đánh ✅ từ **ba** lên **bốn**: thiếu bảng thay đổi ⇒ phiên chưa xong | `git show HEAD -- CLAUDE.md` | [CLAUDE.md](CLAUDE.md) › §2 **một dòng** bảng, §4 › vế **(4)** |

**Đạt khi:** Diff của `CLAUDE.md` chỉ có **2 hunk**. Hunk thứ ba nghĩa là có luật khác bị sửa kèm — luật ở `CLAUDE.md` áp cho mọi phiên sau, sửa kèm là thay đổi không ai xin phép.

### owner-T-15

**Cưỡng chế bảng thay đổi bằng hook** · ai ký: 👤 *(hook chạy ở **mọi** phiên, hỏng là hỏng toàn cục)*

| Thay đổi cái gì | Câu lệnh để thấy thay đổi | Ở đâu |
|---|---|---|
| Hook `Stop` **nhắc** phiên dán bảng thay đổi khi cây còn bẩn | `git show HEAD -- .claude/settings.json` | `.claude/settings.json` **(mới)** › khoá `hooks.Stop` |
| Ghi ra ai sở hữu `.claude/settings.json` — hiện §1 chưa có chủ | `git show HEAD -- CLAUDE.md` | [CLAUDE.md](CLAUDE.md) §1 › **đúng một dòng** NON-CODE, cột *Lane sở hữu file nào* |

**Đạt khi:** Đọc **từng lệnh** trong hook: không lệnh nào ghi file, không lệnh nào thoát mã khác `0`. Hook chặn mỗi lần kết phiên là cách nhanh nhất làm owner tắt hook — bản đầu chỉ **nhắc**.

### owner-T-16

**Bắt mã finding trùng — đóng [F-06](finding.md#f-06)** · ai ký: 🤖 *(chỉ thêm lệnh rà, không đổi luật)*

| Thay đổi cái gì | Câu lệnh để thấy thay đổi | Ở đâu |
|---|---|---|
| Hai lệnh rà tính duy nhất của mã finding: `uniq -d` trên `^### F-`, và đối chiếu số mục với số dòng bảng | `git show HEAD -- .claude/rules/quan-ly-du-an.md` | [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) › §5.2 |

**Đạt khi:** Chạy khối §5.2 mới trên `git show 34b3171:finding.md` phải **bắt được** hai mã trùng. Không bắt được nghĩa là lệnh chỉ trông như đang rà.

### owner-T-18

**Guideline chất lượng chung — tầng 1 của ba tầng** · ai ký: 👤 *(sửa luật `CLAUDE.md` §1 §2 và `paths:` của rule)*

| Thay đổi cái gì | Câu lệnh để thấy thay đổi | Ở đâu |
|---|---|---|
| Nhà mới của câu hỏi *"đầu ra có TỐT không"*: thang T0–T3, năm trục đo, luật biên nhận âm, ba cổng, khuôn kế thừa xuống pha và step | `git show 1e3c963 -- quality/` | `quality/00-guideline-chat-luong.md` **(mới)** › cả file, §1–§8 |
| Lane NON-CODE sở hữu thêm `quality/**`, và §2 có hàng trỏ nhà mới | `git show 1e3c963 -- CLAUDE.md` | [CLAUDE.md](CLAUDE.md) §1 › dòng NON-CODE, cột *Lane sở hữu file nào* · §2 › hàng ngay trên `Phạm vi & giá món` |
| Phiên chạm `quality/` được nạp sổ tay quản lý | `git show 1e3c963 -- .claude/rules/quan-ly-du-an.md` | [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) › frontmatter `paths:` |

**Đạt khi:** đúng **3** file trong commit (`git show --stat 1e3c963` ra 3 dòng); `CLAUDE.md` đổi đúng **2** dòng, không dòng nào trong §3–§8; và không câu nào của rule §3 bị chép sang file mới — `grep -c "bốn vế" quality/00-guideline-chat-luong.md` ra `0`.

### owner-T-19

**Chất lượng của pha 0 · BA — tiền lệ cho 5 pha còn lại** · ai ký: 👤 *(task đầu tiên của tầng pha)*

| Thay đổi cái gì | Câu lệnh để thấy thay đổi | Ở đâu |
|---|---|---|
| Nhà chất lượng của pha 0: mệnh đề riêng + lệnh đo riêng + ranh giới pha | `git show HEAD -- quality/01-pha-0-ba.md` | `quality/01-pha-0-ba.md` **(mới)** › cả file |
| Đoạn liệt kê 6 pha hết ⚠️ ở đúng vế pha 0 | `git show HEAD -- quality/00-guideline-chat-luong.md` | [quality/00-guideline-chat-luong.md](quality/00-guideline-chat-luong.md) §7 › vế `0 · BA` |

**Đạt khi:** file mới **không** chứa bản chép nào của §3 §4 §5 — nó trỏ; và mọi lệnh trong đó chạy được ngay khi dán, không có lệnh nào cần `Makefile` ([CLAUDE.md §7](CLAUDE.md)).

### owner-T-20

**Vế `đỏ khi` vào đặc tả ô biên nhận** · ai ký: 👤 *(sửa rule có `paths:` rộng — áp cho mọi phiên)*

| Thay đổi cái gì | Câu lệnh để thấy thay đổi | Ở đâu |
|---|---|---|
| Ô `Đầu ra kiểm chứng được` bắt buộc khai trạng thái hỏng làm nó đỏ | `git show HEAD -- .claude/rules/quan-ly-du-an.md` | [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) §1.1 › hàng `Đầu ra kiểm chứng được` |
| Vế 2 của định nghĩa XONG trỏ sang thang T0–T3 thay vì dừng ở "hình dạng" | `git show HEAD -- .claude/rules/quan-ly-du-an.md` | [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) §3 › vế 2 |

**Đạt khi:** đúng **1** file trong commit; rule dài thêm **≤ 6 dòng** (`git show --stat HEAD` cho `+6` trở xuống) — luật mới phải trỏ, không chép thang.

### owner-T-21

**Áp vế `đỏ khi` xuống mọi dòng task đang có** · ai ký: 🤖 *(cơ khí, luật đã chốt ở T-20)*

| Thay đổi cái gì | Câu lệnh để thấy thay đổi | Ở đâu |
|---|---|---|
| Mỗi ô `Đầu ra kiểm chứng được` có thêm vế âm, lệnh cũ giữ nguyên | `git show HEAD -- task.md` | [task.md](task.md) §Sổ task › **mọi** dòng `T-xx` |

**Đạt khi:** diff **chỉ thêm**, không xoá lệnh nào đang có (`git show HEAD -- task.md | grep "^-" | grep -c "grep\|test -e\|wc -l"` ra `0`); và số dòng bảng không đổi.

### owner-T-22

**Rule khuôn + cổng của sổ lỗi — tầng chất lượng của `finding.md`** · ai ký: 👤 *(sửa luật ở `CLAUDE.md` §2)*

| Thay đổi cái gì | Câu lệnh để thấy thay đổi | Ở đâu |
|---|---|---|
| Khuôn một mục `### F-xx` (4 vế mở / 6 vế đóng), 4 phép thử một mệnh đề, 2 cổng lệnh, 3 trường hợp **không** mở finding | `git show HEAD -- .claude/rules/chat-luong-finding.md` | `.claude/rules/chat-luong-finding.md` **(mới)** › §1–§5 |
| Hàng *"Cái gì đang sai"* của §2 trỏ thêm nhà của **khuôn**, không thêm hàng mới | `git show HEAD -- CLAUDE.md` | [CLAUDE.md](CLAUDE.md) §2 › **đúng một hàng**, hàng thứ hai của bảng |
| Hai dòng sổ: T-22 (việc này) và T-23 (vá 5 mục cho cổng (a) xanh) | `git show HEAD -- task.md` | [task.md](task.md) §Sổ task › hai dòng ngay dưới `T-21` · §Owner kiểm tra › hai bảng soi cuối file |

**Đạt khi:** đúng **3** file trong commit (`git show --stat HEAD` ra 3 dòng) — `finding.md` **không** có mặt, nó là đối tượng của luật chứ không phải chỗ chứa luật; `CLAUDE.md` đổi đúng **1** dòng và `wc -l < CLAUDE.md` không tăng; và rule mới **trỏ chứ không chép** phần mở đầu `finding.md` — `grep -c 'Rút không ra luật' .claude/rules/chat-luong-finding.md` ra `0` (câu đặc trưng của phần mở đầu đó; có mặt nghĩa là đã chép).

### owner-T-23

**Vá 5 mục finding cho cổng (a) xanh** · ai ký: 🤖 *(khuôn đã chốt ở T-22)*

| Thay đổi cái gì | Câu lệnh để thấy thay đổi | Ở đâu |
|---|---|---|
| F-06 có `Lệnh tái hiện.`; F-13 có `Vì sao nó không tự mất đi.`; F-07, F-08, F-12 có `Chưa đề xuất được vì:` | `git show HEAD -- finding.md` | [finding.md](finding.md) › mục `### F-06`, `### F-07`, `### F-08`, `### F-12`, `### F-13` |

**Đạt khi:** cổng (a) ra rỗng, và diff **chỉ thêm** — `git show HEAD -- finding.md | grep -c '^-[^-]'` ra `0`. Có dòng `-` nghĩa là phiên đã sửa nội dung mệnh đề cũ, việc đó không nằm trong T-23.

### owner-T-24

**Cột `Chất lượng` + bảng soi chất lượng** · ai ký: 👤 *(task đầu tiên của một loại: mọi task sau đều phải có ô này)*

| Thay đổi cái gì | Câu lệnh để thấy thay đổi | Ở đâu |
|---|---|---|
| Cột thứ 9 của sổ task + 23 mục `### cl-T-xx` mới | `git show HEAD -- task.md` | [task.md](task.md) › §Sổ task (dòng tiêu đề + 23 dòng task) và §Chất lượng đầu ra **(mới)** |
| Đặc tả ô `Chất lượng`, chỉ số đếm ô từ phải, hai lệnh tự rà mới | `git show HEAD -- .claude/rules/quan-ly-du-an.md` | [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) › §1 khuôn · §1.1 · §1.2 · §4 · §5.2 |
| Tầng step trỏ thêm sang cột mới, không chép nội dung | `git show HEAD -- quality/00-guideline-chat-luong.md` | [quality/00-guideline-chat-luong.md](quality/00-guideline-chat-luong.md) › §7 gạch đầu dòng *Tầng step* |

**Đạt khi:** `git show --stat HEAD` ra **đúng 3 file**. File thứ tư ⇒ phiên đã lấn phạm vi ([CLAUDE.md §6](CLAUDE.md)), đừng nhận.

### owner-T-25

**Pha 0 · Đ1 — bảng 4 kênh bán** · ai ký: 👤 *(task nội dung đầu tiên của pha 0, đặt tiền lệ cho Đ2 Đ3 và cả 5 pha sau)*

| Thay đổi cái gì | Câu lệnh để thấy thay đổi | Ở đâu |
|---|---|---|
| Bảng 4 kênh bán, mỗi kênh đủ ba ô *ai bấm · gắn bàn · tiền thu ở khâu nào* | `git show --stat HEAD -- design/BA/01-kenh-ban.md` | `design/BA/01-kenh-ban.md` **(mới)** › §1 bảng kênh |
| Hàng `Đ1` ở bảng đầu ra bắt buộc hết ⚠️: đường dẫn thành thật | `git show HEAD -- design/BA/04-yeu-cau.md` | [design/BA/04-yeu-cau.md](design/BA/04-yeu-cau.md) §1 › **đúng ô `Nhà của nó` của hàng `Đ1`** |

**Đạt khi:** `git show --stat HEAD` ra **đúng 2 file**, cả hai trong `design/BA/`. File thứ ba — nhất là file ngoài `design/BA/` — ⇒ lấn lane, đừng nhận.

### owner-T-26

**Lệnh (e) chạy được** · ai ký: 🤖 *(thêm một lệnh rà vào rule đã có, không đổi luật nào)*

| Thay đổi cái gì | Câu lệnh để thấy thay đổi | Ở đâu |
|---|---|---|
| Thân lệnh (e): từ hai dòng chú thích + `<path>` thành vòng lặp đọc `task.md`, lọc theo dòng đã gạch | `git show HEAD -- .claude/rules/bao-cao-thay-doi.md` | [.claude/rules/bao-cao-thay-doi.md](.claude/rules/bao-cao-thay-doi.md) §3 › khối `# e.` |
| Một câu nói rõ (a)–(e) nào **bắt buộc** chạy trước khi commit | `git show HEAD -- .claude/rules/bao-cao-thay-doi.md` | [.claude/rules/bao-cao-thay-doi.md](.claude/rules/bao-cao-thay-doi.md) §3 › đoạn văn dưới khối lệnh |

**Đạt khi:** `git show --stat HEAD` ra **đúng 1 file**. Đụng `task.md` ⇒ đã lấn sang T-27, đừng nhận.

### owner-T-27

**Ghim sha thay `HEAD`** · ai ký: 👤 *(sửa luật ở `CLAUDE.md` §4 — vế đánh ✅ áp cho mọi phiên sau)*

| Thay đổi cái gì | Câu lệnh để thấy thay đổi | Ở đâu |
|---|---|---|
| 12 lệnh của ba task đã gạch: `HEAD` → sha ghim | `git show HEAD -- task.md` | [task.md](task.md) §Owner kiểm tra › `### owner-T-14` `### owner-T-22` `### owner-T-24` |
| Một vế thêm vào bước ghi sổ: commit xong thì thay `HEAD` bằng sha vừa tạo | `git show HEAD -- CLAUDE.md` | [CLAUDE.md](CLAUDE.md) §4 › đoạn về bảng thay đổi |
| Ví dụ `owner-T-02` in trong rule đổi từ `HEAD` sang sha — chỗ phiên sau chép | `git show HEAD -- .claude/rules/bao-cao-thay-doi.md` | [.claude/rules/bao-cao-thay-doi.md](.claude/rules/bao-cao-thay-doi.md) §2 › bảng ví dụ |

**Đạt khi:** `git show --stat HEAD` ra **đúng 3 file**, và diff `task.md` **chỉ** chạm ba mục `owner-T-14` `owner-T-22` `owner-T-24`. Chạm mục thứ tư ⇒ đã đổi sha cho task chưa làm, trả lại.

### owner-T-28

**Mẫu §5.2b + vế 6 quy trình mở lane** · ai ký: 👤 *(sửa luật trong rule có `paths:` rộng)*

| Thay đổi cái gì | Câu lệnh để thấy thay đổi | Ở đâu |
|---|---|---|
| Mẫu dò dòng task: `^\| \*\*T-` → `^\| ~*\*\*T-`, chấp nhận dòng đã gạch | `git show HEAD -- .claude/rules/quan-ly-du-an.md` | [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) §5.2b › khối `for L in ba db be fe devops` |
| Vế thứ sáu của quy trình mở lane: chỗ hụt ghi vào `finding.md`, không ghi vào file lane | `git show HEAD -- .claude/rules/quan-ly-du-an.md` | [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) §6 › danh sách vế |

**Đạt khi:** `git show --stat HEAD` ra **đúng 1 file**. Đụng `design/BA/` ⇒ đã sang lane BA, trả lại.

### owner-T-29

**Vá lệnh `cl-T-02` + vế 3 biên nhận T-02** · ai ký: 🤖 *(vá lệnh đã có, không đổi thang tầng)*

| Thay đổi cái gì | Câu lệnh để thấy thay đổi | Ở đâu |
|---|---|---|
| Lệnh hàng `Đúng` của bảng chất lượng, và vế 3 ô biên nhận `T-02` | `git show HEAD -- task.md` | [task.md](task.md) › `### cl-T-02` hàng `Đúng`, và §Sổ task dòng `T-02` ô `Đầu ra kiểm chứng được` |
| Dòng ví dụ dùng khuôn `[^ )]*` — chỗ 22 bảng `cl-T-xx` còn lại sẽ chép | `git show HEAD -- quality/00-guideline-chat-luong.md` | [quality/00-guideline-chat-luong.md](quality/00-guideline-chat-luong.md) §5 › ví dụ lệnh soi |

**Đạt khi:** `git show --stat HEAD` ra **đúng 2 file**, và diff `task.md` không chạm bảng `cl-` nào ngoài `cl-T-02`.

### owner-T-30

**Khuôn message + cổng sổ-lệch-git** · ai ký: 👤 *(sửa luật ở `CLAUDE.md` §4)*

| Thay đổi cái gì | Câu lệnh để thấy thay đổi | Ở đâu |
|---|---|---|
| Khuôn message tách commit **làm** task khỏi commit **mở** task | `git show HEAD -- CLAUDE.md` | [CLAUDE.md](CLAUDE.md) §4 › đoạn `Commit: stage bằng...` |
| Cổng *sổ lệch git* thêm vào khối lệnh tự rà | `git show HEAD -- .claude/rules/quan-ly-du-an.md` | [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) §5.2 › cuối khối |

**Đạt khi:** `git show --stat HEAD` ra **đúng 2 file**, và `git log --oneline -1` của chính commit này đã theo khuôn mới.

---

### owner-T-31

**Vế `Đóng khi.` vào khuôn finding** · ai ký: 👤 *(sửa khuôn trong rule có `paths:` — rule §1.2b)*

| Thay đổi cái gì | Câu lệnh để thấy thay đổi | Ở đâu |
|---|---|---|
| Một hàng mới trong bảng khuôn: vế `**Đóng khi.**`, bắt buộc khi **mở** | `git show HEAD -- .claude/rules/chat-luong-finding.md` | [.claude/rules/chat-luong-finding.md](.claude/rules/chat-luong-finding.md) §1 › bảng khuôn, hàng sau `Cách sửa đề xuất.` |
| Nhánh cổng **(c)**: mục 🔴 không khai `Đóng khi.` thì in ra | `git show HEAD -- .claude/rules/chat-luong-finding.md` | [.claude/rules/chat-luong-finding.md](.claude/rules/chat-luong-finding.md) §3 › khối ```bash |
| Hai dòng có sẵn của §3 bị **gộp** để trả chỗ cho nhánh mới | `git show HEAD -- .claude/rules/chat-luong-finding.md \| grep '^-'` | [.claude/rules/chat-luong-finding.md](.claude/rules/chat-luong-finding.md) §3 › văn xuôi quanh khối lệnh |

**Đạt khi:** `git show --stat HEAD` ra **đúng 1 file**, và `wc -l` của rule vẫn `<= 95`. Đụng `finding.md` ⇒ đã lấn sang T-32, đừng nhận.

### owner-T-32

**Áp `Đóng khi.` xuống mục đang mở** · ai ký: 🤖 *(khuôn đã chốt ở T-31, việc còn lại là cơ khí)*

| Thay đổi cái gì | Câu lệnh để thấy thay đổi | Ở đâu |
|---|---|---|
| Mỗi mục 🔴 có thêm **một** vế `**Đóng khi.**` — không mục nào mất chữ nào | `git show HEAD -- finding.md \| grep -c '^-[^-]'` → `0` | [finding.md](finding.md) › từng mục `### F-xx` còn 🔴 |
| Mục chưa nghĩ ra lệnh dùng vế thoát, không bịa lệnh | `git show HEAD -- finding.md \| grep '^+\*\*Chưa đóng được bằng lệnh vì:'` | [finding.md](finding.md) › mục kiến trúc chờ owner (`F-07` `F-08` `F-12`) |

**Đạt khi:** `git show --stat HEAD` ra **đúng 1 file**, chỉ có dòng `+`. Bảng khuôn ở rule bị đụng ⇒ task này đang sửa luật, trả lại.

## Chất lượng đầu ra — bảng soi chất lượng của từng task

Ô `Chất lượng` ở §Sổ task giữ **đúng ba** thứ, không hơn: **dấu trạng thái** · **tầng sàn** · link xuống
đây. Dấu: `⬜` chưa đo tới sàn · `✅` đạt sàn (ngày ghi trong bảng) · `❌` trả lại (kèm mã finding).
Tầng `T0–T3`, năm trục đo, và luật biên nhận âm nằm ở
[quality/00-guideline-chat-luong.md](quality/00-guideline-chat-luong.md) §3 §4 §5 — file này **không**
chép lại chúng, chỉ áp xuống từng mã task.

Ba cột hỏi **ba câu khác nhau**, đừng gộp: `Đầu ra kiểm chứng được` hỏi *hiện trạng đúng chưa* (tầng step,
guideline §7) · `Owner kiểm tra` hỏi *vừa đổi cái gì* · bảng dưới đây hỏi *phiên sau dùng được không*.
Vì vậy lệnh trong bảng này phải **khác** lệnh ở ô biên nhận và phải **chạm ≥ 2 file** (guideline §5.2):
lệnh chỉ chạm đúng file mình vừa gõ chỉ chứng minh *"tôi đã gõ"*.

Task nào chạm [finding.md](finding.md) thì **hai cổng** ở
[.claude/rules/chat-luong-finding.md](.claude/rules/chat-luong-finding.md) §3 là một hàng bắt buộc trong
bảng của nó. Dòng `**Đã thử làm đỏ:**` là **chỗ duy nhất** ghi lại việc guideline §5 đòi — chưa thấy một
lệnh đỏ lần nào thì chưa ai biết nó đang đo cái gì, và ô đó phải để `⬜` cho thật.

Dòng chốt của bảng này viết hoa — `**ĐẠT khi:**`, theo cặp ĐẠT/KHÔNG ĐẠT ở guideline §2 — **cố ý khác**
`**Đạt khi:**` của bảng soi owner: lệnh (c) ở
[bao-cao-thay-doi.md](.claude/rules/bao-cao-thay-doi.md) §3 đếm ba số phải bằng nhau bằng chuỗi
`^\*\*Đạt khi:\*\*`, viết giống nhau là 23 bảng mới làm lệnh đó ra `46` và cơ chế đếm chết trong im lặng.

### cl-T-01

**Bộ khung quản lý** · sàn **T3** · ⬜ đo tới **T2** ngày 2026-08-23, chưa diễn tập T3

| Trục §4 | Mệnh đề phải đúng | Lệnh soi (≥ 2 file, khác ô biên nhận) | Đỏ khi |
|---|---|---|---|
| Một nhà | khuôn cột của dòng task chỉ sống ở rule; `CLAUDE.md` chỉ trỏ | `grep -c 'Prompt mở session' CLAUDE.md .claude/rules/quan-ly-du-an.md` → `0` và `>= 1` | `CLAUDE.md` ra `>= 1` ⇒ khuôn có bản chép thứ hai, hai bản sẽ lệch trong im lặng |
| Đúng | mọi con trỏ trong `CLAUDE.md` giải được ra file thật | vòng lặp [rule §5.1](.claude/rules/quan-ly-du-an.md) chạy trên `CLAUDE.md` | in ra một dòng `TRỎ HỤT` |

**ĐẠT khi:** hai hàng xanh **và** một phiên mới chỉ nạp `CLAUDE.md` chọn đúng lane + đúng mã task mà không hỏi thêm câu nào. · **Đã thử làm đỏ:** ✅ 2026-08-23 — bản sao ở scratchpad, chèn `Prompt mở session` vào `CLAUDE.md` → hàng 1 ra `1` thay vì `0`, đỏ thật

### cl-T-02

**Mở lane BA** · sàn **T3** · ⬜ chưa đo

| Trục §4 | Mệnh đề phải đúng | Lệnh soi (≥ 2 file, khác ô biên nhận) | Đỏ khi |
|---|---|---|---|
| Đúng | dòng BA ở `CLAUDE.md` §1 và `paths:` của rule trỏ **cùng một** thư mục | `grep -o 'design/BA[^ )]*' CLAUDE.md .claude/rules/lane-ba.md \| sort -u` | ra hai đường dẫn khác nhau ⇒ phiên BA nạp một chỗ, sửa một chỗ khác |
| Dùng được lạnh | phiên BA mới chỉ nạp gói lane viết được quy tắc nghiệp vụ kế tiếp | diễn tập T3: mở phiên mới, chỉ nạp gói §1, đếm số câu nó phải hỏi | còn **một** câu phải hỏi người |

**ĐẠT khi:** cả hai hàng xanh — lane đầu tiên đặt tiền lệ cho T-06→T-09, sai ở đây là sai bốn lần. · **Đã thử làm đỏ:** ⬜ chưa

### cl-T-03

**`Makefile` + đích `check`** · sàn **T2** (`Makefile` được **chạy**, không phiên nào **nạp** nó) · ✅ đạt sàn T2 · đo 2026-08-23

| Trục §4 | Mệnh đề phải đúng | Lệnh soi (≥ 2 file, khác ô biên nhận) | Đỏ khi |
|---|---|---|---|
| Đủ | `check` gom đủ họ lệnh mà `CLAUDE.md` §7 khai là biên nhận thật của giai đoạn này | `grep -c 'wc -l\|awk\|grep -c\|test -e' Makefile` so với danh sách ở `CLAUDE.md` §7 | `Makefile` thiếu một họ lệnh §7 khai ⇒ `make check` xanh trong khi trần đang vỡ |
| Đúng | `make check` **đỏ được** | phá tạm một trần (thêm dòng cho `CLAUDE.md` vượt 120) → `make check` → khôi phục | vẫn ra mã thoát `0` ⇒ đích rỗng ruột ([F-11](finding.md#f-11)) |

**ĐẠT khi:** thấy `make check` đỏ **một lần** rồi xanh lại — chưa thấy đỏ thì chưa ai biết nó đo gì. · **Đủ:** `grep -c 'wc -l\|awk\|grep -c\|test -e' Makefile` ra `13`, `grep -c 'sed -n\|git log -1' Makefile` ra `5` — đủ cả 6 họ lệnh `CLAUDE.md` §7 khai. · **Đã thử làm đỏ:** ✅ 2026-08-23 — phá tạm 5 lần, mỗi lần đúng một đích in `ĐỎ` và `make` trả `Error 1`: CLAUDE.md 124 dòng · một dòng 500 byte · con trỏ hụt thêm vào `task.md` · đổi tên `### cl-T-03` · gỡ ⚠️ dòng DEVOPS ở §1. `git checkout --` khôi phục, `make check` xanh lại.

### cl-T-04

**`quality/05-checklist.md`** · sàn **T3** · ⬜ chưa đo

| Trục §4 | Mệnh đề phải đúng | Lệnh soi (≥ 2 file, khác ô biên nhận) | Đỏ khi |
|---|---|---|---|
| Một nhà | nội dung **7 vế §6.5** chỉ có một nhà trong repo là checklist; `prompt-fullstack.md` là prompt bàn giao (nguồn ngoài, chỉ đọc) | `grep -rln 'happy path' --include='*.md' --exclude-dir=reference --exclude=task.md --exclude=finding.md .` | ra **≠ `2`** file ⇒ có bản chép thứ ba; hoặc kết quả **không** có `quality/05-checklist.md` ⇒ chưa có nhà. Hai sổ đứng ngoài phạm vi quét: ô soi này và mục [F-28](finding.md#f-28) buộc phải nhắc chính chuỗi mốc, nên bản cũ tự bắt thân mình và đỏ ở cả hai nhánh |
| Đúng | dòng "Định nghĩa XONG khi đã có compiler" ở `CLAUDE.md` §2 trỏ đúng file vừa tạo | `grep -n 'quality/05-checklist.md' CLAUDE.md` và `test -e quality/05-checklist.md` | con trỏ còn ⚠️ hoặc trỏ tên khác |

**ĐẠT khi:** checklist **tiếp nối** thang [guideline §3](quality/00-guideline-chat-luong.md) ở T1/T2 chứ không thay nó (guideline §7 câu cuối). · **Đã thử làm đỏ:** ✅ 2026-08-24 — bản giả bỏ 2 vế hạng B: `grep -c` ra `5` ≠ 7 (đỏ); bản giả chèn 1 mục bịa: ra `8` ≠ 7 (đỏ); bản thật ra `7`. Lệnh *Một nhà* sau khi vá: `1` file trước khi checklist ra đời, `2` sau khi có, `3` khi dựng thêm bản chép thứ ba (thử ở scratchpad, repo không bị chạm). **Vế `awk` không đỏ được** trong phép thử này — lỗ đó là [F-29](finding.md#f-29)

### cl-T-05

**`project_preparation/00-scope.md`** · sàn **T3** · ⬜ chưa đo

| Trục §4 | Mệnh đề phải đúng | Lệnh soi (≥ 2 file, khác ô biên nhận) | Đỏ khi |
|---|---|---|---|
| Một nhà | giá món và phạm vi bán chỉ có **một** bản | `grep -rln '[0-9]\{3,\}đ\|phạm vi bán' --include='*.md' .` | ra `>= 2` file ⇒ giá sẽ lệch, và bản lệch là bản người ta đọc |
| Đúng | mọi con số trong scope là số **owner đã chốt**, không phải số phiên tự điền | đối chiếu `git log -1 --format=%ad -- project_preparation/00-scope.md` với dòng `Cập nhật` trong file | hai ngày lệch ⇒ nội dung đã đổi sau lần chốt cuối |

**ĐẠT khi:** owner ký tận mắt — đây là thứ thuộc quyền owner (`CLAUDE.md` §7), phiên chỉ chuẩn bị khung rỗng. · **Đã thử làm đỏ:** ⬜ chưa

### cl-T-06

**Mở lane DEVOPS** · sàn **T3** · ⬜ chưa đo

| Trục §4 | Mệnh đề phải đúng | Lệnh soi (≥ 2 file, khác ô biên nhận) | Đỏ khi |
|---|---|---|---|
| Đủ | đủ **năm vế** mở lane, không chỉ vế "hết ⚠️" | lệnh [§5.2b](.claude/rules/quan-ly-du-an.md) chạy trên `CLAUDE.md` + `task.md` | in ra `LANE NỬA VỜI: devops` |
| Đúng | `paths:` của rule phủ đúng file lane DEVOPS sở hữu ở `CLAUDE.md` §1 | `head -8 .claude/rules/lane-devops.md` so với ô "Lane sở hữu" dòng DEVOPS | rule phủ hẹp hơn dòng §1 ⇒ có file sửa mà luật lane không được nạp |

**ĐẠT khi:** hai hàng xanh cùng lúc — vế 4 xanh một mình là lane mở nửa vời. · **Đã thử làm đỏ:** ⬜ chưa

### cl-T-07

**Mở lane DB** · sàn **T3** · ⬜ chưa đo

| Trục §4 | Mệnh đề phải đúng | Lệnh soi (≥ 2 file, khác ô biên nhận) | Đỏ khi |
|---|---|---|---|
| Đủ | đủ năm vế mở lane | lệnh [§5.2b](.claude/rules/quan-ly-du-an.md) | in ra `LANE NỬA VỜI: db` |
| Đúng | `paths:` rule và ô "Lane sở hữu" dòng DB trỏ cùng thư mục `design/data_base/` | `grep -o 'design/data_base[^ )]*' CLAUDE.md .claude/rules/lane-db.md \| sort -u` | ra hai đường dẫn khác nhau |

**ĐẠT khi:** hai hàng xanh và dòng task DB đầu tiên đã có mặt trong sổ. · **Đã thử làm đỏ:** ⬜ chưa

### cl-T-08

**Mở lane BE** · sàn **T3** · ⬜ chưa đo

| Trục §4 | Mệnh đề phải đúng | Lệnh soi (≥ 2 file, khác ô biên nhận) | Đỏ khi |
|---|---|---|---|
| Đủ | đủ năm vế mở lane | lệnh [§5.2b](.claude/rules/quan-ly-du-an.md) | in ra `LANE NỬA VỜI: be` |
| Đúng | `paths:` rule và ô "Lane sở hữu" dòng BE trỏ cùng thư mục `design/backend/` | `grep -o 'design/backend[^ )]*' CLAUDE.md .claude/rules/lane-be.md \| sort -u` | ra hai đường dẫn khác nhau |

**ĐẠT khi:** hai hàng xanh và dòng task BE đầu tiên đã có mặt trong sổ. · **Đã thử làm đỏ:** ⬜ chưa

### cl-T-09

**Mở lane FE** · sàn **T3** · ⬜ chưa đo

| Trục §4 | Mệnh đề phải đúng | Lệnh soi (≥ 2 file, khác ô biên nhận) | Đỏ khi |
|---|---|---|---|
| Đủ | đủ năm vế mở lane | lệnh [§5.2b](.claude/rules/quan-ly-du-an.md) | in ra `LANE NỬA VỜI: fe` |
| Đúng | `paths:` rule và ô "Lane sở hữu" dòng FE trỏ cùng thư mục `design/frontend/` | `grep -o 'design/frontend[^ )]*' CLAUDE.md .claude/rules/lane-fe.md \| sort -u` | ra hai đường dẫn khác nhau |

**ĐẠT khi:** hai hàng xanh và dòng task FE đầu tiên đã có mặt trong sổ. · **Đã thử làm đỏ:** ⬜ chưa

### cl-T-10

**Vá 8 con trỏ hụt ở `prompt-fullstack.md`** · sàn **T3** · ⬜ chưa đo

| Trục §4 | Mệnh đề phải đúng | Lệnh soi (≥ 2 file, khác ô biên nhận) | Đỏ khi |
|---|---|---|---|
| Đúng | mỗi ⚠️ mới kèm một mã task **có thật** trong sổ | `for t in $(grep -o 'T-[0-9]\{2\}' project_preparation/prompt-fullstack.md \| sort -u); do grep -q "\*\*$t\*\*" task.md \|\| echo "MÃ BỊA: $t"; done` | in ra một dòng `MÃ BỊA` ⇒ ⚠️ trỏ vào một lời hứa không ai giữ |
| Rẻ để đọc | vá con trỏ **không** làm file phình thêm mục mới | `git diff --stat -- project_preparation/prompt-fullstack.md` | số dòng thêm ≫ số ⚠️ vá ⇒ phiên đã viết thêm nội dung ngoài phạm vi |

**ĐẠT khi:** vòng lặp §5.1 rỗng **và** không mã bịa nào — con trỏ hụt vá bằng mã bịa vẫn là con trỏ hụt. · **Đã thử làm đỏ:** ⬜ chưa

### cl-T-11

**`paths:` của rule + mã finding duy nhất** · sàn **T3** · ⬜ đo tới **T2** ngày 2026-08-23, chưa diễn tập T3

| Trục §4 | Mệnh đề phải đúng | Lệnh soi (≥ 2 file, khác ô biên nhận) | Đỏ khi |
|---|---|---|---|
| Đúng | mọi mã `F-xx` mà `task.md` trỏ đều có mục thật trong `finding.md` | `for f in $(grep -o 'F-[0-9]\{2\}' task.md \| sort -u); do grep -q "^### $f$" finding.md \|\| echo "MÃ BỊA: $f"; done` → rỗng | in ra một mã ⇒ sổ task trỏ vào một finding không tồn tại |
| Một nhà | `paths:` của rule phủ `CLAUDE.md` + `.claude/rules/**` nên luật tự được nạp, không phải nhớ | `head -10 .claude/rules/quan-ly-du-an.md` so với danh sách file NON-CODE sở hữu ở `CLAUDE.md` §1 | có file NON-CODE sở hữu mà `paths:` không phủ |

**ĐẠT khi:** hàng 1 rỗng — đã chạy 2026-08-23, output rỗng. Còn thiếu diễn tập T3. · **Đã thử làm đỏ:** ⬜ chưa

### cl-T-12

**Cắt ranh giới hai nhà theo [F-04](finding.md#f-04)** · sàn **T3** · ⬜ chưa đo

| Trục §4 | Mệnh đề phải đúng | Lệnh soi (≥ 2 file, khác ô biên nhận) | Đỏ khi |
|---|---|---|---|
| Một nhà | *cắt* là **chuyển** nội dung, không phải **nhân đôi** nó | `git diff --stat -- .claude/rules/quan-ly-du-an.md .claude/rules/chat-luong-finding.md` | cả hai file cùng dài thêm ⇒ đã chép, `F-04` sẽ mở lại dưới tên khác |
| Đúng | sau khi cắt, mỗi mệnh đề của `F-04` chỉ còn `>= 1` ở đúng một file | hai lệnh ở mục *Lệnh tái hiện* của [F-04](finding.md#f-04) | một lệnh còn ra `>= 1` trên **cả hai** file |

**ĐẠT khi:** `F-04` đóng kèm dòng `**Bài học giữ lại:**` nói **luật nào đổi** (rule finding §1 vế 6). · **Đã thử làm đỏ:** ⬜ chưa

### cl-T-13

**Làm lệnh tự rà §5.2 đáng tin ([F-05](finding.md#f-05))** · sàn **T3** · ⬜ chưa đo

| Trục §4 | Mệnh đề phải đúng | Lệnh soi (≥ 2 file, khác ô biên nhận) | Đỏ khi |
|---|---|---|---|
| Đúng | lệnh rà **bắt được lỗi thật**, không chỉ xanh trên bản hiện tại | chạy khối §5.2 trên `git show <sha-cũ>:task.md` (bản còn lỗi) → phải in ra dòng; chạy trên bản mới → rỗng | cả hai lần đều rỗng ⇒ lệnh không đo gì ([F-11](finding.md#f-11)) |
| Đủ | mọi ô có `\|` bên trong đều được đếm từ phải, không lệch chỉ số | `grep '^| ~*\*\*T-' task.md \| awk -F'\|' '{print NF}' \| sort -u` | ra nhiều hơn một giá trị ⇒ có ô chứa `\|` chưa thoát, mọi lệnh đếm ô đang đo nhầm dòng |

**ĐẠT khi:** thấy lệnh đỏ trên bản cũ **rồi** xanh trên bản mới, cả hai output dán vào. · **Đã thử làm đỏ:** ⬜ chưa

### cl-T-14

**Nhà của luật báo cáo thay đổi** · sàn **T3** · ⬜ đo tới **T2** ngày 2026-08-23, chưa diễn tập T3

| Trục §4 | Mệnh đề phải đúng | Lệnh soi (≥ 2 file, khác ô biên nhận) | Đỏ khi |
|---|---|---|---|
| Một nhà | khuôn bảng 5 cột chỉ sống ở rule; `CLAUDE.md` §4 chỉ trỏ | `grep -rl -F '\| # \| File \| Sửa ở đâu \| Sửa gì \| Xem diff \|' --include='*.md' .` → đúng **1** file | ra `>= 2` file ⇒ sửa khuôn ở một chỗ, chỗ kia vẫn dạy khuôn cũ |
| Đúng | `CLAUDE.md` §4 trỏ đúng mục `§1 §3` của rule, không trỏ trọn file | `grep -c 'bao-cao-thay-doi.md) §1 §3' CLAUDE.md` → `>= 1` | ra `0` ⇒ phiên phải đọc cả rule mới biết dán bảng nào |

**ĐẠT khi:** hai hàng xanh — đã chạy 2026-08-23, ra `1` file và `>= 1`. Còn thiếu diễn tập T3. · **Đã thử làm đỏ:** ⬜ chưa

### cl-T-15

**Hook `Stop` cưỡng chế bảng thay đổi** · sàn **T2** (`.claude/settings.json` do harness **thực thi**, không phiên nào nạp) · ⬜ chưa đo

| Trục §4 | Mệnh đề phải đúng | Lệnh soi (≥ 2 file, khác ô biên nhận) | Đỏ khi |
|---|---|---|---|
| Đúng | hook **chạy thật** ở một phiên cây bẩn, không chỉ "json hợp lệ" | sửa tạm một file bất kỳ → kết phiên → xem hook có in danh sách file đổi không → `git checkout --` khôi phục | cây bẩn mà hook im ⇒ luật `CLAUDE.md` §4 vẫn chỉ là lời đề nghị |
| Đủ | hook nói đúng thứ rule đòi: **file nào + chỗ nào**, không chỉ "bạn quên bảng" | đối chiếu câu hook in ra với 5 cột ở [bao-cao-thay-doi.md](.claude/rules/bao-cao-thay-doi.md) §1 | hook nhắc chung chung ⇒ phiên vẫn dán bảng thiếu cột |

**ĐẠT khi:** thấy hook đỏ một lần với cây bẩn và im với cây sạch — hook chỉ có một trong hai trạng thái là hook hỏng. · **Đã thử làm đỏ:** ⬜ chưa

### cl-T-16

**Hai lệnh rà tính duy nhất của mã finding** · sàn **T3** · ⬜ chưa đo

| Trục §4 | Mệnh đề phải đúng | Lệnh soi (≥ 2 file, khác ô biên nhận) | Đỏ khi |
|---|---|---|---|
| Đúng | lệnh bắt được mã trùng **trên bản lịch sử đã từng trùng** | chạy khối §5.2 trên `git show 34b3171:finding.md` | không in mã nào ⇒ lệnh xanh vĩnh viễn, không đo gì |
| Đủ | bảng đầu `finding.md` và các mục `### F-xx` khai **cùng một** tập mã | `diff <(grep -o '^| \[F-[0-9]\{2\}\]' finding.md \| grep -o 'F-[0-9]\{2\}' \| sort) <(grep -o '^### F-[0-9]\{2\}' finding.md \| grep -o 'F-[0-9]\{2\}' \| sort)` | in ra dòng lệch ⇒ có mục không vào bảng, hoặc dòng bảng không có mục |

**ĐẠT khi:** `F-06` đóng kèm bài học nói rõ luật nào chặn mã trùng lần sau. · **Đã thử làm đỏ:** ⬜ chưa

### cl-T-18

**`quality/00-guideline-chat-luong.md`** · sàn **T3** · ⬜ đo tới **T2** ngày 2026-08-23, chưa diễn tập T3

| Trục §4 | Mệnh đề phải đúng | Lệnh soi (≥ 2 file, khác ô biên nhận) | Đỏ khi |
|---|---|---|---|
| Một nhà | thang `T0–T3` chỉ có **một** nhà trong cả repo | `grep -rln 'dùng được lạnh' --include='*.md' .` → đúng **1** file | ra `>= 2` file ⇒ tầng dưới đã chép thay vì kế thừa (guideline §7 cấm) |
| Dùng được lạnh | phiên mới chỉ nạp guideline chấm được một đầu ra ĐẠT/KHÔNG ĐẠT | diễn tập T3: đưa một file bất kỳ cho phiên mới, bắt nó chấm bằng §3 §4 | nó phải hỏi "chấm theo tiêu chí nào" |

**ĐẠT khi:** hàng 1 ra đúng 1 file — đã chạy 2026-08-23, ra `quality/00-guideline-chat-luong.md`. Hàng 2 chưa diễn tập. · **Đã thử làm đỏ:** ⬜ chưa

### cl-T-19

**Tầng pha đầu tiên: `quality/01-pha-0-ba.md`** · sàn **T3** · ⬜ chưa đo

| Trục §4 | Mệnh đề phải đúng | Lệnh soi (≥ 2 file, khác ô biên nhận) | Đỏ khi |
|---|---|---|---|
| Một nhà | tầng pha chỉ **thêm** mệnh đề riêng của pha 0, cấm chép §3 §4 §5 | `grep -c 'T0 · tồn tại\|biên nhận âm\|Năm trục' quality/01-pha-0-ba.md` → `0` | ra `>= 1` ⇒ đã chép guideline, hai bản sẽ lệch |
| Đúng | mọi file mà tầng pha đòi đo đều tồn tại thật | vòng lặp [§5.1](.claude/rules/quan-ly-du-an.md) chạy trên `quality/01-pha-0-ba.md` với tiền tố `quality/` | in ra `TRỎ HỤT` |

**ĐẠT khi:** file nói được **ranh giới pha** — nhắc tới cái gì là đã lấn pha 1 (guideline §7 vế c). · **Đã thử làm đỏ:** ⬜ chưa

### cl-T-20

**Đưa vế `đỏ khi` vào đặc tả ô biên nhận** · sàn **T3** · ⬜ chưa đo

| Trục §4 | Mệnh đề phải đúng | Lệnh soi (≥ 2 file, khác ô biên nhận) | Đỏ khi |
|---|---|---|---|
| Đủ | luật vào **đặc tả ô** ở rule §1.1, không phải chỉ được nhắc ở một câu văn | `grep -n 'đỏ khi' .claude/rules/quan-ly-du-an.md \| grep -c '^[0-9]*:| \`Đầu ra' ` → `>= 1` | ra `0` ⇒ luật có mặt nhưng không ở chỗ người viết dòng task nhìn vào |
| Một nhà | rule **trỏ** guideline §5, không chép lại ba dạng biên nhận giả | `grep -c 'Ngưỡng dưới đặt trên thứ dễ đẻ' .claude/rules/quan-ly-du-an.md quality/00-guideline-chat-luong.md` → `0` và `>= 1` | rule ra `>= 1` ⇒ nhà thứ hai của luật biên nhận âm |

**ĐẠT khi:** hai hàng xanh và `wc -l < CLAUDE.md` vẫn `<= 120` — luật này không được leo lên `CLAUDE.md`. · **Đã thử làm đỏ:** ⬜ chưa

### cl-T-21

**Áp `đỏ khi` xuống mọi dòng task đang có** · sàn **T3** · ⬜ chưa đo

| Trục §4 | Mệnh đề phải đúng | Lệnh soi (≥ 2 file, khác ô biên nhận) | Đỏ khi |
|---|---|---|---|
| Đủ | mỗi vế `đỏ khi` đi kèm **một lệnh chạy được**, không phải chữ trang trí | `grep '^| ~*\*\*T-' task.md \| grep 'đỏ khi' \| grep -vc '\`'` → `0` | ra `>= 1` ⇒ có dòng khai vế âm mà trong ô không có lệnh nào |
| Đúng | vế âm nói **điều kiện làm lệnh đỏ**, không nói lại kết quả mong đợi | đọc tay 3 dòng bất kỳ, đối chiếu khuôn ở [guideline §5](quality/00-guideline-chat-luong.md) | vế âm chỉ là phủ định của vế xanh ("đỏ khi không ra `>= 3`") ⇒ chưa nói được cái gì làm nó đỏ |

**ĐẠT khi:** số dòng task = số dòng có `đỏ khi` **và** hàng 1 ra `0`. · **Đã thử làm đỏ:** ⬜ chưa

### cl-T-22

**`.claude/rules/chat-luong-finding.md`** · sàn **T3** · ⬜ đo tới **T2** ngày 2026-08-23, chưa diễn tập T3

| Trục §4 | Mệnh đề phải đúng | Lệnh soi (≥ 2 file, khác ô biên nhận) | Đỏ khi |
|---|---|---|---|
| Đúng | **cả 6** tiêu đề vế mà rule §1 khai đều là chuỗi có thật trong `finding.md` | `for v in 'Mệnh đề sai' 'Vì sao nó không tự mất đi' 'Lệnh tái hiện' 'Cách sửa đề xuất' 'Kiểm chứng' 'Bài học giữ lại'; do printf '%s %s\n' "$v" "$(grep -c "$v" finding.md)"; done` | một vế ra `0` ⇒ rule dò theo chuỗi không có thật, cổng §3 xanh giả |
| Một nhà | rule là **tầng dưới** của guideline: không chép thang T0–T3 | `grep -c 'T0 · tồn tại' .claude/rules/chat-luong-finding.md` → `0` | ra `>= 1` ⇒ chép, đúng gốc của `F-04` |

**ĐẠT khi:** hàng 1 không vế nào ra `0` — đã chạy 2026-08-23, thấp nhất là `2`. Còn thiếu diễn tập T3. · **Đã thử làm đỏ:** ⬜ chưa

### cl-T-23

**Vá 5 mục finding đang mở cho cổng (a) xanh** · sàn **T3** · ⬜ chưa đo

| Trục §4 | Mệnh đề phải đúng | Lệnh soi (≥ 2 file, khác ô biên nhận) | Đỏ khi |
|---|---|---|---|
| Đủ | vế `Lệnh tái hiện.` mới là **lệnh chạy được**, không phải mô tả cái sai | với mỗi mã vừa vá, `sed -n "/^### F-xx$/,/^### F-/p" finding.md \| grep -A2 'Lệnh tái hiện' \| grep -c '\`'` → `>= 1` | ra `0` ⇒ cổng (a) xanh trong khi vế vẫn là lời khai |
| Đúng | mỗi lệnh vá vào **in ra đúng cái sai hôm nay** | chạy từng lệnh vừa thêm, dán output | lệnh ra rỗng ⇒ mệnh đề đã hết đúng mà mục vẫn 🔴, hoặc lệnh viết sai |

**ĐẠT khi:** cổng (a) rỗng **và** `git show HEAD -- finding.md` không có dòng `-` nào (không xoá nội dung cũ để lấy vế mới cho nhanh). · **Đã thử làm đỏ:** ⬜ chưa

### cl-T-24

**Cột `Chất lượng` + bảng soi này** · sàn **T3** · ⬜ đo tới **T2** ngày 2026-08-23, chưa diễn tập T3

| Trục §4 | Mệnh đề phải đúng | Lệnh soi (≥ 2 file, khác ô biên nhận) | Đỏ khi |
|---|---|---|---|
| Đủ | **mọi** dòng task có ô `Chất lượng`, và mọi mã có bảng soi ở đây | `grep '^| ~*\*\*T-' task.md \| grep -vc '\[soi ↓\](#cl-t-'` → `0`; và vòng lặp `THIẾU BẢNG SOI CL` ở [rule §5.2](.claude/rules/quan-ly-du-an.md) → rỗng | ra `>= 1` hoặc in một mã ⇒ cột mới lọt dòng, đúng cách cột `Owner kiểm tra` từng lọt |
| Một nhà | bảng này **không** chép thang tầng của guideline, chỉ áp nó xuống từng mã | `grep -o '^\| \*\*T[0-3] · [^\|]*' quality/00-guideline-chat-luong.md \| while read -r r; do grep -rlF "$r" --include='*.md' .; done \| sort -u` → đúng **1** file | in ra `task.md` ⇒ sổ task đã chép một hàng thang tầng, sửa guideline một chỗ thì chỗ kia dạy tầng cũ |

**ĐẠT khi:** hai hàng xanh **và** một phiên mới chấm được một task ĐẠT/KHÔNG ĐẠT chỉ bằng ô `Chất lượng` + bảng của mã đó. · **Đã thử làm đỏ:** ✅ 2026-08-23 — ba lần trên bản sao ở scratchpad: xoá ô `Chất lượng` của `T-05` → hàng 1 ra `1` · đổi tên `### cl-T-05` → in `THIẾU BẢNG SOI CL: T-05` · chép hàng `T0` của guideline vào sổ task → hàng 2 in ra **hai** file

### cl-T-25

**Pha 0 · Đ1 — bảng 4 kênh bán** · sàn **T3** · ⬜ chưa đo

| Trục §4 | Mệnh đề phải đúng | Lệnh soi (≥ 2 file, khác ô biên nhận) | Đỏ khi |
|---|---|---|---|
| Một nhà | file mới **không** chép lại bốn kênh thành định nghĩa thứ hai — nó trỏ `§3.1` và chỉ **thêm** ba ô mà §3.1 không có | `grep -c 'Phí ship\|Không có đơn tối thiểu\|06:00' design/BA/01-kenh-ban.md` → `0` | ra `>= 1` ⇒ dữ kiện của §3.1 đã bị chép sang nhà thứ hai; sửa giá ship một chỗ thì chỗ kia dạy số cũ |
| Dùng được lạnh | phiên viết **Đ2** (2 sơ đồ luồng) chỉ nạp gói lane §1 + file này là vẽ được luồng ăn tại bàn, không phải hỏi lại chủ quán | diễn tập T3: mở phiên mới, chỉ nạp `CLAUDE.md` + `lane-ba.md` + `04-yeu-cau.md` + `01-kenh-ban.md`, đếm số câu nó phải hỏi người | còn **một** câu phải hỏi về *ai bấm* hay *tiền thu ở khâu nào* ⇒ Đ1 chưa đủ để Đ2 đứng lên trên |

**ĐẠT khi:** hai hàng xanh — Đ2 và Đ3 đọc file này làm đầu vào, sai ở đây là sai ba lần. · **Đã thử làm đỏ:** ⬜ chưa

### cl-T-26

**Lệnh (e) chạy được** · sàn **T2** · ✅ đạt sàn 2026-08-24

| Trục §4 | Mệnh đề phải đúng | Lệnh soi (≥ 2 file, khác ô biên nhận) | Đỏ khi |
|---|---|---|---|
| Đúng | (e) đọc **đúng** cột `Câu lệnh để thấy thay đổi`, không đọc nhầm cột khác | chạy (e) trên bản sao ở scratchpad có một dòng bảng bị đổi thứ tự cột; đối chiếu với `grep -o '\`git [^\`]*\`' task.md \| wc -l` | hai số lệch ⇒ (e) đang bỏ sót hoặc đếm thừa lệnh |
| Một nhà | rule **không** chép lại danh sách task đã gạch — nó đọc `task.md` mỗi lần chạy | `grep -c 'T-14\|T-22\|T-24' .claude/rules/bao-cao-thay-doi.md` → `0` | ra `>= 1` ⇒ danh sách task bị đóng băng vào rule, task thứ tư đóng xong là lệnh mù |

**ĐẠT khi:** hai hàng xanh — (e) là thứ [T-27](#sổ-task) dựa vào để biết đã sửa hết chưa. · **Đã thử làm đỏ:** ✅ 2026-08-24 — trên bản sao ở scratchpad, bỏ một dấu `~` trong bộ lọc của (e) (`~~` → `~*`, tức thôi lọc theo dòng đã gạch): output 8 dòng thành **49**, và lệnh soi `| grep -cE 'T-(0[3-9]\|1[0356]\|25)'` ra **20** thay vì `0`. Repo không bị chạm. Hàng *Một nhà* xanh: `grep -c 'T-14\|T-22\|T-24' .claude/rules/bao-cao-thay-doi.md` ra `0`

### cl-T-27

**Ghim sha thay `HEAD`** · sàn **T3** · ⬜ chưa đo

| Trục §4 | Mệnh đề phải đúng | Lệnh soi (≥ 2 file, khác ô biên nhận) | Đỏ khi |
|---|---|---|---|
| Đúng | mỗi sha ghim trỏ đúng commit **của task đó**, không phải commit gần đó | với mỗi mục `owner-T-xx` đã gạch: `git log -1 --format=%s <sha>` phải chứa đúng mã `T-xx` | message của sha không chứa mã task ⇒ ghim nhầm commit, bảng soi chiếu diff của người khác — đúng [F-17](finding.md#f-17) |
| Dùng được lạnh | owner mở bảng soi của một task đã đóng **sáu tháng trước** và vẫn thấy đúng diff | diễn tập T3: chọn `owner-T-01`, chạy cả 5 lệnh, xem có đủ để nói *nhận* hay *trả lại* không | phải mở `git log` ngoài bảng mới hiểu ⇒ bảng chưa tự đứng được |

**ĐẠT khi:** hai hàng xanh **và** [F-15](finding.md#f-15) đóng được với một dòng `**Kiểm chứng.**` là output của (e). · **Đã thử làm đỏ:** ⬜ chưa

### cl-T-28

**Mẫu §5.2b + vế 6 quy trình mở lane** · sàn **T3** · ⬜ chưa đo

| Trục §4 | Mệnh đề phải đúng | Lệnh soi (≥ 2 file, khác ô biên nhận) | Đỏ khi |
|---|---|---|---|
| Một nhà | mẫu `~*` ở §5.2b **giống hệt** mẫu đã dùng ở (b) (c) — một khuôn, không hai biến thể | `grep -oh '\^| ~\*\\*\\*T-' .claude/rules/quan-ly-du-an.md .claude/rules/bao-cao-thay-doi.md \| sort -u \| wc -l` → `1` | ra `>= 2` ⇒ hai bản mẫu trôi khỏi nhau, sửa một chỗ thì chỗ kia dò kiểu cũ |
| Dùng được lạnh | phiên mở lane DB ([T-07](#sổ-task)) đọc §6 là biết ghi chỗ hụt vào đâu, không phải suy ra | diễn tập T3: mở phiên mới, chỉ nạp §6, hỏi *tôi vừa thấy một chỗ hụt, ghi vào file nào* | nó trả lời `design/data_base/` ⇒ vế 6 chưa nói đủ rõ, và [F-19](finding.md#f-19) sẽ lặp ở lane DB |

**ĐẠT khi:** hai hàng xanh — bốn lane còn lại ([T-06](#sổ-task) [T-07](#sổ-task) [T-08](#sổ-task) [T-09](#sổ-task)) đi qua đúng chỗ này. · **Đã thử làm đỏ:** ⬜ chưa

### cl-T-29

**Vá lệnh `cl-T-02` + vế 3 biên nhận T-02** · sàn **T2** · ⬜ chưa đo

| Trục §4 | Mệnh đề phải đúng | Lệnh soi (≥ 2 file, khác ô biên nhận) | Đỏ khi |
|---|---|---|---|
| Đúng | khuôn `[^ )]*` không còn sống ở **bất kỳ** file nào trong repo | `grep -rn '\[^ )\]\*' --include='*.md' . \| wc -l` → `0` | ra `>= 1` ⇒ còn một chỗ sẽ đẻ lại đúng lỗi này khi bảng `cl-` kế tiếp được đo |
| Đủ | mọi lệnh trong bảng `cl-T-02` sinh ra được **một** phán quyết, không phải một danh sách để người tự đọc | chạy cả hai lệnh của `cl-T-02`, đếm dòng output; đối chiếu với vế `Đỏ khi` viết bên cạnh | output không đọc được thành xanh/đỏ theo đúng câu `Đỏ khi` ⇒ vẫn là lệnh soi, chưa phải cổng |

**ĐẠT khi:** hai hàng xanh **và** vế 3 biên nhận `T-02` đỏ thật trên bản sao đổi `paths:`. · **Đã thử làm đỏ:** ⬜ chưa

### cl-T-30

**Khuôn message + cổng sổ-lệch-git** · sàn **T3** · ⬜ chưa đo

| Trục §4 | Mệnh đề phải đúng | Lệnh soi (≥ 2 file, khác ô biên nhận) | Đỏ khi |
|---|---|---|---|
| Đúng | cổng phân biệt được commit **làm** task với commit **mở** task | chạy cổng trên `git log` hôm nay: `34b3171` (mang nhãn `T-12` nhưng chỉ mở T-12) **không** được in ra | in ra `T-12` ⇒ cổng vẫn đọc tiền tố message theo kiểu cũ, và nó sẽ báo động giả mỗi lần một phiên mở task mới |
| Dùng được lạnh | phiên bất kỳ đọc [CLAUDE.md §4](CLAUDE.md) là chọn đúng khuôn message, không phải tra ví dụ trong `git log` | diễn tập T3: mở phiên mới, chỉ nạp §4, hỏi *tôi vừa mở hai task mới và không làm task nào, message viết sao* | nó viết `<LANE>/T-xx:` ⇒ §4 chưa tách được hai loại commit, [F-18](finding.md#f-18) còn nguyên |

**ĐẠT khi:** hai hàng xanh — cổng này là thứ chặn đúng chuyện vừa xảy ra với `T-02`. · **Đã thử làm đỏ:** ⬜ chưa

### cl-T-31

**Vế `Đóng khi.` vào khuôn finding** · sàn **T3** · ⬜ chưa đo

| Trục §4 | Mệnh đề phải đúng | Lệnh soi (≥ 2 file, khác ô biên nhận) | Đỏ khi |
|---|---|---|---|
| Đúng | cổng (c) phân biệt được vế viết **lúc mở** với vế `Kiểm chứng` dán **lúc đóng** — nó không được xanh nhờ mục đã đóng | chạy cổng (c) trên bản sao ở scratchpad có một mục 🔴 chỉ mang `**Kiểm chứng.**` | mục đó **không** bị in ra ⇒ cổng đang nhận nhầm output-dán-sau làm tiêu chí-viết-trước, đúng chỗ hụt [F-22](finding.md#f-22) mô tả |
| Một nhà | rule **không** chép lại luật biên nhận âm — nó trỏ về guideline §5 | `grep -c 'biên nhận âm' .claude/rules/chat-luong-finding.md` → `0` và `grep -c '00-guideline-chat-luong' .claude/rules/chat-luong-finding.md` → `>= 1` | số thứ nhất `>= 1` ⇒ tầng dưới chép tầng chung, lặp lại đúng [F-04](finding.md#f-04) |
| Dùng được lạnh | phiên bất kỳ chỉ nạp §1 là viết được một mục finding đủ vế, không phải tra ví dụ trong `finding.md` | diễn tập T3: mở phiên mới, chỉ nạp rule, bảo *mở một finding cho việc `git log` khai sai file* | nó viết mục thiếu `Đóng khi.` ⇒ hàng mới trong bảng chưa nói được **viết cái gì**, chỉ nói **có vế đó** |

**ĐẠT khi:** ba hàng xanh — [T-32](#sổ-task) chép đúng khuôn này xuống 18 mục. · **Đã thử làm đỏ:** ⬜ chưa

### cl-T-32

**Áp `Đóng khi.` xuống mục đang mở** · sàn **T3** · ⬜ chưa đo

| Trục §4 | Mệnh đề phải đúng | Lệnh soi (≥ 2 file, khác ô biên nhận) | Đỏ khi |
|---|---|---|---|
| Đúng | vế thêm vào là **lệnh chạy được hôm nay**, không phải câu mô tả cái sẽ đúng | rút 3 mục bất kỳ, chạy nguyên văn lệnh trong vế `Đóng khi.` của chúng | một lệnh không chạy, hoặc chạy mà output không đọc được thành xanh/đỏ theo đúng câu `đỏ khi` viết bên cạnh |
| Đủ | mọi mục 🔴 đều có vế, kể cả mục **kiến trúc chờ owner** — chúng dùng vế thoát chứ không được bỏ trống | cổng (c) ra rỗng, đối chiếu `grep -c '^\*\*Đóng khi\.\*\*\|^\*\*Chưa đóng được bằng lệnh vì:' finding.md` với số mục 🔴 | hai số lệch ⇒ có mục lọt qua cổng nhờ chữ `đỏ khi` nằm sẵn trong văn xuôi, không phải nhờ có vế |
| Một nhà | vế mới **không** chép lại mệnh đề hay lệnh tái hiện đã có trong chính mục đó | `git show HEAD -- finding.md \| grep '^+' \| grep -c 'Lệnh tái hiện'` → `0` | `>= 1` ⇒ vế mới đang là bản sao của vế cũ, và hai bản sẽ lệch nhau ở lần sửa đầu tiên |

**ĐẠT khi:** ba hàng xanh **và** cổng (c) đỏ thật khi gỡ vế của một mục. · **Đã thử làm đỏ:** ⬜ chưa
