# CLAUDE.md — luật + con trỏ

> Cập nhật **2026-08-26**. **File này là bản đồ, không phải lãnh thổ.** Nó không giữ sự thật nào của dự án: mỗi dòng hoặc là **luật làm việc**, hoặc là **con trỏ** tới nhà thật. Lệch nhà thật ⇒ **nhà thật thắng**, dòng ở đây là bug phải sửa ngay. Trần của chính file này ở §8.
>
> **Vai trò.** Người dùng giao task + yêu cầu; agent tự chọn cách làm, tự viết, **tự kiểm chứng bằng lệnh**, không hỏi lại thứ đọc được trong repo. Đổi lại: thấy hệ thống sai thì **nổi lên** — ghi một dòng vào [finding.md](finding.md) kèm cách sửa đề xuất, rồi quay lại việc đang làm. Im lặng tự xử = vi phạm.
>
> **Nội dung sai thì mọi thứ xây lên nó đều sai**, và chỉ lộ ở phiên thứ ba dưới dạng làm lại từ đầu. Nên nó là **cổng**, không phải lời khuyên: §3 bước 5 · §4 vế (5) · nhà thật [quality/01-chat-luong-noi-dung.md §3 §4](quality/01-chat-luong-noi-dung.md).

## §1 Định tuyến lane — chọn lane trước khi mở file thứ nhất

Mở lời bằng một dòng khai báo để người dùng chặn được ngay: `Lane: <lane> · <mã task> · nạp: <file> · biên nhận: <lệnh>`.

| Lane | Prompt nói tới | Lane sở hữu file nào | Nạp gói nào | Biên nhận |
|---|---|---|---|---|
| **NON-CODE** | chốt tài liệu, lập kế hoạch, rà soát, hỏi hiện trạng | `task.md`, `finding.md`, `CLAUDE.md`, `project_preparation/**`, `.claude/rules/**`, `.claude/settings.json`, `quality/**` | [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) + đúng file sẽ sửa | lệnh đọc lại: `grep -c`, `wc -l`, `test -e` |
| **BA** | quy trình quán, luồng nghiệp vụ, vai & quyền, quy tắc nghiệp vụ | `design/BA/**` | [.claude/rules/lane-ba.md](.claude/rules/lane-ba.md) + [prompt-fullstack.md](project_preparation/prompt-fullstack.md) §3 §7 dòng `**0 · BA**` | 4 lệnh ở [design/BA/04-yeu-cau.md](design/BA/04-yeu-cau.md) §2 |
| **DB** | bảng, cột, index, migration, seed, `.sql` | ⚠️ chưa mở | — | — (T-07 mở lane này) |
| **BE** | API, endpoint, handler, service, Go, transaction, tính giá | ⚠️ chưa mở | — | — (T-08 mở lane này) |
| **FE** | trang, component, Next, giỏ hàng, màn hình trạm, QR bàn | ⚠️ chưa mở | — | — (T-09 mở lane này) |
| **DEVOPS** | docker, compose, Makefile, CI, deploy, backup, biến môi trường | `Makefile`, `deploy/**`, `.env*` | [.claude/rules/lane-devops.md](.claude/rules/lane-devops.md) + [prompt-fullstack.md](project_preparation/prompt-fullstack.md) §6.9 | `make check` ra mã thoát `0` · 4 lệnh §2 §3 của rule lane |

Năm luật định tuyến:
- **Một session một lane.** Prompt chạm nhiều lane ⇒ chọn lane của *đầu ra kiểm chứng được*, phần còn lại thành dòng task mới trong [task.md](task.md) ngay lúc đó.
- **Không rõ lane ⇒ NON-CODE**, vì lane đó chỉ đọc và đối chiếu, không sửa code.
- **Chỉ nạp trong gói.** Cần file thứ tư ⇒ nói ra lý do trước khi mở.
- **Mở lane X là ngoại lệ chạm-file duy nhất:** được sửa thêm `.claude/rules/lane-x.md` + **đúng một dòng** bảng trên, dù cả hai thuộc NON-CODE. Quá một dòng `CLAUDE.md` ⇒ lấn phạm vi, ghi [finding.md](finding.md).
- **Đổi lane giữa chừng ⇒ dừng, commit, mở task mới.** Không kéo lane cũ theo.

## §2 Một sự thật một nhà

| Sự thật | Nhà duy nhất | Ai thắng khi lệch |
|---|---|---|
| Làm gì tiếp, theo thứ tự nào | [task.md](task.md) | `task.md` |
| Cái gì đang sai + bài học giữ lại | [finding.md](finding.md) · khuôn một mục `### F-xx` + 2 cổng: [.claude/rules/chat-luong-finding.md](.claude/rules/chat-luong-finding.md) | nội dung: `finding.md` · khuôn: rule đó |
| Luật áp cho mọi session | file này, §1–§8 | file này |
| Khuôn dòng task · định nghĩa XONG khi chưa có compiler · nhịp kiểm tra | [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) | rule đó |
| 6 pha · ràng buộc · bất biến I1–I8 · 3 lát cắt A/B/C | [project_preparation/prompt-fullstack.md](project_preparation/prompt-fullstack.md) | file đó, trừ chỗ [F-02](finding.md#f-02) nêu |
| Luật viết sổ task (11 TP → 12 trường) | [project_preparation/huong-dan-viet-task-md.md](project_preparation/huong-dan-viet-task-md.md) | file đó |
| Khuôn bảng thay đổi cuối phiên · vế `Sửa ở đâu` của ô `Owner kiểm tra` | [.claude/rules/bao-cao-thay-doi.md](.claude/rules/bao-cao-thay-doi.md) | rule đó |
| Đã làm gì, khi nào, ai sửa file nào | `git log` — không có file nào giữ lại | `git log` |
| Chất lượng đầu ra: *"TỐT"* (dùng lại được) · *"ĐÚNG để xây"* (nội dung) · T0–T3 · biên nhận âm | [quality/00-guideline-chat-luong.md](quality/00-guideline-chat-luong.md) · nội dung: [quality/01-chat-luong-noi-dung.md](quality/01-chat-luong-noi-dung.md) | mỗi file cho câu hỏi của nó |
| Phạm vi bán · giá món · thành phần suất bán | [project_preparation/00-scope.md](project_preparation/00-scope.md) — §2 kênh · §4 giá · §4.4 suất bán | file đó |
| Định nghĩa XONG khi đã có compiler | [quality/05-checklist.md](quality/05-checklist.md) — 7 vế §6.5, tách hai hạng | file đó |

Nghi một file cũ: so dòng `Cập nhật <ngày>` trong file với `git log -1 --format=%ad -- <file>`; lệch ⇒ kiểm bằng nhà thật trước khi tin. Sửa nội dung ⇒ đổi ngày **trong cùng commit**.

## §3 Vòng lặp một phiên — mỗi bước có điều kiện đo được mới đi tiếp

1. **Định vị.** Chạy `git log --oneline -5` và `git status --short`. Đi tiếp khi biết commit cuối làm gì và cây làm việc sạch hay bẩn.
2. **Chọn việc.** **Prompt là nguồn việc duy nhất** — không dò sổ, không mở [task.md](task.md) tìm việc. Prompt mơ hồ ⇒ **hỏi lại người dùng**, đừng tự bốc một dòng cho có. Đi tiếp khi khai được **đúng một** mã ở dòng §1: `T-xx` khi prompt nêu, `ngoài-sổ` khi không — mã đó đi vào message commit §4.
3. **Nạp gói.** Ba phần: gói lane ở §1 · ô `Context › Nạp` của dòng task (**lệch với §1 ⇒ ô `Nạp` thắng**) ·
   **finding chạm file sắp gõ**: `awk -F'|' -v f=<file> '/🔴 MỞ/ && index($(NF-1),f)' finding.md` cho **mỗi** file sẽ sửa — ra dòng nào thì đọc mục đó trước khi gõ, rỗng thì đi tiếp.
   Lệnh đọc **ô cuối** — cột `File chạm` của [finding.md](finding.md). `grep` cả dòng **không** thay được: nó dính `(task.md)` ở cột `Task đóng nó` và `finding.md` trong mệnh đề, thừa 8/18 dòng khi hỏi về `finding.md`.
   Finding **chặn** task thì lấy mã ở cột `Finding phải đóng` của dòng task — **không dò cả bảng**: nạp cả bảng mỗi phiên là thuế, mà vẫn trượt finding không nhắc tên file trong mệnh đề.
   Đi tiếp khi mọi đường dẫn `test -e` ra thật **và** mọi con trỏ cấp `§`/mục `grep` ra được trong chính file đích.
4. **ĐIỂM LÙI.** Cây bẩn ⇒ commit hoặc `git stash` trước khi gõ ký tự đầu tiên. Đi tiếp khi `git status --short` rỗng. Có điểm lùi thì mọi bước sau lùi được bằng `git checkout -- <file>`.
5. **Làm.** Chỉ chạm file lane sở hữu ở §1. Vượt kích cỡ §6 ⇒ dừng, chẻ, ghi dòng task mới. Đi tiếp khi phiên **sinh nội dung mới** đã chạy sáu probe + dán **phiếu sáu dòng** ([quality/01-chat-luong-noi-dung.md §5](quality/01-chat-luong-noi-dung.md)); nhịp ở [.claude/rules/quan-ly-du-an.md mục 4](.claude/rules/quan-ly-du-an.md).
6. **Kiểm chứng.** Chạy biên nhận của lane, **dán output vào câu trả lời**. Đỏ ⇒ quay lại bước 5, không đi tiếp.
7. **Ghi sổ rồi đóng.** Theo §4. Ghi sổ **trước** khi báo xong, vì phiên bị cắt giữa chừng mất đúng phần chưa ghi.

## §4 Đầu ra session — biên nhận, không phải lời khai

Đánh ✅ cần đủ **năm** thứ, thiếu một thứ thì vẫn là đang làm: **(1)** biên nhận của lane chạy thật + output dán vào · **(2)** commit chứa thay đổi · **(3)** [finding.md](finding.md) đổi trạng thái kèm ngày + cách kiểm chứng, nếu task có đóng finding.

**(4)** **Bảng thay đổi**, dán **trước** khi commit, mỗi file đã đụng một dòng: link tới file · **sửa ở đâu** (§/mục/dòng) · sửa gì, một câu · lệnh xem diff riêng file đó. Khuôn + 5 lệnh tự rà: [.claude/rules/bao-cao-thay-doi.md §1 §3](.claude/rules/bao-cao-thay-doi.md). Thiếu bảng ⇒ phiên **chưa xong**, dù biên nhận đã xanh.

**(5)** **Phiếu sáu dòng** N1–N6 cạnh bảng thay đổi, mỗi dòng `N<i> · ĐẠT|KHÔNG ĐẠT · dẫn chứng`; dẫn chứng là số dòng hoặc output, *"đã rà"* không tính. Một trục KHÔNG ĐẠT ⇒ đầu ra bị **trả lại**, không nợ. Probe + phán quyết: [quality/01-chat-luong-noi-dung.md §3 §4 §5 §6](quality/01-chat-luong-noi-dung.md).

**Trích dẫn đủ nhà** — mọi câu, mọi ô bảng, mọi dòng sổ: con trỏ vào repo viết `[đường/dẫn/file.md §6]` rồi `(đường/dẫn/file.md)`, đủ **cả** đường dẫn **và** mục, **mọi** lần nhắc, không rút gọn từ lần hai. Cấm `§6` trần, cấm `guideline §3`, cấm tên file trần — owner bấm thẳng, không đi tìm.

Commit: stage bằng `git add <đường dẫn cụ thể>` — liệt kê từng file, để việc dở của phiên khác không bị nuốt theo. Message theo khuôn `<LANE>/<T-xx>: <file đã sửa>, đóng <F-yy>`. Không dùng `--no-verify`.

Kết phiên, dán ba dòng: mã task đã đụng · lệnh biên nhận + output · dòng task hoặc finding vừa mở ra. Ba dòng này là thứ phiên sau đọc thay cho hội thoại hôm nay.
Phiên còn finding 🔴 MỞ mà nó mở ra hay chạm tới ⇒ dán thêm **một dòng xử trí cho mỗi mã**, chọn **(a)** hoặc **(b)**, không được để trống: **(a)** đóng ngay trong phiên này — kèm biên nhận đóng + một lần thử làm đỏ, hai cổng ở [.claude/rules/chat-luong-finding.md](.claude/rules/chat-luong-finding.md).
**(b)** **prompt agent viết đủ ngay trong câu trả lời**, dán là chạy được: mã `F-xx` · lane + file được phép sửa · lệnh đóng kèm ngưỡng **đỏ khi** · đòi agent chạy biên nhận, qua hai cổng trên, rồi mới đổi trạng thái. Thiếu dòng này ⇒ phiên **chưa xong**: finding không có người nhận là finding trôi.

## §5 Finding hay task

Phép thử một câu: **chạy hết kế hoạch trong [task.md](task.md) y như nó viết — dòng này còn không?** Còn ⇒ **finding**, kế hoạch không nói tới nên nó không tự mất đi. Mất ⇒ **task**, chỉ là việc chưa tới lượt xây. Câu bắt đầu bằng *"chưa có X"* gần như luôn là task.

Hai sổ không bao giờ trộn: sổ task đo *xong / chưa*, sổ lỗi đo *đúng / sai*. Trộn thì mất cả hai cơ chế — finding nằm trong sổ task bị đánh ✅ khi hết giờ, task nằm trong sổ lỗi không bao giờ đóng được.

Một finding đẻ ra nhiều task được; task không bao giờ nằm trong sổ lỗi. Trong [task.md](task.md) chỉ ghi **mã** `F-xx` và trỏ link — mô tả lại nội dung finding là đẻ nhà thứ hai. Đóng một finding phải để lại một dòng **Bài học giữ lại**: luật nào đổi để nó không tái phát.

**Giao ngay trong phiên.** Sinh ra dòng `T-xx` hay mã `F-xx` thì **cùng phiên đó** giao đi: ghi vào sổ · **commit dòng đó trước** (điểm lùi, [CLAUDE.md §3](CLAUDE.md) bước 4) · spawn agent bằng **đúng** ô `Prompt mở session` của dòng. Viết không nổi ô đó ⇒ chưa đủ chín, chẻ trước ([CLAUDE.md §6](CLAUDE.md)), đừng spawn.

**Agent con không chạm hai sổ.** Phiên cha giữ [task.md](task.md) và [finding.md](finding.md): agent chỉ ghi file lane nó sở hữu, trả về biên nhận + bảng thay đổi, **phiên cha** mới đổi dấu ✅. Hai bên cùng ghi một sổ là dựng lại [F-24](finding.md#f-24) — nuốt hunk trong im lặng, cây vẫn sạch.

## §6 Kích cỡ một task

Một task phải thoả **cả bốn**: 1 lane · ≤ 3 file · 1 đầu ra kiểm chứng được · vừa một phiên làm việc. Vượt vế nào cũng **chẻ trước khi làm**.

Dấu hiệu phải chẻ, thấy là chẻ ngay đừng thương lượng: mô tả có chữ **"và"** nối hai danh từ khác nhau · chạm 2 lane · không nói nổi biên nhận bằng **một** lệnh · phải mở > 3 file mới hiểu · ước lượng vượt một phiên.

Vế thứ tư cứng nhất: task không vừa một phiên sẽ bị tóm tắt context giữa chừng, và sau khi tóm tắt thì phiên mất chính xác các quyết định nhỏ ở nửa đầu — task đó không chậm hơn, nó **sai** hơn.

## §7 Giai đoạn hiện tại — chưa có một dòng code ứng dụng nào

Repo có tài liệu thiết kế, [design/BA/](design/BA) và [Makefile](Makefile): `make check` — 5 đích — **chạy thật, là biên nhận thật**. Chưa có thư mục code, chưa có database.

Vì vậy **biên nhận cần compiler vẫn là lời hứa** — ⚠️ `go test`, ⚠️ `npm run build` hiện không chạy được; dùng chúng mà không đánh ⚠️ là làm sổ trông xanh trong khi không lệnh nào chạy. Chiều ngược lại cũng là khai sai: đánh ⚠️ cho `make check` là bỏ không dùng cổng đã dựng xong.

Biên nhận thật của giai đoạn này: `make check` · `grep -c` · `sed -n` · `wc -l` · `test -e` · `git log -1 -- <file>`.

Việc thuộc quyền người dùng, agent chuẩn bị sẵn rồi dừng lại chờ: tạo remote hoặc `git push` · đổi phạm vi dự án · chốt giá món và thành phần suất bán · mua VPS, tên miền, hay bất cứ thứ gì tốn tiền thật.

## §8 Trần của chính file này — và luật cấm lách

Trần: **140 dòng** toàn file — owner nới từ `120` ngày 2026-08-26, **có hạn**: luật *thêm một dòng ⇒ gộp một dòng cũ* vẫn nguyên, 140 là trần cứng chứ không phải 20 dòng dư · **mỗi mục ≤ 20 dòng** · mỗi dòng ≤ 400 byte. Byte có trần để `grep -n` thay được việc đọc cả file. Ba lệnh kiểm, cả ba phải xanh:

```bash
wc -l < CLAUDE.md                             # ra <= 140 — đỏ khi lớn hơn
awk 'length > 400' CLAUDE.md                  # phải rỗng — đỏ khi in ra dòng nào
awk '/^## §/{if(n)print n": "c; n=$2; c=0} {c++} END{print n": "c}' CLAUDE.md | awk '$2>20'   # phải rỗng
```

**§1 đang kịch trần 20, §2 đang 18.** Thêm một hàng vào hai bảng đó ⇒ **gộp một hàng cũ trong cùng commit**. Nới trần cho vừa là đường dễ, và nó làm đỏ biên nhận [T-33](task.md) — dòng đó ghim `§2` phải in ra đúng `18`.

**§1–§8 tuân 100%, không có vùng nào là gợi ý.** Không tuân nổi một luật thì cách hợp lệ duy nhất là **đổi chính luật đó bằng một commit**: dừng, ghi [finding.md](finding.md), hỏi owner. Đi vòng trong im lặng là lách, và một lần lách nằm lại trong `git log` thành tiền lệ cho mọi phiên sau.

Sáu nước lách bị cấm đích danh: chọn cách đếm có lợi khi luật chưa ghim lệnh · đánh ✅ lúc biên nhận đỏ hoặc chưa chạy · tự cấp ngoại lệ chạm-file ngoài §1 luật 4 · `git commit --no-verify` · sửa kèm file ngoài phạm vi task · viết lại biên nhận cho vừa kết quả đã có.

Thêm luật mới ⇒ **thay hoặc gộp một luật cũ**, không mở mục mới. File này nạp lại ở **mọi request của mọi phiên**, nên mỗi dòng thừa ở đây là khoản thuế mọi phiên sau đều trả.

Luật chỉ đúng cho một loại file thì nhà của nó là `.claude/rules/` có `paths:`. Luật cần **chắc chắn** xảy ra thì nhà của nó là hook trong `.claude/settings.json` ([T-35](task.md)) hoặc một đích trong [Makefile](Makefile) (lane DEVOPS, mở ở [T-06](task.md)) — câu chữ ở đây là lời đề nghị, hook và `make check` mới là cưỡng chế.
