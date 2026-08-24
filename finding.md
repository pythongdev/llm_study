# finding.md — sổ lỗi

> Cập nhật **2026-08-25**. Đây là **sổ lỗi**: đo *đúng / sai*. Việc **chưa tới lượt xây** đi sổ khác —
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
| [F-14](#f-14) | Luật sàn ở [guideline §3](quality/00-guideline-chat-luong.md) khai **T3 bắt buộc** cho *file mà phiên khác sẽ nạp* — trong repo chỉ-có-tài-liệu này **mọi** `.md` đều là file phiên khác nạp, nên sàn T3 rơi vào 21/23 dòng task và cột `Chất lượng` lọc được đúng bằng không, cùng kiểu hỏng với *đánh 👤 cho mọi dòng* mà rule §1.2b đã cấm | T-24 · 2026-08-23 | 🔴 MỞ | ⚠️ chưa có task — sửa luật chất lượng là việc owner chốt |
| [F-15](#f-15) | 50/61 lệnh ở cột `Câu lệnh để thấy thay đổi` của §Owner kiểm tra ghi `HEAD`; `HEAD` di chuyển sau mỗi commit nên với task **đã xong** lệnh in ra rỗng (`owner-T-02`, cả 3 lệnh) hoặc in ra **diff của task khác** (`owner-T-14` `owner-T-22` đang chiếu diff của T-24) | T-02 rà pipeline · 2026-08-23 | 🔴 MỞ | [T-27](task.md) |
| [F-16](#f-16) | Lệnh **(e)** ở [bao-cao-thay-doi.md](.claude/rules/bao-cao-thay-doi.md) §3 — lệnh **duy nhất** bắt được [F-15](#f-15) — không chạy được: thân nó là hai dòng chú thích cộng `git log --oneline -3 -- <path>` với `<path>` là chỗ trống, và T-14 chỉ đưa (b) (c) (d) vào bộ bắt buộc | T-02 rà pipeline · 2026-08-23 | ✅ ĐÓNG 2026-08-24 | T-26 |
| [F-17](#f-17) | [CLAUDE.md §2](CLAUDE.md) trao cho `git log` vai nhà duy nhất của *"ai sửa file nào"*, nhưng không lệnh nào đối chiếu message với `--stat`: `c386219` khai sửa `.claude/rules/quan-ly-du-an.md` trong khi commit đó chỉ đụng `finding.md` và `task.md` | T-02 rà pipeline · 2026-08-23 | 🔴 MỞ | [T-15](task.md) |
| [F-18](#f-18) | Không cơ chế nào bắt *task đã xong trong git mà dòng sổ còn mở*: T-02 commit đủ đầu ra ở `4851d17` với cả năm vế biên nhận xanh, dòng vẫn `\| **T-02** 🔺` — nên bước 2 của [CLAUDE.md §3](CLAUDE.md) dò đúng vào nó và phiên sau mở ra làm lại việc đã xong | T-02 rà pipeline · 2026-08-23 | 🔴 MỞ | [T-30](task.md) |
| [F-19](#f-19) | Một cơ chế đang hỏng được ghi **ngoài sổ lỗi**: `design/BA/04-yeu-cau.md` §4 mục 2 (*"Đóng T-02 xong thì vế 5 tự đỏ"*) mô tả đủ chuyện đóng T-02 làm lệnh §5.2b in `LANE NỬA VỜI: ba`, nhưng `grep -c 'LANE NỬA VỜI' finding.md` ra `0` và định tuyến §1 không dẫn lane NON-CODE tới `design/BA/**` | T-02 rà pipeline · 2026-08-23 | 🔴 MỞ | [T-28](task.md) |
| [F-20](#f-20) | Bảng `cl-T-02` khai `Đỏ khi: ra hai đường dẫn khác nhau`, nhưng lệnh của nó in ra **8 dòng** ngay cả khi lane hoàn toàn đúng — `[^ )]*` nuốt cả dấu markdown — nên nó **đỏ giả vĩnh viễn**, và khi `paths:` bị đổi sang `design/DB/**` thật thì output chỉ khác đúng một dòng | T-02 rà pipeline · 2026-08-23 | 🔴 MỞ | [T-29](task.md) |
| [F-21](#f-21) | Hai cổng ở [rule §3](.claude/rules/chat-luong-finding.md) lấy mã bằng `grep -o 'F-[0-9]*'` chạy trên **cả dòng bảng**, nên mã `F-xx` **nhắc trong ô** cũng bị duyệt như mã của dòng: dòng `F-06` nhắc `[F-03]` kéo một mã **đã đóng** vào khuôn mở, và cổng (a) duyệt 25 mã cho 18 dòng 🔴 | rà khuôn finding · 2026-08-23 | ✅ ĐÓNG 2026-08-23 | ⚠️ đóng ngay trong phiên rà — không đẻ task |
| [F-22](#f-22) | Khuôn mục `### F-xx` ở [rule §1](.claude/rules/chat-luong-finding.md) không có vế nào giữ **tiêu chí thành công** lúc **mở**: `**Kiểm chứng.**` chỉ bắt buộc khi **đóng**, nên lệnh chứng minh được chọn **sau** khi đã sửa — 14/18 mục 🔴 hiện không khai nổi một vế `đỏ khi` | rà khuôn finding · 2026-08-23 | 🔴 MỞ | [T-31](task.md) |
| [F-23](#f-23) | [CLAUDE.md §7](CLAUDE.md) và [rule §3](.claude/rules/quan-ly-du-an.md) vẫn khai *"chưa có `Makefile`"* + xếp `make ...` vào loại ⚠️ **không được tính là biên nhận**, trong khi từ `9699f1c` `make check` chạy được và ra mã thoát `0`; §5.3 chỉ có lệnh bắt ⚠️ **thiếu**, không lệnh nào bắt ⚠️ **thừa** | T-03 · 2026-08-23 | 🔴 MỞ | ⚠️ chưa có task |
| [F-24](#f-24) | [CLAUDE.md §4](CLAUDE.md) khai `git add <đường dẫn cụ thể>` là cách chống nuốt việc dở của phiên khác — nó chỉ chống **lẫn file**, không chống **lẫn hunk**: hai phiên cùng sửa `task.md`/`finding.md` thì bên nào commit trước cũng nuốt trọn phần bên kia đang viết, cây vẫn sạch và `git log` vẫn hợp khuôn (ca thật: `0d2a785` chứa cả phần đóng `T-03` của phiên DEVOPS) | T-03 · 2026-08-23 | 🔴 MỞ | ⚠️ chưa có task |
| [F-25](#f-25) | Luật *thử làm đỏ một lần* ([guideline §5](quality/00-guideline-chat-luong.md)) không có cổng nào cưỡng chế cho bảng `cl-T-xx`: **28/31** bảng đang `Đã thử làm đỏ: ⬜ chưa`, nên một lệnh soi hỏng nằm im vô hạn — ca phát hiện: `cl-T-04` khai đỏ khi hai file cùng `>= 1` hit `go test`/`npm run`, trong khi rule đã có 2 hit và **một hit nằm trong thân câu lệnh §5.2** nên không xoá được ⇒ trục đó **đỏ vĩnh viễn** | vá dòng T-04 · 2026-08-23 | 🔴 MỞ | ⚠️ chưa có task |
| [F-26](#f-26) | Ô `**Đạt khi:**` của `owner-T-11` trong [task.md](task.md) khai nhà của luật *không deploy trong giờ bán* là `CLAUDE.md`, nhưng `CLAUDE.md` **không có chữ nào** về luật đó — nhà thật là `prompt-fullstack.md` §6.9, và [guideline §6](quality/00-guideline-chat-luong.md) đang trỏ đúng về đó | vá dòng T-04 · 2026-08-23 | 🔴 MỞ | ⚠️ chưa có task |
| [F-27](#f-27) | `project_preparation/prompt-fullstack.md` khai **hai** bề rộng cho cùng một màn hình khách: §3.7 *"mobile-first 375px"*, §6.5 *"thử ở 360px (khách)"* — [T-04](task.md) sẽ chép **một** trong hai vào `quality/05-checklist.md` và chốt luôn số sai | vá dòng T-04 · 2026-08-23 | 🔴 MỞ | ⚠️ chưa có task — owner đã chốt **375px** 2026-08-24, còn phải sửa §6.5 |
| [F-28](#f-28) | Lệnh soi trục *Một nhà* của `cl-T-04` **tự bắt `task.md`**: chuỗi mốc `happy path` bắt buộc phải nằm trong chính ô soi, nên lệnh đỏ ở **cả hai** nhánh — có checklist thì ra `3` file (*bản chép thứ ba*), chưa có thì kết quả thiếu `quality/05-checklist.md` (*chưa có nhà*) | T-04 · 2026-08-24 | ✅ ĐÓNG 2026-08-24 | ⚠️ owner chỉ định vá ngay trong phiên T-04 — không đẻ task |
| [F-29](#f-29) | Ô `Đầu ra kiểm chứng được` của [T-04](task.md) chạy `awk` 7 khoá trên **cả file** trong khi vế nó muốn đo là *bảy dòng `- [ ]`*: §2 của checklist nhắc lại đúng các chuỗi khoá, nên bản **xoá một vế rồi chèn một dòng bịa** qua được cả hai biên nhận — `grep -c` ra `7`, `awk` ra `7` | T-04 · 2026-08-24 | 🔴 MỞ | ⚠️ chưa có task — owner giao agent riêng vá ngay sau T-04 |
| [F-30](#f-30) | Biên nhận thứ nhất của [T-26](task.md) — `grep -c '<path>' .claude/rules/bao-cao-thay-doi.md` ra `0` — quét **cả file** trong khi phạm vi T-26 chỉ là §3: `<path>` ở §1 cột `Xem diff` và §2 cột `Câu lệnh để thấy thay đổi` là placeholder văn xuôi **hợp lệ, phải giữ**, nên ô này ra `2` kể cả khi (e) đã vá đúng — đỏ vĩnh viễn, và cách duy nhất làm nó xanh là lấn phạm vi | T-26 · 2026-08-24 | ✅ ĐÓNG 2026-08-24 | ⚠️ đóng ngay trong phiên vá — không đẻ task |
| [F-31](#f-31) | Hai bản **dẫn xuất** từ `project_preparation/00-scope.md` không có cơ chế nào canh: `prompt-fullstack.md` §9.3 giữ 10 số giá tự khai *"hợp đồng với chủ quán"* mà chỉ khai nguồn bằng câu chữ, và `design/BA/04-yeu-cau.md` dòng 22 còn đánh ⚠️ cho `00-scope.md` §4.4 trong khi nhà đã có | T-05 · 2026-08-24 | 🔴 MỞ | ⚠️ chưa có task |
| [F-32](#f-32) | `.claude/rules/bao-cao-thay-doi.md` §3 khai *"cả năm lệnh (a) (b) (c) (d) (e) đều bắt buộc"* nhưng khối lệnh của §3 chỉ có **bốn** nhãn — `# d.` **chưa từng tồn tại** ở bất kỳ phiên bản nào của file; bộ bắt buộc đang đòi một lệnh ma, và phiên đóng T-26 đã khai *"(d) rỗng"* cho nó | T-05 · 2026-08-24 | 🔴 MỞ | ⚠️ chưa có task |
| [F-33](#f-33) | `quality/05-checklist.md` tự khai là **nhà duy nhất** của câu hỏi *"task này XONG chưa"* cho task có code, nhưng cả bảy vế §1 chỉ đo **vệ sinh của đầu ra** — không vế nào hỏi đầu ra **có phải thứ ô `Task` yêu cầu không**; dòng 57 còn đẩy việc đó sang câu hỏi TỐT | rà quality/05-checklist.md · 2026-08-24 | 🔴 MỞ | ⚠️ chưa có task |
| [F-34](#f-34) | Biên nhận `grep -c '^- \[ \]'` **= đúng 7, không hơn không kém** bị ghim ở **bốn** chỗ (checklist §5 · ô `Đầu ra kiểm chứng được` của T-04 · bảng `cl-T-04` · ô biên nhận của [T-33](task.md) còn mở), nên checklist **không có cửa** nhận vế XONG mới — kể cả vế học từ một sự cố thật mà §6.7 luật 2 đòi | rà quality/05-checklist.md · 2026-08-24 | 🔴 MỞ | ⚠️ chưa có task |
| [F-35](#f-35) | Bảy ô `- [ ]` ở §1 **không phải bảy phép xác nhận**: 5/7 dòng gộp nhiều thứ vào một dấu tick (vế 1 gộp `build · lint · unit test · typecheck`), tổng ra **14–16 tuỳ cách đếm** — và `grep -c` đang đo **số dòng**, không đo số thứ đã xác nhận | rà quality/05-checklist.md · 2026-08-24 | 🔴 MỞ | ⚠️ chưa có task |
| [F-36](#f-36) | §6.9 *(ba thứ không bao giờ thoả hiệp)* chỉ được **trỏ** ở 3 chỗ, **không** cổng nào buộc xác nhận nó trước commit: §3 checklist (*cái gì không tính là XONG*) nhắc `0` lần, và `0` ô `Đạt khi` nào của bảng ba cổng [guideline §6](quality/00-guideline-chat-luong.md) nhắc tới nó | rà quality/05-checklist.md · 2026-08-24 | 🔴 MỞ | ⚠️ chưa có task |
| [F-37](#f-37) | Lời hứa ở checklist §2 — *"vế nào còn ⚠️ thì lane sinh ra nó gỡ ⚠️ ngay trong task mở lane"* — **không nằm trong sổ của ai**: 7/8 dòng bảng §2 đang ⚠️, mà `0` dòng task của T-07 T-08 T-09 nhắc tới `quality/05-checklist.md` | rà quality/05-checklist.md · 2026-08-24 | 🔴 MỞ | ⚠️ chưa có task |
| [F-38](#f-38) | Vòng lặp con trỏ [rule §5.1](.claude/rules/quan-ly-du-an.md) **mù với neo `#f-xx`**: lớp `[^)#]*` cắt bỏ mọi thứ sau `#`, nên `](../finding.md#f-67)` chỉ bị kiểm là *file có tồn tại không* → xanh — và đang có một neo hụt sống ở `prompt-fullstack.md` dòng 13 (`grep -c '^### F-67' finding.md` ra `0`) | rà quality/05-checklist.md · 2026-08-24 | 🔴 MỞ | ⚠️ chưa có task |
| [F-39](#f-39) | Luật báo cáo chỉ đòi con trỏ xuống tới **mục** — ô `Sửa ở đâu` ở [.claude/rules/bao-cao-thay-doi.md §1](.claude/rules/bao-cao-thay-doi.md) đặc tả `§1.1 bảng đặc tả ô`, `dòng T-05` — mà **không** đòi **đường dẫn** đi kèm, nên `§6` trần lọt hợp lệ vào mọi báo cáo; repo đang có **5** file `.md` cùng có một mục `§6`, owner đọc `§6` không biết là §6 của file nào | owner nêu · 2026-08-25 | ✅ ĐÓNG 2026-08-25 | ⚠️ đóng ngay trong phiên owner nêu — không đẻ task |
| [F-40](#f-40) | Hệ đánh số tên file `quality/` va nhau: [guideline §7](quality/00-guideline-chat-luong.md) đặt tầng pha ở `quality/0n-pha-<n>-<tên>.md` cho **6 pha** ⇒ pha 4 đòi `05-`, pha 5 đòi `06-`; nhưng `05-` đã là `05-checklist.md` (T-04 đã xong) và `06-` đã bị [T-33](task.md) đặt trước cho `06-rang-buoc-kien-truc.md` — hai chỗ va, cả hai đều đã ghim vào sổ | T-34 · 2026-08-25 | 🔴 MỞ | ⚠️ chưa có task |
| [F-41](#f-41) | `NHA` trong [Makefile](Makefile) là **danh sách gõ tay 10 file**, không cơ chế nào bắt một nhà mới bị bỏ ngoài: `quality/05-checklist.md` ra đời ở T-04 và **chưa từng** vào `NHA`, nên bốn đích của `make check` không hề soi nó — cổng xanh trong khi hai nhà đứng ngoài cổng | T-34 · 2026-08-25 | 🔴 MỞ | ⚠️ chưa có task |

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


---

### F-14

**Mệnh đề sai.** [Guideline §3](quality/00-guideline-chat-luong.md) đặt luật sàn: *"**T3 bắt buộc** cho
file mà phiên khác sẽ nạp: `CLAUDE.md`, mọi `.claude/rules/**`, mọi `quality/**`, và mọi file đứng trong
ô `Nạp` của một dòng `task.md`"*. Repo giai đoạn này **không có file nào khác** — nó chỉ gồm tài liệu, và
mọi tài liệu đều bị một phiên nào đó nạp. Nên vị ngữ *"file mà phiên khác sẽ nạp"* không loại được file
nào, và một luật không loại được gì thì không phải bộ lọc: 21/23 dòng task nhận sàn T3, hai dòng còn lại
(`T-03` Makefile, `T-15` settings.json) thoát chỉ vì chúng được **chạy** chứ không được **đọc**.

**Vì sao nó không tự mất đi.** Không dòng nào trong [task.md](task.md) hẹp lại luật sàn: `T-19` viết tầng
pha, `T-20` `T-21` đưa vế `đỏ khi` xuống ô biên nhận, `T-04` viết checklist mức compiler — cả bốn đều
**thêm** cơ chế lên trên luật sàn, không cái nào chạm chính nó. Chạy hết kế hoạch y như nó viết thì sàn
T3 vẫn rơi vào gần như mọi dòng.

**Lệnh tái hiện.**

```bash
grep '^| ~*\*\*T-' task.md | grep -o 'T[0-3] · \[soi' | sort | uniq -c   # ra 21 dòng T3, 2 dòng T2
grep -c 'T3 bắt buộc' quality/00-guideline-chat-luong.md                # ra 1 — luật sàn còn nguyên
ls *.md .claude/rules/*.md quality/*.md | wc -l                        # mẫu số: mọi file đều là tài liệu
```

**Vì sao nó nguy hiểm hơn nó trông.** Sàn T3 đòi **diễn tập**: mở một phiên mới, chỉ nạp gói, làm thử
bước kế tiếp. Đòi thứ đó cho mọi task nghĩa là mỗi task tốn hai phiên. Cái giá đó không được trả — nó
được **bỏ qua**, và bỏ qua một luật là cách nhanh nhất dạy phiên sau rằng luật ở đây tuỳ nghi. Đúng cơ
chế mà rule §1.2b đã mô tả cho dấu `👤`: mọi dòng cùng một giá trị thì cột đó lọc đúng bằng không.

**Cách sửa đề xuất.** Hẹp vị ngữ của luật sàn §3 thành thứ **loại được file**: T3 bắt buộc cho file
đứng trong **gói nạp của một lane** ở [CLAUDE.md §1](CLAUDE.md) (`CLAUDE.md`, `.claude/rules/lane-*.md`,
`quality/**`) và cho file đứng trong ô `Nạp` của một dòng task **chưa làm**; file chỉ được tra cứu
(`task.md`, `finding.md`, tài liệu thiết kế đã chốt) sàn **T2**. Sửa ở `quality/00-guideline-chat-luong.md`
§3 đoạn `**Luật sàn.**`, một đoạn, không đụng bảng bốn tầng. Đây là **sửa luật chất lượng** nên rule
§1.2b xếp vào việc owner ký: mở task khi owner chốt hướng hẹp này.

**Bẫy khi sửa.** Đừng hạ sàn chung xuống T2 cho gọn — T2 không đo được *phiên mới có làm tiếp được
không*, và đó đúng là câu hỏi mà [guideline §2](quality/00-guideline-chat-luong.md) định nghĩa là chất
lượng. Hẹp **tập file** chịu T3, không hạ **thang**.

---

### F-15

**Mệnh đề sai.** Cột `Câu lệnh để thấy thay đổi` của §Owner kiểm tra dùng `HEAD` ở **50/61** lệnh, và
`HEAD` di chuyển sau mỗi commit. Với task **đã xong**, lệnh không còn chiếu thay đổi của task đó nữa:
`owner-T-02` in ra **rỗng** cả ba lệnh (T-02 nằm ở `4851d17`, cách `HEAD` năm commit), còn `owner-T-14`
và `owner-T-22` in ra **diff của T-24** vì `HEAD` tình cờ cũng đụng `task.md` và `quan-ly-du-an.md`.
Chuyện này **đã xảy ra thật trong lúc mục này đang được viết**: lúc 10:4x ngày 2026-08-23 `HEAD` còn là
commit của T-24 nên `owner-T-24` xanh; hai commit sau (`862f2c1`, rồi `8dd11b3` tên `dfg`) cả **11** lệnh
ghim `HEAD` của `owner-T-14` `owner-T-22` `owner-T-24` đồng loạt in ra `0` dòng. Bảng soi của ba task đã
✅ ĐÓNG hỏng cùng lúc, không lệnh nào kêu.

**Vì sao nó không tự mất đi.** Luật đã đúng sẵn: [bao-cao-thay-doi.md](.claude/rules/bao-cao-thay-doi.md)
§2 viết *"**đã commit** (kể cả bị phiên khác commit hộ) ⇒ `git show <sha> -- <path>`"*. Nhưng **ví dụ
`owner-T-02` in ngay trong chính rule đó** (§2) lại viết `HEAD`, và phiên sau chép ví dụ chứ không chép
luật. Không dòng nào trong [task.md](task.md) rà lại cột này; T-14 — task dựng ra cột này — đã ✅ ĐÓNG.

**Lệnh tái hiện.**

```bash
awk '/^## Chất lượng đầu ra/{exit} /^### owner-T-/{f=1} f' task.md | grep -c 'HEAD'   # 50 lệnh ghim HEAD
git show --stat HEAD -- design/BA | wc -l                       # ra 0 — bảng owner-T-02 in rỗng
git show --stat 4851d17 -- design/BA | tail -2                  # sha thật: 1 file changed, 81 insertions
awk '$0=="### owner-T-24"{f=1;next} /^### /{f=0} f' task.md | grep -o '`git [^`]*`' | tr -d '`' \
  | while read -r c; do echo "[$(eval "$c" 2>/dev/null | wc -l) dòng] $c"; done   # ba dòng đầu ra 0
```

**Vì sao nó nguy hiểm hơn nó trông.** Rỗng trông y hệt *"không lấn phạm vi"* — đúng cái bẫy mà rule §2
đã cảnh báo cho `git diff` trần: *"nó im lặng, và im lặng trông y hệt không đổi gì"*. Nhưng `owner-T-14`
`owner-T-22` còn tệ hơn rỗng: chúng in ra một diff **thật, dài, hợp lý** của task khác, và owner ký nhận
một thay đổi mình chưa từng nhìn.

**Cách sửa đề xuất.** Chỉ đổi lệnh của task **đã xong** — 12 lệnh ở `owner-T-14` `owner-T-22` `owner-T-24`
cộng 3 lệnh ở `owner-T-02` — sang sha ghim, và thêm vào [CLAUDE.md §4](CLAUDE.md) bước ghi sổ một vế:
*commit xong thì thay `HEAD` trong bảng soi của chính task đó bằng sha vừa tạo*. Sửa kèm ví dụ `owner-T-02`
ở rule §2 để lần chép sau chép đúng.

**Bẫy khi sửa.** Đừng đổi cả 50 lệnh sang sha: 44 lệnh thuộc task **chưa làm**, chưa có sha nào để ghim,
và ghim bừa tạo ra lệnh đỏ vĩnh viễn — thứ mà `design/BA/04-yeu-cau.md` §2 gọi là *biên nhận đỏ vĩnh viễn
thì phiên sau học cách bỏ qua nó*. Với task chưa làm, `HEAD` là **đúng**.

---

### F-16

**Mệnh đề sai.** Lệnh **(e)** ở [bao-cao-thay-doi.md](.claude/rules/bao-cao-thay-doi.md) §3 là lệnh duy
nhất trong repo bắt được [F-15](#f-15), và nó không chạy được: thân nó gồm hai dòng chú thích văn xuôi
cộng `git log --oneline -3 -- <path>`, trong đó `<path>` là chỗ trống cho người tự điền — không phải một
vòng lặp đọc `task.md`. Bốn lệnh còn lại (a) (b) (c) (d) không đọc cột `Câu lệnh để thấy thay đổi` lần nào.

**Vì sao nó không tự mất đi.** T-14 — task tạo ra rule này — đã ✅ ĐÓNG, và ô biên nhận của nó chỉ đòi
**ba** lệnh **(b) (c) (d)**; (e) bị bỏ ra khỏi bộ bắt buộc ngay từ dòng task, nên nó chưa từng phải chạy
một lần nào. Không dòng task nào còn mở chạm tới §3.

**Lệnh tái hiện.**

```bash
sed -n '/^# e\./,/^```/p' .claude/rules/bao-cao-thay-doi.md | grep -c '<path>'   # ra 1 — chỗ trống
grep -c '(b) (c) (d)' task.md                                                    # ra 1 — (e) không có trong biên nhận T-14
```

**Cách sửa đề xuất.** Thay thân (e) bằng vòng lặp chạy được, và đưa nó vào bộ bắt buộc cùng (b) (c) (d).
Bản đã thử chạy — nó in ra đúng 32 dòng, trong đó `owner-T-02` là ba dòng đầu:

```bash
# (e) đỏ khi: một lệnh ở cột "Câu lệnh để thấy thay đổi" in ra rỗng
awk '/^### owner-T-[0-9]*$/{t=$2} /^\| .*\| `git (show|diff)[^`]*` \|/{ \
  match($0,/`git [^`]*`/); c=substr($0,RSTART+1,RLENGTH-2); \
  cmd=c " 2>/dev/null | head -1"; cmd | getline out; close(cmd); \
  if (out=="") print "LỆNH RỖNG: " t " -> " c; out="" }' task.md
```

**Bẫy khi sửa.** Lệnh này in rỗng cho **mọi** task chưa làm, và đó là đúng — chưa có commit thì không có
gì để chiếu. Đưa nó vào bộ bắt buộc mà không lọc theo trạng thái dòng task là biến nó thành 20 dòng nhiễu
mỗi phiên, và nhiễu thì bị bỏ qua y như rỗng. Lọc bằng `^| ~*\*\*T-` + dấu gạch, chỉ soi task đã xong.

**Kiểm chứng.** T-26 · 2026-08-24. Thân (e) nay là vòng lặp đọc `task.md`, lọc theo dòng đã gạch, và §3
khai cả năm lệnh là bắt buộc:

```bash
sed -n '/^## 3\./,/^## 4\./p' .claude/rules/bao-cao-thay-doi.md | grep -c '<path>'   # ra 0 — hết chỗ trống
sed -n '/^## 3\./,/^## 4\./p' .claude/rules/bao-cao-thay-doi.md | grep -c 'bắt buộc' # ra 2 — (e) đã vào bộ bắt buộc
sed -n '/^# e\. /,/^```$/p' .claude/rules/bao-cao-thay-doi.md | grep -v '^```$' | bash \
  | grep -cE 'T-(0[3-9]|1[0356]|25)'                                                  # ra 0 — không nhiễu task chưa làm
```

Khối (e) chạy thật in **8 dòng**, tất cả là `owner-T-11` `owner-T-14` `owner-T-22` `owner-T-24` — đúng
bốn task đã gạch còn ghim `HEAD`, tức [F-15](#f-15), thứ mà (e) sinh ra để bắt. **Đã thử làm đỏ:** bỏ một
dấu `~` trong bộ lọc (`~~` → `~*`) trên bản sao ở scratchpad ⇒ 8 dòng thành **49**, và lệnh soi ra **20**
thay vì `0` — đúng cái bẫy *nhiễu bị bỏ qua y như rỗng* mà mục này cảnh báo.

**Bài học giữ lại:** luật đổi ở [bao-cao-thay-doi.md](.claude/rules/bao-cao-thay-doi.md) §3 đoạn cuối —
**cả năm lệnh (a) (b) (c) (d) (e) đều bắt buộc, không có bộ rút gọn.** Gốc của F-16 không phải lệnh viết
dở, mà là ô biên nhận của T-14 chỉ đòi **ba** lệnh: một lệnh có tên trong rule nhưng không có tên trong
biên nhận của task nào thì **chưa từng phải chạy một lần nào**, nên nó hỏng mà không ai biết. Từ nay
thêm một lệnh vào rule ⇒ cùng commit đó phải nói lệnh ấy bắt buộc hay không.

---

### F-17

**Mệnh đề sai.** [CLAUDE.md §2](CLAUDE.md) trao cho `git log` vai **nhà duy nhất** của *"đã làm gì, khi
nào, ai sửa file nào"*, nhưng message commit là văn bản tự do và không lệnh nào đối chiếu nó với `--stat`
của chính commit đó. Bằng chứng còn nguyên trong lịch sử: `c386219` khai
`NON-CODE/T-11: .claude/rules/quan-ly-du-an.md, task.md, finding.md` trong khi commit đó chỉ đụng
`finding.md` và `task.md`; thay đổi thật của T-11 nằm ở `73ae2fd`, một commit tên `sdfg`.

**Vì sao nó không tự mất đi.** [quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) §5.3 lệnh thứ ba chỉ
soi **hình dạng** message của 5 commit gần nhất (`<LANE>/T-xx:`); nó xanh với một message đúng khuôn mà
khai sai file, và nó không nhìn quá 5 commit. Không dòng task nào chạm chỗ này.

**Lệnh tái hiện.**

```bash
git show --stat c386219 | tail -4                     # chỉ finding.md và task.md
git log --format='%h %s' -- .claude/rules/quan-ly-du-an.md | grep -c c386219   # ra 0
git log --oneline | grep -cE '^[0-9a-f]+ (sdfg|sdgr|sdgf)$'                    # ra 3 commit vô danh
```

**Vì sao nó nguy hiểm hơn nó trông.** Cả cơ chế soi của owner ([F-15](#f-15)) dựa vào việc tra sha **theo
message**. Message sai thì sha tra ra sai, và bảng soi in ra diff của commit khác — không cách nào phát
hiện từ trong bảng.

**Cách sửa đề xuất.** Một lệnh rà, gắn vào [T-15](task.md) (task dựng hook `.claude/settings.json`) vì
đây đúng loại luật mà [CLAUDE.md §8](CLAUDE.md) xếp về hook: đối chiếu danh sách file trong message với
`git show --numstat`, in ra commit nào khai file mình không đụng. Bản `PostCommit`/`Stop` chỉ **nhắc**,
không chặn — theo đúng ràng buộc đã ghi ở ô `Bẫy` của T-15.

**Bẫy khi sửa.** Đừng rà ngược toàn bộ lịch sử rồi sửa message cũ: `git rebase` viết lại sha, và mọi sha
đã ghim trong bảng soi owner (`4e70569`, `1e3c963`, `c386219`…) chết theo. Chỉ rà từ commit kế tiếp.

---

### F-18

**Mệnh đề sai.** Không cơ chế nào bắt được trạng thái *task đã xong trong `git` mà dòng trong sổ còn mở*.
T-02 đã commit đủ đầu ra ở `4851d17` ngày 2026-08-23 09:36 và cả **năm** vế biên nhận của nó xanh hôm nay,
nhưng dòng vẫn là `| **T-02** 🔺` — mang cả dấu ưu tiên chặn. Bước 2 của [CLAUDE.md §3](CLAUDE.md) dò
*"dòng 🔺 đầu tiên"* nên nó dò đúng vào T-02, và phiên sau mở ra để làm lại việc đã xong.

**Vì sao nó không tự mất đi.** Bước 7 §3 (*ghi sổ rồi đóng*) là câu chữ, không phải cưỡng chế. Phiên bị
cắt giữa chừng, hoặc phiên bị **cấm chạm `task.md`** — đúng trường hợp T-02, ô `Prompt mở session` của nó
viết *"chỉ chạm `design/BA/**`, `.claude/rules/lane-ba.md` và đúng một dòng `CLAUDE.md` §1"* — thì không
ai còn quyền đóng dòng. Kế hoạch không có dòng nào dựng ra cơ chế thay thế.

**Lệnh tái hiện.**

```bash
for t in $(grep -o '^| \*\*T-[0-9]*\*\*' task.md | grep -o 'T-[0-9]*'); do \
  git log --format='%s' | grep -q "/$t:" && echo "SỔ LỆCH GIT: $t"; done   # ra T-02 và T-12
```

**Vì sao nó nguy hiểm hơn nó trông.** Lệnh trên **không dùng làm cổng được**, và đó là phần cứng nhất của
finding này: nó báo cả `T-12`, trong khi T-12 chưa hề được làm — `34b3171` mang nhãn `NON-CODE/T-12:`
nhưng nội dung message nói rõ nó chỉ *"mở T-12 T-13"*. Khuôn message `<LANE>/<T-xx>:` ở
[CLAUDE.md §4](CLAUDE.md) không phân biệt commit **làm** T-xx với commit **mở** T-xx, nên không cơ chế
tự động nào đọc `git` mà kết luận được một task đã xong hay chưa.

**Cách sửa đề xuất.** Hai vế, và phải làm cả hai vì vế nào một mình cũng không đủ:
**(i)** [CLAUDE.md §4](CLAUDE.md) thêm một vế cho task bị cấm chạm `task.md`: kết phiên phải để lại
**dòng bàn giao** nêu mã task cần đóng và sha đóng nó — hôm nay T-02 đã làm đúng tinh thần này ở
`design/BA/04-yeu-cau.md` §4 mục 2 (*"Đóng T-02 xong thì vế 5 tự đỏ"*) nhưng ghi vào file lane, xem [F-19](#f-19).
**(ii)** siết khuôn message: commit **làm** một task giữ tiền tố `<LANE>/<T-xx>:`, commit chỉ **mở** task
mới dùng `<LANE>/ngoài-sổ:` — khuôn `ngoài-sổ` đã có sẵn và đang được dùng đúng ở `0745429` và `1e3c963`.
Xong (ii) thì lệnh tái hiện ở trên thành cổng chạy được.

**Bẫy khi sửa.** Đừng đóng T-02 trước khi có một dòng task pha 0 trong sổ: [F-19](#f-19) chỉ ra rằng
đóng nó làm vế 5 của §5.2b đỏ ngay.

---

### F-19

**Mệnh đề sai.** Một cơ chế đang hỏng được ghi **ngoài sổ lỗi**: `design/BA/04-yeu-cau.md` §4 mục 2 (*"Đóng T-02 xong thì vế 5 tự đỏ"*) mô tả đủ
và đúng chuyện *đóng T-02 làm lệnh §5.2b in `LANE NỬA VỜI: ba không dòng task nào`* — vì mẫu dò của §5.2b
là `^| \*\*T-` , không khớp dòng đã bọc `~~`, và T-02 là dòng task BA duy nhất. Nhưng
`grep -c 'LANE NỬA VỜI' finding.md` ra `0`: sổ lỗi không biết chuyện này tồn tại.

**Vì sao nó không tự mất đi.** Định tuyến [CLAUDE.md §1](CLAUDE.md) cho lane NON-CODE sở hữu `task.md`
`finding.md` `CLAUDE.md` `.claude/rules/**` `quality/**` — **không** có `design/BA/**`, đó là lane BA.
Nên chỗ hụt này chỉ đọc được bởi lane không có quyền sửa nó, và lane có quyền sửa không được nạp file
chứa nó. Cùng cái bẫy lặp nguyên xi ở [T-06](task.md) [T-07](task.md) [T-08](task.md) [T-09](task.md),
mỗi lane cũng chỉ có đúng một dòng task mở lane.

**Lệnh tái hiện.**

```bash
grep -c 'LANE NỬA VỜI' finding.md                     # ra 0 — sổ lỗi không biết
grep -rln 'LANE NỬA VỜI' --include='*.md' .            # ra task.md, design/BA/04-yeu-cau.md, rule
sed 's/| \*\*T-02\*\* 🔺 | BA |/| ~~**T-02**~~ ✅ | BA |/' task.md > /dev/null   # xem §4 mục 2 của file đó để chạy đầy đủ
```

**Cách sửa đề xuất.** Hai chỗ, chỗ thứ hai mới là gốc.
**(i)** Vá mẫu của §5.2b thành `^| ~*\*\*T-[0-9]*\*\*~* *[^|]*| *<LANE> ` — chấp nhận cả dòng đã gạch.
Khuôn `~*` này đã được dùng **đúng** ở [bao-cao-thay-doi.md](.claude/rules/bao-cao-thay-doi.md) §3 lệnh
(b) và (c); §5.2b chỉ là quên nó. Đã thử: bản vá xanh khi T-02 bị gạch, và **đỏ đúng** khi xoá hẳn dòng BA.
**(ii)** [CLAUDE.md §1](CLAUDE.md) hoặc [quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) §6 thêm một vế
vào quy trình mở lane: chỗ hụt phát hiện trong lúc mở lane ghi vào [finding.md](finding.md), không ghi vào
file của lane — vì lane khác sẽ không bao giờ đọc nó.

**Bẫy khi sửa.** Vá (i) mà bỏ (ii) là dọn đúng một hậu quả: lần sau lane DB hay BE cũng sẽ ghi chỗ hụt
của mình vào `design/data_base/` hay `design/backend/`, và không lane nào ngoài nó đọc được.

---

### F-20

**Mệnh đề sai.** Bảng `cl-T-02` khai vế `Đỏ khi: ra hai đường dẫn khác nhau`, nhưng lệnh của nó —
`grep -o 'design/BA[^ )]*' CLAUDE.md .claude/rules/lane-ba.md | sort -u` — in ra **8 dòng khác nhau** ngay
cả khi lane hoàn toàn đúng, vì lớp `[^ )]*` nuốt luôn dấu markdown ở cuối đường dẫn (`"`, backtick, `.`,
`](`). Vế `Đỏ khi` vì vậy **luôn đúng**, và ô đó là một cổng đỏ giả vĩnh viễn.

**Vì sao nó không tự mất đi.** [T-20](task.md) và [T-21](task.md) đưa vế `đỏ khi` xuống **ô biên nhận**,
[T-19](task.md) viết tầng chất lượng cho pha 0 — không dòng nào rà lại **lệnh đã viết trong 23 bảng
`cl-T-xx`**. Ô `Chất lượng` của T-02 hôm nay là `⬜ chưa đo`, nên chưa ai chạy lệnh này lần nào; nó sẽ
được chạy lần đầu đúng lúc có người định ký nhận.

**Lệnh tái hiện.**

```bash
grep -o 'design/BA[^ )]*' CLAUDE.md .claude/rules/lane-ba.md | sort -u | wc -l   # ra 8, kỳ vọng 1
```

**Vì sao nó nguy hiểm hơn nó trông.** Lệnh này được viết để bắt đúng một chỗ hụt thật: vế 3 của biên nhận
T-02 là `head -6 .claude/rules/lane-ba.md`, mà `head` **luôn** thoát mã `0` — đổi `paths:` sang
`design/DB/**` thì vế 3 vẫn xanh. Đã thử làm hỏng thật: lệnh `cl-T-02` chạy trên bản hỏng đó chỉ **mất
đúng một dòng** trong tám, người soi không nhận ra. Nên chỗ hụt mà nó sinh ra để canh vẫn đang không có ai canh.

**Cách sửa đề xuất.** Cắt đuôi dấu câu và khai lại vế âm cho đọc được. Bản đã thử chạy:

```bash
grep -ohE 'design/[A-Z]+/[A-Za-z0-9._/-]*' CLAUDE.md .claude/rules/lane-ba.md | sed 's|/*$||' | sort -u
# xanh: ra design/BA và design/BA/04-yeu-cau.md
# đỏ khi: in ra bất kỳ dòng nào không bắt đầu bằng design/BA — đã thử với paths: đổi sang design/DB/**, ra thêm dòng design/DB
```

Sửa kèm vế 3 của ô biên nhận T-02 thành lệnh có mã thoát:
`head -6 .claude/rules/lane-ba.md | grep -q '"design/BA/\*\*"'` — đã thử, xanh trên file thật và **đỏ đúng**
trên bản đổi sang `design/DB`.

**Bẫy khi sửa.** Đừng chỉ sửa lệnh của `cl-T-02`. `grep -c 'design/BA\[^ )\]' task.md` ra 1 hôm nay, nhưng
khuôn `[^ )]*` là thứ 22 bảng `cl-T-xx` còn lại sẽ chép khi tới lượt chúng được đo — chỗ cần sửa cùng lúc
là một dòng ví dụ trong [quality/00-guideline-chat-luong.md](quality/00-guideline-chat-luong.md).

---

### F-21

**Mệnh đề sai.** Hai cổng ở [.claude/rules/chat-luong-finding.md](.claude/rules/chat-luong-finding.md) §3
lấy danh sách mã bằng `grep -o 'F-[0-9]*'` chạy trên **cả dòng bảng**, nên mọi mã `F-xx` được **nhắc trong
ô** `Mệnh đề đang sai` cũng bị duyệt như thể nó là mã của chính dòng đó. Cổng (a) vì vậy duyệt **25 mã**
cho **18 dòng 🔴**, và trong 25 mã đó có `F-03` — một mã **đã đóng**, bị đem đi đo bằng khuôn **mở**.

**Vì sao nó không tự mất đi.** Chạy hết `task.md` y như nó viết thì dòng này còn: `T-23` vá 5 mục *cho
cổng (a) xanh* — nó **tin** cổng đang đọc đúng mã; không dòng task nào chạm §3 của rule. Cổng sai theo
hướng **đỏ giả trên mã đã đóng** còn nguy hơn: mục đóng dùng khuôn đóng, thiếu vế mở là **đúng luật**, nên
người sửa sẽ nhét vế mở vào một mục đã đóng để dập đỏ — hỏng đúng khuôn mà §1 vừa dựng.

**Lệnh tái hiện.** Hai số phải bằng nhau, chúng lệch `25` với `18`:

```bash
grep -o '^| \[F-[0-9]*\].*🔴 MỞ' finding.md | grep -o 'F-[0-9]*' | wc -l   # mẫu cũ: 25
grep '^| \[F-[0-9]*\].*🔴 MỞ' finding.md | sed 's/^| \[\(F-[0-9]*\)\].*/\1/' | wc -l   # đúng: 18
grep -o '^| \[F-[0-9]*\].*🔴 MỞ' finding.md | grep -o 'F-[0-9]*' | sort -u | grep -x 'F-03'  # mã đã đóng lọt vào
```

**Cách sửa đề xuất.** Lấy mã **đầu dòng** bằng `sed` thay cho `grep -o` ở cả hai cổng — mã của dòng luôn
là chuỗi ngay sau `| [`, còn mã tham chiếu thì không bao giờ ở đó:
`grep '^| \[F-[0-9]*\].*🔴 MỞ' finding.md | sed 's/^| \[\(F-[0-9]*\)\].*/\1/'`. Sửa ngay trong phiên
rà, không đẻ task: đây là một dòng lệnh trong rule mà lane NON-CODE sở hữu.

**Kiểm chứng.** Sau vá, hai cổng duyệt đúng số mã của bảng — `18` mở và `2` đóng — và không mã đã đóng
nào lọt vào cổng (a):

```
$ grep '^| \[F-[0-9]*\].*🔴 MỞ' finding.md | sed 's/^| \[\(F-[0-9]*\)\].*/\1/' | wc -l
18
$ grep '^| \[F-[0-9]*\].*✅ ĐÓNG' finding.md | sed 's/^| \[\(F-[0-9]*\)\].*/\1/' | wc -l
2
$ <cổng (a) §3>
THIẾU VẾ: F-06 Lệnh-tái-hiện
THIẾU VẾ: F-07 Cách-sửa
THIẾU VẾ: F-08 Cách-sửa
THIẾU VẾ: F-12 Cách-sửa
THIẾU VẾ: F-13 Vì-sao-không-tự-mất
$ <cổng (b) §3>
(rỗng)
```

Năm dòng còn lại là **nợ thật** của [T-23](task.md), không phải đỏ giả — trước vá chúng lẫn với mã tham
chiếu nên không ai phân biệt được hai loại đỏ. **Đã thử làm đỏ:** trên bản sao ở scratchpad, gỡ vế
`**Cách sửa đề xuất.**` khỏi mục **đã đóng** `F-03` (hợp lệ theo khuôn đóng §1): mẫu cũ in
`THIẾU VẾ: F-03 Cách-sửa`, mẫu mới im.

**Bài học giữ lại:** lệnh rà đọc một **bảng** phải neo vào **vị trí** của ô, không vào **hình dạng** của
mã — `grep -o` trên cả dòng luôn vét thêm mọi con trỏ mà ô đó nhắc tới. Luật này đã vào
[rule §3](.claude/rules/chat-luong-finding.md) ngay dưới khối lệnh, cùng chỗ đã nói *mục đã đóng không qua cổng (a)*.
Đây là họ hàng của [F-05](#f-05) và [F-09](#f-09) — cùng gốc: lệnh tự rà viết bằng khuôn lỏng thì hỏng
theo hướng **im lặng** hoặc **đỏ giả**, và cả hai đều dạy phiên sau bỏ qua nó.

---

### F-22

**Mệnh đề sai.** Khuôn một mục ở [.claude/rules/chat-luong-finding.md](.claude/rules/chat-luong-finding.md)
§1 không có vế nào giữ **tiêu chí thành công** ở thời điểm **mở**: vế duy nhất mang lệnh phán quyết —
`**Kiểm chứng.**` — được khai `Bắt buộc khi: **đóng**`. Người đóng finding vì vậy **tự chọn lệnh chứng minh
sau khi đã sửa xong**, và lệnh chọn sau thì gần như luôn xanh. Đo trên sổ hôm nay: **14/18** mục 🔴 không
có lấy một vế `đỏ khi`.

**Vì sao nó không tự mất đi.** Chạy hết `task.md` y như nó viết thì dòng này còn: `T-20` và `T-21` đưa vế
`đỏ khi` xuống ô `Đầu ra kiểm chứng được` của **`task.md`** — không dòng nào chạm sổ lỗi; `T-23` vá 5 mục
theo đúng khuôn **4 vế hiện có**, tức nó củng cố khuôn thiếu chứ không sửa. Bảng ánh xạ TP → nhà ở
[quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) §7 cũng chỉ phủ **dòng task**: TP4 của nó là ô
`Đầu ra kiểm chứng được`; mục `### F-xx` — thứ phiên sau nạp làm đầu vào y hệt một dòng task — không có
hàng nào trong bảng đó.

**Lệnh tái hiện.** Hai lệnh, chạy từ gốc repo:

```bash
# 1. mục 🔴 không khai nổi một vế âm — ra 14 trên 18
for f in $(grep '^| \[F-[0-9]*\].*🔴 MỞ' finding.md | sed 's/^| \[\(F-[0-9]*\)\].*/\1/'); do \
  sed -n "/^### $f\$/,/^### F-/p" finding.md | grep -qi 'đỏ khi' || echo "MỞ KHÔNG TIÊU CHÍ ĐÓNG: $f"; done | wc -l
# 2. vế mang lệnh phán quyết được khai bắt buộc ở phía nào — in ra **đóng**
sed -n '/^## 1\./,/^## 2\./p' .claude/rules/chat-luong-finding.md | grep 'Kiểm chứng' | grep -o '\*\*đóng\*\*'
```

**Cách sửa đề xuất.** Thêm **một** vế bắt buộc-khi-**mở** vào khuôn §1, gánh cả TP4 lẫn TP6 của
[cau-truc-prompt-tot.md](prompt/huong_dan_prompt/cau-truc-prompt-tot.md):

> `**Đóng khi.**` — lệnh sẽ chứng minh mệnh đề **hết đúng**, viết **lúc mở**, kèm vế `đỏ khi …`, và nêu
> **file được phép chạm** khi sửa. Chưa nghĩ ra lệnh ⇒ `**Chưa đóng được bằng lệnh vì:**` + lý do.

Nó khác `**Kiểm chứng.**` ở chỗ: `Đóng khi` là hợp đồng viết **trước**, `Kiểm chứng` là output thật dán
**sau**; người đóng phải làm xanh đúng lệnh người mở đã chọn, đổi lệnh giữa chừng là đổi mệnh đề. Chẻ làm
hai task theo đúng tiền lệ `T-20`/`T-21`: [T-31](task.md) đưa vế vào rule §1 + cổng (c) ở §3,
[T-32](task.md) áp xuống 18 mục đang mở.

**Bẫy khi sửa.** §3 của rule đang **22/22 dòng** — kịch trần mục ở §5 của chính nó. Thêm cổng (c) là +1
dòng, nên `T-31` phải **gộp** hai dòng có sẵn trong cùng commit; nới trần §5 cho đủ chỗ là chọn đường dễ,
và trần đó là thứ duy nhất giữ cho `grep -n` thay được việc đọc cả file.

**Vì sao nó nguy hiểm hơn nó trông.** Chỗ hụt này không lộ ra ở mục đang mở — nó lộ ra **đúng một lần**,
ở giây phút một finding được đóng, và lúc đó không ai còn đọc lại nó nữa. Sổ lỗi có 20 mã, mỗi mã đóng
một lần: hỏng ở đây là hỏng ở khâu **không lặp lại được**.

---

### F-23

**Mệnh đề sai.** [CLAUDE.md](CLAUDE.md) §7 khai *"Chưa có `Makefile`"* và *"⚠️ `make check` … hiện không chạy
được"*; [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) §3 khai *"Repo chưa có `Makefile`"* và
xếp `make ...` vào danh sách **không được tính là biên nhận ở giai đoạn này**. Từ commit `9699f1c` cả ba mệnh đề
đó đã sai: `Makefile` có thật, `make check` chạy được, ra mã thoát `0`.

**Lệnh tái hiện.**

```bash
make check >/dev/null 2>&1 && echo "make check: ma thoat 0"
grep -n 'Chưa có `Makefile`' CLAUDE.md
grep -n 'Repo chưa có `Makefile`' .claude/rules/quan-ly-du-an.md
```

Ba dòng cùng in ra một lúc: lệnh thứ nhất nói cổng đã chạy được, hai lệnh sau nói tài liệu vẫn khai nó chưa có.

**Vì sao nó không tự mất đi.** Chạy hết [task.md](task.md) y như nó viết: `T-04` chỉ chạm `quality/**` + **đúng
một dòng** `CLAUDE.md` §2 (ô *Định nghĩa XONG khi đã có compiler*); `T-06` chỉ chạm `.claude/rules/lane-devops.md`
+ **đúng một dòng** §1. Không dòng task nào nhận việc sửa §7 hay rule §3, và ô `Nạp` của cả hai không mở hai chỗ
đó ra. Dòng này **còn** ⇒ finding.

**Vì sao nó nguy hiểm hơn nó trông.** ⚠️ trong repo này có nghĩa *"đừng tin biên nhận này, nó chưa chạy được"*.
Để nguyên nó trên một lệnh **đã** chạy được thì phiên sau đọc §7 sẽ không gõ `make check`, mà quay lại dán tay
từng `grep -c` — cổng vừa dựng thành cổng không ai đi qua, và `T-04`…`T-09` mất đúng thứ `T-03` sinh ra để cho
chúng. Chiều ngược lại đã có người canh: §5.3 lệnh 2 bắt `make ...` viết **thiếu** ⚠️. Chiều ⚠️ **thừa** thì
không lệnh nào canh — biên nhận trôi theo hướng bi quan không bao giờ đỏ ở đâu cả.

**Cách sửa đề xuất.** Một task NON-CODE, 3 file, một đầu ra: (1) `CLAUDE.md` §7 bỏ `Makefile` khỏi danh sách chưa
có và đổi ⚠️ `make check` thành biên nhận thật, **giữ** ⚠️ cho `go test` và `npm run build` — hai thứ đó vẫn chưa
cài; (2) rule §3 đoạn *"Khi `Makefile` đã có (T-03)"* viết lại theo hiện trạng; (3) thêm vào rule §5.3 lệnh
nghịch đảo của lệnh 2:

```bash
grep -n '⚠️[^|]*make check' CLAUDE.md .claude/rules/*.md \
  | while read l; do make check >/dev/null 2>&1 && echo "⚠️ THỪA (lệnh đã ra mã thoát 0): $l"; done
```

**Đỏ khi:** một file luật còn ⚠️ trên một lệnh vừa ra mã thoát `0`. **Xanh khi:** hoặc lệnh còn hỏng thật, hoặc
⚠️ đã gỡ. Chạy hôm nay lệnh này **đỏ** — đó là bằng chứng của chính mục này.

**Bẫy khi sửa.** §7 đang là chỗ duy nhất nói *"biên nhận thật của giai đoạn này là lệnh đọc lại"*. Gỡ ⚠️ khỏi
`make check` mà xoá luôn câu đó là mở đường cho phiên sau khai `go test` là biên nhận trong khi Go chưa cài —
đúng cái bẫy mà ô `Bẫy` của [T-03](task.md) đã dựng hàng rào. Gỡ **một** dấu ⚠️, không gỡ cả đoạn.

---

### F-24

**Mệnh đề sai.** [CLAUDE.md §4](CLAUDE.md) khai cách chống nuốt việc của phiên khác là: *"stage bằng
`git add <đường dẫn cụ thể>` — liệt kê từng file, để việc dở của phiên khác không bị nuốt theo."* Cách đó
**chỉ chặn được file khác**, không chặn được **cùng một file**. Hai phiên song song trong repo này đều
sửa `task.md` và `finding.md` — tức đúng cái mà `git add` lấy nguyên vẹn cả file — nên `git add task.md`
của phiên A nuốt trọn phần `task.md` phiên B đang viết dở, dù A đã liệt kê từng đường dẫn đúng như luật.

**Lệnh tái hiện.** Hôm nay, phiên DEVOPS đóng `T-03` (sửa `task.md`, mở `F-23` trong `finding.md`), phiên
NON-CODE chạy song song commit `0d2a785` với message *"đóng F-21, mở F-22 + T-31 T-32"*:

```bash
git show --stat 0d2a785            # 3 file, trong đó task.md + finding.md
git show 0d2a785 -- task.md | grep -c 'T-03'   # ra > 0: việc của phiên DEVOPS nằm trong commit của phiên khác
git log --oneline -1 -- Makefile   # 9699f1c: nửa còn lại của cùng một task, ở commit khác, khai lane khác
```

**Vì sao nó không tự mất đi.** Chạy hết [task.md](task.md) y như nó viết: không dòng nào đổi cách stage.
[F-07](#f-07) nằm ở bước 4 (ĐIỂM LÙI, *trước* khi gõ) và ba hướng sửa của nó đều là kiến trúc chờ owner;
dòng này nằm ở §4 (*lúc commit*) và mệnh đề của nó là **một câu luật đang khai sai mức bảo vệ nó cho**.
Sửa xong F-07 theo hướng 1 hay 2 thì câu ở §4 vẫn sai. Dòng này **còn** ⇒ finding.

**Vì sao nó nguy hiểm hơn nó trông.** Nuốt việc không để lại dấu đỏ nào: cây sạch, `make check` xanh,
`git log` hợp khuôn. Cái mất là **truy vết** — [CLAUDE.md §2](CLAUDE.md) trao cho `git log` vai nhà duy
nhất của *"ai sửa file nào"*, mà `0d2a785` giờ khai sai cả lane lẫn mã task cho một nửa nội dung của nó.
Đó chính là [F-17](#f-17) sinh thêm một ca mới, lần này do luật §4 chỉ đường sai chứ không do người viết ẩu.

**Cách sửa đề xuất.** Đổi câu ở §4 thành hai vế, và ghi kỹ thuật vào
[.claude/rules/bao-cao-thay-doi.md](.claude/rules/bao-cao-thay-doi.md): (1) *file không ai khác chạm* ⇒
`git add <đường dẫn>` như cũ; (2) *file đang bẩn vì phiên khác* ⇒ **không** `git add` cả file, mà dựng
bản vá chỉ chứa hunk của mình rồi nạp thẳng vào index:

```bash
git show HEAD:task.md > /tmp/base            # bản gốc
cp /tmp/base /tmp/mine && <áp đúng sửa đổi của phiên này lên /tmp/mine>
git diff --no-index /tmp/base /tmp/mine | sed 's|/tmp/base|a/task.md|; s|/tmp/mine|b/task.md|' > /tmp/p
git apply --cached /tmp/p && git commit -m '...'   # index = HEAD + phần của tôi; cây vẫn giữ cả hai phiên
```

**Đỏ khi:** `git show --stat <commit>` liệt kê một file mà bảng thay đổi của phiên đó không có dòng nào.
Đây là lệnh (e) mà [F-16](#f-16) đang nói là chưa chạy được — sửa F-16 thì phép đo này có sẵn người canh.

**Bẫy khi sửa.** Đừng sửa bằng cách cấm hai phiên chạy cùng lúc — đó là hướng của [F-07](#f-07) và là quyền
owner. Mục này chỉ đòi câu ở §4 khai **đúng** mức bảo vệ mà `git add <đường dẫn>` thật sự cho: nó chống
lẫn file, không chống lẫn hunk.

---

### F-25

**Mệnh đề sai.** [Guideline §5](quality/00-guideline-chat-luong.md) bắt *"người viết phải thử làm nó đỏ
đúng một lần trước khi commit"*, và mỗi bảng `### cl-T-xx` có sẵn dòng `**Đã thử làm đỏ:**` để ghi lại.
Nhưng **không lệnh nào trong repo đọc dòng đó**: khối tự rà §5.2 của
[quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) đếm cột, dò mã, dò lane — không nhánh nào chạm bảng
`cl-*`. Kết quả: 28/31 bảng đang `⬜ chưa`, và một lệnh soi viết sai nằm im cho tới khi có người đọc nó
bằng mắt.

**Lệnh tái hiện.**

```bash
grep -c 'Đã thử làm đỏ:\*\* ⬜' task.md   # ra 28
grep -c 'Đã thử làm đỏ:\*\* ✅' task.md   # ra 3
grep -c '^### cl-T-' task.md              # ra 31 — 28/31 chưa ai chạy thử
```

Ca cụ thể, phát hiện lúc rà ô của [T-04](task.md): trục *Một nhà* của `cl-T-04` khai
`grep -c 'go test\|npm run'` trên hai file, **đỏ khi cả hai cùng `>= 1`**. Nhưng
`grep -n 'go test\|npm run' .claude/rules/quan-ly-du-an.md` ra **2 dòng**, trong đó dòng 211 nằm **trong
thân câu lệnh** của §5.2 (`grep -rn 'make \|go test\|npm run' …`) nên không xoá được. Vế "cả hai cùng
`>= 1`" vì thế đỏ bất kể checklist viết thế nào — cùng họ với [F-20](#f-20) (đỏ giả) và [F-13](#f-13)
(xanh giả). Bảng `cl-T-04` đã được vá trong chính commit mở mục này; 28 bảng còn lại thì chưa ai biết.

**Vì sao nó không tự mất đi.** Chạy hết [task.md](task.md) y như nó viết: [T-20](task.md) và
[T-21](task.md) thêm vế `đỏ khi` vào ô `Đầu ra kiểm chứng được` — **ô khác**, không phải cột `Lệnh soi`
của bảng `cl-*`. [T-29](task.md) vá đúng **một** bảng (`cl-T-02`). [T-31](task.md) thêm cổng **(c)** cho
khuôn `finding.md`, không chạm `task.md`. Không dòng nào dựng cổng đọc `**Đã thử làm đỏ:**`, nên chạy hết
kế hoạch xong con số vẫn là 28 — dòng này **còn** ⇒ finding.

**Vì sao nó nguy hiểm hơn nó trông.** Bảng `cl-*` là tầng đo **chất lượng**, tức tầng duy nhất đứng trên
ô biên nhận. Ô biên nhận hỏng thì [F-13](#f-13) đã có người canh; bảng `cl-*` hỏng thì **không tầng nào ở
trên nữa** — nó chính là người canh cuối. Một `cl-*` đỏ vĩnh viễn bị bỏ qua sau hai lần đúng như
[guideline §5 mục 3](quality/00-guideline-chat-luong.md) mô tả, và từ lần thứ ba cột `Chất lượng` chỉ còn
là một cột ký hiệu.

**Cách sửa đề xuất.** Thêm một nhánh vào khối §5.2 của
[quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) — mỗi dòng task **đã `✅`** mà bảng `cl-` của nó còn
`⬜` thì in ra một dòng cảnh báo:

```bash
for x in $(grep '^| ~~\*\*T-[0-9]*\*\*~~ ✅' task.md | sed 's/^| ~~\*\*\(T-[0-9]*\)\*\*~~.*/\1/'); do
  sed -n "/^### cl-$x\$/,/^### cl-T-/p" task.md | grep -q 'Đã thử làm đỏ:\*\* ✅' \
  || echo "CHƯA THỬ ĐỎ: $x"; done
```

Gắn vào [T-21](task.md) (nó đã đi qua mọi dòng biên nhận) hoặc mở một dòng task riêng. **Đỏ khi:** đổi tạm
một bảng `cl-` của task đã `✅` về `⬜` ⇒ lệnh phải in `CHƯA THỬ ĐỎ: T-xx`; đổi lại thì output rỗng.

**Bẫy khi sửa.** Đừng bắt **mọi** bảng `cl-*` phải `✅` — 28 bảng kia thuộc task **chưa làm**, chưa có gì
để thử làm đỏ. Cổng chỉ được soi bảng của dòng đã `✅`, nếu không nó đỏ ngay từ lần chạy đầu và chết theo
đúng kiểu [F-11](#f-11).

---

### F-26

**Mệnh đề sai.** Ô `**Đạt khi:**` của bảng `owner-T-11` trong [task.md](task.md) viết: *"…luật không
deploy trong giờ bán **không** bị đem vào rule — luật đó mất giữa phiên là gây hỏng thật, nên **nhà của
nó là `CLAUDE.md`**"*. `CLAUDE.md` không chứa câu nào về luật đó. Nhà thật là
`project_preparation/prompt-fullstack.md` §6.9, và [guideline §6](quality/00-guideline-chat-luong.md)
đang trỏ đúng về đó với chú thích *"trỏ, không chép"*.

**Lệnh tái hiện.**

```bash
grep -c 'deploy trong giờ bán' CLAUDE.md                                   # ra 0 — không có nhà nào ở đây
grep -rn 'không deploy trong giờ bán' --include='*.md' --exclude-dir=reference .
# ra: prompt-fullstack.md §6.9 (nguồn) · quality/00-guideline-chat-luong.md §6 (trỏ) · task.md (khai sai)
```

**Vì sao nó không tự mất đi.** T-11 đã xong ([F-03](#f-03) ✅ ĐÓNG). Chạy hết [task.md](task.md): không
dòng nào mở lại ô `Đạt khi` của `owner-T-11`, và không lệnh nào trong §5.2 đối chiếu một câu khai *"nhà
của X là Y"* với việc Y có thật chứa X hay không. Dòng này **còn** ⇒ finding. Nó cùng họ với
[F-17](#f-17) (khai sai file đã sửa) nhưng khác nguyên nhân: F-17 là commit message lệch `--stat`, mục
này là **một câu khai nhà** lệch nội dung nhà đó.

**Cách sửa đề xuất.** Sửa ô `Đạt khi` của `owner-T-11` cho trỏ đúng nhà thật:
*"…nhà của nó là [prompt-fullstack.md](project_preparation/prompt-fullstack.md) §6.9, `CLAUDE.md` chỉ
được trỏ"*. Nếu owner **muốn** `CLAUDE.md` thật sự thành nhà của ba luật không thoả hiệp thì đó là
*thay hoặc gộp một luật cũ* theo [CLAUDE.md §8](CLAUDE.md) — quyền owner, không phải việc sửa kèm.
**Đỏ khi:** `grep -c 'deploy trong giờ bán' CLAUDE.md` ra `0` **trong khi** `task.md` còn câu
*"nhà của nó là `CLAUDE.md`"* — hai lệnh này phải cùng xanh hoặc cùng đỏ, không được lệch nhau.

---

### F-27

**Mệnh đề sai.** `project_preparation/prompt-fullstack.md` khai **hai** bề rộng cho cùng một màn hình
khách: §3.7 viết *"Khách — mobile-first **375px**"*, §6.5 viết *"có UI thì thử ở **360px** (khách) và
768px (tablet)"*. Một trong hai là số sẽ được kiểm, số kia là số sẽ được thiết kế.

**Lệnh tái hiện.**

```bash
grep -n '375px\|360px' project_preparation/prompt-fullstack.md
# 183: - **Khách** — mobile-first 375px; …
# 295: … có UI thì thử ở 360px (khách) và 768px (tablet) …
```

**Vì sao nó không tự mất đi.** [T-10](task.md) chỉ sửa **con trỏ hụt** ([F-02](#f-02)), không đụng con
số. [T-04](task.md) chép vế 5 của §6.5 vào `quality/05-checklist.md` — chép xong thì `360px` thành luật
kiểm tra chính thức, trong khi FE đọc §3.7 dựng ở `375px`. Không lệnh nào so hai số này. Dòng **còn** ⇒
finding, và nó **xấu đi** sau T-04 chứ không mất.

**Cách sửa đề xuất.** Owner chốt **một** số rồi sửa vế còn lại cho khớp — đây là thứ thuộc quyền owner
theo [CLAUDE.md §7](CLAUDE.md) vì nó là ràng buộc thiết kế, không phải lỗi chính tả. Dữ kiện để chốt:
`360px` là bề rộng CSS nhỏ nhất còn phổ biến trên Android, `375px` là iPhone; kiểm ở số **nhỏ hơn** thì
số lớn hơn tự an toàn, chiều ngược lại thì không. Trước khi có quyết định, [T-04](task.md) nên chép
nguyên văn cả hai kèm dấu `GIẢ ĐỊNH:` thay vì chọn hộ. **Đỏ khi:** lệnh tái hiện ở trên in ra **hai** số
khác nhau cùng gắn nhãn *(khách)*; chốt xong thì nó chỉ còn in một số.

**Owner đã chốt 2026-08-24: `375px`**, theo §3.7. [T-04](task.md) viết `375px` vào
[quality/05-checklist.md](quality/05-checklist.md) §1 vế 7 kèm con trỏ về mục này, **không** dùng
`GIẢ ĐỊNH:` nữa. Finding vẫn 🔴 vì mệnh đề sai chưa hết đúng: §6.5 còn khai `360px`, nên lệnh tái hiện
vẫn in ra hai số. Đánh đổi owner nhận: `360px` hẹp hơn nên kiểm ở đó thì `375px` tự an toàn, chốt chiều
ngược lại thì màn hình Android hẹp không có ai kiểm — bù bằng cách thêm `360px` vào tầng pha FE (T-09).

---

### F-28

**Mệnh đề sai.** Lệnh soi trục *Một nhà* của bảng `cl-T-04` trong [task.md](task.md) không xanh được ở
bất kỳ trạng thái nào của repo. Nó đếm số file `.md` chứa chuỗi mốc `happy path` và khai *đỏ khi* ra
`>= 3` file **hoặc** kết quả thiếu `quality/05-checklist.md` — nhưng chính ô soi đó phải viết chuỗi mốc
ra để mô tả phép đo, nên `task.md` luôn là một hit. Chưa có checklist: ra `2` file, thiếu nhà ⇒ đỏ. Có
checklist: ra `3` file, *bản chép thứ ba* ⇒ đỏ. Cùng họ với [F-11](#f-11) — lệnh tự bắt thân mình.

**Lệnh tái hiện.**

```bash
grep -rln 'happy path' --include='*.md' --exclude-dir=reference .
```

Lệnh in ra `task.md` cùng với `project_preparation/prompt-fullstack.md` — hit thứ nhất là dòng
`503` của chính bảng soi và dòng `506` của vế `Đã thử làm đỏ`, không phải một bản chép nội dung nào.

**Vì sao nó không tự mất đi.** Chạy hết [task.md](task.md) y như nó viết: T-04 chỉ tạo checklist và sửa
đúng một dòng `CLAUDE.md` §2, ô `Context` của nó cấm chạm `task.md`. Không dòng task nào nhận việc sửa ô
soi của một task khác, và `make check` không rà nội dung bảng `cl-`. Dòng **còn** ⇒ finding.

**Cách sửa đề xuất.** Loại **hai sổ** ra khỏi phạm vi quét thay vì nới ngưỡng: thêm `--exclude=task.md
--exclude=finding.md`, và đổi *đỏ khi* thành **≠ `2`** (đếm chính xác, không phải ngưỡng dưới —
[guideline §5](quality/00-guideline-chat-luong.md) mục 1). Hai sổ là chỗ **mô tả** phép đo, không phải
nhà của nội dung §6.5, nên loại chúng không làm mất khả năng bắt bản chép thật.

**Kiểm chứng.**

```bash
grep -rln 'happy path' --include='*.md' --exclude-dir=reference --exclude=task.md --exclude=finding.md .
# project_preparation/prompt-fullstack.md
# quality/05-checklist.md          <- ra đúng 2 file, có nhà mới ⇒ xanh
```

Đã thử làm đỏ: dựng bản chép thứ ba ở scratchpad ⇒ ra `3` ≠ 2 ⇒ đỏ; xoá bản chép ⇒ xanh lại.

**Bài học giữ lại:** một lệnh soi đếm **chuỗi mốc** phải loại `task.md` và `finding.md` ra khỏi phạm vi
quét, vì hai sổ buộc phải nhắc lại chuỗi đó để mô tả phép đo. Luật này về
[guideline §5](quality/00-guideline-chat-luong.md) cùng mục với [F-29](#f-29), chung một câu: **biên nhận
đếm nội dung của một khối phải lọc đúng khối đó trước, không quét cả cây file.**

---

### F-29

**Mệnh đề sai.** Vế thứ hai trong ô `Đầu ra kiểm chứng được` của [T-04](task.md) chạy
`awk '/tầng 1/…/truy vết/…'` trên **cả** `quality/05-checklist.md`, trong khi thứ nó muốn đo là *bảy vế
§6.5 có mặt đủ trong bảy dòng `- [ ]`*. §2 của checklist nhắc lại đúng các chuỗi khoá (`sinh lại type`,
`768`, `down`) ở cột lệnh đo, nên `awk` in `7` kể cả khi một dòng `- [ ]` đã bị thay bằng mục bịa — và vế
thứ nhất `grep -c` chỉ đếm **số** dòng, không đếm nội dung. Hai vế bù nhau thành một lỗ.

**Lệnh tái hiện.**

```bash
grep -v '^- \[ \] \*\*Đổi endpoint\*\*' quality/05-checklist.md > /tmp/lo.md
echo '- [ ] mục bịa, không phải vế nào của §6.5' >> /tmp/lo.md
grep -c '^- \[ \]' /tmp/lo.md   # 7  <- biên nhận 1 xanh
awk '/tầng 1/{a=1}/happy/{b=1}/down/{c=1}/sinh lại type/{d=1}/768/{e=1}/tiếng Việt/{f=1}/truy vết/{g=1}END{print a+b+c+d+e+f+g}' /tmp/lo.md   # 7  <- biên nhận 2 xanh
```

Một bản **thiếu hẳn vế *đổi endpoint*** qua cả hai cổng của T-04.

**Vì sao nó không tự mất đi.** Chạy hết [task.md](task.md) y như nó viết: T-04 đã ✅, ô biên nhận đứng
nguyên và là thứ owner dùng để soi lại sau này; không dòng task nào nhận việc sửa ô biên nhận của một
task đã đóng, và [T-20](task.md)/[T-21](task.md) làm chất lượng ở mức khuôn chung chứ không rà từng ô.
Dòng **còn** ⇒ finding.

**Cách sửa đề xuất.** Lọc khối trước rồi mới đếm nội dung: đổi vế `awk` của T-04 thành
`grep '^- \[ \]' quality/05-checklist.md | awk '…'`. Đã thử: bản thủng ra `6` (đỏ), bản thật ra `7`
(xanh). Thêm luật chung vào [guideline §5](quality/00-guideline-chat-luong.md) — cùng câu với
[F-28](#f-28): **biên nhận đếm nội dung của một khối phải lọc đúng khối đó trước, không quét cả file.**
**Đỏ khi:** một biên nhận khai *"đếm N vế trong danh sách"* mà lệnh của nó chạy trên cả file.

---

### F-30

**Mệnh đề sai.** Vế thứ nhất trong ô `Đầu ra kiểm chứng được` của [T-26](task.md) —
`grep -c '<path>' .claude/rules/bao-cao-thay-doi.md` ra `0`, *đỏ khi chỗ trống còn nguyên* — chạy trên
**cả file**, trong khi T-26 chỉ được chạm **§3** (ô `Prompt mở session` và bảng `owner-T-26` đều chốt
vậy). `<path>` còn hai chỗ nữa ngoài §3: §1 hàng `Xem diff` và §2 hàng `Câu lệnh để thấy thay đổi`, ở đó
nó là **placeholder văn xuôi hợp lệ** đang dạy người đọc viết `git show <sha> -- <path>`. Nên ô này ra
`2` ngay cả khi (e) đã vá đúng hoàn toàn, và cách duy nhất làm nó xanh là **lấn phạm vi sang §1 §2**.

**Lệnh tái hiện.**

```bash
grep -c '<path>' .claude/rules/bao-cao-thay-doi.md                                    # ra 2 — "đỏ"
sed -n '/^## 3\./,/^## 4\./p' .claude/rules/bao-cao-thay-doi.md | grep -c '<path>'   # ra 0 — §3 đã sạch
grep -n '<path>' .claude/rules/bao-cao-thay-doi.md | cut -c1-60                       # hai dòng, cả hai ở §1 §2
```

**Vì sao nó không tự mất đi.** Chạy hết [task.md](task.md) y như nó viết: T-26 đóng xong thì ô biên nhận
của nó đứng nguyên và là thứ owner dùng để soi lại. Không dòng task nào nhận việc sửa ô biên nhận của
task đã đóng — [T-27](task.md) chỉ đụng cột `Câu lệnh để thấy thay đổi`, [T-20](task.md)/[T-21](task.md)
làm chất lượng ở mức khuôn chung. Dòng **còn** ⇒ finding.

**Cách sửa đề xuất.** Giới hạn khối trước khi đếm, đúng bài học mà [F-29](#f-29) đã rút:
`sed -n '/^## 3\./,/^## 4\./p' <file> | grep -c '<path>'` ra `0`. Sửa ô biên nhận của T-26 trong
`task.md`. Nếu owner muốn cưỡng chế ở tầng luật thay vì từng ô, gắn vào
[guideline §5](quality/00-guideline-chat-luong.md) cùng câu của [F-28](#f-28)/[F-29](#f-29):
**biên nhận của một task chỉ được đo đúng phạm vi task ấy được phép chạm — quét rộng hơn phạm vi thì nó
đỏ vì việc của người khác.** **Đỏ khi:** một ô biên nhận `grep`/`awk` cả file trong khi ô
`Prompt mở session` của cùng dòng chốt `chỉ chạm <file> §x`.

**Bẫy khi sửa.** Đừng xoá `<path>` ở §1 §2 cho lệnh xanh: hai chỗ đó là đặc tả **cách viết cột**, xoá đi
thì §1 hàng `Xem diff` mất luôn ví dụ phân biệt `git diff` với `git show <sha>` — tức là làm hỏng thứ
[F-15](#f-15) đang cần, để chữa một lệnh đo sai.


**Kiểm chứng.** Vế thứ nhất của T-26 nay lọc khối §3 trước rồi mới đếm; `<path>` ở §1 §2 giữ nguyên.

```bash
sed -n '/^## 3\./,/^## 4\./p' .claude/rules/bao-cao-thay-doi.md | grep -c '<path>'  # 0  <- vế 1 xanh
grep -c '<path>' .claude/rules/bao-cao-thay-doi.md                                  # 2  <- §1 §2 còn nguyên, ĐÚNG
grep -c "Ba lệnh: \`grep -c '<path>'" task.md                                       # 0  <- ô hết quét cả file
```

Đã thử làm đỏ: chép rule sang scratchpad, chèn lại `git log --oneline -3 -- <path>` vào thân **(e)** đúng
như [F-16](#f-16) mô tả ⇒ vế 1 ra `1` ⇒ đỏ; repo không bị chạm
(`git status --short -- .claude/rules/bao-cao-thay-doi.md` rỗng). Cả ba vế của T-26 xanh sau khi vá:
`0` · `0` · `2`.

**Bài học giữ lại:** ô `Đầu ra kiểm chứng được` **không được đo rộng hơn phạm vi mà ô `Prompt mở session`
của cùng dòng cho phép chạm** — quét rộng hơn thì nó đỏ vì việc của người khác, và cách duy nhất làm nó
xanh là lấn phạm vi. Luật này về [guideline §5](quality/00-guideline-chat-luong.md), cùng câu với
[F-28](#f-28)/[F-29](#f-29); nó **chưa được viết vào đó** và mã đang sở hữu việc cài là [F-29](#f-29)
(còn 🔴) — không đẻ mã mới cho cùng một nguyên nhân, theo
[rule §4](.claude/rules/chat-luong-finding.md).

---

### F-31

**Mệnh đề sai.** Từ T-05, `project_preparation/00-scope.md` là nhà duy nhất của giá — nhưng **hai bản dẫn
xuất của nó không có cơ chế nào canh**. (a) `project_preparation/prompt-fullstack.md` §9.3 giữ 10 số giá
và tự khai là *"hợp đồng với chủ quán"*; T-05 đã thêm một câu nói chúng dẫn xuất từ [00-scope](project_preparation/00-scope.md)
§4.2 §4.3, nhưng **câu chữ không phải cơ chế**: §4.2 đổi một giá mà §9.3 đứng im thì không lệnh nào đỏ.
(b) `design/BA/04-yeu-cau.md` dòng 22 còn khai `nhà thật ⚠️ project_preparation/00-scope.md §4.4 (T-05
tạo)` — ⚠️ ở đó **nay sai**, nhà đã có từ T-05.

**Vì sao nó không tự mất đi.** Chạy hết [task.md](task.md) y như nó viết: T-05 tạo nhà (xong);
[T-10](task.md) chỉ nhận 8 con trỏ hụt **trong `prompt-fullstack.md`**, ô Task chốt đúng file đó nên
`design/BA/**` nằm ngoài; [T-25](task.md) viết `design/BA/01-kenh-ban.md`, không rà `04-yeu-cau.md`.
Không dòng task nào nhận việc đối chiếu §9.3 với §4.2, cũng không dòng nào nhận dòng 22. Dòng còn ⇒ finding.

**Lệnh tái hiện.**

```bash
# (a) 10 ca giá ở §9.3 — dẫn xuất, không có lệnh nào canh
sed -n '/^\*\*9\.3 /,/^\*\*9\.4 /p' project_preparation/prompt-fullstack.md \
  | grep -oE '→ [0-9]+\.[0-9]{3}' | wc -l                      # ra 10
# (b) ⚠️ mồ côi ở lane BA — nhà đã có mà vẫn đánh chưa-có
grep -n '00-scope' design/BA/04-yeu-cau.md | grep -c '⚠️'       # ra 1
```

**Cách sửa đề xuất.** Vế (a) đã có lệnh cưỡng chế chạy được, đưa nó vào đích `check` của `Makefile`:

```bash
comm -23 \
 <(sed -n '/^\*\*9\.3 /,/^\*\*9\.4 /p' project_preparation/prompt-fullstack.md | grep -oE '[0-9]+\.[0-9]{3}' | sort -u) \
 <(sed -n '/^### 4\.2 /,/^### 4\.3 /p' project_preparation/00-scope.md | grep -oE '[0-9]+\.[0-9]{3}' | sort -u)
```

Hôm nay in ra **rỗng** (đã chạy). **Đỏ khi** §9.3 có một số giá mà §4.2 không có — tức bảng ca test đã
lệch khỏi nhà thật. Vế (b): gỡ ⚠️ ở `design/BA/04-yeu-cau.md` dòng 22 — việc của lane BA, gắn vào
[T-25](task.md) hoặc một dòng task riêng cho lane đó; lane NON-CODE **không** sở hữu `design/BA/**`
([CLAUDE.md §1](CLAUDE.md)).

**Bẫy khi sửa.** Đừng xoá 10 số ở §9.3 cho hết trùng lặp: §9.3 là **bảng ca test** của hàm tính giá, nó
phải hardcode kết quả mong đợi — bảng ca test lấy số từ chính nhà nó đang kiểm thì không kiểm gì cả.
Cái cần thêm là **lệnh đối chiếu**, không phải xoá một bên.

---

### F-32

**Mệnh đề sai.** [.claude/rules/bao-cao-thay-doi.md](.claude/rules/bao-cao-thay-doi.md) §3 khai **"Cả năm
lệnh (a) (b) (c) (d) (e) đều bắt buộc chạy trước khi commit"**, nhưng khối lệnh ngay dưới câu đó chỉ có
**bốn** nhãn: `# a.` `# b.` `# c.` `# e.` — **không có `# d.`**. Lệnh (d) chưa từng tồn tại ở bất kỳ phiên
bản nào của file. Cái tên (d) lan ra từ ba chỗ: ô Task của [T-14](task.md) khai đưa *"(b) (c) (d)"* vào bộ
bắt buộc · [F-16](#f-16) khai *"Bốn lệnh còn lại (a) (b) (c) (d)"* · câu "cả năm lệnh" mà T-26 vừa thêm.

**Vì sao nó nguy hiểm hơn nó trông.** Một bộ cổng đòi lệnh không tồn tại thì phiên nào cũng phải **khai
đã chạy thứ không chạy được**. Đã xảy ra: phiên đóng T-26 báo *"(d) rỗng"* — rỗng là kết quả trông y hệt
xanh, nên không ai thấy. Cổng nào cũng có thể trượt kiểu này một lần rồi thành tiền lệ.

**Vì sao nó không tự mất đi.** Chạy hết [task.md](task.md) y như nó viết: [T-14](task.md) đã ✅, [T-26](task.md)
đã ✅, [T-27](task.md) chỉ sửa cột `Câu lệnh để thấy thay đổi` **trong `task.md`** chứ không rà nhãn lệnh
trong rule. Không dòng task nào nhận việc đối chiếu danh sách nhãn ở §3 với khối lệnh ngay dưới nó.
Dòng còn ⇒ finding.

**Lệnh tái hiện.**

```bash
grep -o '^# [a-e]\.' .claude/rules/bao-cao-thay-doi.md          # in a. b. c. e. — (d) khuyết
grep -c '^# [a-e]\.' .claude/rules/bao-cao-thay-doi.md          # ra 4, không phải 5
grep -c '(b) (c) (d)' task.md                                    # ra 1 — nguồn lây đầu tiên
for c in $(git log --format=%h -- .claude/rules/bao-cao-thay-doi.md); do \
  echo "$c $(git show $c:.claude/rules/bao-cao-thay-doi.md | grep -c '^# d\.')"; done   # mọi phiên bản ra 0
```

**Cách sửa đề xuất.** Owner chọn một trong hai, đừng để phiên tự chọn:
1. **Viết thật lệnh (d)** — nếu (d) từng có ý định soi một thứ mà (a)(b)(c)(e) không soi. Không phiên bản
   nào lưu nội dung nó, nên phải chốt lại từ đầu ý định là gì.
2. **Bỏ (d)** — đổi câu §3 thành *"cả bốn lệnh (a) (b) (c) (e)"*, sửa luôn ô Task của T-14 và câu của
   [F-16](#f-16) để hết nhắc (d).

Cưỡng chế bằng một dòng trong đích `check` của `Makefile`. **Đỏ khi** số nhãn `^# [a-e]\.` trong file khác
số nhãn mà câu *"đều bắt buộc"* của §3 liệt ra.

**Bẫy khi sửa.** Đừng chọn hướng 2 chỉ vì nó nhanh. Nếu (d) từng là cổng soi một thứ riêng, bỏ nhãn đi là
**xoá một cổng rồi khai là đã dọn** — đúng hạng lỗi mà [F-16](#f-16) sinh ra để tố, chỉ đổi chiều.

---

### F-33

**Mệnh đề sai.** `quality/05-checklist.md` dòng 4 tự khai: *"Nhà duy nhất của câu hỏi **task này XONG
chưa** cho task **có code**"*. Nhưng cả bảy vế §1 chỉ đo **vệ sinh của đầu ra** — tầng 1 xanh · có test
happy + test lỗi · lỗi tiếng Việt · có mã truy vết · có `down` và đã chạy thử · sinh lại type · 375/768.
**Không vế nào hỏi đầu ra có phải thứ ô `Task` của dòng task yêu cầu hay không.** Dòng 57 còn tự tay đẩy
việc đó ra khỏi phạm vi: *"Bảy vế ở §1 trả lời **XONG**, không trả lời **TỐT**"* — nhưng *"đúng thứ được
giao"* không phải câu hỏi TỐT, nó là vế **đầu tiên** của XONG. Kết quả: một task xây **đúng cách** một
thứ **sai** tick đủ 7/7 và được khai XONG hợp lệ.

**Vì sao nó không tự mất đi.** Chạy hết [task.md](task.md) y như nó viết: [T-04](task.md) đã ✅ và không
dòng nào mở lại §1. Ba lane còn lại ([T-07](task.md) [T-08](task.md) [T-09](task.md)) chỉ mở lane; vế
riêng của từng pha đi **tầng pha** `quality/0n-pha-*.md`, mà [guideline §7](quality/00-guideline-chat-luong.md)
buộc tầng pha *"chỉ được **thêm**"* vế **riêng của pha** — *đúng-việc-được-giao* là vế **chung**, không
tầng pha nào là nhà của nó. Không dòng task nào nhận việc này. Dòng **còn** ⇒ finding.

**Lệnh tái hiện.**

```bash
grep -n "yêu cầu\|ô \`Task\`\|đúng thứ được giao\|acceptance" quality/05-checklist.md
# ra ĐÚNG MỘT dòng:
#   25:- [ ] Log có **mã truy vết** đi theo một yêu cầu từ đầu tới cuối, đủ để debug **tại quán**…
# "yêu cầu" ở đó là một request chạy qua hệ thống, không phải yêu cầu của dòng task
# ⇒ 0/7 vế đo "đầu ra có đúng thứ được giao không"
```

**Cách sửa đề xuất.** Thêm **một dòng cổng** ở đầu §1 — **không** phải ô `- [ ]` thứ tám: số 7 đang bị
ghim ở bốn chỗ ([F-34](#f-34)), thêm một ô làm cả bốn biên nhận đỏ cùng lúc. Câu đại ý: *"Trước khi tick
bảy vế: ô `Đầu ra kiểm chứng được` của dòng task đã **chạy thật** và đã được **thử làm đỏ một lần**
([guideline §5](quality/00-guideline-chat-luong.md)); bảy vế dưới đo vệ sinh của đầu ra, không đo việc
được giao."* Là **con trỏ** tới ô của dòng task, không chép nội dung ⇒ không đẻ nhà thứ hai. Gắn vào một
dòng task mới cho lane NON-CODE.

**Vì sao nó nguy hiểm hơn nó trông.** Đây là chế độ hỏng **đặc trưng của agent**, không phải của người:
người làm sai việc thường làm sai cả cách làm nên bị bắt ở tầng 1, còn agent làm rất sạch đúng thứ nó
hiểu nhầm — bảy vế vệ sinh đều xanh, và cái sai duy nhất là **cái nó đã xây**. Mọi Definition of Done
tham khảo ngoài repo đều đặt *"all acceptance criteria are met"* ở **dòng đầu tiên**; ở đây vế đó không
tồn tại ở bất kỳ dòng nào.

---

### F-34

**Mệnh đề sai.** Biên nhận *"`grep -c '^- \[ \]'` ra **đúng 7**, không hơn không kém"* bị ghim ở **bốn**
chỗ cùng lúc: `quality/05-checklist.md` §5 dòng 74 · ô `Đầu ra kiểm chứng được` của dòng
[T-04](task.md) (đã ✅) · bảng soi `### cl-T-04` (dòng `Đã thử làm đỏ` chốt `5 ≠ 7`, `8 ≠ 7`, *"bản thật
ra 7"*) · và ô biên nhận của [T-33](task.md) — một dòng **còn mở**, khai thẳng *"**đỏ khi** ra `8`"*.
Nguồn duy nhất của con số 7 là [prompt-fullstack.md](project_preparation/prompt-fullstack.md) §6.5 — mà
chính file đó dòng 8 tự khai *"File này là **bản xuất khẩu**, không phải nhà của sự thật nào"* và dòng 13
*"Là bản chép nên nó **sẽ trôi**"*. Kết quả: checklist **không có cửa** nào để nhận một vế XONG thứ tám —
kể cả vế học từ **một sự cố thật ở quán**, đúng thứ §6.7 luật 2 bắt buộc (*"mỗi sự cố ở quán phải sinh ra
một test"*) — vì thêm một dòng làm **bốn** biên nhận đỏ cùng lúc.

**Vì sao nó không tự mất đi.** Chạy hết [task.md](task.md): T-04 đã ✅ ĐÓNG, dòng bị gạch ngang, không
dòng nào mở lại ô biên nhận của nó; `cl-T-04` là bảng soi của một task đã xong nên cũng đứng im; và
[T-33](task.md) — dòng mới nhất chạm checklist — **đóng cửa chặt thêm** thay vì mở: nó dùng `= 7` làm
biên nhận *giữ nguyên hiện trạng*. Không dòng task nào nói tới việc *"vế XONG mới sinh ra ở đâu"*. Chạy
hết kế hoạch thì số 7 được ghim ở nhiều chỗ hơn, không ít hơn. Dòng **còn** ⇒ finding.

**Lệnh tái hiện.**

```bash
grep -rn -F "grep -c '^- \[ \]' quality/05-checklist.md" quality/05-checklist.md task.md | cut -c1-64
# quality/05-checklist.md:74:grep -c '^- \[ \]' quality/05-checklist.md   <- chỗ 1
# task.md:46:| ~~**T-04**~~ ✅ | NON-CODE | Tạo `quality/05-checkli     <- chỗ 2 (T-04, đã đóng)
# task.md:74:| **T-33** | NON-CODE | Tạo `quality/06-rang-buoc-kie     <- chỗ 4 (T-33, CÒN MỞ)
sed -n '/^### cl-T-04/,/^### /p' task.md | grep -o '≠ 7' | wc -l          # ra 2  <- chỗ 3
grep -c 'không hơn không kém' quality/05-checklist.md                     # ra 1  <- cửa bị đóng bằng câu chữ
```

**Cách sửa đề xuất.** Khai **cửa** ở `quality/05-checklist.md` §4 (*ranh giới — file này không sở hữu cái
gì*): vế XONG mới sinh ở **tầng pha** `quality/0n-pha-*.md` ([guideline §7](quality/00-guideline-chat-luong.md)),
**không** sinh ở tầng chung; tầng chung chỉ đổi khi §6.5 đổi. Rồi đổi biên nhận từ **đếm dòng** sang
**neo nội dung** (bảy chuỗi khoá phải nằm đúng trong bảy dòng `- [ ]`). Vế thứ hai **phải chờ vá
[F-29](#f-29) trước** — lệnh `awk` bảy khoá hiện quét cả file nên không đỏ được, sửa biên nhận trước khi
vá F-29 là chồng một lỗ lên một lỗ.

**Bẫy khi sửa.** Đừng gỡ số 7 bằng cách đổi biên nhận thành ngưỡng dưới `>= 7`: đó đúng chỗ hỏng số 1 mà
[guideline §5](quality/00-guideline-chat-luong.md) đã cấm — ngưỡng dưới đặt trên thứ dễ đẻ thì xanh
**vĩnh viễn**, và bảy vế XONG là thứ dễ đẻ nhất trong repo này.

---

### F-35

**Mệnh đề sai.** Bảy ô `- [ ]` ở §1 của `quality/05-checklist.md` **không phải bảy phép xác nhận**:
**5/7** dòng gộp nhiều thứ vào **một** dấu tick — vế 1 gộp `build · lint · unit test · typecheck` *và*
*"output dán vào câu trả lời"*; vế 2 gộp happy path **và** case lỗi; vế 5 gộp *viết `down`* **và** *đã
chạy thử `down` thật*; vế 6 gộp *cập nhật hợp đồng* **và** *FE sinh lại type*; vế 7 gộp 375px **và**
768px. Đếm ra **14** nếu đếm theo nội dung, **16** nếu đếm bằng dấu ngăn — và **không cách đếm nào là
sai**, đó chính là bằng chứng: hôm nay không ai nói được checklist đòi bao nhiêu phép xác nhận. Một dấu
tick không chứng minh được 14 thứ; dòng gộp bị tick theo thành viên **dễ nhất** của nó. `grep -c '^- \[ \]'`
= 7 đang đo **số dòng**, không đo số thứ đã xác nhận.

**Vì sao nó không tự mất đi.** Chạy hết [task.md](task.md): T-04 ✅ đã chốt đúng bảy dòng này và không
dòng nào mở lại; T-07/T-08/T-09 mở lane rồi mở **tầng pha**, mà tầng pha chỉ được *thêm* vế mới, không
được viết lại bảy vế chung ([guideline §7](quality/00-guideline-chat-luong.md), và chính checklist §4
nhắc lại ranh giới đó). Không dòng nào nhận việc tách vế gộp. Dòng **còn** ⇒ finding.

**Lệnh tái hiện.**

```bash
# (1) đếm dòng gộp — dòng có dấu ngăn `·` hoặc liên từ "và"
grep -n '^- \[ \]' quality/05-checklist.md | grep -cE ' và |\*và\*|·'          # ra 5  (trên tổng 7)
# (2) đếm vế con bằng dấu ngăn
grep '^- \[ \]' quality/05-checklist.md \
  | awk '{n=1;m=$0; while(match(m,/ · | và |\*và\*/)){n++;m=substr(m,RSTART+RLENGTH)} s+=n; print n} END{print "TỔNG: " s}'
# ra: 5 · 2 · 1 · 1 · 3 · 2 · 2 · TỔNG: 16
# (3) biên nhận đang xanh trên chính bộ dòng đó
grep -c '^- \[ \]' quality/05-checklist.md                                     # ra 7
```

Bảy dấu tick, mười sáu vế con máy đếm được (mười bốn nếu bỏ *"output dán vào"* và gộp lại
*"`down` đã chạy thử"*). Chênh lệch 14–16 là **cùng một triệu chứng**, không phải sai số.

**Cách sửa đề xuất.** Đánh **số vế con** trong §1 để đếm được (`1a 1b 1c 1d`, `2a 2b`, …), hoặc tách vế 1
thành bốn dòng riêng. Hai hướng đều buộc **chỉnh biên nhận theo** — và chỉnh biên nhận vướng
[F-34](#f-34). **Thứ tự phụ thuộc bắt buộc:** mở cửa nhận vế mới ([F-34](#f-34)) → vá lệnh `awk` bảy khoá
([F-29](#f-29)) → mới tách vế gộp ở mã này. Làm ngược thứ tự thì bước nào cũng làm đỏ biên nhận của bước
chưa tới.

---

### F-36

**Mệnh đề sai.** **Không cơ chế nào buộc xác nhận §6.9** (*ba thứ không bao giờ thoả hiệp: BE luôn tính
lại giá từ DB · backup trước mọi migration và backup phải restore được · không deploy trong giờ bán*)
trước khi commit. Nó xuất hiện đúng ba chỗ, cả ba đều là **con trỏ**: `quality/05-checklist.md` dòng 9–10
(phần dẫn, *"trỏ, không chép"*) · cùng file dòng 62 (§4 — *file này **không** sở hữu cái gì*) ·
`quality/00-guideline-chat-luong.md` dòng 75 (văn xuôi **dưới** bảng ba cổng). Nó **không** là một vế ở
§1, **không** nằm trong danh sách §3 *"cái gì không tính là XONG"*, và **không** ô `Đạt khi` nào của bảng
ba cổng nhắc tới nó.

**Vì sao nó không tự mất đi.** Chạy hết [task.md](task.md): T-04 ✅ đã cố tình **không** chép §6.9 vào
checklist (ô `Bẫy` của dòng T-04 ra lệnh đúng như vậy — và ra lệnh đó **đúng**, chép là đẻ nhà thứ hai);
[T-06](task.md) mở lane DEVOPS có nạp §6.9 nhưng ô Task của nó là tạo `.claude/rules/lane-devops.md`,
không phải cài cổng cho ba luật. Không dòng nào nhận việc *biến con trỏ thành cổng*. Dòng **còn** ⇒ finding.
Khác [F-26](#f-26): F-26 là **một con trỏ khai sai nhà**; mã này là **không có cổng nào** để con trỏ trỏ vào.

**Lệnh tái hiện.**

```bash
sed -n '/^## §3/,/^## §4/p' quality/05-checklist.md | grep -c '6\.9'
# ra 0 — danh sách "cái gì KHÔNG tính là XONG" không nhắc §6.9 lần nào
sed -n '/^## §6/,/^## §7/p' quality/00-guideline-chat-luong.md | grep '^|' | grep -c '6\.9'
# ra 0 — không ô `Đạt khi` nào của BA CỔNG nhắc tới nó
grep -n '6\.9' quality/00-guideline-chat-luong.md
# ra 75:[prompt-fullstack.md](...) §6.9 — trỏ, không chép.   <- nằm NGOÀI bảng (bảng kết thúc ở dòng 72)
```

**Cách sửa đề xuất.** Thêm **một vế** vào §3 của `quality/05-checklist.md`: *"task chạm **giá** /
**migration** / **deploy** mà không xác nhận [§6.9](project_preparation/prompt-fullstack.md) ⇒ **không**
tính XONG"*. §3 là văn xuôi liệt kê, **không** phải bộ ô `- [ ]`, nên thêm vào đó **không** đụng biên
nhận `= 7` ([F-34](#f-34)). Là **con trỏ** tới nhà thật, không chép ba luật ⇒ không vi phạm luật một nhà
([CLAUDE.md §2](CLAUDE.md)). Gắn vào một dòng task mới cho lane NON-CODE.

**Vì sao nó nguy hiểm hơn nó trông.** Với quán ăn đây là vế **đắt nhất** trong cả bộ: vi phạm không ra
một test đỏ, nó ra *khách đặt món 0đ* hoặc *mất toàn bộ đơn hàng*. Và §6.9 tự khai phạm vi là *"kể cả khi
gấp"* — tức đúng lúc nó có giá là đúng lúc nó bị lướt qua, vì lúc đó không cổng nào chặn.

---

### F-37

**Mệnh đề sai.** `quality/05-checklist.md` dòng 46–48 hứa: *"vế nào còn ⚠️ thì **lane sinh ra nó gỡ ⚠️
ngay trong task mở lane**"*. Lời hứa đó **không nằm trong sổ của ai**: **7/8** dòng bảng §2 đang ⚠️, mà
**không** dòng task nào của [T-07](task.md) (lane DB), [T-08](task.md) (lane BE), [T-09](task.md) (lane
FE) nhắc tới `quality/05-checklist.md` — không ở ô `Nạp`, không ở ô `Bẫy`, không ở ô `Đầu ra kiểm chứng
được`. Lời hứa không có người mang ⇒ đến khi lane mở, bảng §2 khai *"chưa chạy được"* về những lệnh **đã
chạy được**, và khai sai trong im lặng.

**Vì sao nó không tự mất đi.** Chạy hết [task.md](task.md) y như nó viết: T-07 T-08 T-09 mở đủ ba lane,
`go.mod`/`package.json` ra đời, `go test`/`npm run build` chạy được — và **đúng lúc đó** bảy dòng ⚠️ của
§2 trở thành sai, vì không ô nào của ba dòng task đó buộc quay lại gỡ. Kế hoạch chạy xong thì lỗi **mới
nở ra**, không phải mất đi. Dòng **còn** ⇒ finding. Cùng họ [F-23](#f-23) (⚠️ **thừa** không lệnh nào
bắt) nhưng khác nguyên nhân: F-23 là ⚠️ đã sai **hôm nay** ở hai file luật, mã này là **lời hứa gỡ ⚠️
không có chủ** ở một file thứ ba.

**Lệnh tái hiện.**

```bash
grep -c '^| \*\*T-0[789]\*\*' task.md                        # ra 3 — ba dòng task đều có thật
grep '^| \*\*T-0[789]\*\*' task.md | grep -c '05-checklist'   # ra 0 — không dòng nào nhắc tới checklist
grep -c '⚠️' quality/05-checklist.md                          # ra 10
sed -n '/^## §2/,/^## §3/p' quality/05-checklist.md | grep -c '^| .*⚠️'   # ra 7  (trên 8 dòng bảng)
grep -n 'lane sinh ra nó gỡ' quality/05-checklist.md          # ra 47 — lời hứa nằm đây, không nằm trong task.md
```

**Cách sửa đề xuất.** Thêm vế gỡ ⚠️ vào ô `Bẫy` **hoặc** ô `Đầu ra kiểm chứng được` của T-07 / T-08 /
T-09 — đại ý *"gỡ ⚠️ ở dòng tương ứng của [checklist §2](quality/05-checklist.md) trong cùng commit;
đỏ khi lane đã mở mà `grep -c '⚠️'` của §2 không giảm"*. **Ba dòng, ba lane khác nhau** ⇒ vượt kích cỡ
một task ([CLAUDE.md §6](CLAUDE.md): 1 lane · ≤ 3 file), nên phải **đẻ task riêng** cho việc sửa sổ, đừng
sửa kèm trong phiên đóng finding — và cũng đừng gộp ba lane vào một dòng.

---

### F-38

**Mệnh đề sai.** Vòng lặp con trỏ ở [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md)
§5.1 dùng `grep -o '](\([^)#]*\)'` — lớp `[^)#]*` **cắt bỏ mọi thứ sau `#`**, nên một con trỏ dạng
`](../finding.md#f-67)` chỉ được kiểm là `test -e ../finding.md` → file có thật → **xanh**, dù neo
`#f-67` không tồn tại. Đây là **một lớp** con trỏ mà **chưa phép rà nào trong repo bắt được**, và lớp đó
đang có một ca sống: `project_preparation/prompt-fullstack.md` dòng 13 trỏ `[F-67](../finding.md#f-67)`
trong khi sổ này **không có mã nào ở dải 60**
(`grep -c '^### F-6[0-9]' finding.md` ra `0`) — `F-67` là dấu vết đánh số của bản `reference/`.

**Vì sao nó không tự mất đi.** Chạy hết [task.md](task.md): [T-10](task.md) nhận đúng **8 đường dẫn** mà
[F-02](#f-02) liệt kê, `#f-67` không nằm trong tám cái đó (nó là **neo**, không phải đường dẫn — chính
`../finding.md` thì có thật). Sửa xong T-10, chạy lại §5.1: neo hụt vẫn xanh, vì lệnh về nguyên tắc không
nhìn thấy phần sau `#`. Dòng **còn** ⇒ finding. **Không trùng [F-02](#f-02):** F-02 là *file A trỏ 8
đường dẫn không tồn tại* — và §5.1 **bắt được** cả 8; mã này là *lệnh §5.1 mù với một lớp con trỏ*, chủ
ngữ là file luật khác, và bài học của F-02 (*mọi con trỏ phải giải được hoặc mang ⚠️*) đã vào
[CLAUDE.md §2](CLAUDE.md) rồi mà vẫn không bắt được ca này — đó đúng là bằng chứng khác nguyên nhân.

**Lệnh tái hiện.**

```bash
grep -n '#f-67' project_preparation/prompt-fullstack.md
# 13:> định nghĩa XONG [quality/05](../quality/05-checklist.md). … rủi ro ghi ở [F-67](../finding.md#f-67).
grep -c '^### F-67' finding.md                                  # ra 0 — neo không có đích
grep -c '^### F-6[0-9]' finding.md                               # ra 0 — sổ này không có mã nào ở dải 60

# vòng lặp §5.1 nguyên văn, chạy trong project_preparation/ (đúng cấp của con trỏ tương đối):
cd project_preparation && grep -o '](\([^)#]*\)' prompt-fullstack.md | sed 's/](//' \
  | grep -v '^http' | grep -v '^$' | sort -u | while read f; do [ -e "$f" ] || echo "TRỎ HỤT: $f"; done
# TRỎ HỤT: ../design/backend/01-thiet-ke.md
# TRỎ HỤT: ../design/data_base/01-thiet-ke.md
# TRỎ HỤT: ../design/frontend/01-thiet-ke.md
# TRỎ HỤT: ../design/system_design/01-thiet-ke.md
# TRỎ HỤT: ../quality/prompt_guiline.md
# <- KHÔNG dòng nào cho #f-67; `grep -o` chỉ moi ra được `](../finding.md`
sed -n '13p' prompt-fullstack.md | grep -o '](\([^)#]*\)'        # ](../quality/05-checklist.md  ·  ](../finding.md
```

**Cách sửa đề xuất.** Bổ sung **một vế** vào §5.1: tách phần sau `#` ra kiểm riêng — với mỗi con trỏ có
neo, `grep -c '^### <mã>' <file đích>` phải ra `1` (mã lấy từ neo, viết hoa lại: `#f-67` → `F-67`). Vế này
**thêm** vào vòng lặp cũ, không thay nó, vì vòng lặp cũ vẫn phải kiểm phần đường dẫn. Gắn vào một dòng
task mới cho lane NON-CODE. Ca `#f-67` sống ở `prompt-fullstack.md` thì gộp vào [T-10](task.md) — dòng đó
đã sở hữu đúng file này rồi, đừng đẻ dòng thứ hai chạm cùng một file.

**Bẫy khi sửa.** §5.1 hiện có `grep -v '^$'` để bỏ **neo trong cùng file** (`](#owner-t-02)`) — vế mới
**không được** làm sống lại đám đó thành `TRỎ HỤT` rỗng; neo cùng file phải kiểm bằng chính file đang
quét, không phải bằng `test -e`. Và đừng sửa §5.1 khi chưa đọc [F-11](#f-11): vòng lặp này còn **tự bắt
chính mình** khi chạy trên file luật, thêm một vế mà không tính tới F-11 là cộng thêm một dòng rác nữa.
---

### F-39

**Mệnh đề sai.** Đặc tả cách viết con trỏ trong báo cáo dừng lại ở **mục**, không đòi **đường dẫn**: ô
`Sửa ở đâu` ở [.claude/rules/bao-cao-thay-doi.md §1](.claude/rules/bao-cao-thay-doi.md) chỉ cấm *"dừng ở
tên file"* mà không cấm chiều ngược lại — dừng ở tên mục. Nên `§6` trần, `guideline §3`, `rule §5.1` là
cách viết **hợp luật** trong khi chúng không trỏ vào đâu cả: owner phải tự đoán file rồi tự đi tìm.

**Vì sao nó không tự mất đi.** Chạy hết [task.md](task.md) y như nó viết thì dòng này còn: không dòng task
nào sở hữu *cách viết con trỏ trong câu trả lời*. Nó còn tệ hơn theo thời gian — mỗi lane mới mở thêm một
file có `§1 §2 §3`, nên cùng một chuỗi `§6` càng ngày càng trỏ được vào nhiều chỗ hơn. Đây cũng là loại
lỗi **không có compiler nào bắt**: văn bản báo cáo sống trong hội thoại, không nằm trong file để `grep`.

**Lệnh tái hiện.**

```bash
# Có bao nhiêu file đang cùng sở hữu một mục "§6"? -> 5. Vậy "§6" trần trỏ vào 1 trong 5.
grep -rln '^#\+ *§6' --include='*.md' . | sed 's|^\./||'
# CLAUDE.md · quality/00-guideline-chat-luong.md · project_preparation/00-scope.md
# project_preparation/prompt-fullstack.md · project_preparation/step.md

# Và cách viết trần đó đã có sẵn trong sổ, không phải giả định:
grep -c 'guideline §' finding.md      # 17
```

**Cách sửa đề xuất.** Thêm một luật ngắn vào [CLAUDE.md §4](CLAUDE.md) *(Đầu ra session)* — nhà của
*"một phiên phải trả ra cái gì"*: mọi con trỏ vào repo viết `[đường/dẫn/file.md §6]` rồi `(đường/dẫn/file.md)`,
đủ **cả** đường dẫn **và** mục, ở **mọi** lần nhắc. `bao-cao-thay-doi.md` §1 chỉ **trỏ** tới luật đó và
thêm nó vào danh sách câu bị cấm — không chép lại, tránh đẻ nhà thứ hai đúng kiểu [F-04](#f-04).

**Bẫy khi sửa.** Đừng biến luật này thành lệnh `grep` quét cả repo: repo đang có **980** chuỗi `§<số>` trong
9 file, quét thô sẽ đỏ vĩnh viễn và thành nhiễu bị tắt đi. Luật này áp cho **văn bản phiên sinh ra từ nay**,
không hồi tố các file đã có — chỗ owner đau là báo cáo đọc một lần, không phải tài liệu đọc có ngữ cảnh.

**Kiểm chứng.**

```bash
grep -c 'Trích dẫn đủ nhà' CLAUDE.md                                    # 1
grep -c 'Bốn câu bị cấm' .claude/rules/bao-cao-thay-doi.md              # 1
grep -c 'Ba câu bị cấm'  .claude/rules/bao-cao-thay-doi.md              # 0  <- khuôn cũ hết đúng
wc -l < CLAUDE.md; awk 'length>400' CLAUDE.md                           # 101, rỗng — còn trong trần §8
```

**Bài học giữ lại:** một con trỏ chỉ được tính là con trỏ khi nó **giải được một mình**. Luật đổi:
[CLAUDE.md §4](CLAUDE.md) *Trích dẫn đủ nhà* — đường dẫn **và** mục, mọi lần nhắc, không rút gọn từ lần
hai. Phép thử áp cho mọi luật khác cùng loại: đọc đúng chuỗi ký tự đó, tách khỏi ngữ cảnh câu, có ra đúng
một chỗ trong repo không? Ra nhiều hơn một ⇒ đó là gợi ý, không phải con trỏ.

---

### F-40

**Mệnh đề sai.** [guideline §7](quality/00-guideline-chat-luong.md) đặt khuôn tên tầng pha là
`quality/0n-pha-<n>-<tên>.md`. Với **sáu** pha bắt đầu từ `01-` ([prompt-fullstack §7](project_preparation/prompt-fullstack.md)),
pha 4 rơi vào `05-` và pha 5 rơi vào `06-`. Cả hai số **đã có chủ khác**: `quality/05-checklist.md` tồn tại
từ T-04, và `06-rang-buoc-kien-truc.md` đã được ô `Task` của [T-33](task.md) đặt trước. Khuôn tên hiện hành
**không cấp phát được** cho hai pha cuối, và không lệnh nào trong repo kêu.

**Vì sao nó không tự mất đi.** Chạy hết [task.md](task.md) y như nó viết: [T-19](task.md) tạo
`01-pha-0-ba.md`, [T-33](task.md) tạo `06-rang-buoc-kien-truc.md`, rồi [T-07](task.md) [T-08](task.md)
[T-09](task.md) mở lane và tầng pha 2/3/4 sẽ lần lượt đòi `03- 04- 05-`. Không dòng task nào nhận việc
**chốt hệ tên**; mỗi dòng chỉ tạo đúng file của nó rồi dừng. Va chạm chỉ lộ ra ở task thứ năm kể từ bây
giờ, lúc đó phiên đang làm sẽ tự chọn một số còn trống và hệ tên mất luôn ý nghĩa. Dòng **còn** ⇒ finding.

**Lệnh tái hiện.**

```bash
grep -c '0n-pha-<n>-<tên>' quality/00-guideline-chat-luong.md   # 2 — khuôn tên tầng pha, hai chỗ
ls quality/                                                     # 05-checklist.md đã chiếm 05-
grep -c '06-rang-buoc-kien-truc' task.md                        # >= 1 — 06- đã bị T-33 đặt trước
# ⇒ khuôn `0n-pha-<n>` còn cấp được 01 02 03 04, thiếu chỗ cho pha 4 và pha 5
```

**Cách sửa đề xuất.** Bỏ số khỏi tên **tầng pha**: `quality/pha-<n>-<tên>.md`. Con số đứng trước ở đó không
mang thông tin nào ngoài thứ tự, mà thứ tự đã nằm sẵn trong `<n>` — bỏ nó thì hai họ tên file không còn tranh
chỗ, và nhìn tên là biết ngay file thuộc tầng nào. Sửa đúng hai chỗ: khuôn ở
[guideline §7](quality/00-guideline-chat-luong.md) và ô `Task` của [T-19](task.md) (chưa làm, nên chưa có
file nào phải đổi tên). Tầng chung giữ số `00`–`0x` như hiện tại. Gắn vào một dòng task mới cho lane NON-CODE.

**Bẫy khi sửa.** `quality/01-chat-luong-noi-dung.md` do [T-34](task.md) tạo đang đứng ở `01-`, cùng số với
`01-pha-0-ba.md` mà [T-19](task.md) sẽ tạo. Hai file **không** đè nhau (khác tên đầy đủ), nên đây chưa phải
lỗi — nhưng sửa hệ tên mà chỉ đổi tầng pha rồi để `01-` mang hai nghĩa thì mới là chọn đường dễ: chuỗi
`-pha-` phải là thứ **duy nhất** phân biệt hai tầng, không phải con số.

---

### F-41

**Mệnh đề sai.** [Makefile](Makefile) dòng 13–19 khai `NHA` bằng cách **gõ tay** ba danh sách (`SO`, `LUAT`,
`HDAN`). `QUET := $(NHA)`, và cả bốn đích `check-nha` `check-tran` `check-contro` `check-so` chỉ chạy trên
tập đó. Một nhà mới không được ai thêm tay vào `NHA` thì **không đích nào soi nó**, và `make check` vẫn in
`XANH`. Đây không phải rủi ro tương lai: `quality/05-checklist.md` sinh ra ở [T-04](task.md) — đã đánh ✅ —
và tới hôm nay vẫn đứng ngoài `NHA`.

**Vì sao nó không tự mất đi.** Chạy hết [task.md](task.md) y như nó viết: [T-06](task.md) mở lane DEVOPS
bằng một rule có `paths:`, không dòng nào nói tới `NHA`. [T-19](task.md) [T-33](task.md) và mọi task tầng
pha sau này đều **tạo thêm** file trong `quality/`, không dòng nào có vế *"thêm vào `NHA`"* trong ô biên
nhận. Cơ chế đăng ký là một thói quen, không phải một cổng — và thói quen đã trượt một lần rồi. Dòng
**còn** ⇒ finding.

**Lệnh tái hiện.**

```bash
ls quality/*.md                                       # 3 file: 00-guideline, 01-chat-luong-noi-dung, 05-checklist
grep -o 'quality/[a-z0-9-]*\.md' Makefile | sort -u   # ra ĐÚNG 1: quality/00-guideline-chat-luong.md
make check                                            # vẫn không nhắc gì về hai file còn lại
# ⇒ 2/3 nhà trong quality/ đứng ngoài mọi đích, cổng vẫn xanh
```

**Cách sửa đề xuất.** Thay danh sách gõ tay bằng một **đích đối chiếu**: liệt kê file thật bằng `ls`/`git
ls-files` trên các thư mục nhà (`quality/` `.claude/rules/` `design/**`), so với `NHA`, in ra chênh lệch và
**đỏ** khi có file thật không nằm trong `NHA`. Giữ `NHA` gõ tay làm bản khai — không tự nạp mọi file, vì
`reference/` và `prompt/` cố ý đứng ngoài — nhưng biến chỗ lệch thành **đỏ** thay vì im lặng. Đây là việc
của lane **DEVOPS** (`Makefile`), lane chưa mở: gắn vào một dòng task mở sau [T-06](task.md).

**Vì sao nó nguy hiểm hơn nó trông.** `make check` là biên nhận **duy nhất** hiện chạy được của cả repo
([CLAUDE.md §7](CLAUDE.md)), nên nó cũng là chỗ mọi phiên tin nhất. Một cổng bỏ sót file không kêu to hơn
một cổng đỏ — nó im, và cái im đó đọc y hệt *"đã kiểm, không có vấn đề"*. Càng nhiều nhà mới sinh ra, tỷ lệ
file thật sự được soi càng giảm, trong khi dòng `make check: XANH` không đổi một chữ.
