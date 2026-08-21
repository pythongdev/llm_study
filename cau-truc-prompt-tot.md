# Cấu trúc của một prompt tốt — mổ xẻ từng thành phần

> Bộ ba tài liệu: [prompt-engineering-huong-dan.md](prompt-engineering-huong-dan.md) (quy trình từng bước) ·
> [vi-du-phan-tich-prompt.md](vi-du-phan-tich-prompt.md) (mổ xẻ một prompt thật) ·
> **file này** (giải phẫu cấu trúc).
>
> Mỗi thành phần dưới đây trình bày theo bốn phần cố định:
> **Tên** → **Lý do tồn tại** → **Ví dụ dùng từ** → **LLM hiểu và làm gì**.

---

## Nguyên lý nền: vì sao cấu trúc lại quan trọng

LLM không "đọc yêu cầu rồi thực thi" như một chương trình. Nó **sinh văn bản tiếp theo có xác suất cao nhất, với điều kiện là toàn bộ prompt của bạn**.

Hệ quả trực tiếp, và mọi thành phần dưới đây đều bắt nguồn từ đây:

| Hiện tượng | Nguyên nhân |
|---|---|
| Prompt mơ hồ → output chung chung | Không có gì thu hẹp phân phối, model rơi về "văn bản trung bình" của loại nội dung đó |
| Prompt cụ thể → output sắc nét | Mỗi chi tiết cắt bỏ một mảng khả năng, phần còn lại đúng ý bạn hơn |
| Model bịa cho khớp giả định của bạn | Văn bản "khớp với câu hỏi" có xác suất cao hơn văn bản "phản bác câu hỏi" |
| Chỉ dẫn cuối prompt có sức nặng hơn | Nó gần nhất với vị trí model bắt đầu sinh chữ |

Nói cách khác: **bạn không ra lệnh cho model, bạn thu hẹp không gian câu trả lời**. Mỗi thành phần trong cấu trúc là một nhát cắt vào không gian đó.

---

## Bảng tổng quan 11 thành phần

| # | Thành phần | Bắt buộc? | Cắt bỏ điều gì |
|---|---|---|---|
| 1 | Vai trò và người đọc | Nên có | Sai trình độ, sai giọng văn |
| 2 | Bối cảnh và lý do | Nên có | Model tuân thủ máy móc, không tổng quát hoá |
| 3 | Nhiệm vụ (động từ hành động) | **Bắt buộc** | Nhận gợi ý thay vì kết quả |
| 4 | Tiêu chí thành công | Nên có | Không biết khi nào là xong, không có cơ sở chê |
| 5 | Dữ liệu đầu vào và vị trí | Khi có data | Bỏ sót thông tin, trả lời chung chung |
| 6 | Phạm vi và ràng buộc | Nên có | Over-engineering, làm dư |
| 7 | Định dạng đầu ra | **Bắt buộc** | Không dùng lại được kết quả |
| 8 | Ví dụ (few-shot) | Khi cần chuẩn xác | Đúng ý nhưng sai hình dạng |
| 9 | Quy trình (khi thứ tự quan trọng) | Tuỳ | Làm nhảy cóc, bỏ bước |
| 10 | Xử lý bất định | **Bắt buộc với task tra cứu** | Bịa nghe rất hợp lý |
| 11 | Tự kiểm tra | Tuỳ model | Lỗi sót không ai bắt |

---

## Thành phần 1 — Vai trò và người đọc

### Lý do tồn tại

Đây là thành phần **hiệu quả cao nhất trên mỗi ký tự bỏ ra**.

Khi không biết ai đọc, model buộc phải chọn một mức trình độ trung bình an toàn — thường ra văn phong bách khoa toàn thư trung tính: đúng, đầy đủ, và **vô dụng với mọi người cụ thể**. Nó sẽ vừa giải thích lại thứ bạn đã biết, vừa lướt qua thứ bạn cần.

Người đọc quyết định bốn thứ cùng lúc: **từ vựng**, **độ sâu**, **cái gì được phép bỏ qua**, và **cái gì phải giải thích**.

Lưu ý phân biệt hai khái niệm hay bị gộp:

- **Vai trò của LLM** ("bạn là senior backend engineer") — định hình *góc nhìn* và *chuẩn nghề nghiệp*.
- **Người đọc** ("viết cho một dev mới ra trường") — định hình *ngôn ngữ* và *độ sâu*.

Cả hai đều hữu ích, nhưng khi phải chọn một, **người đọc quan trọng hơn**.

### Ví dụ dùng từ

Mơ hồ:

```text
Giải thích về JWT
```

Rõ ràng:

```text
Giải thích JWT cho một dev backend đã làm nhiều với session-based auth nhưng chưa từng
dùng token. Họ đang phải quyết định có nên chuyển API nội bộ sang JWT không.
```

### LLM hiểu và làm gì

Bóc từng cụm để thấy mỗi chữ cắt đi cái gì:

| Cụm từ trong prompt | Model suy ra và thay đổi hành vi |
|---|---|
| `dev backend` | Bỏ phần giải thích HTTP là gì, client-server là gì. Được phép dùng thuật ngữ nghề. |
| `đã làm nhiều với session-based` | **Dùng session làm mốc so sánh** — "khác với session ở chỗ server không cần lưu state". Đây là điều model không thể tự nghĩ ra nếu bạn không nói. |
| `chưa từng dùng token` | Phải định nghĩa claim, signature, expiry — không giả định biết sẵn. |
| `đang phải quyết định` | **Đổi thể loại output**: từ bài mô tả sang bài phân tích đánh đổi, có khuyến nghị. |

Cụm thứ hai là ví dụ điển hình cho việc **thông tin về người đọc mở khoá những cấu trúc trả lời mà model không tự tạo ra được**. Không ai nói cho model biết bạn quen session — nên nếu bạn im lặng, bạn mất luôn cách giải thích tốt nhất dành cho mình.

---

## Thành phần 2 — Bối cảnh và lý do

### Lý do tồn tại

Đây là thành phần bị bỏ qua nhiều nhất, và là thứ tạo khác biệt lớn nhất giữa prompt của người mới và người có kinh nghiệm.

Một **mệnh lệnh trần** là một luật cứng: nó chỉ áp dụng đúng vào trường hợp bạn nêu tên, và **im lặng ở mọi trường hợp bạn quên nêu**.

Một **mệnh lệnh kèm lý do** biến thành mục tiêu: model có thể tự suy ra hàng loạt trường hợp bạn chưa nghĩ tới.

Tài liệu Anthropic gọi thẳng đây là điểm mạnh: *"Claude is smart enough to generalize from the explanation."*

### Ví dụ dùng từ

Kém hiệu quả — luật cứng:

```text
NEVER use ellipses
```

Hiệu quả hơn — luật kèm lý do:

```text
Your response will be read aloud by a text-to-speech engine, so never use ellipses since
the text-to-speech engine will not know how to pronounce them.
```

### LLM hiểu và làm gì

Bản thứ nhất: model chặn đúng ký tự `...`. Hết. Nó vẫn thoải mái xuất ra bảng markdown, emoji, ký hiệu toán, viết tắt kiểu `v.v.` — tất cả đều làm hỏng đầu ra TTS y hệt.

Bản thứ hai: model nhận được **hàm mục tiêu "văn bản này sẽ bị đọc thành tiếng"**. Từ đó nó tự suy:

- Bảng biểu → đọc lên thành mớ vô nghĩa → tự chuyển thành câu văn.
- `e.g.`, `v.v.`, `%` → viết thành chữ đầy đủ.
- Câu quá dài nhiều mệnh đề lồng → tự cắt ngắn cho dễ nghe.

**Bạn viết một câu, nhận về hàng chục quy tắc bạn chưa từng viết.** Đó là toàn bộ giá trị của thành phần này.

Một ví dụ khác từ chính công việc của chúng ta:

```text
Giữ nguyên tiếng Anh các prompt mẫu, VÌ tôi sẽ copy trực tiếp vào code và bản dịch
có thể làm giảm hiệu quả.
```

Chữ **"vì"** khiến model áp dụng đúng nguyên tắc đó cho cả những thứ bạn không liệt kê: tên tham số API, thông báo lỗi, tên thẻ XML — tất cả đều "sẽ được copy vào code", nên đều được giữ nguyên.

---

## Thành phần 3 — Nhiệm vụ, diễn đạt bằng động từ hành động

### Lý do tồn tại

Các model mới được huấn luyện để **bám sát nghĩa đen** của câu lệnh. Tài liệu nói rõ: nếu bạn hỏi *"can you suggest some changes"*, model sẽ **chỉ gợi ý**, kể cả khi ý bạn thật sự là muốn nó sửa.

Đây không phải model kém hiểu ý. Đây là model **tôn trọng đúng câu bạn viết**. Một câu hỏi dạng "có thể... không?" về mặt ngôn ngữ là một câu hỏi, và câu trả lời đúng cho câu hỏi là **thông tin**, không phải **hành động**.

### Ví dụ dùng từ

| Diễn đạt | Model sẽ làm gì |
|---|---|
| `Bạn xem giúp function này có vấn đề gì không?` | Liệt kê vấn đề. Không sửa. |
| `Bạn nghĩ sao về cách đặt tên biến ở đây?` | Nêu nhận xét. Không đổi tên. |
| `Có nên tách file này ra không?` | Phân tích nên/không nên. Không tách. |
| `Sửa function này để nó xử lý được input rỗng.` ✅ | Sửa thật. |
| `Tách file này thành hai module theo trách nhiệm.` ✅ | Tách thật. |

Ba dòng đầu **không sai** — chúng đúng khi bạn thật sự chỉ muốn tham khảo. Vấn đề chỉ phát sinh khi bạn muốn kết quả nhưng lại gõ theo thói quen lịch sự.

### LLM hiểu và làm gì

Cơ chế: model phân loại thể loại câu trước khi quyết định hành động.

- Câu hỏi dạng có/không → sinh ra một **câu trả lời**.
- Câu mệnh lệnh có tân ngữ cụ thể → kích hoạt **tool call** (đọc file, sửa file, chạy lệnh).

Nếu bạn muốn model **chủ động hành động theo mặc định** mà không phải canh chừng cách diễn đạt từng câu, tài liệu cho sẵn đoạn dán vào system prompt:

```text
<default_to_action>
By default, implement changes rather than only suggesting them. If the user's intent is
unclear, infer the most useful likely action and proceed, using tools to discover any
missing details instead of guessing.
</default_to_action>
```

Và chiều ngược lại, khi bạn muốn model **dừng lại hỏi trước khi động vào file**:

```text
<do_not_act_before_instructions>
Do not jump into implementation or change files unless clearly instructed to make
changes. When the user's intent is ambiguous, default to providing information, doing
research, and providing recommendations rather than taking action.
</do_not_act_before_instructions>
```

---

## Thành phần 4 — Tiêu chí thành công

### Lý do tồn tại

Không có tiêu chí, model vẫn phải tự đặt ra một tiêu chí ngầm để biết khi nào dừng. Tiêu chí ngầm mà nó hay chọn là **"trông có vẻ đầy đủ"** — dẫn thẳng tới hai bệnh:

- Output dài, phủ mọi khía cạnh, nhưng loãng ở đúng chỗ bạn cần.
- Bạn không có cơ sở nào để nói "bản này chưa đạt" ngoài cảm tính, nên vòng lặp sửa chữa rất tốn công.

Tiêu chí thành công còn là **điều kiện tiên quyết** mà tài liệu Anthropic nêu ngay đầu trang overview: phải có tiêu chí và cách đo **trước khi** bắt đầu tinh chỉnh prompt.

### Ví dụ dùng từ

Không tiêu chí:

```text
Viết unit test cho module thanh toán.
```

Có tiêu chí:

```text
Viết unit test cho module thanh toán.

Đạt yêu cầu khi:
- Mọi nhánh raise exception đều có test riêng.
- Chạy được bằng `pytest -q` mà không cần service ngoài nào đang chạy.
- Không mock các hàm thuộc chính module này, chỉ mock cổng ra ngoài (HTTP, DB).
- Mỗi test fail với một thông báo nói rõ hành vi nào bị vi phạm.
```

### LLM hiểu và làm gì

Ba thay đổi cụ thể xảy ra:

1. **Model tự đối chiếu trước khi kết thúc.** Tiêu chí trở thành một danh sách nó rà lại. Với model bật thinking, việc rà này diễn ra trong phần suy luận — bạn thường thấy nó tự phát hiện "còn nhánh timeout chưa có test" rồi quay lại bổ sung.

2. **Model biết dừng đúng chỗ.** Dòng "không mock hàm nội bộ" ngăn nó viết thêm 20 test giả lập vô nghĩa cho đủ số lượng.

3. **Bạn có ngôn ngữ chung để phản hồi.** Thay vì "test này chưa ổn lắm" (model chỉ có thể đoán), bạn nói "tiêu chí 3 chưa đạt" — và nó sửa đúng chỗ ngay vòng đầu.

Điểm mấu chốt: tiêu chí phải **kiểm chứng được**. So sánh:

| Tiêu chí yếu | Tiêu chí mạnh |
|---|---|
| "Test phải chất lượng cao" | "Mọi nhánh raise exception có test riêng" |
| "Guide phải dễ hiểu" | "Tôi đọc xong tự viết lại được một prompt của mình mà không cần mở tài liệu gốc" |
| "Code phải sạch" | "Không hàm nào dài quá 40 dòng, không tham số nào là dict không có schema" |

Cột trái model không kiểm tra được nên nó bỏ qua. Cột phải model kiểm tra được nên nó thực sự dùng.

---

## Thành phần 5 — Dữ liệu đầu vào và vị trí đặt nó

### Lý do tồn tại

Khi prompt có dữ liệu dài (tài liệu, log, code, transcript), **vị trí đặt dữ liệu ảnh hưởng tới chất lượng nhiều hơn người ta tưởng**.

Tài liệu Anthropic nêu con số cụ thể: với đầu vào từ 20k token trở lên, đặt **dữ liệu ở trên, câu hỏi ở dưới** có thể cải thiện chất lượng **tới khoảng 30%** trong các bài test, đặc biệt với đầu vào nhiều tài liệu phức tạp.

Lý do: chỉ dẫn nằm cuối prompt là thứ **gần nhất** với vị trí model bắt đầu sinh chữ, nên nó chi phối mạnh nhất. Nếu bạn đặt câu hỏi ở đầu rồi dán 30 nghìn token tài liệu phía sau, câu hỏi bị đẩy ra xa và dễ bị pha loãng.

### Ví dụ dùng từ

Bố cục sai — câu hỏi bị chôn ở đầu:

```text
Tóm tắt rủi ro pháp lý trong hợp đồng dưới đây:

[30.000 token hợp đồng]
```

Bố cục đúng — dữ liệu trên, chỉ dẫn dưới, có thẻ XML, có bước trích dẫn:

```xml
<documents>
  <document index="1">
    <source>hop_dong_dich_vu_2026.pdf</source>
    <document_content>
      {{HOP_DONG}}
    </document_content>
  </document>
  <document index="2">
    <source>phu_luc_bao_mat.pdf</source>
    <document_content>
      {{PHU_LUC}}
    </document_content>
  </document>
</documents>

Trước tiên, trích các điều khoản liên quan tới trách nhiệm bồi thường, chấm dứt hợp đồng
và bảo mật dữ liệu. Đặt chúng trong thẻ <quotes>, mỗi trích dẫn ghi rõ nguồn và số điều.

Sau đó, dựa TRÊN các trích dẫn đó, liệt kê rủi ro pháp lý cho bên mua dịch vụ.
Đặt phần này trong thẻ <rui_ro>.
```

### LLM hiểu và làm gì

Ba kỹ thuật đang chồng lên nhau trong ví dụ trên:

**1. Dữ liệu ở trên, chỉ dẫn ở dưới.** Khi model bắt đầu sinh chữ, chỉ dẫn là thứ vừa đọc xong.

**2. Thẻ XML tách bạch dữ liệu với chỉ dẫn.** Không có thẻ, một câu trong hợp đồng kiểu *"Bên A phải liệt kê toàn bộ rủi ro..."* có thể bị model hiểu nhầm là chỉ dẫn dành cho nó. Thẻ `<document_content>` nói rõ: **đây là dữ liệu để đọc, không phải lệnh để tuân theo**. Đây cũng là hàng phòng thủ cơ bản trước prompt injection khi bạn xử lý nội dung do người khác cung cấp.

**3. Bắt trích dẫn trước, kết luận sau.** Đây là kỹ thuật mạnh nhất trong ba cái, và cơ chế rất trực tiếp:

- Không có bước này, model kết luận dựa trên **ấn tượng tổng thể** về tài liệu — nơi chi tiết dễ bị trộn lẫn và bịa ra.
- Có bước này, các trích dẫn được **viết ra thành chữ trong context**. Phần kết luận sau đó được sinh ra với các trích dẫn đó ở ngay trước mặt, nên nó bám vào văn bản thật thay vì ký ức mờ.

Lợi ích phụ rất lớn: **bạn kiểm tra được**. Nếu model bịa, phần `<quotes>` sẽ chứa câu không có trong hợp đồng — bạn Ctrl+F là ra ngay. Không có bước này, việc soi lỗi bịa đặt tốn công gấp nhiều lần.

---

## Thành phần 6 — Phạm vi và ràng buộc

### Lý do tồn tại

Model mặc định hiểu **"làm tốt" = "làm nhiều"**. Tài liệu Anthropic gọi tên bệnh này là *overeagerness*: tự thêm file, tự thêm lớp trừu tượng, tự thêm cấu hình cho những nhu cầu chưa ai yêu cầu.

Bạn nhờ sửa một bug, nhận về một PR đổi 14 file kèm refactor "tiện thể". Về mặt kỹ thuật model không sai — nó đang tối đa hoá thứ nó đoán là "giá trị". Ràng buộc phạm vi là cách bạn **định nghĩa lại "giá trị" thành "đúng việc được giao"**.

### Ví dụ dùng từ

Không ràng buộc:

```text
Sửa lỗi tính sai tiền ship khi đơn hàng có nhiều kho.
```

Có ràng buộc:

```text
Sửa lỗi tính sai tiền ship khi đơn hàng có nhiều kho.

Trong phạm vi: file shipping_calculator.py và test tương ứng.
Ngoài phạm vi: không refactor code xung quanh, không đổi signature của hàm public,
không thêm type annotation cho phần bạn không sửa, không tạo file helper mới.

Nếu bạn thấy một vấn đề khác đáng sửa, hãy liệt kê ở cuối thay vì tự sửa.
```

### LLM hiểu và làm gì

Câu cuối là chi tiết quan trọng nhất và hay bị bỏ sót. Nó **mở một van xả**.

Không có van xả, model rơi vào thế kẹt: nó nhìn thấy một bug thật ở dòng bên cạnh, nhưng bị cấm sửa. Hai lối thoát của nó đều tệ — hoặc lờ đi (bạn mất thông tin), hoặc lén sửa (bạn mất kiểm soát phạm vi).

Câu *"hãy liệt kê ở cuối thay vì tự sửa"* cho nó lối thoát thứ ba: **báo cáo mà không hành động**. Bạn giữ được cả phạm vi hẹp lẫn thông tin.

Khi cần một bản ràng buộc mạnh và dùng lại được nhiều lần, tài liệu có sẵn đoạn chống over-engineering — trích phần cốt lõi:

```text
- Scope: Don't add features, refactor code, or make "improvements" beyond what was
asked. A bug fix doesn't need surrounding code cleaned up.

- Defensive coding: Don't add error handling, fallbacks, or validation for scenarios
that can't happen. Only validate at system boundaries (user input, external APIs).

- Abstractions: Don't create helpers, utilities, or abstractions for one-time
operations. The right amount of complexity is the minimum needed for the current task.
```

---

## Thành phần 7 — Định dạng đầu ra

### Lý do tồn tại

Output đúng nội dung nhưng sai hình dạng thì thường **không dùng được**: bạn cần JSON để parse mà nhận về văn xuôi, cần một đoạn ngắn dán vào Slack mà nhận về báo cáo ba trang.

Nguyên tắc quan trọng nhất, và trái trực giác nhất: **nói cái NÊN làm, đừng nói cái KHÔNG NÊN làm**.

### Ví dụ dùng từ

| Cách viết | Vấn đề |
|---|---|
| `Đừng dùng markdown` ❌ | Model biết cần tránh gì, nhưng **không biết cần hướng tới cái gì** |
| `Viết thành các đoạn văn xuôi liền mạch` ✅ | Có đích để hướng tới |
| `Đừng trả lời dài dòng` ❌ | "Dài" là bao nhiêu? |
| `Trả lời trong tối đa 3 câu` ✅ | Đo được |

Bốn mức kiểm soát, từ lỏng tới chặt:

**Mức 1 — mô tả bằng lời:**
```text
Trả lời bằng 2-3 đoạn văn xuôi, không bullet, không heading.
```

**Mức 2 — chỉ báo bằng thẻ XML:**
```text
Đặt phần phân tích trong thẻ <phan_tich>, phần khuyến nghị trong thẻ <khuyen_nghi>.
```

**Mức 3 — schema tường minh:**
```text
Trả về đúng JSON theo schema sau, không kèm chữ nào khác:
{"category": "<một trong: bug|feature|question>", "priority": 1-5, "reason": "<tối đa 20 từ>"}
```

**Mức 4 — Structured Outputs của API**, khi bạn cần đảm bảo ở mức hệ thống chứ không phải mức thuyết phục.

### LLM hiểu và làm gì

Với `Đừng dùng markdown`: để tuân thủ, model phải liên tục nghĩ về markdown trong lúc viết. Nó biết vùng cấm nhưng không biết vùng đích, nên hay trôi về thói quen cũ ở đoạn sau — bạn sẽ thấy nó ngoan ba đoạn đầu rồi tự nhiên xuất hiện một danh sách gạch đầu dòng.

Với `Viết thành các đoạn văn xuôi liền mạch`: model có một **hình mẫu tích cực** để bám. Việc sinh chữ hướng thẳng về hình mẫu đó, không có vùng cấm nào để trôi vào.

Còn hai cơ chế nữa đáng biết:

**Prompt của bạn là ví dụ ngầm về output.** Tài liệu nói rõ: văn phong prompt ảnh hưởng văn phong trả lời, và **bỏ markdown khỏi prompt sẽ giảm lượng markdown trong output**. Nếu bạn viết prompt toàn bullet rồi yêu cầu "trả lời bằng văn xuôi", bạn đang ra hai tín hiệu trái ngược — và ví dụ ngầm thường thắng lời mô tả.

**Thẻ XML tạo ranh giới cứng.** Khi model đã mở `<khuyen_nghi>`, nó ở trong một "chế độ" cho tới khi đóng thẻ. Điều này giữ cấu trúc ổn định hơn nhiều so với chỉ mô tả bằng lời, và giúp bạn **cắt phần cần dùng bằng regex** thay vì parse cả câu trả lời.

---

## Thành phần 8 — Ví dụ (few-shot)

### Lý do tồn tại

Tài liệu gọi ví dụ là **cách đáng tin cậy nhất** để điều khiển định dạng, giọng văn và cấu trúc. Lý do đơn giản: **một ví dụ là bằng chứng, một lời mô tả chỉ là ý định**. Khi mô tả và ví dụ mâu thuẫn nhau, model gần như luôn theo ví dụ.

Khuyến nghị của tài liệu: **3–5 ví dụ**, thoả ba tính chất — **relevant** (sát use case thật), **diverse** (phủ edge case, đủ khác nhau để model không học nhầm pattern phụ), **structured** (bọc trong thẻ `<example>`).

### Ví dụ dùng từ

**Bộ ví dụ TỆ** — cả ba đều cùng một dạng:

```xml
<examples>
  <example><input>Giao hàng chậm quá!</input><output>{"loai":"van_chuyen","cam_xuc":"tieu_cuc"}</output></example>
  <example><input>Ship lâu kinh khủng</input><output>{"loai":"van_chuyen","cam_xuc":"tieu_cuc"}</output></example>
  <example><input>3 ngày rồi chưa thấy hàng</input><output>{"loai":"van_chuyen","cam_xuc":"tieu_cuc"}</output></example>
</examples>
```

**Bộ ví dụ TỐT** — đa dạng nhãn, có edge case, có trường hợp không xác định:

```xml
<examples>
  <example>
    <input>Giao hàng chậm 3 ngày, tôi rất bực</input>
    <output>{"loai":"van_chuyen","cam_xuc":"tieu_cuc","do_tin_cay":"cao"}</output>
  </example>
  <example>
    <input>Shop có ship COD không ạ?</input>
    <output>{"loai":"hoi_truoc_mua","cam_xuc":"trung_tinh","do_tin_cay":"cao"}</output>
  </example>
  <example>
    <input>Hàng đẹp lắm nhưng ship hơi lâu</input>
    <output>{"loai":"van_chuyen","cam_xuc":"lan_lon","do_tin_cay":"trung_binh"}</output>
  </example>
  <example>
    <input>ok</input>
    <output>{"loai":"khong_xac_dinh","cam_xuc":"trung_tinh","do_tin_cay":"thap"}</output>
  </example>
</examples>
```

### LLM hiểu và làm gì

Với bộ TỆ, model học được đúng thứ bạn dạy — mà bạn lại dạy nhầm. Cụ thể nó suy ra ba luật ngầm:

1. "Mọi ticket đều thuộc loại `van_chuyen`" → ticket hỏi về bảo hành cũng bị gán nhãn vận chuyển.
2. "Mọi ticket đều tiêu cực" → lời khen cũng bị chấm tiêu cực.
3. "Input luôn ngắn và luôn phân loại được" → gặp input mơ hồ, nó **vẫn cố chọn một nhãn** thay vì thừa nhận không rõ.

Đây là bẫy nguy hiểm nhất của few-shot: **model học cả những pattern bạn vô tình tạo ra**. Bạn không hề viết luật nào ở trên, nhưng ba ví dụ giống nhau đã ngầm dạy chúng.

Với bộ TỐT, mỗi ví dụ làm một nhiệm vụ khác nhau:

| Ví dụ | Dạy điều gì |
|---|---|
| Giao hàng chậm | Ca cơ bản, thiết lập format |
| Ship COD | **Tồn tại nhãn khác ngoài `van_chuyen`**, và tồn tại cảm xúc trung tính |
| Đẹp nhưng ship lâu | Ca hỗn hợp — dạy cách xử lý khi hai tín hiệu ngược nhau |
| `ok` | **Cho phép trả lời "không xác định"** |

Ví dụ cuối cùng đáng giá nhất. Nếu thiếu nó, model sẽ ép mọi input vào một nhãn cụ thể, kể cả khi dữ liệu không đủ — vì trong toàn bộ bằng chứng bạn đưa, **chưa từng có lần nào việc thừa nhận không biết là hợp lệ**.

Trường `do_tin_cay` đóng vai trò tương tự ở mức nhẹ hơn: nó cho model một chỗ để bày tỏ sự lưỡng lự, thay vì buộc phải giả vờ chắc chắn.

> **Mẹo:** bạn có thể nhờ chính model rà bộ ví dụ của mình — *"Bộ ví dụ này có pattern ngầm nào ngoài ý muốn không? Sinh thêm 2 ví dụ phủ những ca còn thiếu."*

---

## Thành phần 9 — Quy trình, khi thứ tự thực sự quan trọng

### Lý do tồn tại

Có một ranh giới tinh tế mà tài liệu Anthropic nêu rõ, và rất nhiều người làm ngược:

> **Kê rõ quy trình BÊN NGOÀI.** Thứ tự các hành động có thể quan sát được: đọc file nào trước, chạy lệnh gì, xuất ra theo trình tự nào.
>
> **ĐỪNG kê cách suy nghĩ BÊN TRONG.** Tài liệu ghi: *"Prefer general instructions over prescriptive steps"* — một câu như "think thoroughly" thường cho suy luận tốt hơn một kế hoạch từng bước do người viết tay, vì khả năng suy luận của model thường vượt cái con người kê ra.

Nói gọn: **hãy quy định model làm gì, đừng quy định model nghĩ thế nào.**

### Ví dụ dùng từ

Quy trình ngoài — **nên** kê rõ:

```text
Theo đúng thứ tự sau:
1. Chạy `pytest -q` và ghi lại các test đang fail.
2. Đọc các file liên quan tới test fail. Không sửa gì ở bước này.
3. Trình bày chẩn đoán nguyên nhân, rồi dừng lại chờ tôi xác nhận.
4. Chỉ sau khi tôi xác nhận mới bắt đầu sửa.
```

Cách suy nghĩ — **không nên** kê:

```text
❌ Để phân tích bug, trước hết hãy liệt kê mọi biến trong hàm, sau đó vẽ bảng giá trị
   từng biến qua từng vòng lặp, sau đó so sánh với kết quả mong đợi, sau đó...
```

Thay bằng:

```text
✅ Hãy phân tích kỹ nguyên nhân gốc trước khi đề xuất sửa.
```

### LLM hiểu và làm gì

Ở ví dụ quy trình ngoài, bước 2 và 3 là phần có giá trị nhất. `Không sửa gì ở bước này` và `dừng lại chờ tôi xác nhận` chèn một **điểm kiểm soát** vào giữa. Không có nó, model thường nhảy thẳng từ "thấy test fail" sang "sửa code" — và nếu chẩn đoán sai, bạn phát hiện ra sau khi nó đã đổi 8 file.

Ở ví dụ cách suy nghĩ, việc kê từng bước lại **làm hại**: nó nhốt model vào một lối phân tích cụ thể, kể cả khi bug thực ra nằm ở chỗ hoàn toàn khác (ví dụ ở config hoặc thứ tự import, nơi "bảng giá trị từng biến" hoàn toàn vô dụng). Model sẽ cắm cúi làm theo quy trình bạn kê thay vì đi hướng đúng.

Một lưu ý nhỏ nhưng đáng nhớ: khi **tắt** thinking, Claude Opus 4.5 khá nhạy với từ "think" và biến thể của nó. Trong trường hợp đó tài liệu khuyên dùng "consider", "evaluate", "reason through" thay thế.

---

## Thành phần 10 — Xử lý bất định

### Lý do tồn tại

Đây là thành phần **quan trọng nhất mà hầu như không ai viết**, và là nguyên nhân số một của loại lỗi khó chịu nhất: câu trả lời **nghe cực kỳ hợp lý nhưng sai**.

Cơ chế gây lỗi rất trực tiếp. Model sinh văn bản có xác suất cao, và:

- Văn bản **khớp với giả định trong câu hỏi của bạn** có xác suất cao.
- Văn bản **phản bác giả định của bạn** có xác suất thấp hơn nhiều.

Nên khi bạn hỏi *"tóm tắt các bước trong tài liệu X"* mà tài liệu X **không có** các bước nào cả, đường đi dễ nhất với model là **nặn ra vài bước nghe hợp lý**. Nó không "nói dối" — nó đang đi theo lối mòn xác suất mà chính câu hỏi của bạn đã tạo ra.

Thành phần này tồn tại để **cấp phép tường minh cho câu trả lời "không đủ dữ kiện"**, vốn là câu trả lời có xác suất thấp theo mặc định.

### Ví dụ dùng từ

Ba biến thể cho ba tình huống:

**Khi làm việc với tài liệu / nguồn ngoài:**
```text
Chỉ kết luận dựa trên nội dung thực sự có trong tài liệu. Nếu tài liệu không chứa thông
tin cần thiết, hãy nói rõ thiếu gì thay vì suy đoán. Nếu tài liệu chỉ trỏ sang nguồn
khác thay vì chứa nội dung, hãy nói điều đó ra.
```

**Khi làm việc với codebase:**
```text
Không phỏng đoán về code bạn chưa mở. Nếu tôi nhắc tới một file cụ thể, hãy đọc file đó
trước khi trả lời. Nếu điều tôi mô tả không khớp với code thực tế, hãy nói ra sự khác
biệt thay vì trả lời theo mô tả của tôi.
```

**Khi yêu cầu có thể mâu thuẫn:**
```text
Nếu hai yêu cầu của tôi mâu thuẫn nhau, hãy chỉ ra mâu thuẫn và hỏi trước khi làm,
thay vì tự chọn một bên.
```

### LLM hiểu và làm gì

Ba thay đổi:

1. **"Không biết" trở thành nước đi hợp lệ.** Trước đó nó là nước đi tệ (không đáp ứng câu hỏi); sau đó nó là nước đi **đúng theo chỉ dẫn**.

2. **Mâu thuẫn với giả định của bạn trở thành hành vi được thưởng.** Câu *"nếu điều tôi mô tả không khớp với code thực tế, hãy nói ra"* đảo ngược áp lực làm hài lòng — giờ việc phản bác bạn chính là tuân thủ bạn.

3. **Thứ tự hành động đổi.** `hãy đọc file đó trước khi trả lời` buộc model gọi tool đọc file trước, thay vì trả lời từ suy đoán về tên file.

Bản đầy đủ trong tài liệu Anthropic, dùng cho system prompt:

```text
<investigate_before_answering>
Never speculate about code you have not opened. If the user references a specific file,
you MUST read the file before answering. Make sure to investigate and read relevant
files BEFORE answering questions about the codebase. Never make any claims about code
before investigating unless you are certain of the correct answer - give grounded and
hallucination-free answers.
</investigate_before_answering>
```

> **Đây chính là lỗi đã xảy ra thật** trong prompt đầu tiên của bạn, phân tích chi tiết ở mục 3.6 của [vi-du-phan-tich-prompt.md](vi-du-phan-tich-prompt.md): prompt giả định trang overview có sẵn danh sách các bước, thực tế thì không, và prompt không hề nói phải làm gì trong tình huống đó.

---

## Thành phần 11 — Tự kiểm tra

### Lý do tồn tại

Một câu ngắn ở cuối prompt bắt model rà lại kết quả trước khi kết thúc. Tài liệu ghi nhận kỹ thuật này **bắt lỗi rất hiệu quả, đặc biệt với code và toán**.

### Ví dụ dùng từ

```text
Trước khi kết thúc, hãy tự kiểm tra kết quả theo các tiêu chí ở trên và nêu rõ tiêu chí
nào chưa đạt, nếu có.
```

### LLM hiểu và làm gì

Model sinh chữ tuần tự, nên đoạn đầu được viết khi nó chưa nhìn thấy đoạn cuối. Câu tự kiểm tra tạo ra một lượt đọc lại **toàn bộ output đã hoàn chỉnh** — lúc này các mâu thuẫn nội tại mới lộ ra.

Cụm `và nêu rõ tiêu chí nào chưa đạt` quan trọng: không có nó, model hay kết thúc bằng một câu tự khen vô nghĩa ("Đã hoàn thành đầy đủ các yêu cầu!"). Có nó, việc tự kiểm tra buộc phải cho ra kết quả cụ thể.

### ⚠️ Ngoại lệ quan trọng: Claude Opus 5

Tài liệu nói rõ Opus 5 **tự verify tốt sẵn**, và các câu lệnh verify mang từ prompt cũ sang sẽ gây **over-verification** — tốn token và latency vô ích.

Khuyến nghị chính thức: khi migrate sang Opus 5, hãy **xoá** những câu này, **đừng viết lại chúng**.

---

## Thứ tự lắp ráp và template đầy đủ

Thứ tự dưới đây không tuỳ tiện. Nguyên tắc: **thông tin ổn định ở trên, dữ liệu lớn ở giữa, chỉ dẫn hành động ở dưới cùng** — vì phần cuối gần nhất với chỗ model bắt đầu sinh chữ.

```
┌─ SYSTEM PROMPT (phần bất biến, đúng cho mọi request) ────────┐
│  1. Vai trò và người đọc                                     │
│  2. Bối cảnh và lý do                                        │
│  6. Phạm vi và ràng buộc                                     │
│  7. Định dạng đầu ra                                         │
│  8. Ví dụ                                                    │
│ 10. Xử lý bất định                                           │
└──────────────────────────────────────────────────────────────┘
┌─ USER MESSAGE (phần thay đổi theo từng lần) ─────────────────┐
│  5. Dữ liệu đầu vào          ← ĐẶT TRÊN CÙNG nếu dài         │
│  3. Nhiệm vụ (động từ hành động)                             │
│  9. Quy trình, nếu thứ tự quan trọng                         │
│  4. Tiêu chí thành công                                      │
│ 11. Tự kiểm tra              ← ĐẶT CUỐI CÙNG                 │
└──────────────────────────────────────────────────────────────┘
```

Template dán vào dùng ngay:

````xml
<!-- ========== SYSTEM ========== -->
<vai_tro>
Bạn là [vai trò]. Người đọc kết quả là [ai, biết gì rồi, chưa biết gì].
</vai_tro>

<boi_canh>
[Kết quả này dùng vào việc gì, đi đâu sau đó. Nêu LÝ DO cho các ràng buộc quan trọng
 — model sẽ tự suy ra những trường hợp bạn chưa liệt kê.]
</boi_canh>

<pham_vi>
Trong phạm vi: [...]
Ngoài phạm vi: [...]
Nếu thấy vấn đề ngoài phạm vi, hãy liệt kê ở cuối thay vì tự xử lý.
</pham_vi>

<dinh_dang>
[Mô tả cái NÊN làm, không mô tả cái KHÔNG NÊN làm. Nêu độ dài đo được.]
</dinh_dang>

<examples>
  <example><input>[ca cơ bản]</input><output>[...]</output></example>
  <example><input>[ca biên]</input><output>[...]</output></example>
  <example><input>[ca không xác định]</input><output>[...]</output></example>
</examples>

<xu_ly_bat_dinh>
Chỉ kết luận dựa trên dữ kiện thực sự có. Nếu thiếu, hãy nói rõ thiếu gì thay vì suy đoán.
Nếu điều tôi mô tả không khớp thực tế, hãy nói ra sự khác biệt.
</xu_ly_bat_dinh>

<!-- ========== USER ========== -->
<du_lieu>
[Dữ liệu dài đặt ở đây, TRÊN phần nhiệm vụ]
</du_lieu>

<nhiem_vu>
[Động từ hành động + tân ngữ cụ thể]
</nhiem_vu>

<tieu_chi_thanh_cong>
Đạt yêu cầu khi:
- [tiêu chí kiểm chứng được]
- [tiêu chí kiểm chứng được]
</tieu_chi_thanh_cong>

Trước khi kết thúc, tự kiểm tra theo các tiêu chí trên và nêu rõ tiêu chí nào chưa đạt.
````

---

## Bỏ bớt thành phần nào cho từng loại việc

Đừng dùng cả 11 thành phần cho mọi thứ. Prompt hỏi nhanh mà dài 40 dòng thì bạn đang lãng phí thời gian của chính mình.

| Loại việc | Thành phần tối thiểu |
|---|---|
| Hỏi nhanh trong chat | 1 (người đọc) + 3 (động từ) |
| Nhờ sửa code | 3 + 6 (phạm vi) + 10 (bất định) |
| Đọc tài liệu / nghiên cứu | 5 (dữ liệu + trích dẫn) + 10 (bất định) + 4 (tiêu chí) |
| Phân loại / trích xuất hàng loạt | 7 (schema) + 8 (ví dụ) + 10 |
| Task agentic chạy dài | 4 + 6 + 9 (quy trình) + 10 + 11 |
| Prompt production dùng lại nhiều lần | Cả 11 |

---

## Ví dụ tổng hợp: từ prompt tồi tới prompt tốt

### Bản gốc

```text
Phân tích log lỗi này giúp mình
```

Ba vấn đề: model không biết **bạn là ai**, không biết **thế nào là phân tích xong**, và không biết **phải làm gì khi log không đủ dữ kiện** — nên nó sẽ đưa ra một danh sách "các nguyên nhân có thể" chung chung, phần lớn không liên quan.

### Bản viết lại, chú thích từng dòng

```text
Tôi là dev đang trực sự cố production, cần khoanh vùng nguyên nhân trong 15 phút tới.     ← TP1: người đọc + áp lực thời gian
Kết quả này tôi sẽ dán thẳng vào kênh incident cho team đọc, nên cần ngắn và dứt khoát.    ← TP2: lý do → model tự chọn giọng văn

<log>
[dán log ở đây]                                                                            ← TP5: dữ liệu đặt TRÊN nhiệm vụ
</log>

Khoanh vùng nguyên nhân gốc của sự cố trong log trên.                                      ← TP3: động từ hành động

Cách làm:
1. Trích các dòng log thực sự liên quan, đặt trong thẻ <bang_chung>.                        ← TP9 + neo vào trích dẫn
2. Từ các dòng đó, nêu nguyên nhân khả dĩ nhất và mức độ tin cậy.
3. Nêu bước kiểm chứng tiếp theo tôi nên làm ngay.

Đạt yêu cầu khi: mỗi kết luận đều chỉ được tới một dòng log cụ thể,                         ← TP4: tiêu chí kiểm chứng được
và bước kiểm chứng có thể thực hiện trong dưới 5 phút.

Định dạng: tối đa 150 từ, văn xuôi, không bullet lồng nhau.                                 ← TP7: đo được, nói cái NÊN làm

Nếu log không đủ để kết luận, hãy nói rõ cần thêm log gì,                                   ← TP10: xử lý bất định
thay vì liệt kê các nguyên nhân chung chung.
```

### Vì sao bản này chạy tốt hơn

| Dòng thêm vào | Loại bỏ được hành vi xấu nào |
|---|---|
| `đang trực sự cố, 15 phút` | Bài giảng dài về best practice logging |
| `dán vào kênh incident` | Giọng văn giáo trình; chuyển sang giọng báo cáo sự cố |
| `trích dòng log liên quan trước` | Kết luận dựa trên ấn tượng, không neo vào dữ liệu |
| `mỗi kết luận chỉ tới một dòng log cụ thể` | Nguyên nhân bịa nghe hợp lý nhưng không có bằng chứng |
| `bước kiểm chứng dưới 5 phút` | Khuyến nghị kiểu "hãy thêm distributed tracing" |
| `tối đa 150 từ` | Báo cáo ba trang trong lúc đang cháy |
| `nếu log không đủ, nói rõ cần thêm gì` ⭐ | **Danh sách 8 nguyên nhân có thể, không cái nào đúng** |

Dòng cuối là dòng đáng giá nhất. Không có nó, khi log thiếu dữ kiện model **vẫn sẽ trả lời** — và câu trả lời đó nghe rất chuyên nghiệp, khiến bạn mất 10 phút đuổi theo hướng sai trong lúc hệ thống đang chết.

---

## Ba câu tóm tắt

1. **Bạn không ra lệnh cho model, bạn thu hẹp không gian câu trả lời.** Mỗi thành phần là một nhát cắt.
2. **Lý do có giá trị hơn mệnh lệnh** — một câu "vì..." sinh ra hàng chục quy tắc bạn chưa kịp viết.
3. **Thành phần bị bỏ quên nhiều nhất là xử lý bất định**, và nó chính là thứ ngăn loại lỗi tốn kém nhất: câu trả lời nghe hợp lý nhưng sai.
