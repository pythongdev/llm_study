# CLAUDE.md — luật + con trỏ

> Cập nhật **2026-08-19**. **File này là bản đồ, không phải lãnh thổ.**
> Nó **không giữ sự thật nào của dự án**: mỗi dòng hoặc là **luật làm việc**, hoặc là **con trỏ**
> tới nhà thật. File này lệch nhà thật ⇒ **nhà thật thắng**, dòng ở đây là bug phải sửa ngay.
> Trần của chính nó ở §12. Gốc của các luật dưới đây: [project_preparation/project_issue.md](project_preparation/project_issue.md).
>
> **Vai trò.** Owner giao **task + yêu cầu**; agent là **người làm full-stack** — tự chọn cách làm, tự viết,
> tự kiểm chứng, không hỏi lại thứ đọc được trong repo. Đổi lại, thấy hệ thống sai thì **nổi lên** theo §7:
> ghi finding + **đề xuất cách sửa** + **bài học** để session sau không giẫm lại. Im lặng tự xử = vi phạm.

---

## 1. Định tuyến lane — làm ngay khi đọc prompt, trước khi mở file

Đọc xong prompt thì **việc đầu tiên là chọn lane**, rồi chỉ nạp đúng gói của lane đó.
Mở lời bằng một dòng khai báo, để owner chặn được ngay nếu định tuyến sai:

```
Lane: BE · task T-08 · nạp: design/backend/04-yeu-cau.md + 02-luat.md · biên nhận: make check
```

| Lane | Prompt nói tới | Lane sở hữu file nào | Nạp đúng gói này | Biên nhận |
|------|----------------|----------------------|------------------|-----------|
| **BA** | quy trình quán, luồng nghiệp vụ, vai & quyền, quy tắc nghiệp vụ, thước đo, câu hỏi cho owner | `design/BA/**` | [design/BA/04-yeu-cau.md](design/BA/04-yeu-cau.md) + đúng file sẽ sửa | **lệnh đọc lại** — 4 lệnh ở [04 §4](design/BA/04-yeu-cau.md) |
| **DB** | bảng, cột, index, migration, seed, ràng buộc, `.sql` | `code/be/migrations/**`, `design/data_base/**` | [design/data_base/04-yeu-cau.md](design/data_base/04-yeu-cau.md) + file `.sql` đang chạm + [02-luat](design/data_base/02-luat.md) | `make test-int` |
| **BE** | API, endpoint, handler, service, store, Go, transaction, auth, SSE, tính giá | `code/be/**` trừ `migrations/`, `design/backend/**` | [design/backend/04-yeu-cau.md](design/backend/04-yeu-cau.md) + [02-luat](design/backend/02-luat.md) + [03-hien-trang](design/backend/03-hien-trang.md) | `make check` |
| **FE** | trang, giao diện, Next, component, giỏ hàng, màn hình trạm, QR bàn | `fe/**`, `design/frontend/**` | [design/frontend/04-yeu-cau.md](design/frontend/04-yeu-cau.md) + [02-luat](design/frontend/02-luat.md) + [01-thiet-ke](design/frontend/01-thiet-ke.md) + `code/be/api/openapi.yaml` | `npm run build` + `tsc --noEmit` (`make test-fe` gắn ở `T-23`) |
| **DEVOPS** | docker, compose, Makefile, CI, deploy, Caddy, backup, cổng, biến môi trường | `deploy/**`, `Makefile`, `.env*`, `.github/**` | [deploy/AGENTS.md](deploy/AGENTS.md) + [quality/04](quality/04-devops.md) + [status/04](status/04-devops.md) | `make up && curl -s localhost:8080/healthz && make down` |
| **NON-CODE** | chốt thiết kế, sửa tài liệu, lập kế hoạch, rà soát, hỏi hiện trạng | `task.md`, `finding.md`, `step.md`, `status/`, `quality/`, `project_preparation/`, `README.md`, `CLAUDE.md` | [project_preparation/AGENTS.md](project_preparation/AGENTS.md) + đúng file sẽ sửa | **lệnh đọc lại** chứng minh chữ khớp code (§8) |

Bốn luật định tuyến:

1. **Một session một lane.** Prompt chạm nhiều lane ⇒ chọn lane của **đầu ra kiểm chứng được**,
   phần còn lại thành dòng task mới trong [task.md](task.md) ngay lúc đó.
2. **Không rõ lane ⇒ NON-CODE**, vì lane đó không sửa code: đọc, đối chiếu, hỏi lại một câu gọn.
3. **Cấm nạp ngoài gói.** Cần file thứ 4 ⇒ nói ra lý do trước khi mở. `step.md` (1.330 dòng) chỉ
   đọc **đúng mục** dòng task chỉ tên, không đọc trọn.
4. **Đổi lane giữa chừng = dừng** (§6): commit, ghi sổ, mở task mới. Không kéo lane cũ theo.

## 2. One fact one home

| Sự thật | Nhà duy nhất | Ai thắng khi lệch |
|---------|--------------|-------------------|
| Làm gì tiếp, theo thứ tự nào | **Mỗi pha một sổ task riêng** (6 pha: [prompt-fullstack §7](project_preparation/prompt-fullstack.md)); sổ đã có: `ls design/*/task_*.md`. Pha chưa tách **và** việc không thuộc pha nào → [task.md](task.md) | sổ task của pha đó |
| Vấn đề đã biết: mức, trạng thái, cách kiểm chứng | **Mỗi pha một sổ finding riêng**; sổ đã có: `ls design/*/finding_*.md`. Nhà là pha **phải sửa**, không phải pha phát hiện. Pha chưa tách → [finding.md](finding.md) | sổ finding của pha đó |
| Hệ thống **hiện** có gì | [status/](status/README.md) + code · DB: [design/data_base/03](design/data_base/03-hien-trang.md) | **code** |
| Xây thế nào, thiết kế chi tiết | [step.md](step.md) · DB: [design/data_base/01](design/data_base/01-thiet-ke.md) · BE: [design/backend/01](design/backend/01-thiet-ke.md) · FE: [design/frontend/01](design/frontend/01-thiet-ke.md) | step.md, trừ khi code đã chạy khác ⇒ mở finding |
| "Đúng" nghĩa là gì, định nghĩa XONG | [quality/](quality/README.md) · DB: [design/data_base/02](design/data_base/02-luat.md) · BE: [design/backend/02](design/backend/02-luat.md) · FE: [design/frontend/02](design/frontend/02-luat.md) | quality/ |
| **Mọi sự thật về DB** (4 file: thiết kế · luật · hiện trạng · yêu cầu) | [design/data_base/](design/data_base/01-thiet-ke.md) | code trong `code/be/migrations/` |
| Phạm vi, bảng giá, menu đã chốt | [00-scope.md](project_preparation/00-scope.md) | scope |
| Cách chạy + luật nghiệp vụ không được phá | [README.md](README.md) | code ⇒ lệch thì mở finding |
| Lệnh kiểm tra | [Makefile](Makefile) | Makefile — CI gọi lại `make`, cấm chép lệnh sang chỗ khác |
| Luật riêng của một tầng | `AGENTS.md` của lane (§1) | lane file |

Bốn hệ quả bắt buộc:

1. **Cấm chép.** Cần lại một sự thật ⇒ đặt **link**, không viết lại. Chép = đẻ nhà thứ hai, và
   nhà thứ hai luôn trôi trong im lặng.
2. **Code thắng tài liệu.** Tài liệu ghi "đã sửa" mà code chưa ⇒ finding ⚠️ **MỞ LẠI**, không phải sửa chữ.
3. **Cấm file chỉ để điều hướng.** File mới phải giữ ít nhất một sự thật chưa có ở đâu khác.
   Nếu nó chỉ liệt kê link thì nội dung của nó thuộc về file này. Bản đồ duy nhất của repo là CLAUDE.md.
4. **Mỗi file có đúng một lane sở hữu** (§1). Sửa file của lane khác — kể cả một dòng — là việc
   của lane đó: mở finding + task, đừng tiện tay.

## 3. Vòng lặp làm việc

```
ĐỊNH TUYẾN → ĐỊNH VỊ → PLAN → ĐIỂM LÙI → LÀM → TỰ RÀ → KIỂM CHỨNG → GHI SỔ
```

| Bước | Phải đúng cái gì mới được đi tiếp |
|------|-----------------------------------|
| ĐỊNH TUYẾN | §1 — khai lane + gói nạp + biên nhận ngay dòng đầu |
| ĐỊNH VỊ | **Một task tại một thời điểm**, lấy ở khối đầu [task.md](task.md) (`sed -n '/^## Task tiếp theo/,/^---/p' task.md`) — không mở task thứ hai "cho tiện", không chép mã task / ngày / dấu ✅ sang file khác (§2.1) |
| PLAN | Nói ra: chạm **file nào** (phải thuộc lane đã khai) + **đầu ra kiểm chứng được** là lệnh gì |
| ĐIỂM LÙI | **Ghim `H` + `S`, đếm session (§11)** — > 1 là cảnh báo, không chặn. Sạch **ở đường dẫn lane này sở hữu** (§1), không phải toàn repo: `git status --short -- <đường dẫn của lane>` rỗng, rồi **commit**. File bẩn của lane khác **để nguyên** — không commit hộ, không restore hộ (§11); chúng không chặn lane này |
| LÀM | Chỉ chạm đúng các file đã khai ở PLAN |
| TỰ RÀ | `git diff --stat` — file lạ hoặc file ngoài lane ⇒ bỏ ra, không "tiện tay sửa luôn" |
| KIỂM CHỨNG | Biên nhận của lane (§1) xanh **và** lệnh ở cột *Đầu ra kiểm chứng được* của dòng task chạy thật. Sửa lỗi ⇒ test phải **đỏ trên code cũ**, xanh trên code mới, dán cả hai output |
| GHI SỔ | §4 — chưa ghi sổ thì task chưa xong |

## 4. Đầu ra session — biên nhận, không phải lời khai

- Đánh ✅ cần đủ **ba** thứ: (a) biên nhận lane chạy thật + output, (b) commit chứa thay đổi,
  (c) [finding.md](finding.md) đổi trạng thái kèm ngày + cách kiểm chứng.
  Thiếu một ⇒ vẫn là đang làm. "Đã viết code" ≠ "đã chạy".
- Commit: `git add <đường dẫn cụ thể>` — **cấm `git add -A`**, **cấm `--no-verify`**.
  Message ghi lane + mã task + finding đã đóng: `BE/T-08: service/order.go, đóng F-16 F-17`.
- Cuối session ghi **một lần** vào nhà của từng sự thật, nơi khác đặt **link** — §2.1 áp dụng cho
  chính bước này (`F-39`: sổ từng ăn 80% mọi thay đổi vì mục này bắt chép):
  trạng thái finding ⇒ **chỉ** bảng tổng hợp [finding.md](finding.md) · bằng chứng (ngày, commit,
  lệnh) + **bài học** (§7) ⇒ **chỉ** mục `### F-xx` · dấu ✅ + biên nhận ⇒ **chỉ** dòng task [task.md](task.md) ·
  [status/](status/README.md) **của đúng lane**, chỉ khi ảnh chụp đã đổi.
- **Suy ra được bằng lệnh thì cấm chép thành bảng.** Cần bảng ⇒ ghi lệnh sinh ra nó (§10).
- Đóng một phần ⇒ ghi rõ **phần còn lại** và task sẽ đóng nốt (mẫu đúng: `F-01` để phần đồng thời ở `T-21`).

## 5. *(bỏ trống — số mục giữ nguyên vì `deploy/AGENTS.md` và `project_preparation/AGENTS.md` trỏ tới §10, §11; đánh số lại là sửa file của lane khác, xem §2.4)*

## 6. Session quá dài

- Một session = **một lane, một task**. Session dài không tạo thêm giá trị, chỉ tạo thêm thay đổi không ai rà.
- Dấu hiệu phải dừng: **diff đã chạm file ngoài lane** · sửa > 3 file ngoài kế hoạch ·
  phải cuộn lại để nhớ mình đã quyết gì · hơn 2 lần thử–sai trên cùng một lỗi · context bị tóm tắt giữa chừng.
- Gặp dấu hiệu ⇒ **dừng ở điểm lùi gần nhất**: commit phần chạy được, ghi sổ (§4), mở task mới
  cho phần còn lại **kèm lane của nó**, rồi mới nghỉ. **Cấm gánh tiếp cho xong.**
- Task không vừa một session là task **viết sai kích cỡ** (§9) ⇒ chẻ ngay tại task.md, không phải cố làm.

## 7. Finding / cảnh báo phát hiện giữa chừng

- **Finding hay task? Một phép thử, hỏi trước khi viết dòng nào:** chạy hết kế hoạch đang viết ([step.md](step.md) + [task.md](task.md)) **y như nó viết** — dòng này còn không?
  **Còn** ⇒ **finding**: đang có cái **sai ngay bây giờ** (hai nguồn lệch nhau, code khác thiết kế, luật tự mâu thuẫn) mà kế hoạch không nói tới nên không tự mất đi.
  **Mất** ⇒ **task**: **việc chưa tới lượt xây**, không phải lỗi. Câu mở đầu bằng *"chưa có X"* gần như luôn là task — nhà của nó là [task.md](task.md) + [step.md](step.md) (`F-65`).
- **Hai sổ đo hai đại lượng khác nhau:** finding đo **đúng/sai**, đóng khi mệnh đề sai hết đúng và có lệnh chứng minh; task đo **xong/chưa**, đóng bằng biên nhận lane (§4).
  Một finding đẻ ra nhiều task được; task **không bao giờ** nằm trong sổ finding, và **mỗi pha đúng một sổ finding** (§2), nhà của nó là pha **phải sửa** chứ không phải pha phát hiện — cấm sổ thứ hai trong sổ task, commit message, hay đầu file khác.
- Thấy vấn đề mới ⇒ **thêm dòng vào [finding.md](finding.md) ngay** (ID kế tiếp, ghi đúng lane ở cột *Lane*) **kèm cách sửa đề xuất** ở mục `### F-xx` —
  nêu vấn đề mà không nêu lối ra là đẩy việc ngược cho owner — rồi quay lại việc đang làm. Không sửa kèm — sửa kèm là cách `git add -A` nuốt file người khác.
- Đóng finding cần **bằng chứng chạy được**; đóng vì hết giờ, hết chỗ, hoặc "đọc lại thấy ổn" ⇒ cấm. Bóp nhỏ finding cho vừa cái đã làm cũng cấm: khai 5 vế thì đóng 5 vế, hoặc đóng 3 và ghi 2 vế còn lại.
- Đóng finding **phải để lại một dòng `**Bài học giữ lại:**`** trong mục `### F-xx` — nói **luật nào đổi để nó không tái phát**, không kể lại sự cố.
  Rút không ra luật ⇒ chưa hiểu nguyên nhân, chưa được đóng. Cùng một bài học lặp **lần thứ 3** ⇒ nó lên thành luật ở file này (§12: **thay hoặc gộp**, không thêm mục).
- **Quét cuối session:** đã nói trong hội thoại mà chưa thành dòng thì coi như mất — ghi nốt. Finding không task nào đóng ⇒ lỗi của [task.md](task.md), sửa mục *Đối chiếu finding → task* ở cuối file đó.

## 8. Kỷ luật giữa các lane

- **Mối nối là chỗ hỏng nhất**, nên hợp đồng giữa hai lane phải là **file kiểm chứng được**, không phải
  lời hứa: DB↔BE = migration + test tích hợp · BE↔FE = `code/be/api/openapi.yaml` + type sinh tự động ·
  mọi lane↔DEVOPS = một target trong [Makefile](Makefile).
- Việc bắc cầu 2 lane ⇒ **hai task**, nối bằng cột *Cần xong trước* trong [task.md](task.md)
  (mẫu: `T-13` BE sinh OpenAPI → `T-24` FE sinh type).
- **Lane bị chặn thì đứng lại**, không "tạm mock" bằng lane khác: FE mock BE là cách hai bên trôi
  khỏi nhau mà không lệnh nào đỏ. Ghi finding, chọn task khác trong lane đang mở.
- Lane **NON-CODE không có compiler**, nên biên nhận của nó là **lệnh đọc lại**: `grep` ra đúng số
  hit đã khai, `git log -1 -- <file>`, hoặc `sed` in ra đoạn vừa sửa. Không có lệnh ⇒ chưa xong.
- `status/0X` của lane nào thì **lane đó cập nhật**, không ghi hộ nhau — ghi hộ là đoán.

## 9. Kích cỡ một task

- Một task = **1 lane · ≤ 3 file · 1 đầu ra kiểm chứng được · vừa một session**. Đây có phải task không, hay là finding? Phép thử ở **§7**, hỏi trước khi thêm dòng.
- Vượt bất kỳ vế nào ⇒ **chẻ trước khi làm**, đánh số mới trong [task.md](task.md) (mẫu: `T-36` tách khỏi `T-21`).
- Task giấy tờ (chốt thiết kế) vẫn phải có đầu ra kiểm chứng được: **viết vào file nào, mục nào** —
  không có thì nó là ý kiến, không phải task.
- Task đụng 2 lane ⇒ luôn tách theo lane, vì biên nhận của hai lane là hai lệnh khác nhau (§1).

## 10. Chống tài liệu cũ âm thầm

- Mọi file tài liệu có dòng `Cập nhật <ngày>` ở đầu. Sửa nội dung ⇒ **đổi ngày trong cùng commit**.
- Sửa code làm tài liệu sai ⇒ sửa tài liệu **trong cùng commit**, hoặc mở finding ngay. Không có lựa chọn thứ ba.
- Nghi tài liệu cũ: so ngày trong file với `git log -1 --format=%ad -- <file>`; lệch ⇒ **kiểm bằng code trước khi tin**.
- **Con số trong tài liệu hỏng sớm nhất** (số test, số bảng, số cổng — xem `F-13`). Đếm được bằng lệnh
  thì ghi lệnh, đừng ghi số.

## 11. Điểm lùi & thay đổi ngoài ý muốn

- Điểm lùi = **commit ngay trước khi sửa** (§3). Không có nó thì không được sửa file nào.
- **Một cây làm việc = một session** (gốc: [F-42](finding.md#f-42)). Ở bước ĐIỂM LÙI ghim hai mốc: `H=$(git rev-parse HEAD)` và `S=$(git status --short)`.
  **Đếm session** — `lsof -a -d cwd -c claude -Fn | grep -c "^n$(git rev-parse --show-toplevel)$"` ra **> 1** là **cảnh báo, không phải lệnh dừng** (nó đếm cả cửa sổ nhàn rỗi): báo owner con số, commit hẹp lại, và chạy phép đo va chạm dưới đây trước **mỗi** commit.
- **Chỉ va chạm đo được mới dừng** — không có miễn trừ bằng miệng, vì lời nói không để lại dấu nào đếm được. Trước mỗi commit: `[ "$H" = "$(git rev-parse HEAD)" ]` sai, **hoặc** `git status --short` mọc dòng session này không tạo ra (so với `S`) ⇒ dừng, báo owner,
  **ghi đúng 1 dòng `> **Ca thứ N`** vào [mục F-42](finding.md#f-42) (đếm: `grep -c '^> \*\*Ca thứ' finding.md`); **không** tự amend/reset (việc owner).
- **Cấm `git add -A`.** Trước mỗi commit: đọc `git status --short` và `git diff --stat` từng dòng;
  file lạ hoặc file ngoài lane ⇒ **đừng stage nó**, và **đừng `git restore`** — đó là việc chưa commit của lane khác.
- Thuộc **owner**, agent không tự chạy: `git reset --hard` · xoá branch · `push --force` ·
  `docker compose down -v` · `DROP` / `TRUNCATE` trên DB thật.
  Phát hiện đã sửa nhầm ⇒ **dừng và báo**, đừng tự lùi.
- Repo **chưa có remote** (`F-22` còn nợ, `F-25`): điểm lùi hiện chỉ nằm trên một ổ cứng ⇒ commit dày tay.

## 12. Trần của chính file này

- **≤ 175 dòng** · mỗi mục ≤ 14 dòng · mỗi dòng ≤ 400 byte (để `grep` thay được `Read`).
- Thêm luật mới ⇒ **thay hoặc gộp** luật cũ. Không thêm mục thứ 13 — file này phình ra là mọi
  session sau đều trả tiền.
- Thêm **sự thật** (số liệu, trạng thái, mô tả thiết kế) vào đây là vi phạm §2: đặt link, không đặt nội dung.
