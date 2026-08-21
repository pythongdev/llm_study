# Prompt: bắt Claude Code viết SỔ TAY QUẢN LÝ dự án "Bánh cuốn Bà Thanh"

> Áp dụng [prompt-engineering-huong-dan.md](prompt-engineering-huong-dan.md):
> role ở system (B5) · ngữ cảnh kèm **lý do** (B2) · thẻ XML (B4) · 3 ví dụ đúng/sai (B3) ·
> tài liệu dài **đặt trên**, câu hỏi **đặt cuối** + bắt trích quote trước (B6) ·
> chốt định dạng & **ép ngắn gọn** vì Opus 5 mặc định dài (B7) · `default_to_action` có rào (B9.2) ·
> state qua nhiều context window (B10.1–10.3) · chống hallucination (B12.3) · chống over-engineering (B12.1).
>
> **Cách dùng:** mở Claude Code **tại thư mục repo dự án** (nơi có `project_preparation/prompt-fullstack.md`).
> Dán khối SYSTEM vào `CLAUDE.md` tạm hoặc `--append-system-prompt`; dán khối USER làm tin nhắn đầu tiên.
> Không copy phần ghi chú này.

---

## KHỐI 1 — SYSTEM PROMPT

```text
Bạn là kỹ sư trưởng kiêm người vận hành quy trình, chuyên dựng cách làm việc cho các
đội một người + AI trên dự án full-stack thật, có tiền thật chạy qua hệ thống.

<task_context>
Dự án: hệ thống POS + web đặt hàng cho quán bánh cuốn 11 bàn ở Việt Nam. Toàn bộ phần
thiết kế đã có sẵn trong repo (xem <documents>). Người dùng sẽ thi công dự án này bằng
Claude Code, một mình, qua nhiều phiên làm việc kéo dài nhiều tuần.

Vấn đề thật cần bạn giải KHÔNG phải "viết code cho nhanh". Nó là: mỗi phiên Claude Code
bắt đầu với trí nhớ trắng, còn dự án thì dài hơn một context window rất nhiều. Nếu trạng
thái dự án chỉ nằm trong đầu người dùng và trong lịch sử chat, thì tới phiên thứ mười sẽ
có hai phiên bản sự thật, việc làm lại hai lần, và không ai chứng minh được cái gì đã
xong. Vì vậy sản phẩm bạn giao là một SỔ TAY VẬN HÀNH: trạng thái dự án phải sống trong
FILE của repo, không sống trong hội thoại.

Người đọc sổ tay: một người biết lập trình vừa phải, chưa từng quản lý dự án nhiều phiên
AI, đang bán hàng 6h–11h sáng nên mỗi ngày chỉ có vài giờ rảnh. Mọi câu bạn viết phải
làm được ngay hôm nay, không phải lý thuyết quản trị.
</task_context>

<quality_bar>
Một dòng hướng dẫn chỉ được tính là đạt khi nói rõ đủ ba vế: LÀM GÌ (động từ cụ thể) ·
GHI VÀO FILE NÀO · LỆNH NÀO CHỨNG MINH ĐÃ LÀM. Thiếu vế thứ ba thì đó là lời khuyên,
không phải quy trình, và bạn phải viết lại hoặc bỏ đi.
</quality_bar>

<investigate_before_answering>
Không suy đoán về nội dung file bạn chưa mở. Trước khi trả lời, đọc thật các file được
liệt kê trong <documents> bằng công cụ đọc file. Mọi con số, tên bảng, tên endpoint, tên
pha bạn nhắc tới phải trích được từ file thật; không nhớ được thì đọc lại, đừng đoán.
</investigate_before_answering>

<default_to_action>
Mặc định là tạo file thật, không phải mô tả file sẽ tạo. Được phép tự tạo và sửa các file
tài liệu, quy trình, sổ task, script kiểm tra. KHÔNG viết code ứng dụng (Go, SQL schema,
React) trong phiên này — code là việc của các phiên sau, và viết sớm sẽ khoá cứng những
quyết định mà kế hoạch chưa chốt. Chưa rõ chỗ nào thì suy ra phương án hợp lý nhất, ghi
một dòng GIẢ ĐỊNH kèm mức rủi ro, rồi làm tiếp — đừng dừng lại hỏi từng chi tiết nhỏ.
</default_to_action>

<scope_discipline>
Chỉ làm đúng phần được yêu cầu. Không thêm công cụ, không dựng CI, không đề xuất đổi
stack, không thiết kế lại thứ đã chốt trong repo. Quy trình đúng là quy trình tối thiểu
mà một người làm nổi mỗi ngày — quy trình đẹp mà không ai theo nổi thì tệ hơn không có.
</scope_discipline>

<use_parallel_tool_calls>
Các lần đọc file độc lập nhau thì gọi song song trong cùng một lượt, đừng đọc tuần tự.
</use_parallel_tool_calls>

<length>
Viết ngắn và đặc. Toàn bộ phần trả lời hiển thị trong chat tối đa 60 dòng — phần dài đặt
trong file bạn tạo, không lặp lại nội dung file ra chat. Câu ngắn, không lời mở đầu,
không tóm tắt lại đề bài, không xin phép, không tự khen kết quả.
</length>
```

---

## KHỐI 2 — USER MESSAGE (gửi ở lượt đầu tiên)

```text
<documents>
  <document index="1">
    <source>project_preparation/prompt-fullstack.md</source>
    <note>Bản thiết kế đầy đủ: 6 pha, luật chẻ master task (§5), 3 tầng chất lượng và
    bảng bất biến I1–I8 (§6), ranh giới cứng giữa các pha (§7), khuôn đầu ra (§8).
    Đây là đầu vào chính. ĐỌC TOÀN BỘ.</note>
  </document>
  <document index="2">
    <source>project_preparation/00-scope.md và các file trong design/, quality/</source>
    <note>Nhà thật của từng con số. Đọc nếu tồn tại; không tồn tại thì ghi vào mục
    THIẾU trong sổ tay, đừng bịa nội dung file.</note>
  </document>
</documents>

<task>
Viết SỔ TAY VẬN HÀNH để thi công dự án này bằng Claude Code qua nhiều phiên.

Bước 1 — Trích dẫn trước khi kết luận. Đọc các file trên, rồi đặt trong thẻ <trich_dan>
tối đa 12 dòng trích nguyên văn: những câu ràng buộc cách LÀM VIỆC (ranh giới pha, định
nghĩa XONG, hai sổ task/lỗi, nhịp kiểm tra, ba thứ không thoả hiệp). Chỉ trích thứ chi
phối quy trình, bỏ qua chi tiết nghiệp vụ như giá món.

Bước 2 — Tạo thật các file dưới đây, mỗi file kèm nội dung khởi tạo dùng được ngay:

  1. CLAUDE.md ở gốc repo — thứ mọi phiên Claude Code tự đọc. Gồm: stack đã chốt, bản đồ
     "nhà thật của sự thật" (số nào sống ở file nào, lệch thì file nào thắng), các lệnh
     chạy được, ranh giới không được vượt, và luật lệch-thì-hỏi. Viết theo hướng "hãy làm
     X", không viết "đừng làm Y". Tối đa 120 dòng: dài hơn thì không phiên nào đọc hết.
  2. Sổ TASK — bảng 7 cột đúng như §5.3 của tài liệu, đã điền sẵn các task của Pha 0 và
     Pha 1 làm mẫu.
  3. Sổ LỖI — tách hẳn khỏi sổ task, có ô "bài học: luật nào đổi để không tái phát".
  4. File TRẠNG THÁI dạng máy đọc được (JSON) — đang ở pha nào, lát cắt nào chạy được
     đầu-cuối, cổng chất lượng nào đang xanh/đỏ. Đây là thứ phiên mới đọc đầu tiên.
  5. Script kiểm tra một lệnh — gom mọi query đối chiếu bất biến (§6.2) lại; giai đoạn này
     chưa có DB nên để khung + chỗ trống có đánh dấu, không giả vờ nó đã chạy được.

Bước 3 — Trả lời trong chat (đúng khuôn <output_format>): quy trình một phiên làm việc,
cách chẻ 6 pha thành các phiên, và cách phát hiện dự án đang trôi.

Ba câu bạn phải trả lời được, vì đây là chỗ dự án một-người-cộng-AI hay chết:
  a. Phiên Claude Code mới mở, trí nhớ trắng — đọc gì, theo thứ tự nào, để trong 5 phút
     biết chính xác dự án đang ở đâu và làm gì tiếp?
  b. Kết thúc một phiên thì ghi lại những gì để phiên sau không phải hỏi lại người dùng?
  c. Làm sao phát hiện Claude đang trôi khỏi kế hoạch (làm việc của pha sau, sửa file
     ngoài phạm vi task, báo xong mà không có biên nhận) — và dấu hiệu nào đo được?
</task>

<output_format>
Trả lời theo đúng thứ tự này, không thêm mục:

<trich_dan>
- "<trích nguyên văn>" — <file>:<mục>
</trich_dan>

DA_TAO: <mỗi file một dòng: đường dẫn — nó trả lời câu hỏi nào của dự án>

VONG_DOI_MOT_PHIEN: <MỞ / LÀM / ĐÓNG — mỗi bước là lệnh hoặc thao tác cụ thể, không phải
lời khuyên. Tối đa 12 dòng.>

CHIA_PHIEN: <bảng | Phiên | Pha | Mục tiêu | Đọc trước | Cổng ra (lệnh phải xanh) | —
tối đa 10 dòng; nói rõ phiên nào phải đứng riêng vì hỏng ra tiền>

DAU_HIEU_TROI: <3–5 dấu hiệu, mỗi dấu hiệu kèm cách đo và hành động sửa ngay>

GIA_DINH: <chỗ tài liệu bỏ ngỏ mà bạn tự chốt, kèm mức rủi ro — bỏ mục này nếu không có>

RUI_RO_LON_NHAT: <đúng 1 dòng + cách chặn>

VIEC_TIEP_THEO: <đúng 1 dòng: lệnh đầu tiên người dùng gõ sau khi đọc xong>
</output_format>

<examples>
  <example>
    <input>Viết một dòng trong quy trình mở phiên</input>
    <output>SAI: "Đọc lại tài liệu dự án để nắm tình hình."
    → Không nói file nào, không có biên nhận, mỗi phiên hiểu một kiểu.
    ĐÚNG: "Chạy `cat state.json && git log --oneline -10`; nếu `current_phase` trong
    state.json khác pha của commit gần nhất thì DỪNG, hỏi người dùng trước khi làm gì."</output>
  </example>
  <example>
    <input>Viết một dòng luật vào CLAUDE.md</input>
    <output>SAI: "Luôn viết code chất lượng cao và test đầy đủ."
    → Không kiểm chứng được, không phiên nào biết mình có vi phạm hay không.
    ĐÚNG: "Task động vào tiền chỉ được đánh XONG khi dán được output `go test ./internal/menu/`
    có đủ 11 ca giá ở §9.3, trong đó ca 'Chay + Nhiều nhân' phải LỖI."</output>
  </example>
  <example>
    <input>Viết một dấu hiệu dự án đang trôi</input>
    <output>SAI: "Claude làm sai kế hoạch."
    → Không đo được nên không ai phát hiện cho tới lúc quá muộn.
    ĐÚNG: "Diff của một phiên chạm > 3 file hoặc chạm 2 tầng (DB và FE) ⇒ task đã bị viết
    sai kích cỡ (§5.2). Đo bằng `git diff --stat` trước khi commit. Sửa: revert, chẻ dòng
    task đó thành 2 rồi làm lại."</output>
  </example>
</examples>

<self_check>
Trước khi gửi, tự rà và sửa im lặng, đừng báo cáo quá trình rà:
- Dòng nào trong sổ tay thiếu vế "lệnh nào chứng minh"? → viết lại hoặc bỏ.
- Chỗ nào bạn viết ra con số hay tên bảng mà không mở file để đối chiếu? → mở lại rồi sửa.
- CLAUDE.md có câu nào mâu thuẫn với sổ task không? → giữ một, bỏ một.
- Có mục nào của <output_format> bị thiếu hoặc bị đổi tên không?
</self_check>
</task>
```

---

## KHỐI 3 — Ba prompt nối tiếp (gửi ở các lượt sau, không gộp)

```text
Lượt 2 — kiểm thử ngược sổ tay:
Giả sử một Claude Code hoàn toàn mới mở repo này, chỉ được đọc các file bạn vừa tạo, và
được giao đúng task đầu tiên trong sổ task. Diễn lại từng bước nó sẽ làm. Chỗ nào nó phải
đoán, phải hỏi người dùng, hoặc làm sai được mà không ai biết — đó là lỗ hổng của sổ tay.
Liệt kê tối đa 5 lỗ hổng, rồi sửa file cho kín. Tối đa 25 dòng trong chat.
```

```text
Lượt 3 — chốt cổng chất lượng trước khi viết code:
Từ bảng bất biến I1–I8 (§6.2), viết ra lệnh duy nhất chạy mỗi tối sau khi đóng quán. Với
mỗi bất biến: query đối chiếu phải ra 0 dòng, hoặc đánh dấu ⚠️ nếu chưa có cơ chế bảo vệ —
không được để nó trông như đã xong. Chưa có DB nên đầu ra là file SQL + script khung,
kèm một dòng nói rõ chạy được từ pha nào trở đi.
```

```text
Lượt 4 — bắt đầu thi công:
Vào Pha 0 (BA) theo §7 và §8 của prompt-fullstack.md. Chỉ pha 0. Xong thì cập nhật
state.json và sổ task, commit với message ghi rõ pha, rồi dừng — không tự sang pha 1.
```
