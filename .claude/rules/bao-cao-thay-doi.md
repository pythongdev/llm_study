---
paths:
  - "**"
  - "*"
---

# Báo cáo thay đổi — nạp ở **mọi** phiên chạm bất kỳ file nào

> Cập nhật **2026-08-22**. Luật này trả lời đúng một câu hỏi của owner: *phiên vừa rồi đổi **file nào**,
> và trong file đó đổi **chỗ nào**?* [CLAUDE.md §4](../../CLAUDE.md) chỉ đòi biên nhận + commit — cả hai
> chứng minh **kết quả đúng**, không cái nào bày ra **đường đi**. File này giữ phần còn thiếu đó.
>
> `paths:` của rule này cố tình là `**`: nó không phải luật của một lane, nó là điều kiện để một phiên
> được coi là đã báo cáo xong. Phiên không dán bảng ở §1 thì **chưa xong**, dù biên nhận đã xanh.

---

## 1. Bảng thay đổi — dán trước khi commit, không phải sau

Mọi phiên có sửa dù một ký tự đều kết bằng bảng này. Không có ngoại lệ cho "sửa nhỏ", "chỉ đổi một dòng",
"chỉ sửa chính tả" — owner chặn được hay không phụ thuộc vào việc thấy đủ, không phụ thuộc kích cỡ diff.

```markdown
### Thay đổi phiên này

| # | File | Sửa ở đâu | Sửa gì | Xem diff |
|---|---|---|---|---|
| 1 | [task.md](task.md) | §Sổ task › dòng `T-05` | thoát dấu `\|` trong ô biên nhận | `git diff -- task.md` |
| 2 | `quality/05-checklist.md` **(mới)** | cả file | 9 mục `- [ ]` của định nghĩa XONG | `git show --stat HEAD -- quality/` |
```

Năm cột, đặc tả từng cột — thiếu cột nào thì bảng đó không tính:

| Cột | Viết cái gì | Sai điển hình |
|---|---|---|
| `File` | **file đã tồn tại ⇒ link markdown** — `[tên]` rồi `(đường/dẫn)`, đường dẫn tương đối từ gốc repo · **file phiên này mới tạo ⇒ backtick + `(mới)`**, không link | link tới file chưa có — nó lọt vòng lặp con trỏ §5.1 của [quan-ly-du-an.md](quan-ly-du-an.md) thành `TRỎ HỤT` |
| `Sửa ở đâu` | xuống tới **mục / dòng / hàm**: `§1.1 bảng đặc tả ô`, `dòng T-05`, `frontmatter paths:`, `func CalcTotal` | dừng ở tên file — đó là cột bên trái, không phải câu trả lời |
| `Sửa gì` | **một câu**, động từ + tân ngữ, nói *đổi cái gì* chứ không *vì sao* | "cập nhật", "chỉnh sửa", "refactor" — ba chữ này không mang thông tin nào |
| `Xem diff` | **một lệnh chạy được**, giới hạn `-- <path>` để chỉ hiện file của dòng đó | `git diff` trần — bắt owner tự lọc giữa mọi file |
| `#` | một file một dòng, đánh số | gộp "và vài file khác", "cùng một số file liên quan" |

**Ba câu bị cấm trong phần kết phiên**, thấy là viết lại: *"đã cập nhật các file liên quan"* ·
*"chi tiết xem `git diff`"* · tên file viết trần không link và không chỉ ra chỗ sửa.

---

## 2. Ô `Owner kiểm tra` của một dòng task phải có phần `Sửa ở đâu:`

Bảng §1 là báo cáo **sau khi làm**. Ô `Owner kiểm tra` trong [task.md](../../task.md) là lời khai
**trước khi làm**: dòng task hứa sẽ đụng đúng những chỗ nào. Owner đối chiếu hai cái đó — lệch ra một
file không có trong lời khai là dấu phiên đã lấn phạm vi, và đó là finding, không phải chuyện nhỏ.

Ô này gồm **bốn** phần, theo đúng thứ tự, ngăn bằng ` · `:

```
👤 · git show --stat HEAD -- <path> — <nhìn gì thì gọi là đạt> · **Sửa ở đâu:** <link tới file> §<mục> › <dòng> · `file-moi.md` (mới)
```

1. **Dấu ai ký** `👤` / `🤖` — luật chọn dấu ở [quan-ly-du-an.md](quan-ly-du-an.md) §1.2b.
2. **Một lệnh in ra thay đổi** — `git show`, `git diff --stat`, luôn có `-- <path lane sở hữu>`.
3. Sau dấu `—`: **nhìn gì thì gọi là đạt**.
4. **`**Sửa ở đâu:**` + danh sách chỗ sửa**, cùng quy ước link/backtick như cột `File` ở §1.

Phần 4 không bao giờ rỗng. Task chưa biết sẽ chạm chỗ nào ⇒ task đó chưa đủ chín để làm, chẻ nhỏ trước
([CLAUDE.md §6](../../CLAUDE.md)).

---

## 3. Lệnh tự rà — chạy từ gốc repo

```bash
# a. Mọi file git thấy đã đổi đều phải có mặt trong bảng thay đổi vừa dán
git status --short | awk '{print $NF}'

# b. Mọi dòng task đều có phần "Sửa ở đâu" — in ra mã của dòng nào thiếu
grep '^| \*\*T-' task.md | grep -v 'Sửa ở đâu' | grep -o '\*\*T-[0-9]*\*\*'

# c. Đếm cho khớp: hai số phải bằng nhau (chỉ đếm dòng bảng, không đếm phần văn xuôi)
grep -c '^. ~*\*\*T-' task.md; grep '^. ~*\*\*T-' task.md | grep -c 'Sửa ở đâu'
```

**d.** Mọi link trong `task.md` phải giải được: chạy **vòng lặp con trỏ** ở
[quan-ly-du-an.md](quan-ly-du-an.md) §5.1 trên `task.md` — file này **không chép lại** lệnh đó.
Ra `TRỎ HỤT` nghĩa là có chỗ sửa được viết thành link trong khi file chưa tồn tại: đổi thành
backtick + `(mới)`, đừng tạo file rỗng cho con trỏ giải được.

Lệnh (a) chạy **trước** khi commit và đối chiếu bằng mắt với bảng: git là nhà thật của *file nào đã đổi*,
bảng chỉ là bản khai. Lệch ⇒ sửa bảng, không sửa git.

---

## 4. Vì sao luật này tồn tại

`git diff` đã có sẵn mọi thứ — nhưng nó trả lời *cái gì đã đổi ở mức ký tự*, còn owner cần *chỗ nào trong
kiến trúc đã đổi*. Hai câu hỏi khác nhau: một diff 6 dòng có thể là sửa chính tả, cũng có thể là đổi một
luật ở `CLAUDE.md` §2 mà mọi phiên sau đều phải theo. Chỉ phiên vừa làm mới biết đó là cái nào, và nó biết
điều đó **đúng một lần** — sau khi phiên đóng, thông tin ấy chỉ còn suy lại được bằng cách đọc lại cả file.

Bảng §1 là chỗ duy nhất kiến thức đó được ghi trước khi mất. Link trong bảng là để owner bấm thẳng vào
chỗ sửa thay vì đi tìm — bỏ link đi thì bảng thành lời khai, và lời khai thì [CLAUDE.md §4](../../CLAUDE.md)
đã nói rõ là không được tính.
