# step.md — lộ trình ba lớp, không phải sổ task

> Cập nhật **2026-08-22**. File này **không giữ sự thật nào**, nó chỉ giữ **thứ tự ba lớp** và
> **đường đi tới dòng code đầu tiên**. Mọi câu hỏi khác đã có nhà: *làm gì tiếp* ở `task.md` ·
> *cái gì đang sai* ở `finding.md` · *đã làm gì, ai sửa file nào* ở `git log` · *luật* ở `CLAUDE.md`.
> Lệch nhà thật ⇒ **nhà thật thắng**, dòng ở đây là bug phải sửa ngay.
>
> Vì vậy file này **cấm** chép mã task, mô tả finding, hay đếm số việc còn lại — mỗi con số chép ra
> là một chỗ thứ hai phải sửa, và chỗ thứ hai sẽ quên. Chỗ nào cần số, ở đây để **lệnh**, không để số.

---

## §1 Ba lớp, không được đảo

| Lớp | Là gì | Nhà của nó | Trạng thái |
|---|---|---|---|
| **1 · Thiết kế** | 6 pha · 11 ràng buộc · bất biến I1–I8 · 3 lát cắt A/B/C | [prompt-fullstack.md](prompt-fullstack.md) | ✅ có từ trước — nhưng còn `F-02` (con trỏ hụt) |
| **2 · Bộ khung quản lý** | lane nào sửa file nào · sự thật nào ở nhà nào · "XONG" nghĩa là gì · biên nhận nào tính | `CLAUDE.md` · `.claude/rules/**` · `task.md` · `finding.md` | 🔄 **đang ở đây** — dựng xong bản đầu, đang vá bằng chính nó |
| **3 · Code ứng dụng** | Go · MySQL · Next.js | ⚠️ chưa có nhà — pha 2–4 mới mở | ⬜ chưa bắt đầu, và **cố ý** chưa bắt đầu |

Viết code trước khi có lớp 2 không phải "đi nhanh hơn" — nó là tạo ra thứ chưa ai rà được.
Bằng chứng lớp 3 chưa mở, chạy được: `ls -d design quality Makefile 2>&1` — cả ba đều `No such file`.

## §2 Đo hiện trạng bằng lệnh, đừng tin con số trong file này

```bash
grep -c '^| \(~~\)\?\*\*T-' task.md      # tổng số dòng task
grep -c '^| ~~\*\*T-' task.md             # số task đã xong (gạch ngang)
grep -c '🔴 MỞ' finding.md                # số finding còn mở
grep -n '^| \*\*T-' task.md | grep '🔺' | head -1   # việc phải làm ngay
git log --oneline -5                      # phiên trước đã đụng gì
```

Ở đây **cố ý không chép lại output**. Hai sổ đang được sửa gần như mỗi phiên, nên một con số dán vào
file này hết đúng trước khi ai đọc tới nó — và một con số sai trông y hệt một con số đúng. Cái duy nhất
ổn định để nói: lớp 2 chưa đóng, và việc đang chờ luôn là **dòng 🔺 đầu tiên** mà lệnh thứ tư dò ra.

## §3 Lớp 2 đang vá tới đâu

Bộ khung dựng xong ở phiên đầu rồi **tự soi lại nó bằng phiên trí nhớ trắng** — đó là cơ chế, không phải
sự cố: một phiên chỉ được đọc `CLAUDE.md` + `task.md` + `finding.md` + rule, nhận đúng dòng task mà lệnh
*Task tiếp theo* dò ra, rồi diễn lại từng bước bằng lệnh. Ba loại lỗ hổng nó phải tìm, nguy hiểm tăng dần:

1. chỗ phiên mới phải **đoán**
2. chỗ phiên mới phải **hỏi lại owner** — tức bộ khung chưa gánh được việc của nó
3. ⚠️ chỗ phiên mới **làm sai được mà không lệnh nào đỏ** — loại này chỉ lộ sau nhiều phiên, lúc đó sửa đã đắt

Ngoại lệ đã chốt: lỗ hổng nào chỉ sửa được bằng cách **đổi kiến trúc file** thì phiên không tự sửa, chỉ
ghi finding kèm cách sửa đề xuất rồi quay lại việc đang làm.

Danh sách lỗ hổng hiện tại **không ở đây**, nó ở `finding.md`. Xem bằng: `sed -n '/^| # |/,/^$/p' finding.md`.

## §4 Đường đi từ đây tới dòng code đầu tiên

```
vá nốt lớp 2 ──> mở lane BA ──> mở lane DEVOPS ──> DB ──> BE ──> FE ──> Pha 0 (thiết kế nghiệp vụ thật)
                                                                             │
                                                            Go / SQL / React ở Pha 2–4, còn xa
```

Thứ tự thật nằm ở cột `Cần xong trước` trong `task.md`, không ở sơ đồ này. Sơ đồ chỉ nói **hình dạng**:
mở lane trước, viết nội dung lane sau — mở lane là dựng cái *chứa*, pha là việc *đổ vào*.
Một lane coi là mở khi đủ **năm vế** ở `.claude/rules/quan-ly-du-an.md` §6, không phải khi có thư mục.

## §5 Việc thuộc quyền owner, agent chuẩn bị sẵn rồi dừng

Bốn thứ agent **không** tự quyết (`CLAUDE.md` §7): tạo remote hoặc `git push` · đổi phạm vi dự án ·
chốt giá món và thành phần suất bán · mua bất cứ thứ gì tốn tiền thật.

Cộng thêm: finding nào bảng ghi **"chưa có task — kiến trúc, chờ owner chốt"** đang nằm đó đợi một câu
trả lời, chứ không đợi một phiên rảnh. Dò bằng: `grep -c 'chưa có task' finding.md`.

## §6 Ba cái bẫy đã trả giá, đừng trả lần hai

- **`reference/` là dự án ở giai đoạn xa hơn.** Nó nói tới `code/be/`, `Makefile`, `migrations/`, mã
  finding tới hai chữ số, 6 lane đang mở — chép nó = vẽ bản đồ cho lãnh thổ chưa tồn tại, rồi phiên sau
  đi theo bản đồ đó và tự dựng một cấu trúc khác. Lấy **cấu trúc và giọng viết**, không lấy nội dung.
- **Biên nhận cần compiler đều là lời hứa.** `make check` · `go test` · `npm run build` hiện không chạy.
  Dùng chúng mà không đánh ⚠️ là làm sổ trông xanh trong khi không lệnh nào chạy. Biên nhận thật của giai
  đoạn này là lệnh đọc lại: `grep -c`, `sed -n`, `wc -l`, `test -e`, `git log -1 -- <file>`.
- **Cây bẩn không chắc là của mình.** Repo này đã có hai phiên chạy chồng nhau. Bước ĐIỂM LÙI
  (`CLAUDE.md` §3) bảo commit hoặc `git stash` khi cây bẩn — làm đúng thế mà file đó là việc dở của phiên
  khác thì bạn vừa nuốt nó. Trước khi commit: `git status --short` rồi `git add` **từng đường dẫn cụ thể**,
  không bao giờ `git add -A`.
