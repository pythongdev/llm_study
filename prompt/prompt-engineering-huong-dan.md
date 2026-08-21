# Hướng dẫn Prompt Engineering cho Claude — từng bước

> Nguồn: [Prompt engineering overview](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/overview)
> và trang tham chiếu chính mà overview trỏ tới:
> [Prompting best practices](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/claude-prompting-best-practices).
>
> Lưu ý: trang overview hiện **không còn liệt kê các kỹ thuật theo thứ tự** như bản cũ.
> Nó chỉ nói: "All prompting techniques (from clarity and examples to XML structuring,
> role prompting, thinking, and prompt chaining) are covered in Prompting best practices.
> That's the living reference; start there."
> Vì vậy phần "từng bước" dưới đây là thứ tự áp dụng thực tế, dựng lại từ nội dung
> của trang best practices.

---

## Bước 0 — Chuẩn bị TRƯỚC khi prompt engineering

Tài liệu nói rõ: guide này giả định bạn đã có sẵn 3 thứ. Nếu chưa có, hãy làm 3 thứ này trước, đừng vội chỉnh prompt.

1. **Định nghĩa rõ tiêu chí thành công (success criteria)** cho use case của bạn.
2. **Có cách đo lường thực nghiệm (evals)** dựa trên tiêu chí đó.
3. **Có một bản prompt nháp** để cải thiện.

Hai cảnh báo quan trọng:

- **Không phải vấn đề nào cũng giải bằng prompt.** Ví dụ latency và chi phí thường dễ cải thiện hơn bằng cách **đổi model** hoặc chỉnh `effort`, chứ không phải viết prompt dài hơn.
- **Chưa có prompt nháp?** Dùng [metaprompt notebook](https://colab.research.google.com/github/anthropics/claude-cookbooks/blob/main/misc/metaprompt.ipynb) để sinh bản đầu tiên.

**Quy trình vòng lặp nên theo:**

```
Viết eval  →  Prompt nháp  →  Chạy trên bộ test  →  Đo  →  Sửa 1 thứ  →  Đo lại
```

Mỗi lần chỉ sửa **một** yếu tố, nếu không bạn sẽ không biết cái gì làm kết quả tốt lên.

---

## Bước 1 — Rõ ràng và trực tiếp (Be clear and direct)

Đây là kỹ thuật nền tảng, đem lại nhiều cải thiện nhất.

**Nguyên tắc vàng (Golden rule) từ tài liệu:**

> Đưa prompt của bạn cho một đồng nghiệp không biết gì về task và bảo họ làm theo.
> Nếu họ thấy khó hiểu, Claude cũng sẽ thấy khó hiểu.

Hãy coi Claude như **một nhân viên rất giỏi nhưng mới vào làm**, chưa biết quy ước và quy trình nội bộ của bạn. Bạn giải thích càng chính xác, kết quả càng tốt.

Cụ thể:

- Nói rõ **định dạng đầu ra mong muốn** và **các ràng buộc**.
- Khi thứ tự hoặc tính đầy đủ của các bước quan trọng → dùng **danh sách đánh số** hoặc bullet.
- Muốn Claude làm "vượt mong đợi" thì **phải nói ra**, đừng mong model tự suy ra từ prompt mơ hồ.

**Ví dụ trong tài liệu:**

Kém hiệu quả:

```text
Create an analytics dashboard
```

Hiệu quả hơn:

```text
Create an analytics dashboard. Include as many relevant features and interactions as possible. Go beyond the basics to create a fully-featured implementation.
```

---

## Bước 2 — Thêm ngữ cảnh và lý do (Add context)

Giải thích **tại sao** bạn muốn hành vi đó, chứ không chỉ ra lệnh cụt lủn. Claude đủ thông minh để **tổng quát hoá từ lời giải thích** và xử lý đúng cả những trường hợp bạn chưa liệt kê.

Kém hiệu quả:

```text
NEVER use ellipses
```

Hiệu quả hơn:

```text
Your response will be read aloud by a text-to-speech engine, so never use ellipses since the text-to-speech engine will not know how to pronounce them.
```

Câu thứ hai không chỉ chặn dấu "..." mà còn khiến model tránh mọi ký tự khác gây khó cho TTS.

---

## Bước 3 — Dùng ví dụ (few-shot / multishot)

Đây là **cách đáng tin cậy nhất** để điều khiển **định dạng, giọng văn và cấu trúc** đầu ra.

Ví dụ tốt cần đủ 3 tính chất:

- **Relevant (liên quan):** phản ánh sát use case thật của bạn.
- **Diverse (đa dạng):** phủ các edge case, đủ khác nhau để Claude không học nhầm một pattern phụ ngoài ý muốn.
- **Structured (có cấu trúc):** bọc từng ví dụ trong thẻ `<example>`, nhiều ví dụ thì bọc chung trong `<examples>`, để model phân biệt ví dụ với chỉ dẫn.

**Số lượng khuyến nghị: 3–5 ví dụ.**

Mẹo: bạn có thể **nhờ chính Claude** đánh giá bộ ví dụ của bạn về độ liên quan / đa dạng, hoặc sinh thêm ví dụ dựa trên bộ ban đầu.

```xml
<examples>
  <example>
    <input>Đơn hàng bị giao chậm 3 ngày, khách rất bực</input>
    <output>{"category": "shipping_delay", "sentiment": "negative", "priority": "high"}</output>
  </example>
  <example>
    <input>Cho mình hỏi shop có ship COD không?</input>
    <output>{"category": "pre_sales_question", "sentiment": "neutral", "priority": "low"}</output>
  </example>
</examples>
```

---

## Bước 4 — Cấu trúc prompt bằng thẻ XML

Khi prompt trộn lẫn **chỉ dẫn + ngữ cảnh + ví dụ + dữ liệu đầu vào biến đổi**, thẻ XML giúp Claude phân tách rạch ròi, giảm hiểu nhầm.

Best practice:

- Dùng **tên thẻ mô tả rõ nghĩa và nhất quán** giữa các prompt (`<instructions>`, `<context>`, `<input>`...).
- **Lồng thẻ** khi nội dung có phân cấp tự nhiên: các tài liệu nằm trong `<documents>`, mỗi tài liệu là `<document index="n">`.

```xml
<instructions>
  Phân loại ticket dưới đây theo 5 nhãn cho trước. Chỉ trả về JSON.
</instructions>

<context>
  Đây là ticket từ hệ thống CSKH của một sàn thương mại điện tử.
</context>

<input>
  {{TICKET_TEXT}}
</input>
```

---

## Bước 5 — Gán vai trò (role prompting) qua system prompt

Đặt vai trò trong **system prompt** giúp tập trung hành vi và giọng văn. Tài liệu nhấn mạnh: **chỉ một câu cũng đã tạo khác biệt.**

```python
import anthropic

client = anthropic.Anthropic()

message = client.messages.create(
    model="claude-opus-5",
    max_tokens=1024,
    system="You are a helpful coding assistant specializing in Python.",
    messages=[
        {"role": "user", "content": "How do I sort a list of dictionaries by key?"}
    ],
)

print(message.content)
```

Quy ước phân vai:

- **`system`**: vai trò, quy tắc chung, định dạng, ràng buộc — những gì đúng cho **mọi** request.
- **`messages`**: dữ liệu và yêu cầu **của lần này**.

---

## Bước 6 — Prompt với ngữ cảnh dài (long context, 20k+ token)

Bốn quy tắc từ tài liệu:

1. **Đặt dữ liệu dài lên ĐẦU prompt** — trên cả câu hỏi, chỉ dẫn và ví dụ.
   Tài liệu ghi: câu hỏi đặt ở cuối có thể **cải thiện chất lượng tới ~30%** trong các bài test, đặc biệt với đầu vào nhiều tài liệu phức tạp.

2. **Bọc tài liệu và metadata bằng XML**: mỗi tài liệu trong `<document>`, với `<source>` và `<document_content>`.

3. **Neo câu trả lời vào trích dẫn (ground in quotes)**: yêu cầu Claude **trích các đoạn liên quan trước**, rồi mới làm nhiệm vụ. Cách này giúp model tập trung phần cần thiết và bỏ qua phần nhiễu.

4. Kết hợp cả ba ở trên trong một prompt.

Mẫu đầy đủ từ tài liệu:

```xml
You are an AI physician's assistant. Your task is to help doctors diagnose possible patient illnesses.

<documents>
  <document index="1">
    <source>patient_symptoms.txt</source>
    <document_content>
      {{PATIENT_SYMPTOMS}}
    </document_content>
  </document>
  <document index="2">
    <source>patient_records.txt</source>
    <document_content>
      {{PATIENT_RECORDS}}
    </document_content>
  </document>
</documents>

Find quotes from the patient records and appointment history that are relevant to diagnosing the patient's reported symptoms. Place these in <quotes> tags. Then, based on these quotes, list all information that would help the doctor diagnose the patient's symptoms. Place your diagnostic information in <info> tags.
```

---

## Bước 7 — Kiểm soát định dạng và độ dài đầu ra

### 7.1 Bốn cách điều khiển định dạng

1. **Nói cái NÊN làm, đừng nói cái KHÔNG NÊN làm.**
   - Thay vì: `Do not use markdown in your response`
   - Hãy dùng: `Your response should be composed of smoothly flowing prose paragraphs.`

2. **Dùng thẻ XML làm chỉ báo định dạng:**
   `Write the prose sections of your response in <smoothly_flowing_prose_paragraphs> tags.`

3. **Khớp style của prompt với style đầu ra mong muốn.** Văn phong prompt ảnh hưởng văn phong trả lời — ví dụ **bỏ markdown khỏi prompt** sẽ giảm lượng markdown trong output.

4. **Viết chỉ dẫn định dạng chi tiết** khi cần kiểm soát chặt.

Prompt mẫu để giảm markdown thừa (trích nguyên văn tài liệu):

````text
<avoid_excessive_markdown_and_bullet_points>
When writing reports, documents, technical explanations, analyses, or any long-form
content, write in clear, flowing prose using complete paragraphs and sentences. Use
standard paragraph breaks for organization and reserve markdown primarily for `inline
code`, code blocks (```...```), and simple headings (## and ###). Avoid using **bold**
and *italics*.

DO NOT use ordered lists (1. ...) or unordered lists (*) unless: a) you're presenting
truly discrete items where a list format is the best option, or b) the user explicitly
requests a list or ranking

Instead of listing items with bullets or numbers, incorporate them naturally into
sentences. This guidance applies especially to technical writing. Using prose instead of
excessive formatting will improve user satisfaction. NEVER output a series of overly
short bullet points.

Your goal is readable, flowing text that guides the reader naturally through ideas
rather than fragmenting information into isolated points.
</avoid_excessive_markdown_and_bullet_points>
````

### 7.2 Độ dài và văn phong

Các model mới nhất mặc định **ngắn gọn và tự nhiên hơn** thế hệ trước: báo cáo tiến độ dựa trên sự kiện thay vì tự khen, ít máy móc hơn, và **có thể bỏ qua phần tóm tắt** để tiết kiệm. Nếu bạn muốn nhìn thấy quá trình:

```text
After completing a task that involves tool use, provide a quick summary of the work you've done.
```

**Ngoại lệ — Claude Opus 5:** mặc định trả lời **dài hơn** các model trước, và tăng/giảm `effort` **không** thay đổi đáng tin cậy độ dài phần trả lời hiển thị. Với Opus 5 phải **yêu cầu ngắn gọn một cách tường minh** trong prompt.

### 7.3 LaTeX

Các model mới **mặc định dùng LaTeX** cho biểu thức toán. Muốn plain text:

```text
Format your response in plain text only. Do not use LaTeX, MathJax, or any markup
notation such as \( \), $, or \frac{}{}. Write all math expressions using standard text
characters (e.g., "/" for division, "*" for multiplication, and "^" for exponents).
```

### 7.4 ⚠️ Prefill đã bị bỏ

Từ các model Claude 4.6 trở đi và Claude Mythos Preview, **prefill (đưa sẵn một phần assistant message ở lượt cuối) không còn được hỗ trợ** — request có prefill sẽ trả về **lỗi 400**. Model cũ hơn vẫn dùng được; thêm assistant message ở **giữa** hội thoại thì không bị ảnh hưởng.

Cách thay thế cho từng kịch bản prefill cũ:

| Mục đích cũ của prefill | Cách thay thế |
|---|---|
| Ép định dạng JSON/YAML, phân loại | Dùng [Structured Outputs](https://platform.claude.com/docs/en/build-with-claude/structured-outputs); hoặc tool có field `enum` cho bài toán phân loại. Model mới bám schema phức tạp khá tốt chỉ bằng chỉ dẫn, nhất là khi có retry. |
| Bỏ phần mở đầu ("Here is...") | Chỉ dẫn trong system prompt: `Respond directly without preamble. Do not start with phrases like 'Here is...', 'Based on...', etc.` Hoặc bắt output trong thẻ XML / structured outputs / tool calling. Còn sót thì cắt ở hậu xử lý. |
| Né refusal sai | Không cần nữa — model đã từ chối đúng hơn nhiều; prompt rõ ràng trong `user` message là đủ. |
| Tiếp tục câu trả lời bị cắt | Chuyển phần tiếp nối sang **user message**: `Your previous response was interrupted and ended with [previous_response]. Continue from where you left off.` Hoặc đơn giản là retry. |
| Bơm lại ngữ cảnh / giữ vai trò | Chèn lời nhắc vào **user turn**; hoặc bơm qua tool; hoặc xử lý ở [context compaction](https://platform.claude.com/docs/en/build-with-claude/compaction). |

---

## Bước 8 — Thinking (suy luận) và `effort`

### 8.1 Adaptive thinking là mặc định mới

- Claude 4.6 trở lên và Claude Mythos Preview dùng **adaptive thinking**: `thinking: {type: "adaptive"}` — model **tự quyết định khi nào và nghĩ bao nhiêu**.
- Trên **Claude Fable 5 và Mythos 5**: thinking **luôn bật**, adaptive là chế độ duy nhất.
- Mức suy nghĩ được hiệu chỉnh theo 2 yếu tố: **tham số `effort`** và **độ phức tạp của câu hỏi**. Câu dễ thì model trả lời thẳng.
- Theo đánh giá nội bộ của Anthropic, **adaptive thinking cho kết quả tốt hơn extended thinking**.

Mặc định khi **bỏ trống** tham số `thinking`:

| Model | Thinking khi không set |
|---|---|
| Opus 4.6 → Opus 4.8, Sonnet 4.6 | **Tắt** |
| Opus 5, Sonnet 5 | **Bật** (Opus 5 chỉ tắt được ở effort `high` trở xuống) |
| Fable 5, Mythos 5 | **Luôn bật**, không tắt được |

### 8.2 `budget_tokens` đã lỗi thời

`budget_tokens` **vẫn chạy** trên Opus 4.6 / Sonnet 4.6 nhưng **deprecated**. Trên **Claude 4.7 trở đi, set `budget_tokens` trả về lỗi 400**. Thay bằng: hạ `effort`, hoặc dùng `max_tokens` làm trần cứng cùng adaptive thinking.

Ví dụ migrate:

```python
# TRƯỚC: extended thinking với budget thủ công (model cũ)
client.messages.create(
    model="claude-sonnet-4-5-20250929",
    max_tokens=16000,
    thinking={"type": "enabled", "budget_tokens": 10000},
    messages=[{"role": "user", "content": "..."}],
)

# SAU: adaptive thinking + effort
client.messages.create(
    model="claude-opus-4-8",
    max_tokens=16000,
    thinking={"type": "adaptive"},
    output_config={"effort": "high"},
    messages=[{"role": "user", "content": "..."}],
)
```

### 8.3 Điều khiển thinking bằng prompt

Thinking **có thể prompt được**. Nếu model nghĩ nhiều hơn bạn muốn (hay xảy ra khi system prompt lớn/phức tạp):

```text
Thinking adds latency and should only be used when it will meaningfully improve
answer quality - typically for problems that require multistep reasoning. When in
doubt, respond directly.
```

Nếu muốn model **phản tư sau khi gọi tool**:

```text
After receiving tool results, carefully reflect on their quality and determine optimal
next steps before proceeding. Use your thinking to plan and iterate based on this new
information, and then take the best next action.
```

### 8.4 Bốn nguyên tắc về CoT

- **Ưu tiên chỉ dẫn tổng quát hơn là kê từng bước.** Một câu như "think thoroughly" thường cho suy luận tốt hơn một kế hoạch từng bước do người viết tay — khả năng suy luận của Claude thường vượt cái con người kê ra.
- **Multishot hoạt động tốt với thinking:** đặt thẻ `<thinking>` trong ví dụ few-shot để cho model thấy *kiểu* suy luận; nó sẽ tổng quát hoá sang thinking block của chính mình.
- **CoT thủ công là phương án dự phòng khi thinking tắt:** yêu cầu model suy luận từng bước, dùng thẻ `<thinking>` và `<answer>` để tách phần suy luận khỏi kết quả. *Riêng Opus 5:* nên **giữ thinking bật ở effort thấp** thay vì tắt — khi tắt, model đôi khi lỡ in thẻ XML nội bộ ra output.
- **Yêu cầu tự kiểm tra:** thêm `Before you finish, verify your answer against [test criteria].` — rất hiệu quả với code và toán.
  *Ngoại lệ Opus 5:* nó tự verify tốt sẵn; giữ lại các câu verify cũ sẽ gây **over-verification**, tốn token và latency → khi migrate sang Opus 5, hãy **xoá** chúng chứ đừng viết lại.

> Lưu ý: khi extended thinking **tắt**, Claude Opus 4.5 khá nhạy với từ "think" và các biến thể. Cân nhắc dùng "consider", "evaluate", "reason through" thay thế.

### 8.5 Chống "overthinking"

Opus 4.6 khám phá nhiều hơn ở đầu, nhất là khi `effort` cao. Nếu quá đà:

- **Thay mặc định chung bằng chỉ dẫn có điều kiện.** Thay vì "Default to using [tool]" → "Use [tool] when it would enhance your understanding of the problem."
- **Bỏ over-prompting.** Câu kiểu "If in doubt, use [tool]" sẽ gây overtrigger trên model mới.
- **Hạ `effort`** như phương án cuối.

```text
When you're deciding how to approach a problem, choose an approach and commit to it.
Avoid revisiting decisions unless you encounter new information that directly
contradicts your reasoning. If you're weighing two approaches, pick one and see it
through. You can always course-correct later if the chosen approach fails.
```

---

## Bước 9 — Tool use

### 9.1 Nói thẳng là "làm", đừng nói "gợi ý"

Model mới **bám chữ nghĩa rất sát**. "Can you suggest some changes" → nó sẽ **chỉ gợi ý**, dù ý bạn là muốn nó sửa thật.

| Kém hiệu quả (chỉ gợi ý) | Hiệu quả (thực sự sửa) |
|---|---|
| `Can you suggest some changes to improve this function?` | `Change this function to improve its performance.` |
| | `Make these edits to the authentication flow.` |

### 9.2 Hai prompt điều chỉnh mức chủ động

Muốn model **chủ động hành động**:

```text
<default_to_action>
By default, implement changes rather than only suggesting them. If the user's intent is
unclear, infer the most useful likely action and proceed, using tools to discover any
missing details instead of guessing. Try to infer the user's intent about whether a tool
call (e.g., file edit or read) is intended or not, and act accordingly.
</default_to_action>
```

Muốn model **dè dặt hơn**, chỉ hành động khi được yêu cầu:

```text
<do_not_act_before_instructions>
Do not jump into implementation or change files unless clearly instructed to make
changes. When the user's intent is ambiguous, default to providing information, doing
research, and providing recommendations rather than taking action. Only proceed with
edits, modifications, or implementations when the user explicitly requests them.
</do_not_act_before_instructions>
```

### 9.3 Hạ tông giọng "CRITICAL / MUST"

Opus 4.5 và 4.6 **nhạy với system prompt hơn** model cũ. Nếu prompt của bạn từng viết để chống *undertrigger* tool, giờ chúng có thể gây **overtrigger**. Cách sửa: **giảm giọng điệu gay gắt** — `"CRITICAL: You MUST use this tool when..."` → `"Use this tool when..."`.

### 9.4 Gọi tool song song

Model mới tự chạy song song các tool call độc lập (search nhiều nhánh, đọc nhiều file cùng lúc, chạy bash song song). Tỷ lệ thành công đã cao sẵn, nhưng prompt sau đẩy lên ~100%:

```text
<use_parallel_tool_calls>
If you intend to call multiple tools and there are no dependencies between the tool
calls, make all of the independent tool calls in parallel. Prioritize calling tools
simultaneously whenever the actions can be done in parallel rather than sequentially.
For example, when reading 3 files, run 3 tool calls in parallel to read all 3 files into
context at the same time. Maximize use of parallel tool calls where possible to increase
speed and efficiency. However, if some tool calls depend on previous calls to inform
dependent values like the parameters, do NOT call these tools in parallel and instead
call them sequentially. Never use placeholders or guess missing parameters in tool
calls.
</use_parallel_tool_calls>
```

Muốn giảm song song (ví dụ tránh nghẽn hệ thống):

```text
Execute operations sequentially with brief pauses between each step to ensure stability.
```

---

## Bước 10 — Hệ agentic (agent chạy dài, nhiều context window)

### 10.1 Context awareness

Sonnet 5, Sonnet 4.6, Sonnet 4.5 và Haiku 4.5 có **context awareness**: model theo dõi được phần context còn lại ("token budget") của chính nó. Nếu harness của bạn có compaction hoặc lưu state ra file, hãy **nói cho model biết**, nếu không nó có thể tự "gói ghém kết thúc sớm" khi thấy sắp hết context:

```text
Your context window will be automatically compacted as it approaches its limit, allowing
you to continue working indefinitely from where you left off. Therefore, do not stop
tasks early due to token budget concerns. As you approach your token budget limit, save
your current progress and state to memory before the context window refreshes. Always be
as persistent and autonomous as possible and complete tasks fully, even if the end of
your budget is approaching. Never artificially stop any task early regardless of the
context remaining.
```

### 10.2 Task trải nhiều context window — 6 kỹ thuật

1. **Dùng prompt KHÁC cho context window đầu tiên:** window đầu để dựng khung (viết test, tạo script setup); các window sau thì lặp trên todo-list.
2. **Bắt model viết test ở định dạng có cấu trúc** (ví dụ `tests.json`) trước khi bắt đầu, và nhấn mạnh: "It is unacceptable to remove or edit tests because this could lead to missing or buggy functionality."
3. **Dựng công cụ tiện ích:** khuyến khích model tạo `init.sh` để khởi động server, chạy test suite, linter — tránh làm lại từ đầu ở context window mới.
4. **Bắt đầu mới thay vì compact:** model mới **rất giỏi tự khám phá state từ filesystem**. Khi bắt đầu window mới, hãy chỉ dẫn cụ thể:
   - "Call pwd; you can only read and write files in this directory."
   - "Review progress.txt, tests.json, and the git logs."
   - "Manually run through a fundamental integration test before moving on to implementing new features."
5. **Cung cấp công cụ tự kiểm chứng:** task tự chủ càng dài, model càng cần tự verify mà không có người review — computer use tool, browser use tool, hoặc MCP server tự động hoá trình duyệt.
6. **Khuyến khích dùng hết context một cách hiệu quả:**

```text
This is a very long task, so it may be beneficial to plan out your work clearly. It's
encouraged to spend your entire output context working on the task - just make sure you
don't run out of context with significant uncommitted work. Continue working
systematically until you have completed this task.
```

### 10.3 Quản lý state

- **Dữ liệu có cấu trúc → JSON** (kết quả test, trạng thái task) để model hiểu schema.
- **Ghi chú tiến độ → text tự do**.
- **Dùng git làm sổ ghi state:** có log và checkpoint khôi phục được; model mới dùng git để theo dõi state qua nhiều phiên rất tốt.
- **Nhấn mạnh tiến bộ tăng dần:** yêu cầu model bám tiến độ và làm từng phần nhỏ.

```json
// tests.json
{
  "tests": [
    { "id": 1, "name": "authentication_flow", "status": "passing" },
    { "id": 2, "name": "user_management", "status": "failing" },
    { "id": 3, "name": "api_endpoints", "status": "not_started" }
  ],
  "total": 200,
  "passing": 150,
  "failing": 25,
  "not_started": 25
}
```

### 10.4 Cân bằng tự chủ và an toàn

Không có chỉ dẫn, Opus 4.6 có thể làm những việc khó hoàn tác (xoá file, force-push, đăng ra dịch vụ ngoài):

```text
Consider the reversibility and potential impact of your actions. You are encouraged to
take local, reversible actions like editing files or running tests, but for actions that
are hard to reverse, affect shared systems, or could be destructive, ask the user before
proceeding.

Examples of actions that warrant confirmation:
- Destructive operations: deleting files or branches, dropping database tables, rm -rf
- Hard to reverse operations: git push --force, git reset --hard, amending published commits
- Operations visible to others: pushing code, commenting on PRs/issues, sending
messages, modifying shared infrastructure

When encountering obstacles, do not use destructive actions as a shortcut. For example,
don't bypass safety checks (e.g. --no-verify) or discard unfamiliar files that may be
in-progress work.
```

### 10.5 Nghiên cứu và thu thập thông tin

Ba nguyên tắc: (1) nêu rõ tiêu chí thế nào là câu trả lời thành công, (2) yêu cầu đối chiếu nhiều nguồn, (3) với task phức tạp thì dùng cách tiếp cận có cấu trúc:

```text
Search for this information in a structured way. As you gather data, develop several
competing hypotheses. Track your confidence levels in your progress notes to improve
calibration. Regularly self-critique your approach and plan. Update a hypothesis tree or
research notes file to persist information and provide transparency. Break down this
complex research task systematically.
```

### 10.6 Điều phối subagent

Model mới **tự điều phối subagent** mà không cần chỉ dẫn. Việc bạn cần làm: định nghĩa tool subagent rõ ràng, rồi để model tự quyết. Rủi ro là **dùng quá nhiều** — Opus 4.6 rất thích subagent (có khi spawn subagent để dò code trong khi một lệnh `grep` là đủ và nhanh hơn); Opus 5 cũng delegate nhiều hơn model trước. Nếu thấy lạm dụng:

```text
Use subagents when tasks can run in parallel, require isolated context, or involve
independent workstreams that don't need to share state. For simple tasks, sequential
operations, single-file edits, or tasks where you need to maintain context across steps,
work directly rather than delegating.
```

---

## Bước 11 — Prompt chaining (nối chuỗi prompt)

Với adaptive thinking và subagent, Claude đã xử lý phần lớn suy luận nhiều bước **ở bên trong**. Chaining tường minh (chia task thành nhiều API call tuần tự) vẫn hữu ích khi bạn cần **soi output trung gian** hoặc **ép một pipeline cố định**.

Pattern chaining phổ biến nhất là **self-correction**:

```
Sinh bản nháp  →  Claude review theo tiêu chí  →  Claude tinh chỉnh dựa trên review
```

Mỗi bước là một API call riêng, nên bạn có thể log, đánh giá hoặc rẽ nhánh ở bất kỳ điểm nào.

---

## Bước 12 — Các prompt "chữa bệnh" thường dùng

### 12.1 Chống over-engineering (Opus 4.5 / 4.6 hay bị)

```text
Avoid over-engineering. Only make changes that are directly requested or clearly
necessary. Keep solutions simple and focused:

- Scope: Don't add features, refactor code, or make "improvements" beyond what was
asked. A bug fix doesn't need surrounding code cleaned up. A simple feature doesn't need
extra configurability.

- Documentation: Don't add docstrings, comments, or type annotations to code you didn't
change. Only add comments where the logic isn't self-evident.

- Defensive coding: Don't add error handling, fallbacks, or validation for scenarios
that can't happen. Trust internal code and framework guarantees. Only validate at system
boundaries (user input, external APIs).

- Abstractions: Don't create helpers, utilities, or abstractions for one-time
operations. Don't design for hypothetical future requirements. The right amount of
complexity is the minimum needed for the current task.
```

### 12.2 Chống "chỉ lo cho test pass" và hard-code

```text
Please write a high-quality, general-purpose solution using the standard tools
available. Do not create helper scripts or workarounds to accomplish the task more
efficiently. Implement a solution that works correctly for all valid inputs, not just
the test cases. Do not hard-code values or create solutions that only work for specific
test inputs. Instead, implement the actual logic that solves the problem generally.

Focus on understanding the problem requirements and implementing the correct algorithm.
Tests are there to verify correctness, not to define the solution. Provide a principled
implementation that follows best practices and software design principles.

If the task is unreasonable or infeasible, or if any of the tests are incorrect, please
inform me rather than working around them. The solution should be robust, maintainable,
and extendable.
```

### 12.3 Chống hallucination khi code

```text
<investigate_before_answering>
Never speculate about code you have not opened. If the user references a specific file,
you MUST read the file before answering. Make sure to investigate and read relevant
files BEFORE answering questions about the codebase. Never make any claims about code
before investigating unless you are certain of the correct answer - give grounded and
hallucination-free answers.
</investigate_before_answering>
```

### 12.4 Dọn file tạm

```text
If you create any temporary new files, scripts, or helper files for iteration, clean up
these files by removing them at the end of the task.
```

### 12.5 Model tự nhận diện

```text
The assistant is Claude, created by Anthropic. The current model is Claude Opus 5.
```

```text
When an LLM is needed, please default to Claude Opus 5 unless the user requests
otherwise. The exact model string for Claude Opus 5 is claude-opus-5.
```

---

## Bước 13 — Tips theo năng lực chuyên biệt

### 13.1 Vision

Opus 4.5 và 4.6 xử lý ảnh và trích xuất dữ liệu tốt hơn hẳn, đặc biệt khi có **nhiều ảnh trong context**; điều này kéo theo computer use đọc screenshot và UI chính xác hơn. Có thể phân tích video bằng cách **tách thành frame**.

Kỹ thuật đã được kiểm chứng là **cho Claude một tool crop** (hoặc agent skill) để "zoom" vào vùng liên quan của ảnh — thử nghiệm cho thấy điểm eval ảnh tăng ổn định. Anthropic có sẵn [recipe cho crop tool](https://platform.claude.com/cookbook/multimodal-crop-tool).

### 13.2 Frontend design — tránh "AI slop"

Không có chỉ dẫn, model dễ rơi vào mẫu chung chung mà người dùng gọi là thẩm mỹ "AI slop". Prompt mẫu:

```text
<frontend_aesthetics>
You tend to converge toward generic, "on distribution" outputs. In frontend design, this
creates what users call the "AI slop" aesthetic. Avoid this: make creative, distinctive
frontends that surprise and delight.

Focus on:
- Typography: Choose fonts that are beautiful, unique, and interesting. Avoid generic
fonts like Arial and Inter; opt instead for distinctive choices that elevate the
frontend's aesthetics.
- Color & Theme: Commit to a cohesive aesthetic. Use CSS variables for consistency.
Dominant colors with sharp accents outperform timid, evenly-distributed palettes. Draw
from IDE themes and cultural aesthetics for inspiration.
- Motion: Use animations for effects and micro-interactions. Prioritize CSS-only
solutions for HTML. Use Motion library for React when available. Focus on high-impact
moments: one well-orchestrated page load with staggered reveals (animation-delay)
creates more delight than scattered micro-interactions.
- Backgrounds: Create atmosphere and depth rather than defaulting to solid colors. Layer
CSS gradients, use geometric patterns, or add contextual effects that match the overall
aesthetic.

Avoid generic AI-generated aesthetics:
- Overused font families (Inter, Roboto, Arial, system fonts)
- Clichéd color schemes (particularly purple gradients on white backgrounds)
- Predictable layouts and component patterns
- Cookie-cutter design that lacks context-specific character

Interpret creatively and make unexpected choices that feel genuinely designed for the
context. Vary between light and dark themes, different fonts, different aesthetics. You
still tend to converge on common choices (Space Grotesk, for example) across
generations. Avoid this: it is critical that you think outside the box!
</frontend_aesthetics>
```

### 13.3 Tạo tài liệu / slide

Model mới tạo presentation, animation, tài liệu trực quan với khả năng bám chỉ dẫn tốt, thường **dùng được ngay lần đầu**:

```text
Create a professional presentation on [topic]. Include thoughtful design elements,
visual hierarchy, and engaging animations where appropriate.
```

---

## Bước 14 — Migration: chuyển prompt cũ sang model mới

Sáu điểm cần rà khi nâng cấp từ thế hệ trước:

1. **Nói cụ thể hành vi mong muốn** — mô tả chính xác cái bạn muốn thấy ở output.
2. **Thêm modifier nâng chất lượng** — "Create an analytics dashboard" → "Create an analytics dashboard. Include as many relevant features and interactions as possible. Go beyond the basics to create a fully-featured implementation."
3. **Yêu cầu tính năng cụ thể một cách tường minh** — animation và thành phần tương tác phải nói ra mới có.
4. **Cập nhật cấu hình thinking** — dùng `thinking: {type: "adaptive"}` thay `budget_tokens`, điều khiển độ sâu bằng `effort`.
5. **Bỏ prefill** — xem bảng thay thế ở mục 7.4.
6. **Hạ bớt prompt "chống lười"** — model mới đã chủ động hơn; giữ nguyên chỉ dẫn cũ sẽ gây overtrigger.

Trang riêng cho từng model (đọc khi bạn chốt được model dùng):

- [Prompting Claude Fable 5](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/prompting-claude-fable-5) — effort, instruction following, tuyên bố tiến độ khi chạy dài, memory system, refusal category `reasoning_extraction`.
- [Prompting Claude Sonnet 5](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/prompting-claude-sonnet-5) — độ dài trả lời, hiệu chỉnh effort/thinking, trigger tool, bám chữ nghĩa, mặc định về design/frontend.
- [Prompting Claude Opus 5](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/prompting-claude-opus-5) — verbosity, cập nhật tiến độ, độ dài deliverable, phạm vi task và over-verification, kiểm soát subagent, self-correction.
- [Prompting Claude Opus 4.8](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/prompting-claude-opus-4-8).

---

## Checklist rút gọn — dán lên bàn làm việc

Trước khi gửi prompt, tự hỏi:

- [ ] Tôi đã có **tiêu chí thành công** và **cách đo** chưa?
- [ ] Một đồng nghiệp không biết context đọc prompt này có làm được không? *(Golden rule)*
- [ ] Tôi đã nói rõ **định dạng đầu ra** và **ràng buộc** chưa?
- [ ] Tôi đã giải thích **tại sao** muốn hành vi đó chưa?
- [ ] Có **3–5 ví dụ** liên quan, đa dạng, bọc trong `<example>` chưa?
- [ ] Các loại nội dung khác nhau đã tách bằng **thẻ XML** chưa?
- [ ] **System prompt** đã có role chưa? Phần bất biến đã nằm ở system chưa?
- [ ] Nếu input dài: **dữ liệu ở trên, câu hỏi ở dưới**, và có yêu cầu **trích quote trước** không?
- [ ] Chỉ dẫn viết theo hướng **"hãy làm X"** thay vì **"đừng làm Y"** chưa?
- [ ] Tôi muốn model **hành động** hay chỉ **gợi ý**? Câu lệnh đã phản ánh đúng điều đó chưa?
- [ ] Cấu hình `thinking` / `effort` đã đúng cho model đang dùng chưa? Còn sót `budget_tokens` không?
- [ ] Còn sót **prefill** ở assistant turn cuối không? *(gây lỗi 400 từ Claude 4.6+)*
- [ ] Prompt còn giọng "CRITICAL / YOU MUST" thừa từ thời model cũ không?

---

## Template khởi điểm

```xml
<!-- SYSTEM PROMPT -->
You are a [vai trò cụ thể] specializing in [lĩnh vực].

<task_context>
[Bối cảnh: hệ thống này là gì, output dùng vào đâu, ai đọc.
 Giải thích LÝ DO của các ràng buộc quan trọng.]
</task_context>

<instructions>
1. [Bước 1]
2. [Bước 2]
3. [Bước 3]
</instructions>

<output_format>
[Mô tả chính xác định dạng mong muốn. Nói cái NÊN làm, không nói cái KHÔNG NÊN.]
</output_format>

<examples>
  <example>
    <input>[input tiêu biểu]</input>
    <output>[output đúng chuẩn]</output>
  </example>
  <example>
    <input>[edge case]</input>
    <output>[output đúng chuẩn]</output>
  </example>
</examples>
```

```xml
<!-- USER MESSAGE (dữ liệu dài đặt TRÊN câu hỏi) -->
<documents>
  <document index="1">
    <source>[tên file]</source>
    <document_content>{{DOCUMENT_1}}</document_content>
  </document>
</documents>

[Câu hỏi / yêu cầu cụ thể của lần này, đặt ở CUỐI.]
```

---

## Tự học thêm

- [GitHub prompting tutorial](https://github.com/anthropics/prompt-eng-interactive-tutorial) — tutorial tương tác, đầy ví dụ, phủ các khái niệm trong docs.
- [Google Sheets prompting tutorial](https://docs.google.com/spreadsheets/d/19jzLgRruG9kjUQNKtCg1ZjdD6l6weA6qRXG5zLIAhC8) — bản nhẹ hơn, dạng bảng tính tương tác.
- [Prompt generator notebook (metaprompt)](https://colab.research.google.com/github/anthropics/claude-cookbooks/blob/main/misc/metaprompt.ipynb) — sinh prompt nháp đầu tiên.
- [Best practices for prompt engineering (blog)](https://claude.com/blog/best-practices-for-prompt-engineering) — kỹ năng prompt tổng quát, ngoài phần đặc thù Claude.
- [Define success criteria and build evaluations](https://platform.claude.com/docs/en/test-and-evaluate/develop-tests) — làm Bước 0 cho tử tế.
