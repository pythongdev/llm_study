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
| `Xem diff` | **một lệnh chạy được và thực sự IN RA**, giới hạn `-- <path>`. Chưa commit ⇒ `git diff -- <path>`; **đã commit** (kể cả bị phiên khác commit hộ) ⇒ `git show <sha> -- <path>`. Chạy thử trước khi dán: ra rỗng thì lệnh sai, không phải thay đổi mất | `git diff` trần — bắt owner tự lọc giữa mọi file · `git diff -- <path>` cho thay đổi **đã commit**: nó im lặng, và im lặng trông y hệt *không đổi gì* |
| `#` | một file một dòng, đánh số | gộp "và vài file khác", "cùng một số file liên quan" |

**Ba câu bị cấm trong phần kết phiên**, thấy là viết lại: *"đã cập nhật các file liên quan"* ·
*"chi tiết xem `git diff`"* · tên file viết trần không link và không chỉ ra chỗ sửa.

---

## 2. Bảng soi của owner — một task một bảng, ba cột

Bảng §1 là báo cáo **sau khi làm**. Bảng soi trong [task.md](../../task.md) §Owner kiểm tra là lời khai
**trước khi làm**: task hứa sẽ đụng đúng những chỗ nào. Owner đối chiếu hai cái đó — lệch ra một file
không có trong lời khai là dấu phiên đã lấn phạm vi, và đó là finding, không phải chuyện nhỏ.

**Không nhét bảng vào một ô bảng.** Markdown không cho lồng bảng trong ô, nên ô `Owner kiểm tra` ở §Sổ task
chỉ giữ **dấu ai ký + link**, còn bảng nằm ở mục riêng cuối `task.md`:

```markdown
| ... | 👤 *(lý do ký)* · [bảng soi ↓](#owner-t-02) | ... |     <- ô trong §Sổ task

### owner-T-02                                                  <- neo: tiêu đề đặt đúng dạng này
                                                                   thì link #owner-t-02 tự giải
**Mở lane BA** · ai ký: 👤 *(mở lane đầu tiên, đặt tiền lệ cho T-06→T-09)*

| Thay đổi cái gì | Câu lệnh để thấy thay đổi | Ở đâu |
|---|---|---|
| Nhà của lane BA + file yêu cầu pha 0 | `git show --stat HEAD -- design/BA` | `design/BA/04-yeu-cau.md` **(mới)** › cả file |
| Dòng BA hết ⚠️ | `git show HEAD -- CLAUDE.md` | [CLAUDE.md](../../CLAUDE.md) §1 bảng lane › **đúng một dòng BA** |

**Đạt khi:** `CLAUDE.md` chỉ đổi **đúng một dòng**; mọi thứ khác nằm trong `design/BA/`.
```

Ba cột, **đúng thứ tự này** — nó là thứ tự owner đọc, không phải thứ tự tiện viết:

| Cột | Viết cái gì | Sai điển hình |
|---|---|---|
| `Thay đổi cái gì` | **một câu**, nói *cái gì trong dự án đổi*, không phải *thao tác gì trên file* | "sửa file", "cập nhật rule" — owner đã biết là có sửa, câu hỏi là **đổi cái gì** |
| `Câu lệnh để thấy thay đổi` | **một lệnh chạy được**, in ra **thay đổi** (`git show`, `git diff`), giới hạn `-- <path>` của **đúng dòng đó** | một lệnh chung cho cả bảng — owner lại phải tự lọc |
| `Ở đâu` | file (link nếu đã có, backtick + `(mới)` nếu task sẽ tạo) **rồi** `›` **rồi** §/mục/dòng/hàm | dừng ở tên file — đó là nửa câu trả lời |

Dưới bảng, **một dòng `**Đạt khi:**`**: cái owner nhìn để nói *nhận* hay *trả lại*. Đây là chỗ ghi ranh
giới đếm được — "đúng 4 file", "chỉ 2 hunk", "đúng một dòng" — chứ không phải lời khen chung chung.

Bảng soi không bao giờ rỗng. Task chưa biết sẽ chạm chỗ nào ⇒ chưa đủ chín để làm, chẻ nhỏ trước
([CLAUDE.md §6](../../CLAUDE.md)).

---

## 3. Lệnh tự rà — chạy từ gốc repo

```bash
# a. Mọi file git thấy đã đổi đều phải có mặt trong bảng thay đổi vừa dán
git status --short | awk '{print $NF}'

# b. Mỗi dòng task có một bảng soi, và ngược lại — hai vòng lặp, cả hai phải im
for t in $(grep -o '^| ~*\*\*T-[0-9]*' task.md | grep -o 'T-[0-9]*'); do \
  grep -q "^### owner-$t\$" task.md || echo "THIẾU BẢNG SOI: $t"; done
for o in $(grep -o '^### owner-T-[0-9]*' task.md | grep -o 'T-[0-9]*'); do \
  grep -q "^| ~*\*\*$o\*\*" task.md || echo "BẢNG SOI MỒ CÔI: $o"; done

# c. Mỗi bảng soi có dòng "Đạt khi:" — ba số phải bằng nhau
grep -c '^### owner-T-' task.md; grep -c '^\*\*Đạt khi:\*\*' task.md; grep -c '^| ~*\*\*T-' task.md

# e. Mọi lệnh ở cột "Xem diff" phải IN RA: chạy từng lệnh, cái nào rỗng là lệnh sai
#    Thường gặp: thay đổi đã vào commit (phiên khác commit hộ) mà cột vẫn ghi `git diff`
#    -> tra sha rồi đổi sang `git show <sha> -- <path>`:
git log --oneline -3 -- <path>
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
