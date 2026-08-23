# task.md — việc tiếp theo là gì, theo thứ tự nào

> Cập nhật **2026-08-22**. Đây là **sổ task**: đo *xong / chưa*. Cái đang **sai** đi sổ khác —
> [finding.md](finding.md). Luật không trộn hai sổ ở [CLAUDE.md §5](CLAUDE.md).
> Khuôn 10 cột, đặc tả từng ô, và định nghĩa XONG của giai đoạn chưa-có-compiler nằm ở
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

---

## Sổ task

| # | Lane | Task | Context | Cần xong trước | Finding phải đóng | Đầu ra kiểm chứng được | Owner kiểm tra | Hỏng thì mất gì | Prompt mở session |
|---|---|---|---|---|---|---|---|---|---|
| ~~**T-01**~~ | NON-CODE | Dựng bộ khung quản lý: `CLAUDE.md`, `.claude/rules/quan-ly-du-an.md`, `task.md`, `finding.md` | **Nạp:** `project_preparation/prompt-fullstack.md` §5 §6 §7 · `huong-dan-viet-task-md.md` Phần IV VII · `claude-md-huong-dan.md` Bước 3 Bước 6 · **Đã chốt:** kiến trúc tách file do người dùng chốt · **Bẫy:** `reference/` là dự án ở giai đoạn xa hơn — lấy cấu trúc, không chép nội dung | — | [F-01](finding.md#f-01) ✅ | `wc -l < CLAUDE.md` ra `<= 120` (trần §8), `awk 'length > 400' CLAUDE.md` rỗng, `head -6 .claude/rules/quan-ly-du-an.md` in ra frontmatter `paths:` | 👤 · [bảng soi ↓](#owner-t-01) | Phiên thứ mười có hai phiên bản sự thật, làm lại hai lần, không ai chứng minh được cái gì đã xong | `Lane NON-CODE · T-01 · đọc 4 file ở project_preparation và prompt/ · chỉ chạm CLAUDE.md, .claude/rules/, task.md, finding.md · xong 4 file thì DỪNG, chưa mở lane nào` |
| **T-02** 🔺 | BA | Mở lane BA: tạo `design/BA/` và `design/BA/04-yeu-cau.md` liệt kê lệnh đọc lại làm biên nhận của lane | **Nạp:** `project_preparation/prompt-fullstack.md` §3.3 · §7 dòng `**0 · BA**` (grep ra được — không có mục nào tên "pha 0") · [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) §6 · **Đã chốt:** hệ tên là **6 Pha** của §7, không dùng chữ "Giai đoạn" · **Bẫy:** pha 0 **không** được nhắc tên bảng dữ liệu; muốn nhắc là đã lấn sang pha 2 | — | — | **Đủ năm vế §6, thiếu vế nào thì lane chưa mở:** `test -e design/BA/04-yeu-cau.md` không kêu (vế 1) · `grep -c '^- .*\`' design/BA/04-yeu-cau.md` ra `>= 3` — đếm dòng gạch đầu dòng **có backtick lệnh**, không đếm gạch đầu dòng văn xuôi (vế 2) · `head -6 .claude/rules/lane-ba.md` in ra frontmatter `paths:` trỏ `design/BA/**` (vế 3) · dòng BA ở `CLAUDE.md` §1 hết ⚠️ và `grep -n 'design/BA' CLAUDE.md` ra `>= 1` (vế 4) · lệnh **§5.2b** của rule không in dòng `LANE NỬA VỜI: ba` nào (vế 3 + vế 5) | 👤 *(mở lane đầu tiên, đặt tiền lệ cho T-06→T-09)* · [bảng soi ↓](#owner-t-02) | Pha 0 chạy xong mà đầu ra không có nhà ⇒ luồng nghiệp vụ sống trong hội thoại, phiên sau phải hỏi lại chủ quán từ đầu | `Lane BA · T-02 · grep -n 'T-02' task.md · chỉ chạm design/BA/**, .claude/rules/lane-ba.md và đúng một dòng CLAUDE.md §1 · xong đủ năm vế §6 thì DỪNG, chưa viết nội dung pha 0 (đó là việc của phiên sau)` |
| **T-03** 🔺 | DEVOPS | Tạo `Makefile` ở gốc repo với đích `check` gom lệnh đọc lại hiện có (`wc -l`, `awk`, vòng lặp con trỏ) | **Nạp:** [CLAUDE.md §7](CLAUDE.md) · [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) §5 · **Đã chốt:** chưa có code ứng dụng nên `check` chỉ gọi lệnh đọc lại · **Bẫy:** đừng viết sẵn đích `test`/`build` gọi `go`/`npm` — chúng chưa cài, đích đỏ ngay lần đầu chạy làm cả `Makefile` mất tin cậy | — | — | ⚠️ `make check` chạy được lần đầu tiên và ra mã thoát `0`, output dán vào phiên; `test -e Makefile` không kêu | 👤 *(nền biên nhận của DB/BE/FE)* · [bảng soi ↓](#owner-t-03) | Không có `Makefile` thì DB/BE/FE không có biên nhận nào ngoài lời khai, và ba lane đó không mở được | `Lane DEVOPS · T-03 · grep -n 'T-03' task.md · chỉ chạm Makefile · xong đích check chạy xanh thì DỪNG, chưa thêm đích nào gọi go hay npm` |
| **T-04** | NON-CODE | Tạo `quality/05-checklist.md` — nhà duy nhất của định nghĩa XONG khi đã có compiler | **Nạp:** `project_preparation/prompt-fullstack.md` §6.5 §6.6 §6.9 · [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) §3 · **Đã chốt:** định nghĩa XONG của giai đoạn chưa-có-compiler đã có nhà ở rule §3 — file mới **tiếp nối**, không chép lại · **Bẫy:** §6.9 (ba thứ không thoả hiệp) là luật áp cho mọi lane ⇒ trỏ, đừng chép sang file mới | T-03 | — | `test -e quality/05-checklist.md` không kêu; `grep -c '^- \[ \]' quality/05-checklist.md` ra `>= 7`; dòng "Định nghĩa XONG khi đã có compiler" ở `CLAUDE.md` §2 hết ⚠️ | 🤖 · [bảng soi ↓](#owner-t-04) | Mỗi lane tự định nghĩa "xong" theo cách riêng ⇒ đánh ✅ khi hết giờ chứ không khi có bằng chứng | `Lane NON-CODE · T-04 · grep -n 'T-04' task.md · chỉ chạm quality/** và đúng một dòng CLAUDE.md §2 · xong checklist thì DỪNG, chưa đụng tới task.md` |
| **T-05** | NON-CODE | Tạo `project_preparation/00-scope.md` — nhà duy nhất của phạm vi bán và giá món | **Nạp:** `prompt-fullstack.md` §3.1 §3.2 · **Bẫy:** giá và thành phần suất bán là **quyền của người dùng**; chỗ nào tài liệu chưa chốt thì ghi một dòng `GIẢ ĐỊNH:` kèm mức rủi ro rồi hỏi, đừng tự chốt | — | — | `test -e project_preparation/00-scope.md` không kêu; `grep -c '^\| ' project_preparation/00-scope.md` ra `>= 8`; dòng "Phạm vi & giá món" ở `CLAUDE.md` §2 hết ⚠️ | 👤 *(giá món là quyền người dùng, [CLAUDE.md §7](CLAUDE.md))* · [bảng soi ↓](#owner-t-05) | Giá món sống ở nhiều chỗ ⇒ backend tính một giá, menu hiện một giá, khách trả giá thứ ba | |
| **T-06** | DEVOPS | Mở lane DEVOPS: tạo `.claude/rules/lane-devops.md` có `paths:` trỏ `Makefile`, `deploy/**`, `.env*` | **Nạp:** [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) §6 · `prompt-fullstack.md` §6.9 · **Bẫy:** luật "không deploy trong giờ bán" mất đi giữa phiên là gây hỏng ⇒ nhà của nó là `CLAUDE.md`, không phải rule này | T-03 | — | `head -6 .claude/rules/lane-devops.md` in ra frontmatter `paths:`; dòng DEVOPS ở `CLAUDE.md` §1 hết ⚠️ | 🤖 · [bảng soi ↓](#owner-t-06) | Lane deploy không có luật riêng ⇒ phiên nào đó đẩy bản mới lúc 7h sáng, quán đang đông | |
| **T-07** | DB | Mở lane DB: tạo `.claude/rules/lane-db.md` và thư mục `design/data_base/` | **Nạp:** [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) §6 · `prompt-fullstack.md` §6.2 (bất biến I1–I8) · **Bẫy:** bất biến nào chưa có cơ chế bảo vệ phải đánh ⚠️ **ngay trong bảng**, đừng để nó trông như đã xong | T-03 | — | `head -6 .claude/rules/lane-db.md` in ra frontmatter `paths:`; `test -e design/data_base` không kêu; dòng DB ở `CLAUDE.md` §1 hết ⚠️ | 🤖 · [bảng soi ↓](#owner-t-07) | Migration viết ra mà không lane nào sở hữu ⇒ hai phiên sửa cùng một file `.sql` đã chạy, dữ liệu lệch không lùi được | |
| **T-08** | BE | Mở lane BE: tạo `.claude/rules/lane-be.md` và thư mục `design/backend/` | **Nạp:** [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) §6 · `prompt-fullstack.md` §4 (11 ràng buộc) · **Bẫy:** "giá luôn tính ở backend trong một hàm duy nhất" là ràng buộc kiến trúc ⇒ trỏ tới §4, đừng diễn giải lại bằng lời của mình | T-07 | — | `head -6 .claude/rules/lane-be.md` in ra frontmatter `paths:`; dòng BE ở `CLAUDE.md` §1 hết ⚠️ | 🤖 · [bảng soi ↓](#owner-t-08) | Không có lane BE thì hàm tính giá không có chủ, và tiền thu sai chỉ lộ ra khi đối chiếu két cuối tháng | |
| **T-09** | FE | Mở lane FE: tạo `.claude/rules/lane-fe.md` và thư mục `design/frontend/` | **Nạp:** [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) §6 · `prompt-fullstack.md` §3.7 §7 pha 4 · **Bẫy:** pha 4 **không** được đổi hợp đồng API; cần đổi ⇒ ghi một dòng finding gửi ngược về lane BE | T-08 | — | `head -6 .claude/rules/lane-fe.md` in ra frontmatter `paths:`; dòng FE ở `CLAUDE.md` §1 hết ⚠️ | 🤖 · [bảng soi ↓](#owner-t-09) | FE tự đoán hình dạng API ⇒ gõ tay type, lệch hợp đồng, lỗi chỉ lộ ra trên máy khách | |
| **T-10** | NON-CODE | Sửa 8 con trỏ hụt trong `project_preparation/prompt-fullstack.md` thành ⚠️ + mã task | **Nạp:** [finding.md#f-02](finding.md#f-02) · [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) §5.1 · **Bẫy:** đừng tạo file rỗng cho con trỏ giải được — file rỗng trông như đã có nhà; đánh ⚠️ và trỏ mã task tạo ra nó | T-04, T-05 | [F-02](finding.md#f-02) | Vòng lặp §5.1 chạy trên `project_preparation/prompt-fullstack.md` in ra rỗng, hoặc mỗi dòng in ra đều có ⚠️ + mã task tại chỗ trỏ | 🤖 · [bảng soi ↓](#owner-t-10) | Phiên đọc file này đi tìm `design/backend/01-thiet-ke.md`, không thấy, rồi **tự tạo** một cấu trúc khác — im lặng, không lệnh nào đỏ | |
| ~~**T-11**~~ | NON-CODE | Thêm `"CLAUDE.md"` và `".claude/rules/**"` vào `paths:` của `.claude/rules/quan-ly-du-an.md` | **Nạp:** [finding.md#f-03](finding.md#f-03) · **Bẫy:** đây là đổi kiến trúc file do người dùng chốt ⇒ hỏi người dùng một câu trước khi sửa, đừng tự đổi | — | [F-03](finding.md#f-03) | `head -10 .claude/rules/quan-ly-du-an.md` ra **6 mục `paths:`**, hai mục đầu `"CLAUDE.md"` + `".claude/rules/**"` ✅ · `grep -o '^### F-[0-9]*' finding.md \| sort \| uniq -d` ra **rỗng** ✅ → đóng **F-03**, mở **F-06** | 👤 *(đổi kiến trúc file owner đã chốt)* · [bảng soi ↓](#owner-t-11) | Phiên mở lane sửa `CLAUDE.md` §1 mà không được nạp quy trình mở lane ⇒ mở nửa vời: sửa bảng nhưng không tạo rule, không tạo dòng task | |
| **T-12** | NON-CODE | Cắt ranh giới hai nhà theo [F-04](finding.md#f-04): rule §1.1 giữ *viết thế nào*, `huong-dan-viet-task-md.md` Phần V giữ *vì sao có ô này*; rule §7 và Phần IV gộp về một bản | **Nạp:** [finding.md#f-04](finding.md#f-04) mục *Cách sửa đề xuất* · [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) §1.1 §7 · **Đã chốt:** rule thắng khi lệch — nó là file `paths:` tự nạp đúng lúc sửa sổ · **Bẫy:** đừng gộp bằng cách xoá bớt chữ ở một bên; bên nào giữ vế nào phải nói ra trong [CLAUDE.md §2](CLAUDE.md), nếu không lần sau lại mọc bản thứ hai | — | — | Chạy **hai lệnh ở mục *Lệnh tái hiện* của [F-04](finding.md#f-04)** — file này không chép lại chúng: mỗi lệnh phải ra `>= 1` trên **một** file và `0` trên file kia (hiện ra `>= 1` trên cả hai) → đóng **[F-04](finding.md#f-04)** | 👤 *(sửa luật ở `CLAUDE.md` §2 và rule có `paths:` rộng)* · [bảng soi ↓](#owner-t-12) | Hai bản đặc tả trôi khỏi nhau trong im lặng: phiên viết dòng task tin bản nó đọc trước, và chỗ lệch chỉ lộ ra khi tình cờ có ai mở cả hai file trong một phiên | `Lane NON-CODE · T-12 · grep -n 'T-12' task.md · chỉ chạm .claude/rules/quan-ly-du-an.md, project_preparation/huong-dan-viet-task-md.md, CLAUDE.md · xong ba file thì DỪNG, không đụng task.md` |
| **T-13** | NON-CODE | Làm bốn lệnh tự rà ở rule §5.2 đáng tin theo [F-05](finding.md#f-05): thoát dấu ngăn cột ở ô biên nhận T-05, thêm phép đếm cột, siết mẫu dò finding | **Nạp:** [finding.md#f-05](finding.md#f-05) · [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) §5.2 · **Bẫy:** mẫu grep `'^` + dấu ngăn + `'` là thứ phân biệt dòng bảng với dòng thường — thoát nó, đừng bỏ nó | — | — | Lệnh ở mục *Lệnh tái hiện* của [F-05](finding.md#f-05) in ra **rỗng** (mọi dòng task đủ 10 cột) và có mặt trong rule §5.2; lệnh dò finding bỏ rơi của §5.2 không còn in mã hai chữ số nào không có trong bảng → đóng **[F-05](finding.md#f-05)** | 🤖 · [bảng soi ↓](#owner-t-13) | Bốn lệnh tự rà của sổ đọc theo vị trí cột: một dòng vỡ cột là chúng đọc nhầm ô mà vẫn báo xanh — sổ trông sạch trong khi không ai kiểm gì | `Lane NON-CODE · T-13 · grep -n 'T-13' task.md · chỉ chạm task.md dòng T-05 và rule §5.2 · xong hai chỗ đó thì DỪNG, không rà lại nội dung task khác` |
| ~~**T-14**~~ | NON-CODE | Mở nhà cho luật *báo cáo thay đổi*: tạo `.claude/rules/bao-cao-thay-doi.md`, thêm phần **Sửa ở đâu** vào mọi ô `Owner kiểm tra`, nối con trỏ ở `CLAUDE.md` §2 §4 và rule §1.1 §4 §5.2 | **Nạp:** [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) §1.1 §4 §5.2 · [CLAUDE.md](CLAUDE.md) §2 §4 §8 · **Đã chốt:** owner yêu cầu thấy *file nào đổi + đổi chỗ nào*, kèm link bấm được — 2026-08-22 · **Bẫy:** đường dẫn **chưa tồn tại** phải viết backtick, **không** viết link markdown, nếu không vòng lặp con trỏ §5.1 báo `TRỎ HỤT` | — | — | `test -e .claude/rules/bao-cao-thay-doi.md` không kêu; ba lệnh **(b) (c) (d)** ở [.claude/rules/bao-cao-thay-doi.md](.claude/rules/bao-cao-thay-doi.md) §3 — dòng này **không chép lại** chúng: (b) in ra **rỗng**, (c) ra hai số bằng nhau, (d) không dòng `TRỎ HỤT` nào; `wc -l < CLAUDE.md` vẫn `<= 120` và `awk 'length > 400' CLAUDE.md` rỗng | 👤 *(sửa luật ở `CLAUDE.md` §4 — vế đánh ✅ đổi từ ba thành bốn, áp cho mọi phiên sau)* · [bảng soi ↓](#owner-t-14) | Owner đọc xong một phiên vẫn không biết nó đã đụng vào đâu ⇒ phải tự mở `git diff` từng lần, và lần nào bận thì thay đổi trôi qua không ai soi | `Lane NON-CODE · T-14 · grep -n 'T-14' task.md · chỉ chạm .claude/rules/bao-cao-thay-doi.md, task.md, .claude/rules/quan-ly-du-an.md, CLAUDE.md · xong bốn file thì DỪNG, chưa viết hook` |
| **T-15** | NON-CODE | Cưỡng chế bảng thay đổi bằng hook `Stop` trong `.claude/settings.json` — luật chữ ở rule mới chỉ là lời đề nghị | **Nạp:** [.claude/rules/bao-cao-thay-doi.md](.claude/rules/bao-cao-thay-doi.md) §1 §3 · [CLAUDE.md §8](CLAUDE.md) · **Đã chốt:** [CLAUDE.md §8](CLAUDE.md) — luật cần **chắc chắn** xảy ra thì nhà của nó là hook, không phải câu chữ · **Bẫy:** `.claude/settings.json` **chưa có chủ** ở bảng lane `CLAUDE.md` §1 ⇒ task này phải sửa kèm **đúng một dòng** NON-CODE ở §1; và hook chặn (exit 2) mỗi lần kết phiên là cách nhanh nhất làm owner tắt hook — bản đầu chỉ **nhắc**, đừng chặn | T-14 | — | `test -e .claude/settings.json` không kêu; `python3 -c 'import json;json.load(open(".claude/settings.json"))'` không kêu; chạy tay lệnh trong hook khi cây bẩn thì in ra danh sách file đổi, khi cây sạch thì im | 👤 *(hook chạy ở **mọi** phiên, hỏng là hỏng toàn cục)* · [bảng soi ↓](#owner-t-15) | Luật báo cáo sống bằng thiện chí: phiên nào quên là owner mất đúng phiên đó, mà không dấu hiệu nào báo là đã mất | `Lane NON-CODE · T-15 · grep -n 'T-15' task.md · chỉ chạm .claude/settings.json và đúng một dòng CLAUDE.md §1 · hook chỉ NHẮC không CHẶN · xong thì DỪNG` |
| **T-16** | NON-CODE | Thêm hai lệnh rà tính duy nhất của mã finding vào rule §5.2: `uniq -d` trên `^### F-` và đối chiếu số mục với số dòng bảng | **Nạp:** [finding.md#f-06](finding.md#f-06) · [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) §5.2 · **Đã chốt:** hậu quả đã dọn ở T-11, task này chỉ dựng **cơ chế** chặn tái phát · **Bẫy:** [F-05](finding.md#f-05) nói chính bốn lệnh ở §5.2 đang không đáng tin ⇒ làm sau [T-13](task.md), đừng thêm lệnh mới vào một mục đang hỏng | T-13 | [F-06](finding.md#f-06) | `grep -c '^grep -o' .claude/rules/quan-ly-du-an.md` tăng thêm `1`; chạy khối §5.2 trên `git show 34b3171:finding.md` phải **bắt được** hai mã trùng → đóng **F-06** | 🤖 *(chỉ thêm lệnh rà, không đổi luật)* · [bảng soi ↓](#owner-t-16) | Hai mục cùng mã trong sổ lỗi ⇒ đóng một mục còn mục kia vẫn 🔴, và bài học bị treo nhầm nguyên nhân | `Lane NON-CODE · T-16 · grep -n 'T-16' task.md · chỉ chạm rule §5.2 · xong hai lệnh thì DỪNG, không rà lại nội dung finding` |
| ~~**T-18**~~ ✅ | NON-CODE | Tạo `quality/00-guideline-chat-luong.md` — nhà duy nhất của câu hỏi *"đầu ra có TỐT không"*: thang biên nhận T0–T3, năm trục đo, luật biên nhận âm; nối vào khung bằng `CLAUDE.md` §1 §2 và `paths:` của rule | **Nạp:** [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) §3 §4 · [CLAUDE.md §2](CLAUDE.md) · **Đã chốt:** định nghĩa XONG ở rule §3 **không** chuyển nhà — file mới đo câu hỏi khác, XONG là quy trình, TỐT là đầu ra · **Bẫy:** đặt trần từng mục mà không kèm lệnh đếm từng mục là lặp lại đúng [F-08](finding.md#f-08) | — | — | `test -e quality/00-guideline-chat-luong.md` không kêu · `wc -l < quality/00-guideline-chat-luong.md` ra `<= 115` — **đỏ khi** file phình quá trần · lệnh đếm dòng **từng mục** ở §8 của chính file ra rỗng — **đỏ khi** một mục vượt 18 dòng (*đã thấy đỏ thật*: §7 từng 22 dòng, phải cắt bảng 6 pha thành đoạn văn) · vòng lặp con trỏ [rule §5.1](.claude/rules/quan-ly-du-an.md) chạy với tiền tố `quality/` ra rỗng — **đỏ khi** một link trong file trỏ hụt · `grep -c "quality/00-guideline" CLAUDE.md` ra `1` — **đỏ khi** nhà mới không được §2 trỏ tới · `grep -c "quality/" .claude/rules/quan-ly-du-an.md` ra `>= 1` ở khối `paths:` — **đỏ khi** phiên chạm `quality/` không được nạp sổ tay | 👤 *(sửa luật ở `CLAUDE.md` §1 §2 và `paths:` của rule — rule §1.2b)* · [bảng soi ↓](#owner-t-18) | Sổ xanh hết mà không ai chứng minh được đầu ra **dùng được**: quán nhận về một chồng tài liệu đúng hình dạng, phiên sau vẫn phải hỏi chủ quán lại từ đầu | `Lane NON-CODE · T-18 · đã xong ở commit 1e3c963 · không mở lại` |
| **T-19** | NON-CODE | Tầng pha đầu tiên: tạo `quality/01-pha-0-ba.md` — chất lượng của **pha 0 · BA**, kế thừa §3 §4 §5 của guideline chung bằng con trỏ, chỉ thêm mệnh đề riêng của pha, lệnh đo riêng, và **ranh giới pha** | **Nạp:** [quality/00-guideline-chat-luong.md](quality/00-guideline-chat-luong.md) §7 · [project_preparation/prompt-fullstack.md](project_preparation/prompt-fullstack.md) §7 dòng `**0 · BA**` · **Đã chốt:** tầng pha **cấm chép** §3 §4 §5, chỉ được trỏ — chép là đẻ nhà thứ hai · **Bẫy:** nhắc tên bảng dữ liệu là đã lấn pha 2; ranh giới đó chính là thứ file này phải đo | T-02 | — | `test -e quality/01-pha-0-ba.md` không kêu · `grep -c "đỏ khi" quality/01-pha-0-ba.md` ra `>= 4` — **đỏ khi** có biên nhận không khai vế âm · `grep -c "00-guideline-chat-luong" quality/01-pha-0-ba.md` ra `>= 1` — **đỏ khi** file tự đứng một mình thay vì kế thừa · `grep -c "biên nhận âm" quality/01-pha-0-ba.md` ra `0` — **đỏ khi** §5 bị chép lại thay vì trỏ | 👤 *(task đầu tiên của tầng pha, đặt tiền lệ cho 5 pha còn lại — rule §1.2b)* · [bảng soi ↓](#owner-t-19) | Mỗi pha tự nghĩ ra tiêu chuẩn riêng ⇒ đầu ra pha 0 tốt hay xấu thành chuyện cảm tính, và pha 1 xây lên trên nó không biết mình đang đứng trên cái gì | `Lane NON-CODE · T-19 · grep -n "T-19" task.md · chỉ chạm quality/01-pha-0-ba.md · xong file pha 0 thì DỪNG, năm pha còn lại là task khác` |
| **T-20** | NON-CODE | Tầng step — đưa **vế `đỏ khi`** vào đặc tả ô `Đầu ra kiểm chứng được` ở rule §1.1, và cho vế 2 của rule §3 trỏ sang thang T0–T3 thay vì dừng ở chữ "hình dạng" | **Nạp:** [quality/00-guideline-chat-luong.md](quality/00-guideline-chat-luong.md) §3 §5 · [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) §1.1 §3 · **Đã chốt:** rule **trỏ** sang thang, không chép thang · **Bẫy:** chỉ chạm 1 file — sửa luôn 16 dòng `task.md` là vượt kích cỡ [§6](CLAUDE.md), đó là T-21 | — | [F-13](finding.md#f-13) *(mở phần lệnh áp dụng, T-21 đóng)* | `grep -c "đỏ khi" .claude/rules/quan-ly-du-an.md` ra `>= 2` — **đỏ khi** luật được nhắc mà không vào đặc tả ô · `grep -c "00-guideline-chat-luong" .claude/rules/quan-ly-du-an.md` ra `>= 1` — **đỏ khi** vế 2 của §3 vẫn dừng ở "hình dạng" · `wc -l < CLAUDE.md` ra `<= 120` — **đỏ khi** luật bị nhét nhầm vào `CLAUDE.md` | 👤 *(sửa rule có `paths:` rộng — rule §1.2b)* · [bảng soi ↓](#owner-t-20) | Luật chất lượng nằm trong `quality/` mà không có đường vào ô biên nhận ⇒ phiên sau vẫn viết biên nhận không đỏ được, và guideline thành file không ai áp | `Lane NON-CODE · T-20 · grep -n "T-20" task.md · chỉ chạm .claude/rules/quan-ly-du-an.md · xong §1.1 + §3 thì DỪNG, chưa đụng 16 dòng task.md` |
| **T-21** | NON-CODE | Áp vế `đỏ khi` xuống **mọi** dòng đang có trong `task.md`: mỗi ô `Đầu ra kiểm chứng được` khai rõ trạng thái hỏng nào làm nó đỏ | **Nạp:** [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) §1.1 *(sau T-20)* · [quality/00-guideline-chat-luong.md](quality/00-guideline-chat-luong.md) §5 · **Đã chốt:** không đổi lệnh đang có, chỉ **thêm** vế âm — đổi lệnh là đổi phạm vi task cũ · **Bẫy:** ba khuôn biên nhận giả ở §5 — gặp ngưỡng dưới trên thứ dễ đẻ thì ghi finding, đừng lặng lẽ sửa ngưỡng | T-20 | [F-13](finding.md#f-13) | Hai số phải bằng nhau: `grep -c "^\| ~*\*\*T-" task.md` và `grep "^\| ~*\*\*T-" task.md \| grep -c "đỏ khi"` — **đỏ khi** còn một dòng task chưa khai vế âm · khối lệnh tự rà [rule §5.2](.claude/rules/quan-ly-du-an.md) im — **đỏ khi** việc thêm chữ làm vỡ cột | 🤖 *(việc cơ khí, luật đã chốt ở T-20)* · [bảng soi ↓](#owner-t-21) | Guideline có luật, rule có đặc tả, mà 16 dòng cũ vẫn xanh giả ⇒ luật mới chỉ áp cho task tương lai và repo giữ nguyên vùng mù đang có | `Lane NON-CODE · T-21 · grep -n "T-21" task.md · chỉ chạm task.md · xong khi hai số bằng nhau thì DỪNG` |
| ~~**T-22**~~ ✅ | NON-CODE | Tạo `.claude/rules/chat-luong-finding.md` — nhà duy nhất của **khuôn một mục `### F-xx`** (4 vế khi mở, 6 vế khi đóng) và **2 cổng lệnh** của sổ lỗi; nối vào khung bằng đúng một hàng `CLAUDE.md` §2 | **Nạp:** phần mở đầu [finding.md](finding.md) · [quality/00-guideline-chat-luong.md](quality/00-guideline-chat-luong.md) §3 §4 §5 · [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) §2 · **Đã chốt:** guideline T-18 là **tầng chung** — file này là tầng dưới, chỉ được **thêm** khuôn và lệnh, cấm chép thang T0–T3 · **Bẫy:** *ba vế để đóng* đã có nhà ở đầu `finding.md`, và *finding hay task* ở [CLAUDE.md §5](CLAUDE.md); chép một trong hai sang rule mới là lặp lại đúng [F-04](finding.md#f-04) | T-18 | — | `test -e .claude/rules/chat-luong-finding.md` không kêu · `wc -l` ra `<= 95` — **đỏ khi** file phình quá trần · lệnh đếm dòng **từng mục** ở §5 của chính file ra rỗng — **đỏ khi** một mục vượt 22 dòng (*đã thấy đỏ thật*: §3 từng 24 dòng, phải cắt hai lần) · cổng **(b)** ở §3 ra rỗng — **đỏ khi** một mục khai ✅ ĐÓNG mà không có `Bài học giữ lại` (*đã thấy đỏ thật* trên bản sao ở scratchpad, `finding.md` không bị đụng) · `grep -c 'chat-luong-finding' CLAUDE.md` ra `1` — **đỏ khi** nhà mới không được §2 trỏ tới | 👤 *(sửa luật ở `CLAUDE.md` §2 — rule §1.2b)* · [bảng soi ↓](#owner-t-22) | Sổ lỗi phình thành chỗ than phiền: mục không tái hiện được thì không đóng được, mà không đóng được thì mã đó nằm đó mãi và mọi phiên sau đều phải đọc lại nó để kết luận *"không làm gì"* | `Lane NON-CODE · T-22 · xong ngay trong commit này · không mở lại` |
| **T-23** | NON-CODE | Vá **5 mục finding đang mở** cho cổng (a) xanh: thêm `Lệnh tái hiện.` cho F-06 · `Vì sao nó không tự mất đi.` cho F-13 · `Chưa đề xuất được vì:` cho F-07, F-08, F-12 | **Nạp:** [.claude/rules/chat-luong-finding.md](.claude/rules/chat-luong-finding.md) §1 §3 · **Đã chốt:** F-07, F-08, F-12 là **kiến trúc chờ owner**, nên chúng dùng vế thoát `Chưa đề xuất được vì:` chứ **không** bịa ra cách sửa · **Bẫy:** đừng viết vế cho có — vế `Lệnh tái hiện.` của F-06 phải là lệnh chạy được **hôm nay**, chạy thử trước khi dán | T-22 | — | Cổng **(a)** ở [rule §3](.claude/rules/chat-luong-finding.md) ra **rỗng** — **đỏ khi** còn một mục 🔴 thiếu 1 trong 4 vế (hiện đỏ với 5 mã: F-06, F-07, F-08, F-12, F-13); và `git show HEAD -- finding.md` chỉ có dòng `+`, không dòng `-` nào — **đỏ khi** phiên xoá nội dung cũ để lấy vế mới cho nhanh | 🤖 *(khuôn đã chốt ở T-22, việc còn lại là cơ khí)* · [bảng soi ↓](#owner-t-23) | Cổng vừa dựng đã đỏ ngay từ ngày đầu; đỏ vĩnh viễn hai lần thì phiên thứ ba học cách bỏ qua nó, và luật khuôn finding chết trong im lặng | `Lane NON-CODE · T-23 · grep -n 'T-23' task.md · chỉ chạm finding.md · xong khi cổng (a) rỗng thì DỪNG, không sửa nội dung mệnh đề của mục nào` |

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
| Nhà của lane BA + file yêu cầu pha 0, liệt kê lệnh đọc lại làm biên nhận | `git show --stat HEAD -- design/BA` | `design/BA/04-yeu-cau.md` **(mới)** › cả file |
| Rule riêng của lane, để phiên chạm `design/BA/**` tự được nạp luật lane | `git show HEAD -- .claude/rules/lane-ba.md` | `.claude/rules/lane-ba.md` **(mới)** › frontmatter `paths:` trỏ `design/BA/**` |
| Dòng BA hết ⚠️: có đường dẫn thật + gói nạp + biên nhận | `git show HEAD -- CLAUDE.md` | [CLAUDE.md](CLAUDE.md) §1 bảng lane › **đúng một dòng BA** |

**Đạt khi:** `CLAUDE.md` chỉ đổi **đúng một dòng**; mọi thứ khác nằm trong `design/BA/` và `.claude/rules/lane-ba.md`. Xuất hiện file thứ tư ⇒ lấn phạm vi, đừng nhận.

### owner-T-03

**Tạo `Makefile` với đích `check`** · ai ký: 👤 *(nền biên nhận của DB/BE/FE)*

| Thay đổi cái gì | Câu lệnh để thấy thay đổi | Ở đâu |
|---|---|---|
| Đích `check` gom lệnh đọc lại đang có (`wc -l`, `awk`, vòng lặp con trỏ) | `git show HEAD -- Makefile` | `Makefile` **(mới)** › đích `check` |

**Đạt khi:** Đọc **từng đích**: không đích nào gọi `go` hay `npm`. Hai thứ đó chưa cài — một đích đỏ ngay lần chạy đầu làm cả `Makefile` mất tin cậy, và ba lane DB/BE/FE mất nền biên nhận.

### owner-T-04

**Nhà của định nghĩa XONG khi đã có compiler** · ai ký: 🤖

| Thay đổi cái gì | Câu lệnh để thấy thay đổi | Ở đâu |
|---|---|---|
| Checklist XONG mức có compiler, tiếp nối rule §3 chứ không chép lại | `git show HEAD -- quality/` | `quality/05-checklist.md` **(mới)** › cả file |
| Dòng *Định nghĩa XONG khi đã có compiler* hết ⚠️, trỏ vào nhà mới | `git show HEAD -- CLAUDE.md` | [CLAUDE.md](CLAUDE.md) §2 › **đúng một dòng** bảng |

**Đạt khi:** Checklist là nội dung **mới**: không câu nào chép từ rule §3. Chép là đẻ nhà thứ hai, và bản chép sẽ lệch trong im lặng.

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
