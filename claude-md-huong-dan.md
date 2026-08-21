# Hướng dẫn CLAUDE.md — Best practices (tổng hợp 2026)

> **Nguồn chính (chính thức):**
> - [How Claude remembers your project — Claude Code Docs](https://code.claude.com/docs/en/memory)
> - [Extend Claude Code: CLAUDE.md vs Skills vs Rules vs Hooks](https://code.claude.com/docs/en/features-overview)
> - [Steering Claude Code — Anthropic blog](https://claude.com/blog/steering-claude-code-skills-hooks-rules-subagents-and-more)
> - [Claude Code power user tips — Anthropic Help Center](https://support.claude.com/en/articles/14554000-claude-code-power-user-tips)
>
> **Nguồn cộng đồng (đối chiếu, lấy ví dụ thực tế):**
> - [CLAUDE.md Anti-Patterns: 12 Productivity Killers](https://claude-world.com/articles/claude-md-antipatterns/)
> - [CLAUDE.md Best Practices: The Complete 2026 Guide](https://maketocreate.com/claude-md-best-practices-the-complete-2026-guide/)
> - [Karpathy's CLAUDE.md, Annotated](https://mcp.directory/blog/karpathy-claude-md-annotated-2026)
> - [Claude Code Best Practices (rosmur)](https://rosmur.github.io/claudecode-best-practices/)

---

## Bước 0 — Hiểu đúng bản chất trước khi viết

**CLAUDE.md không phải tài liệu dự án. Nó là prompt production.**

Ba sự thật kỹ thuật quyết định mọi best practice bên dưới:

1. **Nó được nạp vào context window ở đầu **mọi** session**, và ở lại trong **mọi request** sau đó. Mỗi dòng bạn viết đều tốn token của mọi lượt trò chuyện, mãi mãi.
2. **Nó là context, không phải cấu hình bắt buộc.** Docs nói rõ: nội dung CLAUDE.md được gửi như một *user message* sau system prompt — "there's no guarantee of strict compliance". Muốn **chặn cứng** một hành động → dùng **hook** hoặc **permissions**, không phải câu chữ trong CLAUDE.md.
3. **Càng dài càng ít được tuân thủ.** Docs: "Longer files consume more context and reduce adherence." Hiệu ứng *lost in the middle* khiến model chú ý kém phần giữa của context dài.

> **Nguyên tắc nền:** mỗi dòng trong CLAUDE.md phải *kiếm được chỗ đứng của nó*. Nếu Claude có thể tự suy ra bằng cách đọc code → xóa.

---

## Bước 1 — Phân biệt CLAUDE.md và auto memory

Claude Code có **hai** hệ thống trí nhớ, cả hai đều nạp đầu session:

| | **CLAUDE.md** | **Auto memory** |
|---|---|---|
| Ai viết | **Bạn** | **Claude tự viết** |
| Chứa gì | Chỉ dẫn, luật lệ | Bài học, pattern Claude tự rút ra |
| Phạm vi | Project / user / tổ chức | Theo repository (dùng chung mọi worktree) |
| Nạp bao nhiêu | **Toàn bộ file**, không giới hạn | 200 dòng đầu hoặc 25KB đầu của `MEMORY.md` |
| Dùng cho | Coding standards, workflow, kiến trúc | Build command, insight debug, sở thích Claude phát hiện |
| Lưu ở đâu | Trong repo / `~/.claude/` | `~/.claude/projects/<project>/memory/` (máy local, **không** commit) |

- Auto memory **bật mặc định**. Tắt: `/memory` → toggle, hoặc `"autoMemoryEnabled": false`, hoặc env `CLAUDE_CODE_DISABLE_AUTO_MEMORY=1`.
- `MEMORY.md` là **index**, chi tiết nằm ở các file chủ đề (`debugging.md`, `api-conventions.md`…) — các file chủ đề **không** nạp lúc khởi động, Claude đọc khi cần.
- Khi bạn nói "nhớ giúp tôi là dùng pnpm chứ không phải npm" → Claude lưu vào **auto memory**. Muốn vào CLAUDE.md thì phải nói rõ: **"thêm cái này vào CLAUDE.md"**.

> ⚠️ Phím tắt `#` để ghi nhanh vào CLAUDE.md đã thay đổi hành vi qua các phiên bản (nay thiên về auto memory). Đường đi đáng tin cậy hiện tại: dùng `/memory` để mở file, hoặc bảo Claude *"add this to CLAUDE.md"*.

---

## Bước 2 — Đặt file ở đâu

Nạp theo thứ tự từ **phạm vi rộng → hẹp** (cái hẹp hơn xuất hiện sau trong context):

| Phạm vi | Vị trí | Dùng cho | Chia sẻ với |
|---|---|---|---|
| **Managed policy** | macOS: `/Library/Application Support/ClaudeCode/CLAUDE.md`<br>Linux/WSL: `/etc/claude-code/CLAUDE.md`<br>Windows: `C:\Program Files\ClaudeCode\CLAUDE.md` | Chuẩn công ty, security policy, compliance | Toàn tổ chức |
| **User** | `~/.claude/CLAUDE.md` | Sở thích cá nhân cho **mọi** project | Chỉ bạn |
| **Project** | `./CLAUDE.md` hoặc `./.claude/CLAUDE.md` | Kiến trúc, chuẩn code, workflow của team | Team, qua git |
| **Local** | `./CLAUDE.local.md` | Sở thích riêng trong project này | Chỉ bạn — **nhớ .gitignore** |

**Cách nạp thực tế:**

- Claude đi **ngược cây thư mục** từ cwd lên root, gom tất cả `CLAUDE.md` + `CLAUDE.local.md` gặp được. Chúng được **nối vào nhau**, không ghi đè nhau.
- Thứ tự: từ root xuống cwd. Chạy trong `foo/bar/` thì `foo/CLAUDE.md` vào trước, `foo/bar/CLAUDE.md` vào sau. Trong cùng thư mục, `CLAUDE.local.md` xếp sau `CLAUDE.md`.
- File ở **thư mục con** của cwd **không** nạp lúc khởi động — chỉ nạp khi Claude đọc file trong thư mục đó (lazy).
- `--add-dir` **không** nạp CLAUDE.md của thư mục thêm, trừ khi bật `CLAUDE_CODE_ADDITIONAL_DIRECTORIES_CLAUDE_MD=1`.

**Nhiều worktree?** `CLAUDE.local.md` bị gitignore nên chỉ tồn tại ở worktree bạn tạo. Muốn dùng chung, import từ home:

```markdown
# Individual Preferences
- @~/.claude/my-project-instructions.md
```

---

## Bước 3 — Viết cái gì vào (và không viết cái gì)

### ✅ NÊN có

| Mục | Ví dụ cụ thể |
|---|---|
| **Lệnh Claude không thể đoán** | `Test: php artisan test` (Pest, **không** chạy PHPUnit trực tiếp) |
| **Layout thư mục cốt lõi** (3–5 mục) | `API handlers nằm ở src/api/handlers/` |
| **Convention linter KHÔNG bắt được** | `Truy cập DB chỉ qua app/Repositories/. Không dùng Eloquent trong controller.` |
| **Cái Claude hay làm sai trong repo này** | `Luôn gọi Sentry.captureException() trong error handler` |
| **Quirk trái với mặc định của tool** | `Tailwind v4 cấu hình qua @theme trong app/globals.css — KHÔNG có tailwind.config.ts` |
| **Vùng cấm** | `Không sửa legacy/, không sửa file generated trong src/gen/` |
| **Quy ước branch / PR / commit** | `Branch: feat/<ticket>. Không push thẳng main.` |
| **Con trỏ tới tài liệu sâu hơn** | `Chi tiết API xem docs/api-guide.md` |

> Tiêu chí quyết định của docs: *"Add to it when Claude makes the same mistake a second time"* — Claude sai **lần thứ hai** thì đó là một dòng CLAUDE.md, không phải một lần sửa trong chat.

### ❌ KHÔNG nên có

| Thứ cần loại | Vì sao | Thay bằng |
|---|---|---|
| **Code block dán vào** | Tốn token khủng khiếp, dễ lỗi thời | Trỏ vị trí: `See lib/parser.ts:42` |
| **Luật mà linter/formatter đã enforce** | Trùng lặp vô ích, config mới là nguồn chân lý | Để cho ESLint/Prettier/gofmt |
| **Kiến thức lập trình phổ thông** | Model đã biết | Xóa |
| **Cây thư mục dài, danh sách dependency, tổng quan kiến trúc dài dòng** | Claude tự đọc được từ codebase | Xóa (chính `/doctor` cũng đề xuất cắt những mục này) |
| **Quy trình nhiều bước (30 dòng)** | Chiếm context mọi session dù hiếm dùng | Chuyển thành **Skill** |
| **Luật chỉ áp dụng cho `src/api/**`** | Nhiễu khi làm việc chỗ khác | Chuyển thành **path-scoped rule** |
| **"Tuyệt đối không được X"** | Chỉ là lời đề nghị, không có gì đảm bảo | **Hook** `PreToolUse` hoặc `permissions.deny` |
| **Sở thích cá nhân trong file team** | Gây xung đột trong repo chung | `CLAUDE.local.md` hoặc `~/.claude/CLAUDE.md` |
| **Kiến trúc "mong muốn" chưa tồn tại** | Claude viết code cho hệ thống không có thật | Mô tả **hiện trạng**; để target architecture ở tài liệu riêng |

---

## Bước 4 — Ba tiêu chí viết câu lệnh tốt

Docs nêu bốn thuộc tính: **Size, Structure, Specificity, Consistency**.

### 4.1 Cụ thể đến mức kiểm chứng được

| ❌ Mơ hồ | ✅ Cụ thể |
|---|---|
| "Format code properly" | "Use 2-space indentation" |
| "Test your changes" | "Run `npm test` before committing" |
| "Keep files organized" | "API handlers live in `src/api/handlers/`" |

### 4.2 Cấu trúc bằng header + bullet

Claude quét cấu trúc y như người đọc. Section có tổ chức dễ theo hơn đoạn văn dày đặc. Đừng viết văn xuôi.

### 4.3 Nhất quán — mâu thuẫn là kẻ thù

Nếu hai luật chống nhau, **Claude có thể chọn bừa một cái**. Rà định kỳ: CLAUDE.md gốc, CLAUDE.md ở thư mục con, và `.claude/rules/` để xóa luật cũ / mâu thuẫn.

### 4.4 Mẹo viết từ thực chiến

- **Luật phủ định dễ verify hơn luật khẳng định.** "No abstractions for single-use code" rõ hơn "Prefer simplicity".
- **Giải thích *tại sao*** cho ràng buộc quan trọng — model tuân thủ tốt hơn khi hiểu lý do.
- **Đưa "câu test" cho mỗi nguyên tắc**, ví dụ: *"Would a senior engineer say this is overcomplicated?"*
- **Biến mệnh lệnh mơ hồ thành mục tiêu kiểm chứng được**: "Fix the bug" → "Viết test tái hiện bug, rồi làm nó pass".
- **Đưa nguyên tắc, đừng đưa flowchart cứng** — flowchart vỡ khi gặp trường hợp bất ngờ.

---

## Bước 5 — Cú pháp `@import` và các chi tiết ngầm

```markdown
See @README for project overview and @package.json for available npm commands.

# Additional Instructions
- git workflow @docs/git-instructions.md
```

Những điều **phải nhớ**:

- **Import KHÔNG tiết kiệm context.** File được import vẫn nạp đầy đủ lúc khởi động. Import chỉ giúp *tổ chức*, không giúp *giảm token*.
- Đường dẫn tương đối tính từ **file chứa import**, không phải cwd. Đệ quy tối đa **4 hop**.
- **Muốn nhắc tới một path mà không import → bọc backtick.** `` `@README` `` là text thường; `@README` không backtick sẽ import file.
- Import trong file project trỏ ra **ngoài** working directory (ví dụ `@~/.claude/...`) sẽ hiện **hộp thoại phê duyệt** lần đầu. Từ chối một lần là tắt luôn. (Import trong file user-scope thì không hỏi.)
- **HTML comment cấp block bị strip trước khi vào context**: `<!-- ghi chú cho người maintain -->` không tốn token. Comment trong code block thì được giữ.

### Dự án đã có `AGENTS.md`?

Claude Code đọc `CLAUDE.md`, **không** đọc `AGENTS.md`. Cách nối:

```markdown
@AGENTS.md

## Claude Code

Use plan mode for changes under `src/billing/`.
```

Hoặc symlink (không dùng được trên Windows nếu không có quyền Admin):

```bash
ln -s AGENTS.md CLAUDE.md
```

---

## Bước 6 — Khi CLAUDE.md phình to: dùng `.claude/rules/`

```text
your-project/
├── .claude/
│   ├── CLAUDE.md           # Chỉ dẫn chính
│   └── rules/
│       ├── code-style.md
│       ├── testing.md
│       └── security.md
```

**Rule có `paths` frontmatter chỉ nạp khi Claude động vào file khớp pattern** → đây là công cụ giảm context thật sự (khác với `@import`).

```markdown
---
paths:
  - "src/api/**/*.ts"
---

# API Development Rules

- All API endpoints must include input validation
- Use the standard error response format
```

- Rule **không có** `paths` → nạp mọi session, ưu tiên ngang `.claude/CLAUDE.md`.
- Hỗ trợ brace expansion: `"src/**/*.{ts,tsx}"`. Ngân sách giới hạn 1.000 pattern sau khi expand.
- Rule user-level ở `~/.claude/rules/` áp cho mọi project, nạp **trước** rule project (nên rule project ưu tiên cao hơn).
- Chia sẻ rule giữa các repo bằng symlink: `ln -s ~/company-standards/security.md .claude/rules/security.md`

---

## Bước 7 — Cây quyết định: CLAUDE.md hay thứ khác?

| Tình huống kích hoạt | Dùng cái gì |
|---|---|
| Claude sai một convention/command **lần thứ hai** | → **CLAUDE.md** |
| Luật chỉ đúng cho một thư mục / loại file | → **`.claude/rules/` có `paths:`** |
| Bạn gõ đi gõ lại cùng một prompt để bắt đầu task | → **Skill** (`/<name>`) |
| Bạn dán cùng một playbook nhiều bước lần thứ ba | → **Skill** |
| Tài liệu tham khảo dài (API docs, style guide đầy đủ) | → **Skill** (nạp on-demand) |
| Việc **bắt buộc** phải xảy ra mỗi lần, không cần Claude suy nghĩ | → **Hook** |
| Việc **tuyệt đối** không được xảy ra | → **Hook `PreToolUse`** / `permissions.deny` |
| Task phụ làm ngập context bằng output không dùng lại | → **Subagent** |
| Repo thứ hai cần đúng setup này | → **Plugin** |

**So sánh chi phí context:**

| Cơ chế | Nạp khi nào | Chi phí |
|---|---|---|
| CLAUDE.md | Đầu session | **Toàn bộ nội dung, mọi request** |
| Rules có `paths:` | Khi mở file khớp | Thấp |
| Skills | Description đầu session, nội dung khi dùng | Thấp |
| Hooks | Khi event xảy ra | **Bằng 0** (trừ khi hook trả output) |
| Subagents | Khi spawn | Cô lập khỏi session chính |

> Câu chốt từ Anthropic: *"An instruction like 'never edit .env' in CLAUDE.md or a skill is a request, not a guarantee. A PreToolUse hook that blocks the edit is enforcement."*

---

## Bước 8 — Khung mẫu (template)

Thứ tự section được khuyến nghị — **tổng dưới ~200 dòng**:

```markdown
# <Tên project>

<Một câu: repo này là cái gì>

## Tech stack
- Next.js 15 (App Router), TypeScript strict, Postgres 16, Drizzle ORM
- Package manager: pnpm (KHÔNG dùng npm/yarn)

## Commands
- Dev:        `pnpm dev`
- Test:       `pnpm test` (Vitest)
- Typecheck:  `pnpm typecheck`
- Lint:       `pnpm lint --fix`
- Migration:  `pnpm db:migrate`

<!-- Chạy typecheck + test trước khi báo xong. Đây là feedback loop chính. -->

## Architecture
- `src/app/`      — routes (App Router)
- `src/server/`   — business logic, service layer
- `src/db/`       — schema + migrations (generated, đừng sửa tay)
- Chi tiết luồng auth: xem `docs/auth.md`

## Conventions
- Truy cập DB chỉ qua `src/server/repositories/`. Không query trực tiếp trong route handler.
- Mọi error handler phải gọi `captureException()` từ `src/lib/observability.ts`.
- Tailwind v4 cấu hình qua `@theme` trong `app/globals.css` — KHÔNG có `tailwind.config.ts`.

## Boundaries
- Không sửa `src/db/generated/**` (sinh tự động).
- Không sửa `legacy/**` trừ khi được yêu cầu rõ ràng.
- Không push thẳng `main`. Branch: `feat/<ticket-id>`.

## Những lỗi hay lặp lại
- Quên chạy `pnpm db:generate` sau khi đổi schema.
- Dùng `useEffect` để fetch data thay vì server component.
```

**Bốn nguyên tắc hành vi** (kiểu Karpathy, ~60 dòng, có thể thêm vào `~/.claude/CLAUDE.md` cá nhân):

```markdown
## 1. Think before coding
Nêu rõ giả định; hỏi khi không chắc. Đưa ra các cách hiểu khác nhau thay vì
tự chọn im lặng. Phản biện khi có cách đơn giản hơn.

## 2. Simplicity first
Code tối thiểu giải quyết được vấn đề. Không tính năng ngoài yêu cầu.
Không abstraction cho code dùng một lần.
Test: "Một senior engineer có nói cái này bị over-engineer không?"

## 3. Surgical changes
Chỉ chạm cái buộc phải chạm. Mọi dòng thay đổi phải truy ngược được về yêu cầu.
Dọn import/biến mà thay đổi của bạn làm thừa — KHÔNG dọn dead code có sẵn.
Bám theo style hiện tại, kể cả khi nó không tối ưu.

## 4. Goal-driven execution
Định nghĩa tiêu chí thành công, lặp đến khi verify được.
"Fix the bug" → "Viết test tái hiện bug, rồi làm nó pass".
```

---

## Bước 9 — Quy trình duy trì

```
/init  →  dùng thật  →  Claude sai lần 2  →  thêm 1 dòng  →  review như code  →  /doctor cắt tỉa định kỳ
```

1. **Khởi tạo bằng `/init`.** Claude phân tích codebase, sinh CLAUDE.md với build command, test instruction, convention nó phát hiện được. Nếu file đã tồn tại, `/init` **đề xuất cải thiện** chứ không ghi đè. Bật `CLAUDE_CODE_NEW_INIT=1` để có flow tương tác nhiều pha (hỏi bạn muốn tạo CLAUDE.md / skills / hooks, khám phá codebase bằng subagent, đưa proposal để bạn duyệt trước khi ghi file).
   - `/init` cũng đọc `.cursor/rules/`, `.cursorrules`, `.github/copilot-instructions.md` để chuyển sang. Với `CLAUDE_CODE_NEW_INIT=1` thì đọc thêm `AGENTS.md`, `.devin/rules/`, `.windsurf/rules/`, `.clinerules`.
   - `/import` mang cấu hình agent khác vào (kèm MCP servers, commands, subagents, skills) — cần v2.1.213+.
2. **Commit vào git.** Cả team hưởng chung, thay đổi đi qua code review như mọi file khác.
3. **Cho nó một người chủ (owner).** Trong repo chung, ai cũng append và không ai xóa → chi phí cộng dồn theo quy mô.
4. **Bổ sung theo tín hiệu, không theo cảm hứng.** Bốn tín hiệu chính thức:
   - Claude mắc **cùng một lỗi lần thứ hai**
   - Code review bắt được thứ mà Claude lẽ ra phải biết
   - Bạn gõ lại đúng câu chỉnh sửa của session trước
   - Người mới vào team sẽ cần đúng context đó
5. **Nhờ chính Claude viết.** Sau khi sửa nó, bảo "cập nhật CLAUDE.md để lần sau khỏi sai" — *"Claude is very good at writing rules for itself."*
6. **Rà định kỳ (hàng quý).** Xóa luật lỗi thời, gộp luật trùng. Dùng **`/doctor`**: nó đề xuất cắt phần Claude tự suy ra được (cây thư mục, danh sách dependency, tổng quan kiến trúc) và **giữ lại** pitfall, lý do, và convention khác mặc định (cần v2.1.206+).

---

## Bước 10 — Debug khi Claude không nghe lời

| Triệu chứng | Cách xử lý |
|---|---|
| Không biết file có được nạp không | `/context` → xem mục **Memory files**. Không thấy tên file = Claude không hề thấy nó. |
| Cần mở/sửa file memory | `/memory` (liệt kê cả file chưa tồn tại; chọn là tạo luôn) |
| Đã nạp nhưng vẫn không tuân thủ | Viết cụ thể hơn ("2-space indentation" > "format nicely"); tìm luật mâu thuẫn giữa các file |
| Muốn biết **chính xác** file nào nạp, lúc nào, vì sao | Hook [`InstructionsLoaded`](https://code.claude.com/docs/en/hooks) |
| Luật "biến mất" sau `/compact` | CLAUDE.md ở **root project vẫn sống sót** (được đọc lại từ đĩa và tiêm lại). CLAUDE.md ở **thư mục con** và rule có `paths:` **không** được tiêm lại — chỉ nạp lại khi Claude chạm file tương ứng. Chỉ dẫn nói miệng trong chat thì mất → đó là lý do phải ghi vào CLAUDE.md. |
| Monorepo bị hút CLAUDE.md của team khác | `claudeMdExcludes` trong `.claude/settings.local.json` |
| Cần enforce cứng, không phải "đề nghị" | Hook / `permissions.deny` / managed settings |
| Cần chỉ dẫn ở mức system prompt | `--append-system-prompt` (phải truyền mỗi lần chạy → hợp cho script hơn là dùng tương tác) |

```json
// .claude/settings.local.json
{
  "claudeMdExcludes": [
    "**/monorepo/CLAUDE.md",
    "/home/user/monorepo/other-team/.claude/rules/**"
  ]
}
```

> Managed policy CLAUDE.md **không thể bị exclude** — chỉ dẫn cấp tổ chức luôn áp dụng.

---

## Bước 11 — Cho tổ chức / team lớn

- Deploy file tại **managed policy location** bằng MDM, Group Policy, Ansible.
- Hoặc nhúng thẳng nội dung vào `managed-settings.json` bằng key `claudeMd`:

```json
{
  "claudeMd": "Always run `make lint` before committing.\nNever push directly to main."
}
```

  Key này **chỉ có tác dụng** ở managed/policy settings — đặt ở user/project/local là vô nghĩa.

- **Phân vai rõ ràng giữa settings và CLAUDE.md:**

| Mối quan tâm | Cấu hình ở |
|---|---|
| Chặn tool / lệnh / path cụ thể | Managed settings: `permissions.deny` |
| Bắt buộc sandbox | Managed settings: `sandbox.enabled` |
| Env vars, API provider routing | Managed settings: `env` |
| Login method, giới hạn tổ chức | `forceLoginMethod`, `forceLoginOrgUUID` |
| Chuẩn code & chất lượng | **Managed CLAUDE.md** |
| Nhắc nhở xử lý dữ liệu & compliance | **Managed CLAUDE.md** |
| Hướng dẫn hành vi cho Claude | **Managed CLAUDE.md** |

---

## Bước 12 — 12 anti-pattern kinh điển

| # | Anti-pattern | Vấn đề | Cách sửa |
|---|---|---|---|
| 1 | **The Novel** | 500+ dòng lời khuyên chung chung Claude đã biết | Dưới 200 dòng; trỏ tới config linter thay vì chép lại |
| 2 | **The Paranoid Parent** | Bắt xin phép mọi thứ → giết năng suất | Định nghĩa rõ việc được tự làm; chỉ confirm việc rủi ro |
| 3 | **The Ghost Town** | Quá sơ sài, Claude phải đoán lại mỗi session | Có tech stack, commands, cấu trúc thư mục, mô tả project |
| 4 | **The Copy-Paste Special** | Copy template người khác, đầy luật không liên quan | Viết từ đầu: project làm gì, stack gì, convention riêng gì |
| 5 | **The Time Capsule** | Chỉ dẫn lỗi thời, trỏ tới pattern đã bỏ | Review định kỳ; ghi ngày/version |
| 6 | **The Contradiction Machine** | Luật mâu thuẫn → hành vi ngẫu nhiên | Đặt mức ưu tiên rõ; ghi rõ ngoại lệ |
| 7 | **The Jargon Jungle** | Acronym nội bộ Claude không hiểu | Có section glossary |
| 8 | **The Security Theater** | Luật bảo mật chung chung, không đúng rủi ro thật | Rủi ro cụ thể của project + ví dụ + wrapper function |
| 9 | **The Micromanager** | Flowchart cứng, vỡ khi gặp case lạ | Đưa nguyên tắc và pattern |
| 10 | **The Wishful Thinker** | Mô tả kiến trúc mong muốn, không phải hiện trạng | Ghi trung thực hiện trạng; target để tài liệu riêng |
| 11 | **The One Size Fits All** | Cùng độ nghiêm ngặt cho mọi loại code | Phân biệt production / UI / script / experiment |
| 12 | **The Silo** | Mỗi người một CLAUDE.md xung đột | Dùng phân cấp: team version + local override + personal global |

Cộng thêm hai cái từ nguồn khác:

- **`@`-import cả file docs lớn** vào mỗi run — file import vẫn nạp đầy đủ, đây là bloat trá hình.
- **Dán code block** thay vì trỏ `file:line`.

---

## Checklist trước khi commit CLAUDE.md

- [ ] Dưới **200 dòng** (lý tưởng: dưới ~2.000 token)
- [ ] Mọi command ghi **đúng cú pháp gõ được ngay**
- [ ] **Không** có luật mà linter/formatter đã enforce
- [ ] **Không** có code block — chỉ có tham chiếu `path/file.ts:42`
- [ ] **Không** có thứ Claude tự đọc code là biết (cây thư mục, dependency list)
- [ ] Ghi rõ **vùng cấm** (thư mục frozen, file generated, vendored code)
- [ ] Chỉ chứa luật **áp dụng mọi session** — cái theo task → Skill, cái theo path → rule có `paths:`
- [ ] Luật "tuyệt đối không" đã được chuyển thành **hook**, không nằm ở đây dưới dạng câu chữ
- [ ] Không có sở thích cá nhân (đẩy sang `CLAUDE.local.md` / `~/.claude/CLAUDE.md`)
- [ ] Không có hai luật mâu thuẫn nhau (rà cả file thư mục con và `.claude/rules/`)
- [ ] `CLAUDE.local.md` đã nằm trong `.gitignore`
- [ ] Đã commit vào git và được review trong PR
- [ ] Đã chạy `/context` xác nhận file thực sự được nạp

---

## Tóm tắt một câu

> **CLAUDE.md là working memory, không phải documentation.** Viết ngắn, cụ thể, kiểm chứng được; chỉ giữ thứ Claude không thể tự suy ra; đẩy quy trình sang Skill, luật theo path sang rules, và ràng buộc cứng sang hooks.

---

## Nguồn

- [How Claude remembers your project — Claude Code Docs](https://code.claude.com/docs/en/memory)
- [Extend Claude Code (features overview) — Claude Code Docs](https://code.claude.com/docs/en/features-overview)
- [Steering Claude Code: when to use CLAUDE.md, skills, hooks, rules, subagents — Anthropic](https://claude.com/blog/steering-claude-code-skills-hooks-rules-subagents-and-more)
- [Claude Code power user tips — Anthropic Help Center](https://support.claude.com/en/articles/14554000-claude-code-power-user-tips)
- [Claude Code Best Practices — Anthropic Engineering](https://www.anthropic.com/engineering/claude-code-best-practices)
- [CLAUDE.md Anti-Patterns: 12 Productivity Killers — ClaudeWorld](https://claude-world.com/articles/claude-md-antipatterns/)
- [CLAUDE.md Best Practices: The Complete 2026 Guide — maketocreate](https://maketocreate.com/claude-md-best-practices-the-complete-2026-guide/)
- [Karpathy's CLAUDE.md, Annotated (2026) — MCP.Directory](https://mcp.directory/blog/karpathy-claude-md-annotated-2026)
- [Claude Code Best Practices — rosmur.github.io](https://rosmur.github.io/claudecode-best-practices/)
- [How to Prevent CLAUDE.md Bloat — BSWEN](https://docs.bswen.com/blog/2026-04-23-prevent-claudemd-bloat/)
