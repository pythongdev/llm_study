---
paths:
  - "CLAUDE.md"
  - ".claude/rules/**"
  - "task.md"
  - "finding.md"
  - "project_preparation/**"
  - "design/**"
  - "quality/**"
---

# Sổ tay quản lý dự án — nạp khi chạm sổ task, sổ lỗi, hoặc tài liệu thiết kế

> Cập nhật **2026-08-26**. File này giữ phần **dài** mà [CLAUDE.md](../../CLAUDE.md) không chứa nổi.
> Luật áp cho **mọi** session nằm ở `CLAUDE.md` §1–§8 — file này **trỏ** tới chúng, không chép lại.
> Chép lại là đẻ nhà thứ hai, và bản chép sẽ lệch trong im lặng.

---

## 1. Khuôn một dòng task — 11 cột

```
| # | Lane | Task | Context | Cần xong trước | Finding phải đóng | Đầu ra kiểm chứng được | Owner kiểm tra | Chất lượng | Hỏng thì mất gì | Prompt mở session |
```

Khuôn này mở rộng từ 7 cột của `prompt-fullstack.md` §5.3: `Ưu tiên` và `Trạng thái` gộp vào ô `#`,
`Context` gộp ba mẩu, và cột `Hỏng thì mất gì` được **giữ lại** (quyết định G2 ở
`huong-dan-viet-task-md.md` Phần X) vì đó là căn cứ duy nhất để xếp ưu tiên.
Cột `Owner kiểm tra` thêm ngày **2026-08-22** theo yêu cầu của owner: cột `Đầu ra kiểm chứng được` chứng
minh **hiện trạng đúng**, nó không cho owner thấy **cái gì vừa đổi**. Cột `Chất lượng` thêm ngày
**2026-08-23** (T-24) vì cả hai cột trên đều không trả lời câu *đầu ra có dùng được cho phiên sau không*
— câu đó ở [quality/00-guideline-chat-luong.md](../../quality/00-guideline-chat-luong.md) §1.
Hai cột mới đứng liền sau ô biên nhận nên lệnh tự rà §5.2 đếm ô **từ phải sang** (`$(NF-5)` = biên nhận,
`$(NF-4)` = `Owner kiểm tra`, `$(NF-3)` = `Chất lượng`), không đếm từ trái: một ô có `|` bên trong (ví dụ
`grep -c '^\| '`) làm lệch mọi chỉ số đếm xuôi. Lệnh nào rà được bằng **regex trên cả dòng** thì dùng
regex — nó miễn nhiễm với ô chứa `|` chưa thoát, thứ đang có thật ở vài dòng (`T-05`, `T-11`, `T-21`).

### 1.1 Đặc tả từng ô

| Ô | Viết cái gì | Sai điển hình | Vì sao ô này tồn tại |
|---|---|---|---|
| `#` | `**T-xx**` · xong thì bọc `~~**T-xx**~~` · 🔺 nếu chặn task khác · `⚑n` nếu ngoài đường găng | đánh số lại khi chèn task | Mã là khoá tra; đánh số lại làm mọi con trỏ `T-xx` ở commit cũ trỏ hụt |
| `Lane` | đúng một lane ở `CLAUDE.md` §1 | `BA ⚠️+BE` để nguyên rồi làm | Lane quyết định gói nạp và biên nhận; hai lane trên một dòng là dấu vượt kích cỡ, **chẻ trước khi làm** |
| `Task` | động từ + tân ngữ cụ thể + file sẽ sửa | "Làm chức năng đặt món" | Không có tân ngữ thì phiên tự chọn phạm vi, và nó chọn rất tự tin |
| `Context › Nạp` | file + **đúng mục** phải đọc trước khi sửa dòng đầu | trỏ trọn một file 500 dòng | Nạp trọn file là cách nhanh nhất tiêu hết context trước khi làm được gì |
| `Context › Đã chốt` | quyết định đã có nhà — **trỏ**, không chép | chép lại con số | Chép = nhà thứ hai |
| `Context › Bẫy` | chỗ đã cắn hoặc chắc chắn sẽ cắn, kèm cách xử | bỏ trống | Đây là ô cấp phép cho phiên **phản bác đề bài** thay vì sửa cho khớp |
| `Cần xong trước` | mã task hoặc `—` | "sau khi xong phần backend" | Phụ thuộc dữ liệu quyết định thứ tự, không phải sở thích |
| `Finding phải đóng` | **chỉ mã** `[F-xx](finding.md#f-xx)` | mô tả lại nội dung finding | Mô tả lại = nhà thứ hai; mã là con trỏ giải được bằng `grep` |
| `Đầu ra kiểm chứng được` | **một lệnh + kết quả kỳ vọng**; kỳ vọng của thứ **còn được sửa tiếp** viết bằng **ngưỡng** (`<= 120`), không bằng hằng số (`ra 92`) | "code chạy được", "xong khi ổn" · hằng số tuyệt đối — task ✅ rồi thì không ai chạy lại, và nó hết đúng trong im lặng | "Đã làm" không phải trạng thái, nó là output của một lệnh |
| `Owner kiểm tra` | **chỉ hai** thứ: `👤`/`🤖` (+ lý do ký trong ngoặc *nghiêng*) · link `[bảng soi ↓](#owner-t-xx)`. Chi tiết nằm ở **bảng soi ba cột** trong §Owner kiểm tra của `task.md` — *thay đổi cái gì · câu lệnh để thấy thay đổi · ở đâu* — khuôn ở [bao-cao-thay-doi.md](bao-cao-thay-doi.md) §2 | `👤 · đọc lại file` — không phải lệnh, và "file" không phải "thay đổi" · liệt kê tên file mà không nói **chỗ nào trong file** | Biên nhận chứng minh **hiện trạng đúng**; ô này cho owner thấy **cái gì vừa đổi** — hai câu hỏi khác nhau, một diff sạch vẫn có thể kèm ba file không ai xin phép |
| `Chất lượng` | **chỉ ba** thứ: dấu `⬜` chưa đo / `✅` đạt sàn / `❌` trả lại (kèm mã finding) · **tầng sàn** `T0–T3` · link `[soi ↓](#cl-t-xx)`. Mệnh đề, lệnh soi và vế `đỏ khi` nằm ở bảng bốn cột `### cl-T-xx` trong `task.md`. Chọn tầng sàn theo [guideline §3](../../quality/00-guideline-chat-luong.md) — **không** chép thang tầng vào đây | nhét lệnh vào ô, hoặc chép lại năm trục đo | Ô biên nhận đo *hiện trạng đúng*, ô này đo *phiên sau dùng được*. Thiếu nó thì task **XONG mà không TỐT** trông y hệt task tốt: `test -e` xanh, `grep -c` xanh, nội dung là rác |
| `Hỏng thì mất gì` | hậu quả **ở quán**, bằng tiếng thường | "lỗi đơn hàng" | Viết bằng thuật ngữ ⇒ mọi task trông quan trọng như nhau ⇒ ưu tiên thành cảm tính |
| `Prompt mở session` | lane · mã · lệnh mở dòng · `chỉ chạm <path>` · **câu DỪNG** | bỏ câu DỪNG | Không có câu DỪNG thì phiên gánh luôn task kế, diff phình, không ai rà nổi |

**Dấu `|` bên trong một ô phải viết `\|`.** Không escape thì ô bị cắt làm đôi khi render, và mọi lệnh
tự rà đếm ô từ trái đọc nhầm cột (gốc [F-04](../../finding.md#f-04)).

### 1.2 Bốn trường không bao giờ được bỏ

`Lane` · `Task` · `Đầu ra kiểm chứng được` · `Hỏng thì mất gì`. Task giấy tờ bỏ được `Bẫy`,
`Cần xong trước`, `Prompt`; task trên đường găng và task DEVOPS đụng tiền thật phải có **đủ** 10 ô.

`Owner kiểm tra` và `Chất lượng` không bao giờ **rỗng**, và **hai bảng soi** của mã đó (`### owner-T-xx`,
`### cl-T-xx`) luôn có mặt: bỏ được dòng lý do ký, không bỏ được dấu ai ký, tầng sàn, link, một hàng bảng
soi nào, dòng `**Đạt khi:**`, hay dòng `**Đã thử làm đỏ:**` (guideline §5 đòi, không nhà nào khác giữ). Chưa nói được sẽ chạm chỗ
nào ⇒ task chưa đủ chín để làm, chẻ trước ([CLAUDE.md §6](../../CLAUDE.md)).

### 1.2b Ai ký: `👤` hay `🤖`

`👤` **owner phải nhìn tận mắt trước khi phiên sau đi tiếp**, đúng bốn trường hợp: đụng thứ thuộc quyền
owner ([CLAUDE.md §7](../../CLAUDE.md): phạm vi, giá món, tiền thật, remote/push) · sửa **luật** ở
`CLAUDE.md` §2–§8 hoặc rule có `paths:` rộng · dựng thứ mà lane khác lấy làm biên nhận (`Makefile`) ·
**task đầu tiên của một loại**, vì nó đặt tiền lệ cho mọi task cùng loại sau đó.

`🤖` cho phần còn lại — kể cả việc đổi **đúng một dòng** bảng `CLAUDE.md` §1 theo quy trình §6, vốn là
việc cơ khí. `🤖` **không** có nghĩa là owner không được xem: lệnh vẫn phải ghi ra, và vẫn phải chạy được.

Đánh `👤` cho mọi dòng là hỏng cơ chế: cột này là **bộ lọc sự chú ý** của owner, mọi dòng `👤` thì nó
lọc đúng bằng không.

### 1.3 Kích cỡ

Bốn vế và dấu hiệu phải chẻ nằm ở [CLAUDE.md §6](../../CLAUDE.md). Kiểm bằng mắt trước khi thêm dòng:
đọc ô `Task`, nếu phải nói chữ "và" mới tả hết thì đó là hai dòng.

---

## 2. Hai sổ — task và lỗi khác nhau chỗ nào

| | **Task** (`task.md`) | **Finding** (`finding.md`) |
|---|---|---|
| Đo cái gì | **xong / chưa** | **đúng / sai** |
| Bản chất | việc **chưa tới lượt xây** | cái **đang sai ngay bây giờ** |
| Câu mở đầu điển hình | "chưa có X", "cần thêm X" | "X và Y nói hai điều khác nhau", "tài liệu khác hiện trạng" |
| Đóng bằng | biên nhận của lane: lệnh chạy thật + output | mệnh đề sai **hết đúng** + lệnh chứng minh |
| Bắt buộc để lại | commit + dấu ✅ | một dòng `**Bài học giữ lại:**` |
| Quan hệ | một finding đẻ ra **nhiều** task được | task **không bao giờ** nằm trong sổ lỗi |

Phép thử một câu và luật không-trộn-sổ ở [CLAUDE.md §5](../../CLAUDE.md).

**Vì sao trộn là hỏng cả hai cơ chế.** Finding nằm trong sổ task sẽ bị đánh ✅ khi hết giờ — sổ task
đo *xong/chưa*, mà "hết giờ" trông rất giống "xong". Task nằm trong sổ lỗi sẽ không bao giờ đóng được
— sổ lỗi đòi một mệnh đề sai hết đúng, mà "chưa có X" thì không có mệnh đề nào sai.

**Rút không ra bài học ⇒ chưa được đóng finding.** Không rút ra được luật nào đổi nghĩa là chưa hiểu
nguyên nhân, và cái chưa hiểu thì sẽ quay lại.

---

## 3. Định nghĩa XONG — giai đoạn KHÔNG CÓ COMPILER

Repo đã có `Makefile`: `make check` chạy thật, là biên nhận thật ([CLAUDE.md §7](../../CLAUDE.md)).
Chưa có test runner (Go, npm). Nên ngoài `make check`, **biên nhận là lệnh đọc lại**.
Một task giai đoạn này gọi là XONG khi đủ **bốn** vế, thiếu một vế thì vẫn là đang làm:

1. **Đầu ra tồn tại thật.** `test -e <đường dẫn>` không kêu. Trỏ tới file chưa có mà không đánh ⚠️
   là bịa ra một lãnh thổ, và phiên sau sẽ đi theo tấm bản đồ đó.
2. **Nội dung đúng hình dạng, đo bằng lệnh.** Ví dụ hợp lệ: `grep -c '^| ' task.md` ra số dòng mong đợi ·
   `wc -l < CLAUDE.md` ra ≤ 140 · `sed -n '/T-03/p' task.md` in ra đúng một dòng ·
   `awk 'length > 400' CLAUDE.md` rỗng · `head -6 .claude/rules/quan-ly-du-an.md` in ra frontmatter.
3. **Mọi con trỏ trong đầu ra giải được.** Chạy vòng lặp §5.1 dưới đây, output rỗng, hoặc mỗi dòng in
   ra đều có ⚠️ + mã task **ngay tại chỗ trỏ**.
4. **Đủ mọi vế của [`CLAUDE.md` §4](../../CLAUDE.md)** — biên nhận + output · commit · `finding.md`
   đổi trạng thái · bảng thay đổi · phiếu sáu dòng N1–N6. **Số đếm nằm ở §4, mục này cấm chép lại nó**:
   chép là đẻ nhà thứ hai và nhà con sẽ trôi lại đúng như `F-44`. Đếm bằng `CLAUDE.md` §4, không đếm ở đây.

**Cái gì KHÔNG được tính là biên nhận ở giai đoạn này:** `go test` ⚠️ · `npm run ...` ⚠️ · "đã đọc lại
thấy ổn" · "đã hoàn thành đầy đủ yêu cầu". Hai cái đầu chưa chạy được, hai cái sau không phải output
của lệnh nào. `make check` **không** nằm trong danh sách này — đánh ⚠️ cho nó là khai sai theo chiều
bi quan: cổng đã dựng xong thành cổng không ai đi qua. Lệnh 3 của §5.3 dưới đây bắt chiều đó.

**`Makefile` đã có (T-03),** nên `make check` hết ⚠️; `go test` và `npm run ...` giữ ⚠️ cho tới khi lane
BE và FE mở. Định nghĩa XONG đầy đủ chuyển nhà sang
[quality/05-checklist.md](../../quality/05-checklist.md) (T-04 tạo). Từ lúc đó mục 3 này chỉ còn
áp cho lane NON-CODE và BA.

---

## 4. Nhịp kiểm tra

| Khi nào | Chạy cái gì | Ra kết quả khác kỳ vọng thì |
|---|---|---|
| Mỗi phiên **sinh nội dung mới** — sau khi gõ, **trước** biên nhận | sáu probe N1–N6 ở [quality/01-chat-luong-noi-dung.md](../../quality/01-chat-luong-noi-dung.md) §3 §4, rồi dán **phiếu sáu dòng** theo §5 bước 3 của file đó | một trục KHÔNG ĐẠT ⇒ đầu ra bị **trả lại** (§6 file đó), không có nợ; sửa không xong trong phiên ⇒ nhãn tại chỗ **và** một dòng [finding.md](../../finding.md) |
| Mỗi task, trước khi đánh ✅ | biên nhận trong ô `Đầu ra kiểm chứng được` | quay lại làm, chưa được đánh ✅ |
| Mỗi lần sửa `task.md` | **cả khối** lệnh tự rà ở §5.2 — đếm số lệnh trong câu này là hằng số, nó tự trôi | lỗi của `task.md`, sửa ngay trong phiên đó |
| Owner soi lại một task vừa ✅ | từng lệnh ở **bảng soi** `### owner-T-xx` trong `task.md`, rồi đọc dòng `**Đạt khi:**` | thay đổi khác cái bảng đó khai ⇒ ghi finding, đừng sửa lặng lẽ |
| Owner soi **chất lượng** một task vừa ✅ | từng lệnh ở bảng `### cl-T-xx`, rồi dòng `**ĐẠT khi:**` và `**Đã thử làm đỏ:**` | chưa đạt tầng sàn ⇒ ô `Chất lượng` để `❌` + mở finding, **không** đổi dấu thành ✅ cho xong |
| Mỗi lần sửa `CLAUDE.md` | `wc -l` ≤ 120 · `awk 'length > 400'` rỗng · vòng lặp con trỏ §5.1 | gộp hoặc thay luật cũ, không nới trần |
| Cuối mỗi phiên **có sửa file** | dán bảng thay đổi 5 cột — khuôn [bao-cao-thay-doi.md](bao-cao-thay-doi.md) §1 | thiếu bảng ⇒ phiên **chưa xong**, dù biên nhận đã xanh |
| Cuối mỗi phiên | ba lệnh dò phiên trôi §5.3 | ghi finding hoặc mở task, đừng sửa lặng lẽ |
| Mỗi lần mở một lane | quy trình §6 **và lệnh §5.2b** | thiếu vế nào thì lane đó chưa được coi là mở |
| Mỗi lần viết ô `Nạp` mới | §5.2c — `grep` từng con trỏ cấp `§` trong chính file đích | ra `0` ⇒ con trỏ bịa, sửa ngay, đừng để phiên sau đi tìm |

---

## 5. Lệnh — chạy từ gốc repo

### 5.1 Mọi con trỏ trong một file có giải được không

`grep -v '^$'` bỏ qua link **neo trong cùng file** (`](#owner-t-02)`) — chúng không có đường dẫn
để `test -e`, và không lọc thì mọi neo đều báo `TRỎ HỤT` rỗng.

```bash
grep -o '](\([^)#]*\)' <file> | sed 's/](//' | grep -v '^http' | grep -v '^$' | sort -u \
  | while read f; do [ -e "$f" ] || echo "TRỎ HỤT: $f"; done
```

### 5.2 Tự rà `task.md` trước khi commit

```bash
grep '^| \*\*T-' task.md | awk -F'|' 'length($(NF-5)) < 12 {print $2}'  # thiếu biên nhận ⇒ là ý kiến
grep '^| \*\*T-' task.md | grep '⚠️+'                                   # chạm 2 lane ⇒ chẻ trước khi làm
grep '^| \*\*T-' task.md | awk -F'|' '$(NF-4) !~ /👤|🤖/ {print $2}'    # thiếu ô Owner kiểm tra
grep '^| ~*\*\*T-' task.md | grep -v '\[soi ↓\](#cl-t-'                    # thiếu ô Chất lượng (regex: miễn nhiễm ô chứa |)
grep '^| ~*\*\*T-' task.md | grep -o 'T[0-3] · \[soi' | sort | uniq -c      # phổ tầng sàn: mọi dòng cùng một tầng ⇒ cột hết lọc
for t in $(grep -o '^| ~*\*\*T-[0-9]*' task.md | grep -o 'T-[0-9]*'); do \
  grep -q "^### cl-$t\$" task.md || echo "THIẾU BẢNG SOI CL: $t"; done          # task không có bảng soi chất lượng
for c in $(grep -o '^### cl-T-[0-9]*' task.md | grep -o 'T-[0-9]*'); do \
  grep -q "^| ~*\*\*$c\*\*" task.md || echo "BẢNG SOI CL MỒ CÔI: $c"; done   # bảng soi chất lượng không còn task
for t in $(grep -o '^| ~*\*\*T-[0-9]*' task.md | grep -o 'T-[0-9]*'); do \
  grep -q "^### owner-$t\$" task.md || echo "THIẾU BẢNG SOI: $t"; done      # task không có bảng soi
for o in $(grep -o '^### owner-T-[0-9]*' task.md | grep -o 'T-[0-9]*'); do \
  grep -q "^| ~*\*\*$o\*\*" task.md || echo "BẢNG SOI MỒ CÔI: $o"; done    # bảng soi không còn task
grep -o '\*\*T-[0-9]*\*\*' task.md | sort | uniq -d                  # mã task trùng
grep -n '^| \*\*T-[0-9]*\*\*[^|]*✅' task.md                        # đánh ✅ mà quên gạch ⇒ lệnh dò trả lại task đã xong
grep '^| ~~\*\*T-' task.md | awk -F'|' 'NF==13 {t=substr($2,index($2,"T-"),4); \
  n=split($6,d,/[ ,]+/); for(i=1;i<=n;i++) if (d[i]~/^T-[0-9]+$/) print t, d[i]}' \
  | while read t dep; do grep -q "^| ~~\*\*$dep\*\*" task.md \
    || echo "XONG TRƯỚC PHỤ THUỘC: $t đánh xong nhưng $dep chưa"; done   # làm sai thứ tự
for f in $(grep -oE 'F-[0-9]{2}' finding.md | sort -u); do \
  grep -q "^| \[$f\].*⚠️" finding.md && continue                     # khai rõ chưa có task (chờ owner) ⇒ bỏ qua
  grep -q "$f" task.md || echo "FINDING BỎ RƠI: $f"; done            # finding không task nào đóng
```

### 5.2b Lane khai đã mở nhưng mở nửa vời

Dòng lane ở `CLAUDE.md` §1 hết ⚠️ chỉ chứng minh vế 4 của §6. Vế 3 (rule riêng) và vế 5 (dòng task đầu
tiên) không có lệnh nào đòi, nên lane mở nửa vời **không đỏ ở đâu cả**:

```bash
for L in ba db be fe devops; do grep -qi "^| \*\*$(echo $L | tr a-z A-Z)\*\*.*⚠️ chưa" CLAUDE.md && continue; \
  test -e ".claude/rules/lane-$L.md" || echo "LANE NỬA VỜI: $L thiếu rule"; \
  grep -qi "^| \*\*T-[0-9]*\*\* *[^|]*| *$(echo $L | tr a-z A-Z) " task.md || echo "LANE NỬA VỜI: $L không dòng task nào"; done
```

### 5.2c Con trỏ cấp `§`/mục có giải được không

§5.1 chỉ `test -e` ở **cấp file**: ô `Nạp` trỏ `<file> §3.3 §7 pha 0` vẫn xanh kể cả khi trong file
không có mục nào tên như vậy. Với mỗi con trỏ cấp mục vừa viết, `grep` nó trong chính file đích trước
khi commit — ví dụ `grep -c 'Pha 0' project_preparation/prompt-fullstack.md` ra `0` nghĩa là con trỏ bịa.

### 5.3 Bốn lệnh dò phiên đang trôi

```bash
git status --short | grep -v -E '^\?\? '   # sửa file ngoài lane: đối chiếu cột "Lane sở hữu" ở CLAUDE.md §1
grep -rn 'go test\|npm run' CLAUDE.md task.md | grep -v '⚠️'   # biên nhận là lời hứa, chưa đánh dấu
grep -rnoE '⚠️ ?`make [a-z][a-z-]*`|`make [a-z][a-z-]*` ?⚠️' CLAUDE.md task.md .claude/rules/*.md \
  | grep -oE 'make [a-z][a-z-]*' | sort -u \
  | while read -r _ d; do make -n "$d" >/dev/null 2>&1 \
      && echo "⚠️ THỪA: đích 'make $d' đã dựng xong, gỡ ⚠️"; done   # ⚠️ kề cổng đã chạy được
git log --oneline -5 | grep -v -E '^[0-9a-f]+ (NON-CODE|BA|DB|BE|FE|DEVOPS)/T-[0-9]+:'  # commit không khai lane + mã task
```

**Lệnh 3 dùng `make -n`, không dùng mã thoát của `make`.** Hai thứ đó khác nhau: `make -n <đích>` ra `0`
nghĩa là **cổng đã dựng** (đích có trong [Makefile](../../Makefile)), còn `make <đích>` ra khác `0` có thể
chỉ nghĩa là **cổng đang bắt được lỗi thật** — hôm nay `make check` đúng là đang đỏ ở `check-so`
([finding.md F-05 ca sống 2026-08-25](../../finding.md#f-05)). Lấy mã thoát của `make` làm bằng chứng thì
mỗi ngày repo có lỗi thật, lệnh 3 lại tự tắt: ⚠️ thừa trôi qua đúng lúc cần bắt nhất.

**Phải khớp thế kề nhau, không phải cùng dòng.** Bản cùng-dòng bắt nhầm đúng những câu **giải thích**
luật ("đánh ⚠️ cho `make check` là khai sai") — đoạn §3 trên và [CLAUDE.md §7](../../CLAUDE.md) đều
dính. Chỉ tính khi ⚠️ **kề** đích, cách nhau nhiều nhất một dấu cách, ở một trong hai thế.

**Đỏ khi** một sổ hay file luật còn ⚠️ **kề** một đích `make` đã có trong [Makefile](../../Makefile).
**Xanh khi** hoặc đích đó chưa dựng (⚠️ đúng), hoặc ⚠️ đã gỡ. Chạy 2026-08-25 lệnh này **đỏ**:
[task.md](../../task.md) dòng 45, ô `Đầu ra` của `T-03`, còn ⚠️ từ thời chưa có `Makefile` —
ca sống ghi ở [finding.md F-23](../../finding.md#f-23).

Lệnh 1 bắt **sửa file ngoài lane**. Lệnh 2 bắt **báo xong mà không có biên nhận chạy được**. Lệnh 3 bắt
chiều ngược lại: **⚠️ bi quan trên cổng đã chạy được**. Lệnh 4 bắt **commit không truy vết được về một
dòng task** — tức việc của pha sau lọt vào phiên này.

---

## 6. Quy trình mở một lane mới — làm đủ năm vế, thiếu vế nào thì lane đó chưa mở

1. **Nhà của lane tồn tại.** Tạo thư mục lane sở hữu, `test -e` không kêu.
2. **Biên nhận chạy được.** Viết ra lệnh, chạy thật, dán output. Chưa chạy được ⇒ lane chưa mở, để ⚠️.
3. **Rule riêng của lane.** `.claude/rules/lane-<tên>.md` có frontmatter `paths:` trỏ đúng thư mục lane
   sở hữu. Rule này giữ luật **chỉ đúng cho lane đó**; luật áp cho mọi lane vẫn ở `CLAUDE.md`.
4. **Sửa đúng một dòng ở `CLAUDE.md` §1.** Thay `⚠️ chưa mở` bằng đường dẫn thật + gói nạp + biên nhận.
   Sửa một dòng, không thêm mục — trần ở `CLAUDE.md` §8.
5. **Dòng task đầu tiên của lane đó có mặt trong `task.md`.** Lane mở mà không có việc nào là lane
   không ai đi vào, và cột `Lane sở hữu file nào` sẽ trôi khỏi hiện trạng mà không lệnh nào đỏ.

Thứ tự mở: lane nào là **nền của biên nhận lane khác** thì mở trước. DEVOPS (`Makefile`) đứng trước
DB / BE / FE vì ba lane đó lấy `Makefile` làm biên nhận.

---

## 7. Bảng ánh xạ 11 thành phần prompt → chỗ giữ

Nguồn: `prompt/huong_dan_prompt/cau-truc-prompt-tot.md` (11 TP) ·
`project_preparation/huong-dan-viet-task-md.md` Phần IV (11 TP → 13 trường).
**Nguyên tắc phân bổ:** thành phần *ổn định qua mọi task* ở `CLAUDE.md`; thành phần *dài và chỉ cần khi
chạm sổ* ở file này; thành phần *đổi theo từng việc* ở một ô của dòng task. Không TP nào được ở cả ba chỗ.

| TP | Thành phần prompt | Nhà giữ nó | Ghi chú |
|---|---|---|---|
| 1 | Vai trò và người đọc | `CLAUDE.md` dòng vai trò + §1 · ô `Lane` của dòng task | §1 quyết định gói nạp; `Lane` chọn ra một hàng của §1 |
| 2 | Bối cảnh và lý do | ô `Hỏng thì mất gì` + `Context › Đã chốt` của dòng task | Lý do viết bằng hậu quả ở quán, đặc tả ở §1.1 file này |
| 3 | Nhiệm vụ (động từ hành động) | ô `Task` của dòng task | Động từ + tân ngữ + file sẽ sửa |
| 4 | Tiêu chí thành công | ô `Đầu ra kiểm chứng được` · §3 file này (định nghĩa XONG) | §3 là mức sàn chung, ô task là mức riêng của việc đó |
| 5 | Dữ liệu đầu vào và vị trí | ô `Context › Nạp` của dòng task · gói nạp ở `CLAUDE.md` §1 | §1 là mặc định **mức lane**; ô `Nạp` là mức **việc này** và **thắng khi lệch** ([CLAUDE.md §3](../../CLAUDE.md) bước 3). Trỏ **đúng mục**, và mục đó phải `grep` ra được (§5.2c) |
| 6 | Phạm vi và ràng buộc + van xả | `CLAUDE.md` §1 (lane sở hữu file nào) + §6 (kích cỡ) · ô `Finding phải đóng` | Van xả: thấy việc khác ⇒ một dòng vào `finding.md`, không sửa kèm |
| 7 | Định dạng đầu ra | ô `Đầu ra kiểm chứng được` (lệnh + kết quả kỳ vọng) · §1 file này (khuôn 10 cột) | Định dạng của sổ ở đây, định dạng của đầu ra ở dòng task |
| 8 | Ví dụ (few-shot) | ô `Prompt mở session` — ba dòng đầu `task.md` viết đủ làm mẫu | Dòng sau soi ba dòng đầu mà viết |
| 9 | Quy trình (thứ tự) | `CLAUDE.md` §3 (thứ tự **trong** phiên) · ô `Cần xong trước` (thứ tự **giữa** các task) | Hai loại thứ tự khác nhau, hai nhà khác nhau |
| 10 | Xử lý bất định | ô `Context › Bẫy` · `CLAUDE.md` dòng vai trò ("nổi lên") · §3.1 file này (luật ⚠️) | Không biết ⇒ ghi finding kèm cách sửa, không đoán cho trôi |
| 11 | Tự kiểm tra *(máy)* | **không thành cột** — thành ba thứ để đánh ✅ ở `CLAUDE.md` §4 | Opus 5 tự verify sẵn; câu "hãy tự kiểm tra lại" chỉ tốn token |
| 11 | Kiểm tra *(người)* | ô `Owner kiểm tra` + bảng soi `### owner-T-xx` của `task.md` | Vế thứ hai của TP11: máy tự verify được **hiện trạng**, nó không thay owner quyết định **thay đổi này có được nhận không** |
| 11 | Kiểm tra *(chất lượng)* | ô `Chất lượng` + bảng soi `### cl-T-xx` của `task.md` · thang đo ở `quality/00-guideline-chat-luong.md` §3 §4 | Vế thứ ba của TP11: máy đo **hiện trạng**, người đo **thay đổi**, cột này đo **dùng được cho phiên sau** |
