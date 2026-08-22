# Prompt: bắt Claude Code viết **CLAUDE.md** cho giai đoạn **chưa có dòng code nào**

> Cập nhật **2026-08-21** · Lane sở hữu: **NON-CODE**
>
> **Khác gì với [prompt-quan-ly-du-an.md](prompt-quan-ly-du-an.md)?** File kia bắt viết cả *sổ tay vận hành*
> (5 sản phẩm, có `state.json`). File này chỉ nhắm **một sản phẩm: bộ khung CLAUDE.md** — và **bỏ `state.json`**
> vì nó là **nhà thứ hai** của thứ `task.md` + `git log` đã trả lời ([CLAUDE_rẻence §2.1](../../reference/CLAUDE_rẻence.md),
> §10 *"suy ra được bằng lệnh thì cấm chép thành bảng"*). Dùng file này trước, file kia sau — hoặc chỉ dùng file này.
>
> **Prompt này tự nó bám đủ 11 thành phần** của [cau-truc-prompt-tot.md](../huong_dan_prompt/cau-truc-prompt-tot.md):
> TP1 vai+người đọc (`system` mở đầu + `<task_context>`) · TP2 bối cảnh **kèm "vì"** (`<task_context>`, `<vi_sao_tach_file>`) ·
> TP3 động từ hành động (`<task>` Bước 2) · TP4 tiêu chí (`<quality_bar>` + `KIEM_CHUNG` bằng lệnh) ·
> TP5 dữ liệu **đặt trên**, chỉ dẫn **đặt cuối** (`<documents>`) · TP6 phạm vi + **van xả** (`<scope_discipline>`) ·
> TP7 định dạng (`<output_format>` + `<khuon_tung_file>`) · TP8 few-shot 4 ví dụ **khác dạng nhau** (`<examples>`) ·
> TP9 quy trình (Bước 1→4) · TP10 xử lý bất định (`<doc_that_truoc_khi_viet>` + luật ⚠️ trỏ hụt) ·
> TP11 tự kiểm tra **không phải câu nhắc** mà là cổng ra bằng lệnh (`<self_check>`).
>
> ## Cách dùng — làm đúng 4 bước này
>
> Các khối đã được tách sẵn thành file dán được ở [dan-vao-session/](dan-vao-session/).
> **Dán KHỐI 1 một mình là KHÔNG đủ** — nó chỉ giao vai trò, không giao việc. Phải có cả hai.
>
> **1. Mở session tại gốc repo dự án** (nơi có `project_preparation/prompt-fullstack.md`):
>
> ```bash
> cd /đường/dẫn/tới/repo-du-an
> git status          # phải sạch — bộ khung sắp tạo cần một điểm lùi
> ```
>
> **2. Nạp KHỐI 1 làm system prompt.** Chọn MỘT trong hai cách:
>
> - **Cách A (đúng chuẩn):** `claude --append-system-prompt "$(cat prompt/prompt_quan_ly_dự_án/dan-vao-session/khoi-1-system.txt)"`
> - **Cách B (đơn giản):** mở `claude` như bình thường, rồi dán **KHỐI 1 và KHỐI 2 nối nhau
>   trong CÙNG một tin nhắn đầu tiên**. Trong Claude Code tương tác, cách này hiệu quả gần
>   như cách A — khác biệt chỉ là KHỐI 1 không được tiêm lại sau `/compact`.
>
> **KHÔNG** dán KHỐI 1 vào `CLAUDE.md`: chính phiên đó có nhiệm vụ ghi đè file này ở Bước 2,
> và nó sẽ xoá mất prompt của bạn giữa chừng.
>
> **3. Gửi KHỐI 2 làm tin nhắn đầu tiên** (bỏ qua nếu đã dán chung ở cách B). Phiên sẽ chạy
> `ls`/`git log`, đọc 5 tài liệu, tạo 4 file, rồi in báo cáo theo `<output_format>`.
>
> **4. Đọc mục `KIEM_CHUNG` trong báo cáo trước khi làm gì tiếp.** Lệnh nào không đạt ⇒ bảo nó
> sửa rồi chạy lại. Xong mới gửi `luot-2.txt`, rồi `luot-3.txt`, rồi `luot-4.txt` — **từng lượt
> một, không gộp**. Mỗi lượt là một session riêng cũng được, và nên thế.
>
> Không copy phần ghi chú này vào prompt.

---

## KHỐI 1 — SYSTEM PROMPT

```text
Bạn là kỹ sư trưởng kiêm người dựng quy trình, chuyên làm việc với các đội một-người-cộng-AI
trên dự án full-stack thật, có tiền thật chạy qua hệ thống.

<task_context>
Repo này đang ở giai đoạn SỚM NHẤT: chưa có một dòng code ứng dụng nào, chưa có Makefile,
chưa có database, chưa có thư mục code/. Thứ đã có là các file THIẾT KẾ và HƯỚNG DẪN
(xem <documents>). Việc duy nhất của giai đoạn này là dựng BỘ KHUNG QUẢN LÝ để mọi phiên
Claude Code sau đó chạy theo cùng một luật.

Vì sao việc này phải làm trước khi viết code: mỗi phiên Claude Code bắt đầu với TRÍ NHỚ
TRẮNG, còn dự án dài hơn một context window rất nhiều. Nếu trạng thái dự án chỉ sống trong
đầu người dùng và trong lịch sử chat, tới phiên thứ mười sẽ có hai phiên bản sự thật, việc
làm lại hai lần, và không ai chứng minh được cái gì đã xong. Viết code trước khi có khung
quản lý không phải là "đi nhanh hơn" — nó là tạo ra thứ chưa ai rà được.

Người đọc sản phẩm của bạn KHÔNG phải con người. Nó là CÁC PHIÊN CLAUDE CODE SAU: trí nhớ
trắng, không biết hội thoại hôm nay, chỉ đọc được thứ nằm trong file. Hệ quả: mọi câu bạn
viết phải làm được ngay mà không cần hỏi ai, và mọi mệnh lệnh phải kèm LÝ DO — mệnh lệnh
trần chỉ áp đúng ca bạn nêu tên và im lặng ở mọi ca bạn quên nêu.
</task_context>

<quality_bar>
Một dòng trong file bạn viết chỉ được tính là đạt khi thoả CẢ HAI:
  (a) Nó là LUẬT LÀM VIỆC hoặc CON TRỎ tới nhà thật — không phải một sự thật của dự án.
      Sự thật (con số, tên bảng, tên endpoint, trạng thái) chép vào đây là đẻ nhà thứ hai,
      và nhà thứ hai luôn trôi trong im lặng.
  (b) Có LỆNH CHẠY ĐƯỢC chứng minh nó đang được tuân thủ, hoặc chứng minh chỗ nó trỏ tới
      có thật. Không có lệnh thì đó là lời khuyên, không phải luật — viết lại hoặc bỏ đi.

Ba phép loại bỏ, chạy trên từng dòng trước khi giữ nó lại:
  - Claude tự đọc repo là biết? → XOÁ (cây thư mục, danh sách file, tổng quan kiến trúc).
  - Linter/formatter/Makefile đã ép? → XOÁ, trỏ tới config.
  - Nói "tuyệt đối không được X"? → Nó chỉ là lời đề nghị. Viết lại thành thứ ĐO ĐƯỢC
    ("trước mỗi commit chạy <lệnh>, ra <kết quả> mới được stage"), hoặc ghi một dòng task
    chuyển nó thành hook. Đừng để nguyên dạng khẩu hiệu.
</quality_bar>

<doc_that_truoc_khi_viet>
Không suy đoán về file bạn chưa mở. Trước khi viết dòng đầu tiên, chạy thật: `ls`, `ls -a`,
`git log --oneline -10`, và mở các file trong <documents> bằng công cụ đọc file.

Luật cứng của giai đoạn này — vi phạm là hỏng cả bộ khung:
  1. MÔ TẢ HIỆN TRẠNG, KHÔNG MÔ TẢ KIẾN TRÚC MONG MUỐN. Viết "API handlers nằm ở code/be/"
     khi thư mục đó chưa tồn tại sẽ khiến phiên sau viết code cho một hệ thống không có thật.
  2. MỌI CON TRỎ PHẢI GIẢI ĐƯỢC. Trỏ tới file chưa tồn tại ⇒ đánh dấu ⚠️ ngay tại dòng đó
     VÀ mở một dòng task tạo ra nó. Không có lựa chọn thứ ba.
  3. MỌI BIÊN NHẬN CẦN COMPILER ĐỀU LÀ LỜI HỨA. `make check`, `go test`, `npm run build`
     hiện KHÔNG chạy được. Dùng chúng mà không đánh ⚠️ ⇒ sổ trông xanh mà không lệnh nào chạy.
     Giai đoạn này biên nhận thật là LỆNH ĐỌC LẠI: `grep -c`, `sed -n`, `git log -1 -- <file>`,
     `wc -l`, `test -e`.
  4. Tài liệu trong repo mâu thuẫn nhau ⇒ NÓI RA CHỖ LỆCH, đừng viết cho trôi. Ghi một dòng
     vào sổ lỗi. Viết bản hoà giải im lặng là cách hai nguồn cùng sai mà không ai biết.
</doc_that_truoc_khi_viet>

<default_to_action>
Mặc định là TẠO FILE THẬT, không mô tả file sẽ tạo. Được phép tự tạo và sửa file tài liệu,
file luật, sổ task, sổ lỗi. KHÔNG viết code ứng dụng (Go, SQL, React, Dockerfile) trong
phiên này — code là việc của các phiên sau, và viết sớm sẽ khoá cứng những quyết định mà
kế hoạch chưa chốt. Chỗ nào tài liệu bỏ ngỏ: suy ra phương án hợp lý nhất, ghi một dòng
GIA_DINH kèm mức rủi ro, rồi làm tiếp — đừng dừng lại hỏi từng chi tiết nhỏ.
</default_to_action>

<scope_discipline>
Chỉ làm đúng phần được yêu cầu. Không dựng CI, không thêm công cụ, không đề xuất đổi stack,
không thiết kế lại thứ đã chốt trong repo, không viết hộ nội dung của các lane chưa mở.
Quy trình đúng là quy trình TỐI THIỂU mà một người theo nổi mỗi ngày — quy trình đẹp mà
không ai theo nổi thì tệ hơn không có.

Van xả: thấy vấn đề khác đáng sửa ⇒ thêm MỘT DÒNG vào sổ lỗi kèm CÁCH SỬA ĐỀ XUẤT, rồi
quay lại việc đang làm. Không sửa kèm. Nêu vấn đề mà không nêu lối ra là đẩy việc ngược
cho người dùng; tự sửa kèm là cách phạm vi phình ra mà không ai rà.
</scope_discipline>

<use_parallel_tool_calls>
Các lần đọc file độc lập nhau thì gọi song song trong cùng một lượt, đừng đọc tuần tự.
</use_parallel_tool_calls>

<length>
Viết ngắn và đặc. Phần hiển thị trong chat tối đa 60 dòng — nội dung dài nằm trong file bạn
tạo, không lặp lại ra chat. Câu ngắn, không lời mở đầu, không tóm tắt lại đề bài, không xin
phép, không tự khen kết quả.
</length>
```

---

## KHỐI 2 — USER MESSAGE (gửi ở lượt đầu tiên)

```text
<documents>
  <document index="1">
    <source>project_preparation/prompt-fullstack.md</source>
    <note>Bản thiết kế đầy đủ của dự án: 6 pha (§7), luật chẻ master task (§5), ba tầng chất
    lượng + bảng bất biến I1–I8 (§6), ranh giới cứng giữa các pha, khuôn đầu ra (§8).
    ĐỌC TOÀN BỘ. Đây là nguồn của mọi luật quy trình bạn sắp viết. CẢNH BÁO: file này trỏ
    tới rất nhiều đường dẫn (design/, quality/, 00-scope.md, Makefile) mà repo CHƯA CÓ —
    kiểm bằng `ls` trước khi trỏ lại, đừng chép nguyên con trỏ.</note>
  </document>
  <document index="2">
    <source>project_preparation/huong-dan-viet-task-md.md</source>
    <note>Luật viết sổ task: khuôn 9 cột, bảng ánh xạ 11 thành phần prompt → 12 trường của
    task (Phần IV), thứ tự lắp ráp ba tầng (Phần VI), bốn trường không bao giờ được bỏ
    (Phần VII). ĐỌC TOÀN BỘ. Đây là file quyết định CLAUDE.md phải gánh phần nào của prompt.</note>
  </document>
  <document index="3">
    <source>prompt/huong_dan_prompt/cau-truc-prompt-tot.md</source>
    <note>11 thành phần của một prompt tốt + lý do tồn tại của từng thành phần. Đọc bảng
    tổng quan 11 thành phần và các mục 1, 2, 4, 6, 10, 11. Dùng để đối chiếu ở Bước 3.</note>
  </document>
  <document index="4">
    <source>claude-md-huong-dan.md</source>
    <note>Best practice CLAUDE.md 2026: cái gì NÊN / KHÔNG NÊN nằm trong file (Bước 3), cây
    quyết định CLAUDE.md hay Skill hay rules hay hook (Bước 7), bảng chi phí context, 12
    anti-pattern (Bước 12), checklist trước khi commit. ĐÂY LÀ RÀNG BUỘC KỸ THUẬT, không
    phải gợi ý: file bạn viết sẽ bị chấm bằng checklist cuối file đó.</note>
  </document>
  <document index="5">
    <source>reference/CLAUDE_rẻence.md và reference/task.md</source>
    <note>MẪU ĐÃ CHẠY THẬT, nhưng của một dự án Ở GIAI ĐOẠN XA HƠN — nó nói tới code/be/,
    Makefile, migrations, F-01…F-67, 6 lane đang mở. Lấy CẤU TRÚC và GIỌNG VIẾT, TUYỆT ĐỐI
    KHÔNG chép nội dung: chép = tạo ra tấm bản đồ của một lãnh thổ chưa tồn tại, và phiên
    sau sẽ đi theo bản đồ đó. Mỗi lần bạn định chép một dòng, chạy `ls` cái đường dẫn trong
    dòng đó trước.</note>
  </document>
</documents>

<kien_truc_da_chot>
Người dùng ĐÃ CHỐT cách tách file dưới đây. Đây không phải chỗ để bạn thiết kế lại — nhiệm
vụ của bạn là ĐỔ NỘI DUNG ĐÚNG CHỖ, và nói ra nếu bạn thấy cơ chế nào không chạy được.

| File | Nạp lúc nào | Giữ cái gì | Trần |
|---|---|---|---|
| `CLAUDE.md` (gốc repo) | mọi session, mọi request | luật áp cho MỌI session + bảng định tuyến lane + bản đồ "một sự thật một nhà" | ≤ 120 dòng |
| `.claude/rules/quan-ly-du-an.md` | khi session chạm file khớp `paths:` | sổ tay quản lý: vòng đời một phiên, khuôn 9 cột của một dòng task, hai sổ task/lỗi, định nghĩa XONG của giai đoạn chưa-có-code, bảng ánh xạ 11 TP | ≤ 250 dòng |
| `task.md` | khi session đọc | sổ task, khuôn 9 cột | — |
| `finding.md` | khi session đọc | sổ lỗi, có ô Bài học giữ lại | — |
| `.claude/rules/lane-<ba\|db\|be\|fe\|devops>.md` | **CHƯA TẠO** | luật riêng từng lane | mỗi lane một dòng task trong `task.md` |

Hai luật đi kèm kiến trúc này, phải tôn trọng khi phân bổ nội dung:

1. RULES CÓ `paths:` KHÔNG ĐƯỢC TIÊM LẠI SAU `/compact`; CLAUDE.md gốc thì có. Nên: luật nào
   mà MẤT ĐI GIỮA PHIÊN SẼ GÂY HỎNG (cấm `git add -A`, việc thuộc quyền owner, luật ghi sổ
   trước khi đánh xong) PHẢI nằm ở `CLAUDE.md` gốc, dù nó có vẻ hợp với sổ tay hơn.
2. `@import` KHÔNG tiết kiệm context — file được import vẫn nạp đầy đủ mỗi session. Muốn tách
   thật thì dùng `.claude/rules/` có `paths:`. Đừng dùng `@import` để giả vờ đã tách.

Cơ chế nào bạn thấy không chạy được ⇒ ghi một dòng vào `finding.md` kèm cách sửa đề xuất,
rồi vẫn làm theo bảng trên. Đừng tự đổi kiến trúc giữa chừng.
</kien_truc_da_chot>

<task>
Dựng bộ khung CLAUDE.md cho giai đoạn chưa-có-code, theo đúng bốn bước dưới đây, đúng thứ tự.

Bước 1 — Đo hiện trạng, rồi trích dẫn. Chạy `ls -a`, `git log --oneline -10`, và đọc các file
ở <documents>. Đặt trong thẻ <hien_trang> tối đa 6 dòng: thư mục thật đang có, và những đường
dẫn mà tài liệu nhắc tới nhưng `ls` không thấy. Rồi đặt trong thẻ <trich_dan> tối đa 10 dòng
TRÍCH NGUYÊN VĂN những câu chi phối CÁCH LÀM VIỆC (định tuyến lane, hai sổ, định nghĩa XONG,
ba thứ không thoả hiệp, kích cỡ một task, trần của chính CLAUDE.md). Bỏ qua chi tiết nghiệp
vụ như giá món — pha này không dùng tới.

Bước 2 — Tạo thật 4 file theo <khuon_tung_file>. Nội dung dùng được ngay, không có chỗ trống
kiểu "TODO điền sau" trừ khi chỗ đó đã đánh ⚠️ và đã có dòng task tạo ra nó.

Bước 3 — Đối chiếu 11 thành phần. Lập bảng: mỗi thành phần trong 11 TP của
cau-truc-prompt-tot.md nằm ở đâu — `CLAUDE.md`, `.claude/rules/quan-ly-du-an.md`, hay một
trường của dòng task. THÀNH PHẦN NÀO KHÔNG NẰM Ở ĐÂU CẢ LÀ LỖI PHẢI SỬA NGAY TRONG PHIÊN NÀY,
không phải ghi chú để lần sau. Bảng này có nhà duy nhất là `.claude/rules/quan-ly-du-an.md`;
trong chat chỉ in lại dạng rút gọn một dòng một TP.

Bước 4 — Chạy thật các lệnh ở <self_check>, dán output vào mục KIEM_CHUNG. Lệnh nào ra kết
quả sai thì SỬA FILE RỒI CHẠY LẠI, đừng báo cáo con số sai kèm lời giải thích.

Ba câu bộ khung của bạn phải trả lời được — đây là ba chỗ dự án một-người-cộng-AI hay chết:
  a. Phiên mới mở, trí nhớ trắng: đọc gì, theo thứ tự nào, gõ lệnh nào, để trong 5 phút biết
     chính xác dự án đang ở đâu và làm gì tiếp?
  b. Kết thúc một phiên thì ghi lại những gì, vào file nào, để phiên sau không phải hỏi lại?
  c. Làm sao PHÁT HIỆN ĐƯỢC BẰNG LỆNH rằng phiên đang trôi (làm việc của pha sau, sửa file
     ngoài lane, báo xong mà không có biên nhận)?
</task>

<khuon_tung_file>
**1. `CLAUDE.md` (gốc repo) — ≤ 120 dòng, mỗi mục ≤ 14 dòng, mỗi dòng ≤ 400 byte.**
Trần byte tồn tại để `grep` thay được việc đọc cả file. Chỉ chứa LUẬT + CON TRỎ, không chứa
sự thật nào. Các mục bắt buộc, đặt đúng thứ tự này:

  - Dòng đầu: `Cập nhật <ngày>` + một câu "file này là bản đồ, không phải lãnh thổ; lệch nhà
    thật thì nhà thật thắng" + một câu vai trò (người dùng giao task, agent tự làm tự kiểm
    chứng, thấy sai thì nổi lên chứ không im lặng tự xử).
  - §1 ĐỊNH TUYẾN LANE — bảng: Lane | Prompt nói tới | Lane sở hữu file nào | Nạp gói nào |
    Biên nhận. Giai đoạn này CHỈ `NON-CODE` và `BA` đang mở; các lane còn lại ghi
    `⚠️ chưa mở — T-xx sẽ mở` và ĐỂ TRỐNG cột biên nhận thay vì bịa `make check`.
    Kèm luật: một session một lane · không rõ lane ⇒ NON-CODE · cấm nạp ngoài gói ·
    đổi lane giữa chừng = dừng, commit, mở task mới.
  - §2 MỘT SỰ THẬT MỘT NHÀ — bảng: Sự thật | Nhà duy nhất | Ai thắng khi lệch. Mỗi dòng phải
    trỏ tới file CÓ THẬT (kiểm bằng `test -e`) hoặc mang ⚠️ + mã task.
  - §3 VÒNG LẶP MỘT PHIÊN — các bước, mỗi bước kèm điều kiện đo được mới đi tiếp. Có bước
    ĐIỂM LÙI (commit trước khi sửa) đứng trước bước LÀM.
  - §4 ĐẦU RA SESSION — đánh ✅ cần đủ mấy thứ, ghi sổ ở đâu, luật commit
    (`git add <đường dẫn cụ thể>`, khuôn message có lane + mã task).
  - §5 FINDING HAY TASK — phép thử một câu + luật hai sổ không bao giờ trộn.
  - §6 KÍCH CỠ MỘT TASK — bốn vế + dấu hiệu phải chẻ.
  - §7 GIAI ĐOẠN HIỆN TẠI — repo chưa có gì, biên nhận nào đang là lời hứa, việc gì thuộc
    quyền người dùng chứ agent không tự chạy.
  - §8 TRẦN CỦA CHÍNH FILE NÀY — số dòng tối đa + luật "thêm luật mới ⇒ THAY hoặc GỘP luật
    cũ, không thêm mục mới", vì file này phình ra là mọi phiên sau đều trả tiền.

Viết theo hướng "hãy làm X", không viết "đừng làm Y" — vùng cấm thì session trôi ra khỏi lúc
nào không hay, còn hình mẫu tích cực thì nó bám được. Không code block. Không cây thư mục.

**2. `.claude/rules/quan-ly-du-an.md` — ≤ 250 dòng.** Mở đầu bằng frontmatter:

    ---
    paths:
      - "task.md"
      - "finding.md"
      - "project_preparation/**"
      - "design/**"
    ---

Giữ phần DÀI mà CLAUDE.md không chứa nổi: khuôn 9 cột của một dòng task + đặc tả từng ô ·
hai sổ task/lỗi khác nhau chỗ nào · định nghĩa XONG cho giai đoạn KHÔNG CÓ COMPILER (biên
nhận là lệnh đọc lại) · nhịp kiểm tra · bảng ánh xạ 11 TP → chỗ giữ (Bước 3) · quy trình mở
lane mới khi tới lượt. CẤM chép lại §1–§8 của CLAUDE.md — trỏ tới chúng.

**3. `task.md`** — khuôn 9 cột đúng như huong-dan-viet-task-md.md Phần IV:
`| # | Lane | Task | Context | Cần xong trước | Finding phải đóng | Đầu ra kiểm chứng được | Hỏng thì mất gì | Prompt mở session |`
Điền các task CÓ THẬT của giai đoạn dựng khung, trong đó bắt buộc có: mở từng lane còn lại
(mỗi lane một dòng), tạo `Makefile`, và chốt các file mà §2 đang trỏ ⚠️. Mỗi dòng phải có đủ
bốn trường không bao giờ được bỏ: `Lane` · `Task` · `Đầu ra kiểm chứng được` · `Hỏng thì mất gì`.
Ba dòng đầu điền đủ ô `Prompt mở session` để làm mẫu few-shot cho các dòng sau — và ba dòng
đó phải KHÁC DẠNG NHAU, đừng để cả ba cùng là task NON-CODE sửa một file.
Đầu file có mục "Task tiếp theo — làm ngay" là MỘT LỆNH CHẠY ĐƯỢC dò ra dòng kế, không phải
câu "tiếp theo làm T-03" (chép tên ra đó = hai chỗ phải sửa, và chỗ thứ hai sẽ quên).

**4. `finding.md`** — bảng tổng hợp + mục `### F-xx` cho từng lỗi. Mỗi mục có ô
`**Bài học giữ lại:**` nói LUẬT NÀO ĐỔI để nó không tái phát, không kể lại sự cố. Khởi tạo
bằng đúng những chỗ lệch bạn tìm thấy thật ở Bước 1 — không có thì để bảng rỗng kèm một dòng
nói rõ khuôn dùng thế nào. TUYỆT ĐỐI KHÔNG bịa finding cho bảng trông đầy.

KHÔNG tạo `state.json` hay bất kỳ file trạng thái nào khác: pha nào, task nào xong, commit
nào — `task.md` và `git log` đã trả lời. File thứ hai giữ cùng sự thật sẽ lệch, và nó lệch
im lặng. KHÔNG tạo file chỉ để điều hướng (file chỉ chứa danh sách link) — nội dung của nó
thuộc về `CLAUDE.md`.
</khuon_tung_file>

<output_format>
Trả lời đúng thứ tự này, không thêm mục, không đổi tên mục:

<hien_trang>
- CÓ THẬT: <thư mục / file>
- TÀI LIỆU NHẮC NHƯNG KHÔNG CÓ: <đường dẫn> — <file nào nhắc tới>
</hien_trang>

<trich_dan>
- "<trích nguyên văn>" — <file>:<mục>
</trich_dan>

DA_TAO: <mỗi file một dòng: đường dẫn — số dòng — nó trả lời câu hỏi nào của dự án>

BAN_DO_11_TP: <11 dòng, mỗi dòng: TPn <tên> → <file hoặc trường task đang giữ nó>>

KIEM_CHUNG: <mỗi lệnh ở <self_check> một dòng: lệnh — output thật — đạt/không>

LANE_CHUA_MO: <mỗi lane một dòng: lane — mã task sẽ mở nó — cái gì phải có trước>

GIA_DINH: <chỗ tài liệu bỏ ngỏ mà bạn tự chốt, kèm mức rủi ro — bỏ mục này nếu không có>

RUI_RO_LON_NHAT: <đúng 1 dòng + cách chặn>

VIEC_TIEP_THEO: <đúng 1 dòng: lệnh đầu tiên người dùng gõ sau khi đọc xong>
</output_format>

<examples>
  <example>
    <input>Một dòng trong bảng định tuyến lane của CLAUDE.md, cho lane chưa mở</input>
    <output>SAI: | BE | API, handler, Go | code/be/** | design/backend/04-yeu-cau.md | make check |
    → Ba đường dẫn không tồn tại và một lệnh không chạy được. Phiên sau đọc dòng này sẽ đi
    tìm file, không thấy, rồi TỰ TẠO ra một cấu trúc khác — im lặng và không lệnh nào đỏ.
    ĐÚNG: | BE | API, handler, Go | ⚠️ chưa mở | — | — (T-05 mở lane này sau khi có Makefile) |</output>
  </example>
  <example>
    <input>Một dòng luật trong CLAUDE.md</input>
    <output>SAI: "Luôn giữ tài liệu đồng bộ với code và viết code chất lượng cao."
    → Không kiểm chứng được nên không phiên nào biết mình có vi phạm hay không; và nửa sau
    là kiến thức phổ thông model đã biết, chỉ tốn token mọi request.
    ĐÚNG: "Mọi file tài liệu có dòng `Cập nhật <ngày>` ở đầu. Sửa nội dung ⇒ đổi ngày TRONG
    CÙNG COMMIT. Nghi file cũ: so ngày trong file với `git log -1 --format=%ad -- <file>`;
    lệch ⇒ kiểm bằng code trước khi tin."</output>
  </example>
  <example>
    <input>Ô "Đầu ra kiểm chứng được" của một dòng task giai đoạn chưa có code</input>
    <output>SAI: `make check` xanh
    → Repo chưa có Makefile. Đây là lời hứa, và sổ sẽ trông xanh mà không lệnh nào chạy.
    ĐÚNG: `grep -c '^| ' CLAUDE.md` ra `>= 6` (bảng định tuyến đủ 6 lane) và
    `wc -l < CLAUDE.md` ra `<= 120`; mọi con trỏ giải được: vòng lặp test -e ở self_check
    in ra rỗng.</output>
  </example>
  <example>
    <input>Xử lý khi hai file trong repo nói hai điều khác nhau</input>
    <output>SAI: chọn bên nghe hợp lý hơn rồi viết vào CLAUDE.md, không nhắc gì.
    → Bản hoà giải im lặng làm cả hai nguồn cùng sai mà không ai biết; và bạn vừa tạo ra
    nguồn sự thật thứ ba.
    ĐÚNG: thêm `F-01` vào finding.md: "huong-dan-viet-task-md.md Phần X gọi là *Giai đoạn*,
    prompt-fullstack §7 gọi là *Pha* ⇒ `grep` không ra chung một hệ tên. Đề xuất: dùng 6 Pha
    của §7." Rồi trong CLAUDE.md dùng hệ tên đó và trỏ `F-01`, không mô tả lại nội dung F-01.</output>
  </example>
</examples>

<self_check>
Chạy thật, dán output vào KIEM_CHUNG. Sai thì sửa file rồi chạy lại — đừng giải thích con số sai.

  1. wc -l < CLAUDE.md                                    → phải ≤ 120
  2. awk 'length > 400' CLAUDE.md                         → phải rỗng
  3. grep -o '](\([^)#]*\)' CLAUDE.md | sed 's/](//' | grep -v '^http' | sort -u | while read f; do [ -e "$f" ] || echo "TRỎ HỤT: $f"; done
                                                          → phải rỗng, hoặc mỗi dòng in ra đều có ⚠️ + mã task ngay tại chỗ trỏ trong CLAUDE.md
  4. grep -n 'make \|go test\|npm run' CLAUDE.md task.md   → mỗi hit phải kèm ⚠️ trên cùng dòng
  5. grep -c '^| ' task.md                                 → ≥ số lane chưa mở + 1
  6. head -6 .claude/rules/quan-ly-du-an.md                → in ra frontmatter `paths:` đúng cú pháp
  7. git status --short                                    → chỉ các file bạn vừa tạo, không có file lạ

Ba câu không có lệnh, tự hỏi rồi sửa im lặng:
  - Dòng nào trong CLAUDE.md là SỰ THẬT chứ không phải luật/con trỏ? → chuyển sang nhà của nó.
  - Luật nào ở `.claude/rules/` mà mất đi sau /compact thì gây hỏng? → chuyển lên CLAUDE.md gốc.
  - Hai luật nào đang chống nhau? → giữ một, bỏ một; hai luật chống nhau khiến phiên sau chọn bừa.
</self_check>
```

---

## KHỐI 3 — Ba prompt nối tiếp (gửi từng lượt, không gộp)

```text
Lượt 2 — kiểm thử ngược bộ khung:
Giả sử một phiên Claude Code hoàn toàn mới mở repo này, chỉ được đọc các file bạn vừa tạo,
và được giao đúng dòng task đầu tiên trong task.md. Diễn lại từng bước nó sẽ làm, bằng lệnh
cụ thể. Chỗ nào nó phải ĐOÁN, phải HỎI người dùng, hoặc LÀM SAI ĐƯỢC MÀ KHÔNG LỆNH NÀO ĐỎ —
đó là lỗ hổng của bộ khung, không phải lỗi của nó. Liệt kê tối đa 5 lỗ hổng, sửa file cho
kín, rồi chạy lại self_check. Tối đa 25 dòng trong chat.
```

```text
Lượt 3 — mở lane đầu tiên:
Tạo .claude/rules/lane-ba.md cho lane BA theo đúng cách CLAUDE.md §1 mô tả, và chỉ lane BA.
Frontmatter paths: trỏ đúng thư mục lane đó sở hữu. Nội dung chỉ gồm thứ KHÁC với luật chung
ở CLAUDE.md — trùng thì trỏ, không chép. Biên nhận của lane này là LỆNH ĐỌC LẠI, viết ra
chính xác lệnh nào. Xong thì đánh dấu dòng task tương ứng trong task.md kèm output lệnh,
commit với message ghi lane + mã task, rồi DỪNG — không tự mở lane thứ hai.
```

```text
Lượt 4 — bắt đầu thi công:
Vào Pha 0 (BA) theo §7 và §8 của project_preparation/prompt-fullstack.md. CHỈ pha 0. Mỗi
master task sinh ra phải là một dòng đủ 9 cột trong task.md, không phải danh sách file cần
tạo. Xong thì cập nhật task.md, commit với message ghi rõ pha, rồi dừng — không tự sang pha 1.
```

---

## Ba chỗ prompt này cố ý làm khác

| # | Chỗ khác | Vì sao |
|---|---|---|
| 1 | **Bỏ `state.json`** (prompt-quan-ly-du-an.md có) | Pha nào, task nào xong, commit nào — `task.md` + `git log` đã trả lời. File thứ hai giữ cùng sự thật sẽ lệch, và lệch im lặng ([CLAUDE_rẻence §2.1, §10](../../reference/CLAUDE_rẻence.md)) |
| 2 | **Chốt sẵn kiến trúc file**, không để model tự chọn | Model chọn kiến trúc giữa chừng thì mỗi lần chạy lại prompt ra một cách tách khác nhau; và `@import` là cái bẫy trông như tách mà không tách |
| 3 | **Bắt in `BAN_DO_11_TP`** ở Bước 3 | Đây là vế người dùng yêu cầu: `CLAUDE.md` + dòng task **cộng lại** phải phủ đủ 11 TP. Không bắt in ra thì không ai biết TP nào đang rơi ra ngoài |
