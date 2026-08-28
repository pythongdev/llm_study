---
paths:
  - "Makefile"
  - "deploy/**"
  - ".env*"
---

# Lane DEVOPS — nạp khi chạm `Makefile`, `deploy/**`, `.env*`

> Cập nhật **2026-08-28**. Ở đây **chỉ** có luật riêng của lane DEVOPS. Luật áp cho mọi lane ở
> `CLAUDE.md` §1–§8; khuôn dòng task và định nghĩa XONG ở `.claude/rules/quan-ly-du-an.md` §1 §3.
> File này không chép lại vế nào của hai file đó — lệch thì hai file đó thắng.
>
> **Đường dẫn ở file này viết trong backtick, tính từ gốc repo,** không viết link markdown — cùng lý do
> đã ghi ở `.claude/rules/lane-ba.md` phần mở đầu (họ hàng của `finding.md` F-11).
>
> **Hai trong ba mẫu `paths:` chưa có file nào hôm nay:** `ls deploy` kêu, `git ls-files` không ra
> `.env` nào. Chúng là **khai chủ quyền trước**, không phải khai đã có nhà — đúng vế 1 của
> `.claude/rules/quan-ly-du-an.md` §6 thì nhà thật của lane này hôm nay là `Makefile`, một file.

## 1. Lane này chốt xong đúng một câu hỏi

**Cổng nào chứng minh phiên vừa rồi không làm hỏng gì, và bản chạy được dựng lại từ đâu.**

Lane này sở hữu **cái cân**, không sở hữu **cái được cân**. Nội dung `task.md`, `finding.md`,
`CLAUDE.md`, `quality/**` là lane NON-CODE; `Makefile` chỉ *đo* chúng. Ranh giới đó là toàn bộ lý do
lane này tách ra: người viết cổng mà được sửa luôn thứ cổng đang soi thì cổng không còn là cổng.

## 2. Ranh giới cứng — và lệnh bắt vi phạm

**(a) Cấm sửa thứ được cân để cổng xanh.** Phiên DEVOPS chỉ được đụng file lane sở hữu:

```bash
git status --short | grep -v -E '^\?\? ' | grep -vE '(Makefile|^ *M deploy/|\.env)' 
```

Ra **rỗng** mới đạt. Mỗi dòng in ra là một file ngoài lane — nếu nó xuất hiện cùng phiên với một đích
vừa chuyển từ đỏ sang xanh thì cổng vừa bị mua chuộc, không phải vừa được vá.

**(b) Không đích nào gọi thứ chưa cài.** `CLAUDE.md` §7 xếp `go test` và `npm run build` vào loại
chưa chạy được ở giai đoạn này:

```bash
grep -nE '^	.*(go |npm |yarn )' Makefile
```

Ra **rỗng** mới đạt. Một đích đỏ ngay lần chạy đầu làm cả `Makefile` mất tin cậy, và ba lane DB/BE/FE
mất nền biên nhận — nguyên văn ô `Bẫy` của `T-03` trong `task.md`.

**(c) Bí mật không vào git.**

```bash
git ls-files | grep -E '(^|/)\.env($|\.)' | grep -v '\.example$'
```

Ra **rỗng** mới đạt. `.env*` sống trên máy; thứ đi vào git là `deploy/.env.example` với giá trị giả.

## 3. Mỗi đích khai "đỏ khi" — lệnh đọc chính `Makefile`

Nhà của luật biên nhận âm là `quality/00-guideline-chat-luong.md` §5 — trỏ, không chép. Lane này chỉ
thêm lệnh áp nó xuống từng đích:

```bash
for t in $(sed -n 's/^\.PHONY: *//p' Makefile); do \
  sed -n "/^## $t — /,/^$t:/p" Makefile | grep -q 'Đỏ khi' || echo "ĐÍCH RỖNG RUỘT: $t"; done
```

**Đỏ khi:** một đích trong `.PHONY` không có vế `Đỏ khi` trong khối chú thích của nó. Đã thử làm đỏ
2026-08-25: xoá dòng `## Đỏ khi:` của `check-lane` ⇒ in `ĐÍCH RỖNG RUỘT: check-lane`; khôi phục ⇒ rỗng.

## 4. Biên nhận của lane

`make check` — **5 đích**, mã thoát `0` (đích gộp `check` gọi 5 đích con). Đây là biên nhận **thật**, không phải lời hứa: nó chạy được từ
commit `9699f1c`. Hai file luật khai cùng chuyện này là `CLAUDE.md` §7 và
`.claude/rules/quan-ly-du-an.md` mục 3 — đọc thẳng ở đó, file này không chép lại lời khai của chúng.
Lịch sử của chỗ này là [finding.md F-23](../../finding.md#f-23) — **trạng thái của nó đọc ở hàng `F-23`
trong [finding.md](../../finding.md)**, file này không chép lại và không ghim số dòng của file nào
([.claude/rules/quan-ly-du-an.md §5.3](quan-ly-du-an.md)). Muốn biết ô `Đầu ra` của `T-03` còn ⚠️ kề
`make check` không thì dò `grep -n 'make check' task.md`; thấy còn cũng **đừng sửa kèm ở đây** —
`task.md` là lane NON-CODE. Lý do luật này tồn tại: [finding.md F-53](../../finding.md#f-53).

**Đừng giả định cổng đang xanh — và cũng đừng giả định nó đang đỏ.** `make check` có thể đỏ sẵn vì một
lỗi thuộc lane khác: nội dung hai sổ là lane NON-CODE, **không** thuộc lane này. File này cố ý **không
khai trạng thái tức thời của cổng** — trạng thái đọc bằng chính lệnh, không đọc ở một file luật.
Nó chỉ khai ba bước xử trí, ba bước này đúng ở mọi ngày:

1. Chạy `make check` **trước** khi gõ ký tự đầu tiên, giữ output làm vạch nền.
2. Chạy lại sau khi gõ, và chỉ đọc **phần khác** giữa hai lần.
3. Dòng đỏ có sẵn thì để nguyên và trỏ mã finding của nó — dò mã bằng
   `grep -n '<chuỗi trong dòng đỏ>' finding.md`, chưa có mã thì mở một mã; đừng chép dòng đỏ sang đây.
   Vá một đích cho nó im là vi phạm §2 (a):
   cổng đỏ thường trực là cổng phiên sau học cách bỏ qua, còn cổng bị bịt miệng thì không ai học được nữa.

## 5. Ba thứ không bao giờ thoả hiệp — trỏ, không chép

Hai trong ba thuộc lane này: *backup trước mọi migration và backup phải restore được* · *không deploy
trong giờ bán*. **Nhà của chúng là `project_preparation/prompt-fullstack.md` §6.9** — đọc thẳng ở đó
trước mỗi phiên chạm `deploy/**`.

Rule này **cố ý không chép** nguyên văn ba luật đó, và ô `Đạt khi` của bảng `owner-T-06` trong
`task.md` đòi đúng như vậy. Chép sang đây là đẻ nhà thứ hai; và ca sống của việc *khai sai nhà* của
đúng ba luật này đã có mã: `finding.md` F-26.

## 6. Cái gì KHÔNG thuộc lane DEVOPS

Nội dung sổ task và sổ lỗi → NON-CODE · luồng nghiệp vụ → BA · migration `.sql` → DB · endpoint và hàm
tính giá → BE · route và component → FE.

Việc **thuộc quyền người dùng**, lane này chuẩn bị sẵn rồi dừng (`CLAUDE.md` §7): tạo remote hay
`git push` · mua VPS, tên miền, dịch vụ backup · bất cứ thứ gì tốn tiền thật. Viết sẵn file cấu hình
là việc của lane; bấm nút tiêu tiền thì không.
