# CLAUDE.md — luật + con trỏ

> Cập nhật **2026-08-22**. **File này là bản đồ, không phải lãnh thổ.** Nó không giữ sự thật nào của dự án: mỗi dòng hoặc là **luật làm việc**, hoặc là **con trỏ** tới nhà thật. Lệch nhà thật ⇒ **nhà thật thắng**, dòng ở đây là bug phải sửa ngay. Trần của chính file này ở §8.
>
> **Vai trò.** Người dùng giao task + yêu cầu; agent tự chọn cách làm, tự viết, **tự kiểm chứng bằng lệnh**, không hỏi lại thứ đọc được trong repo. Đổi lại: thấy hệ thống sai thì **nổi lên** — ghi một dòng vào [finding.md](finding.md) kèm cách sửa đề xuất, rồi quay lại việc đang làm. Im lặng tự xử = vi phạm.

## §1 Định tuyến lane — chọn lane trước khi mở file thứ nhất

Mở lời bằng một dòng khai báo để người dùng chặn được ngay: `Lane: <lane> · <mã task> · nạp: <file> · biên nhận: <lệnh>`.

| Lane | Prompt nói tới | Lane sở hữu file nào | Nạp gói nào | Biên nhận |
|---|---|---|---|---|
| **NON-CODE** | chốt tài liệu, lập kế hoạch, rà soát, hỏi hiện trạng | `task.md`, `finding.md`, `CLAUDE.md`, `project_preparation/**`, `.claude/rules/**` | [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) + đúng file sẽ sửa | lệnh đọc lại: `grep -c`, `wc -l`, `test -e` |
| **BA** | quy trình quán, luồng nghiệp vụ, vai & quyền, quy tắc nghiệp vụ | `design/BA/**` | [.claude/rules/lane-ba.md](.claude/rules/lane-ba.md) + [prompt-fullstack.md](project_preparation/prompt-fullstack.md) §3 §7 dòng `**0 · BA**` | 4 lệnh ở [design/BA/04-yeu-cau.md](design/BA/04-yeu-cau.md) §2 |
| **DB** | bảng, cột, index, migration, seed, `.sql` | ⚠️ chưa mở | — | — (T-07 mở lane này) |
| **BE** | API, endpoint, handler, service, Go, transaction, tính giá | ⚠️ chưa mở | — | — (T-08 mở lane này) |
| **FE** | trang, component, Next, giỏ hàng, màn hình trạm, QR bàn | ⚠️ chưa mở | — | — (T-09 mở lane này) |
| **DEVOPS** | docker, compose, Makefile, CI, deploy, backup, biến môi trường | ⚠️ chưa mở | — | — (T-03 + T-06 mở lane này) |

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
| Cái gì đang sai + bài học giữ lại | [finding.md](finding.md) | `finding.md` |
| Luật áp cho mọi session | file này, §1–§8 | file này |
| Khuôn dòng task · định nghĩa XONG khi chưa có compiler · nhịp kiểm tra | [.claude/rules/quan-ly-du-an.md](.claude/rules/quan-ly-du-an.md) | rule đó |
| 6 pha · ràng buộc · bất biến I1–I8 · 3 lát cắt A/B/C | [project_preparation/prompt-fullstack.md](project_preparation/prompt-fullstack.md) | file đó, trừ chỗ [F-02](finding.md#f-02) nêu |
| Luật viết sổ task (11 TP → 12 trường) | [project_preparation/huong-dan-viet-task-md.md](project_preparation/huong-dan-viet-task-md.md) | file đó |
| Khuôn bảng thay đổi cuối phiên · vế `Sửa ở đâu` của ô `Owner kiểm tra` | [.claude/rules/bao-cao-thay-doi.md](.claude/rules/bao-cao-thay-doi.md) | rule đó |
| Đã làm gì, khi nào, ai sửa file nào | `git log` — không có file nào giữ lại | `git log` |
| Phạm vi & giá món | ⚠️ chưa có nhà — T-05 tạo `project_preparation/00-scope.md` | — |
| Định nghĩa XONG khi đã có compiler | ⚠️ chưa có nhà — T-04 tạo `quality/05-checklist.md` | — |

Nghi một file cũ: so dòng `Cập nhật <ngày>` trong file với `git log -1 --format=%ad -- <file>`; lệch ⇒ kiểm bằng nhà thật trước khi tin. Sửa nội dung ⇒ đổi ngày **trong cùng commit**.

## §3 Vòng lặp một phiên — mỗi bước có điều kiện đo được mới đi tiếp

1. **Định vị.** Chạy `git log --oneline -5` và `git status --short`. Đi tiếp khi biết commit cuối làm gì và cây làm việc sạch hay bẩn.
2. **Chọn việc.** Chạy lệnh ở mục *Task tiếp theo* đầu [task.md](task.md). Đi tiếp khi có **đúng một** mã `T-xx`.
3. **Nạp gói.** Ba phần: gói lane ở §1 · ô `Context › Nạp` của dòng task (**lệch với §1 ⇒ ô `Nạp` thắng**) ·
   **bảng đầu [finding.md](finding.md)** — finding còn 🔴 MỞ mà chạm file task này sẽ sửa thì đọc mục đó trước khi gõ.
   Đi tiếp khi mọi đường dẫn `test -e` ra thật **và** mọi con trỏ cấp `§`/mục `grep` ra được trong chính file đích.
4. **ĐIỂM LÙI.** Cây bẩn ⇒ commit hoặc `git stash` trước khi gõ ký tự đầu tiên. Đi tiếp khi `git status --short` rỗng. Có điểm lùi thì mọi bước sau lùi được bằng `git checkout -- <file>`.
5. **Làm.** Chỉ chạm file lane sở hữu ở §1. Vượt kích cỡ §6 ⇒ dừng, chẻ, ghi dòng task mới.
6. **Kiểm chứng.** Chạy biên nhận của lane, **dán output vào câu trả lời**. Đỏ ⇒ quay lại bước 5, không đi tiếp.
7. **Ghi sổ rồi đóng.** Theo §4. Ghi sổ **trước** khi báo xong, vì phiên bị cắt giữa chừng mất đúng phần chưa ghi.

## §4 Đầu ra session — biên nhận, không phải lời khai

Đánh ✅ cần đủ **bốn** thứ, thiếu một thứ thì vẫn là đang làm: **(1)** biên nhận của lane chạy thật + output dán vào · **(2)** commit chứa thay đổi · **(3)** [finding.md](finding.md) đổi trạng thái kèm ngày + cách kiểm chứng, nếu task có đóng finding.

**(4)** **Bảng thay đổi**, dán **trước** khi commit, mỗi file đã đụng một dòng: link tới file · **sửa ở đâu** (§/mục/dòng) · sửa gì, một câu · lệnh xem diff riêng file đó. Khuôn + lệnh tự rà: [.claude/rules/bao-cao-thay-doi.md](.claude/rules/bao-cao-thay-doi.md) §1 §3. Thiếu bảng ⇒ phiên **chưa xong**, dù biên nhận đã xanh.

Commit: stage bằng `git add <đường dẫn cụ thể>` — liệt kê từng file, để việc dở của phiên khác không bị nuốt theo. Message theo khuôn `<LANE>/<T-xx>: <file đã sửa>, đóng <F-yy>`. Không dùng `--no-verify`.

Kết phiên, dán ba dòng: mã task đã đụng · lệnh biên nhận + output · dòng task hoặc finding vừa mở ra. Ba dòng này là thứ phiên sau đọc thay cho hội thoại hôm nay.

## §5 Finding hay task

Phép thử một câu: **chạy hết kế hoạch trong [task.md](task.md) y như nó viết — dòng này còn không?** Còn ⇒ **finding**, kế hoạch không nói tới nên nó không tự mất đi. Mất ⇒ **task**, chỉ là việc chưa tới lượt xây. Câu bắt đầu bằng *"chưa có X"* gần như luôn là task.

Hai sổ không bao giờ trộn: sổ task đo *xong / chưa*, sổ lỗi đo *đúng / sai*. Trộn thì mất cả hai cơ chế — finding nằm trong sổ task bị đánh ✅ khi hết giờ, task nằm trong sổ lỗi không bao giờ đóng được.

Một finding đẻ ra nhiều task được; task không bao giờ nằm trong sổ lỗi. Trong `task.md` chỉ ghi **mã** `F-xx` và trỏ link — mô tả lại nội dung finding là đẻ nhà thứ hai. Đóng một finding phải để lại một dòng **Bài học giữ lại**: luật nào đổi để nó không tái phát.

## §6 Kích cỡ một task

Một task phải thoả **cả bốn**: 1 lane · ≤ 3 file · 1 đầu ra kiểm chứng được · vừa một phiên làm việc. Vượt vế nào cũng **chẻ trước khi làm**.

Dấu hiệu phải chẻ, thấy là chẻ ngay đừng thương lượng: mô tả có chữ **"và"** nối hai danh từ khác nhau · chạm 2 lane · không nói nổi biên nhận bằng **một** lệnh · phải mở > 3 file mới hiểu · ước lượng vượt một phiên.

Vế thứ tư cứng nhất: task không vừa một phiên sẽ bị tóm tắt context giữa chừng, và sau khi tóm tắt thì phiên mất chính xác các quyết định nhỏ ở nửa đầu — task đó không chậm hơn, nó **sai** hơn.

## §7 Giai đoạn hiện tại — chưa có một dòng code ứng dụng nào

Repo hiện chỉ có tài liệu thiết kế và hướng dẫn. Chưa có `Makefile`, chưa có thư mục code, chưa có database, chưa có `design/`.

Vì vậy **mọi biên nhận cần compiler đều là lời hứa** — ⚠️ `make check`, ⚠️ `go test`, ⚠️ `npm run build` hiện không chạy được; dùng chúng mà không đánh ⚠️ là làm sổ trông xanh trong khi không lệnh nào chạy.

Biên nhận thật của giai đoạn này là **lệnh đọc lại**: `grep -c`, `sed -n`, `wc -l`, `test -e`, `git log -1 -- <file>`.

Việc thuộc quyền người dùng, agent chuẩn bị sẵn rồi dừng lại chờ: tạo remote hoặc `git push` · đổi phạm vi dự án · chốt giá món và thành phần suất bán · mua VPS, tên miền, hay bất cứ thứ gì tốn tiền thật.

## §8 Trần của chính file này

Trần: **120 dòng**, mỗi mục ≤ 14 dòng, mỗi dòng ≤ 400 byte. Byte có trần để `grep -n` thay được việc đọc cả file. Kiểm: `wc -l < CLAUDE.md` và `awk 'length > 400' CLAUDE.md` (phải rỗng).

Thêm luật mới ⇒ **thay hoặc gộp một luật cũ**, không mở mục mới. File này nạp lại ở **mọi request của mọi phiên**, nên mỗi dòng thừa ở đây là khoản thuế mọi phiên sau đều trả.

Luật chỉ đúng cho một loại file thì nhà của nó là `.claude/rules/` có `paths:`, không phải ở đây. Luật cần **chắc chắn** xảy ra thì nhà của nó là hook trong `.claude/settings.json` — câu chữ ở đây là lời đề nghị, hook mới là cưỡng chế.
