# Ví dụ thực chiến: mổ xẻ và viết lại một prompt

> Bài tập đi kèm [prompt-engineering-huong-dan.md](prompt-engineering-huong-dan.md).
> Vật mẫu: chính prompt bạn đã dùng để yêu cầu tạo ra file guide đó.
> Chọn ví dụ này vì ta **biết chắc kết quả thực tế** nó tạo ra — nên phân tích không phải phỏng đoán.

---

## 1. Prompt gốc

```text
tôi muốn hiểu về best practice prompt cho llm hãy đửa ra hướng dẫn từng bước dựa trên
https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/overview.
hãy đoc kĩ web site trên và làm file hương dẫn cho tôi
```

Prompt này **đã hoạt động** — nó cho ra một file guide dùng được. Nên mục tiêu ở đây không phải chê, mà là chỉ ra chỗ nào bạn đang **may mắn** thay vì **chắc chắn**.

---

## 2. Ba điểm mạnh (giữ nguyên khi viết lại)

### 2.1 Có động từ hành động rõ ràng → Bước 9 của guide

`hãy đọc kĩ web site trên và làm file hướng dẫn` — đây là điểm mạnh nhất.

Guide nói model mới bám chữ nghĩa rất sát: `Can you suggest some changes?` sẽ chỉ nhận lại **gợi ý**, không phải thay đổi thật. Prompt của bạn dùng **"làm file"**, không phải "bạn có thể nói cho tôi về..." → model tạo file thật thay vì in ra màn hình rồi thôi.

Đối chiếu bảng trong guide:

| Nếu bạn viết | Kết quả |
|---|---|
| `giải thích cho tôi về best practice prompt` | Một bài trả lời trong chat, không có file |
| `làm file hướng dẫn cho tôi` ✅ | File thật trên đĩa |

### 2.2 Có nguồn cụ thể → chống hallucination

Bạn đưa **URL chính thức** thay vì hỏi chay "best practice prompt là gì". Điều này khớp với tinh thần mục 12.3 của guide (`<investigate_before_answering>`): bắt model **đọc nguồn trước khi nói**, thay vì lấy từ trí nhớ.

Đây là khác biệt rất lớn về chất lượng. Không có URL, model sẽ trả lời theo trí nhớ — mà trí nhớ đó có thể đã lỗi thời (ví dụ vẫn khuyên dùng prefill, trong khi prefill đã bị bỏ và gây lỗi 400).

### 2.3 Có deliverable cụ thể

"File hướng dẫn" là một vật thể kiểm chứng được — hoặc có hoặc không. Tốt hơn nhiều so với mục tiêu mơ hồ kiểu "giúp tôi giỏi prompt hơn".

### Còn lỗi chính tả thì sao?

`đửa`, `đoc kĩ`, `hương dẫn` — **không ảnh hưởng gì**. Model xử lý tốt lỗi gõ tiếng Việt. Đừng tốn thời gian lo chuyện này; hãy dồn công vào cấu trúc và độ cụ thể.

---

## 3. Sáu điểm yếu và cách sửa

### 3.1 Thiếu tiêu chí thành công → Bước 0

Prompt không định nghĩa **thế nào là một guide tốt**. Dài hay ngắn? Đủ ý hay dễ đọc? Cho người mới hay người đã biết?

Vì không có tiêu chí, model phải **tự đoán** — và bạn không có cơ sở nào để nói "bản này chưa đạt" ngoài cảm tính.

> **Sửa:** nêu tiêu chí nghiệm thu. *"Guide đạt yêu cầu khi tôi có thể mở ra, làm theo và tự viết lại một prompt của mình mà không cần đọc thêm tài liệu gốc."*

### 3.2 Thiếu lý do và người đọc → Bước 2

Guide dạy: nói **tại sao** thì model tự tổng quát hoá. Ví dụ kinh điển trong tài liệu — `NEVER use ellipses` (cụt) so với `...because the text-to-speech engine will not know how to pronounce them` (có lý do, và model tự tránh cả những ký tự khác gây khó cho TTS).

Prompt của bạn không nói bạn học để làm gì. Ba mục đích dưới đây cần ba guide **hoàn toàn khác nhau**:

| Mục đích | Guide nên nghiêng về |
|---|---|
| Viết prompt cho sản phẩm đang chạy production | System prompt, structured outputs, eval, chi phí/latency |
| Dùng Claude Code hằng ngày cho việc code | Tool use, agentic, chống over-engineering |
| Dạy lại cho team | Ví dụ nhiều, checklist, template copy-paste |

Vì không nói, model đoán và làm **cả ba** → file dài 780 dòng. Đủ ý, nhưng nếu bạn chỉ cần mục đích thứ hai thì hơn nửa file là thừa.

> **Sửa:** thêm một câu về bạn là ai và dùng để làm gì.

### 3.3 Không mô tả định dạng đầu ra → Bước 1 và Bước 7

Prompt không nói: file **tên gì**, đặt **ở đâu**, định dạng **gì** (`.md`? `.html`? PDF?), **dài bao nhiêu**, viết bằng **tiếng gì**, các prompt mẫu **dịch sang tiếng Việt hay giữ tiếng Anh**.

Riêng câu cuối là một quyết định thật sự quan trọng — prompt mẫu tiếng Anh thường chạy tốt hơn bản dịch, nên giữ nguyên văn là lựa chọn đúng. Nhưng lần vừa rồi đó là **model tự quyết**, không phải bạn quyết.

> **Sửa:** nói rõ tên file, ngôn ngữ giải thích, ngôn ngữ prompt mẫu, độ dài mong muốn.

### 3.4 Không có ví dụ về format mong muốn → Bước 3

Guide gọi ví dụ là **cách đáng tin cậy nhất** để điều khiển định dạng, giọng văn và cấu trúc, và khuyến nghị **3–5 ví dụ**.

Ở đây chỉ cần **một** ví dụ nhỏ về hình dạng một mục trong guide là đủ để khoá cấu trúc toàn file.

### 3.5 Không tách bạch các loại nội dung → Bước 4

Prompt gộp bốn thứ khác nhau vào một khối chữ liền: **mục tiêu học tập**, **nguồn tham khảo**, **chỉ dẫn quy trình** ("đọc kĩ"), **yêu cầu deliverable** ("làm file"). Với prompt ngắn thì không sao. Nhưng khi prompt dài ra hoặc bạn muốn tái sử dụng nó, việc trộn lẫn sẽ khiến model bỏ sót một trong các yêu cầu.

> **Sửa:** dùng thẻ XML (`<context>`, `<nguon>`, `<yeu_cau>`, `<dinh_dang_dau_ra>`).

### 3.6 Giả định sai về nguồn, và không có phương án dự phòng ⚠️

Đây là điểm yếu **nghiêm trọng nhất**, và nó đã thực sự xảy ra.

Prompt viết `hãy đưa ra hướng dẫn từng bước **dựa trên** [URL overview]` — ngầm giả định rằng trang overview **có sẵn một chuỗi các bước**. Thực tế trang đó chỉ có ba mục ngắn và một câu trỏ sang trang khác:

> "All prompting techniques… are covered in Prompting best practices. That's the living reference; start there."

Prompt không hề nói model phải làm gì khi nguồn không chứa thứ bạn tưởng. Model có thể chọn ba hướng:

1. Bịa ra các bước rồi gán cho trang đó → **kết quả tệ nhất**, bạn học phải thông tin sai nguồn.
2. Trả về đúng nội dung ít ỏi của trang overview → **đúng nhưng vô dụng**.
3. Lần theo link, đọc trang đích, và **nói rõ đã làm vậy** → điều thực tế đã xảy ra.

Bạn nhận được kết quả 3 — nhưng đó là **may**, không phải do prompt đảm bảo.

> **Sửa:** thêm chỉ dẫn xử lý khi nguồn thiếu. *"Nếu trang gốc trỏ sang trang khác hoặc không đủ nội dung, hãy đọc tiếp các trang được trỏ tới và ghi rõ trong file phần nào lấy từ đâu. Không suy diễn nội dung không có trong nguồn."*

---

## 4. Bản viết lại — phiên bản dùng hằng ngày

Đây là bản tôi khuyên dùng: đủ chặt để đáng tin, vẫn đủ ngắn để gõ trong 2 phút.

```text
Tôi là dev đang xây app dùng Claude API và muốn nắm best practice viết prompt.

Hãy đọc kĩ https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/overview
và MỌI trang mà nó trỏ tới (đặc biệt là trang "Prompting best practices"), rồi tạo file
prompt-guide.md trong thư mục hiện tại.

Yêu cầu về nội dung:
- Sắp xếp theo thứ tự áp dụng thực tế: bước nào làm trước, bước nào làm sau.
- Mỗi kỹ thuật gồm 3 phần: kỹ thuật này giải quyết vấn đề gì, ví dụ kém hiệu quả,
  ví dụ hiệu quả hơn.
- Ưu tiên phần liên quan tới gọi API và tool use. Phần frontend/vision chỉ cần nhắc qua.
- Kết thúc bằng một checklist tôi có thể tự soi prompt của mình.

Yêu cầu về định dạng:
- Giải thích bằng tiếng Việt, nhưng GIỮ NGUYÊN TIẾNG ANH các prompt mẫu trích từ tài liệu,
  vì tôi sẽ copy chúng vào code, và bản dịch có thể làm giảm hiệu quả.
- Độ dài khoảng 300-400 dòng. Ưu tiên ví dụ chạy được hơn là diễn giải dài dòng.

Quan trọng: chỉ viết những gì thực sự có trong tài liệu. Nếu trang gốc không chứa nội dung
tôi đang giả định là có, hãy nói thẳng ra trong file thay vì suy diễn cho khớp yêu cầu của tôi.
```

**Những gì đã thay đổi:**

| Sửa | Bước trong guide |
|---|---|
| Thêm "Tôi là dev đang xây app dùng Claude API" | Bước 2 — context và lý do |
| "MỌI trang mà nó trỏ tới" | Vá điểm yếu 3.6 |
| "Mỗi kỹ thuật gồm 3 phần..." | Bước 1 — cấu trúc output cụ thể |
| "Ưu tiên API và tool use, frontend chỉ nhắc qua" | Bước 1 — phân bổ trọng tâm |
| "Giữ nguyên tiếng Anh prompt mẫu, **vì** tôi sẽ copy vào code" | Bước 2 — nêu lý do, không chỉ ra lệnh |
| "khoảng 300-400 dòng" | Bước 7 — kiểm soát độ dài |
| Đoạn "chỉ viết những gì thực sự có trong tài liệu" | Bước 12.3 — chống hallucination |

Lưu ý câu cuối. Nó chống lại xu hướng nguy hiểm nhất khi bạn hỏi về một tài liệu: model muốn **làm bạn hài lòng** nên sẽ cố nặn nội dung cho khớp giả định trong câu hỏi của bạn. Câu đó cấp phép tường minh cho model nói "cái bạn tưởng không có ở đây".

---

## 5. Bản viết lại — phiên bản có cấu trúc XML

Dùng bản này khi bạn muốn **tái sử dụng** prompt, hoặc nhét vào code như một template có biến thay thế.

````xml
<context>
Tôi là dev đang xây sản phẩm dùng Claude API. Tôi cần một tài liệu tham chiếu nội bộ
để cả team dùng chung khi viết prompt, nên nó phải chính xác và tra cứu nhanh được.
</context>

<nguon>
Nguồn duy nhất được phép dùng:
https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/overview
và các trang con mà trang này trỏ tới.

Nếu một trang chỉ trỏ sang trang khác thay vì chứa nội dung, hãy đọc tiếp trang được trỏ tới.
Ghi rõ trong file nội dung nào lấy từ trang nào.
</nguon>

<yeu_cau>
1. Đọc toàn bộ nguồn ở trên trước khi viết bất cứ dòng nào.
2. Sắp xếp các kỹ thuật theo thứ tự áp dụng thực tế, không theo thứ tự xuất hiện trong trang.
3. Với mỗi kỹ thuật: nêu vấn đề nó giải quyết, một ví dụ kém, một ví dụ tốt.
4. Đánh dấu rõ những kỹ thuật đã lỗi thời hoặc gây lỗi API.
5. Kết thúc bằng checklist tự soi prompt.
</yeu_cau>

<dinh_dang_dau_ra>
- File markdown, tên prompt-guide.md, đặt tại thư mục hiện tại.
- Phần giải thích viết bằng tiếng Việt.
- Prompt mẫu trích từ tài liệu: giữ nguyên tiếng Anh, đặt trong code block,
  vì team sẽ copy trực tiếp vào code và bản dịch có thể làm giảm hiệu quả.
- Khoảng 300-400 dòng.
</dinh_dang_dau_ra>

<vi_du_dinh_dang_mot_muc>
## Bước N — [Tên kỹ thuật]

[1-2 câu: kỹ thuật này giải quyết vấn đề gì.]

Kém hiệu quả:
```text
[ví dụ]
```

Hiệu quả hơn:
```text
[ví dụ]
```

Vì sao khác: [1 câu].
</vi_du_dinh_dang_mot_muc>

<rang_buoc>
Chỉ viết những gì thực sự có trong nguồn. Nếu nguồn không chứa thứ mà yêu cầu của tôi
giả định là có, hãy nói thẳng điều đó trong file thay vì suy diễn cho khớp.
</rang_buoc>
````

Phần `<vi_du_dinh_dang_mot_muc>` chính là ứng dụng Bước 3: **một ví dụ về hình dạng output đáng giá hơn cả đoạn văn mô tả output**.

---

## 6. Bài học rút ra

Trình tự ưu tiên khi bạn có 5 phút để cải thiện một prompt:

1. **Nói bạn là ai và dùng kết quả để làm gì** — một câu, hiệu quả cao nhất trên mỗi ký tự bỏ ra.
2. **Mô tả hình dạng đầu ra**, hoặc tốt hơn là **đưa một ví dụ** về nó.
3. **Nói model phải làm gì khi giả định của bạn sai** — đây là thứ hầu như ai cũng quên, và là nguyên nhân số một của kết quả "nghe rất hợp lý nhưng sai".
4. Tách các loại nội dung bằng thẻ XML — chỉ cần khi prompt dài hoặc tái sử dụng.
5. Nêu tiêu chí nghiệm thu, nếu bạn định lặp lại nhiều vòng.

Điều **không** cần lo: lỗi chính tả, dấu câu, câu văn có mượt hay không.
