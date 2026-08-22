Nên thứ tự làm là ba lớp, không được đảo:

Lớp	Là gì	Trạng thái
1. Thiết kế	project_preparation/prompt-fullstack.md — 6 pha, 11 ràng buộc, bất biến I1–I8, bảng giá	✅ đã có từ trước
2. Bộ khung quản lý	luật để mọi phiên sau chạy cùng một cách: lane nào sửa file nào, sự thật nào ở nhà nào, "xong" nghĩa là gì	✅ vừa xong ở session 1
3. Code ứng dụng	Go, MySQL, Next.js	⬜ chưa bắt đầu, và cố ý chưa bắt đầu
Viết code trước khi có lớp 2 không phải "đi nhanh hơn" — nó là tạo ra thứ chưa ai rà được.

B. Session 1 đã làm gì — từng bước
Khối 1 (system) giao vai + luật chơi, khối 2 (user) giao việc. Phiên đó chạy 4 bước:

Bước 1 — Đo hiện trạng trước khi viết một chữ
Chạy ls -a, git log, đọc 5 tài liệu. Đây là bước quan trọng nhất, vì nó chống lại cái bẫy lớn nhất: reference/CLAUDE_rẻence.md là bản mẫu đã chạy thật nhưng của dự án ở giai đoạn xa hơn — nó nói tới code/be/, Makefile, migrations/, F-01…F-67, 6 lane đang mở. Chép nó = vẽ bản đồ cho lãnh thổ chưa tồn tại, và phiên sau sẽ đi theo bản đồ đó rồi tự tạo ra một cấu trúc khác.

Kết quả đo: repo không có code/, design/, quality/, Makefile, database. Và 8 đường dẫn mà prompt-fullstack.md trỏ tới không tồn tại.

Bước 2 — Tạo 4 file, mỗi file một nhiệm vụ
File	Dòng	Nạp lúc nào	Trả lời câu gì
CLAUDE.md	92	mọi request, mọi phiên	luật nào áp cho mọi phiên · lane nào sở hữu file nào · sự thật nào ở nhà nào
.claude/rules/quan-ly-du-an.md	180	chỉ khi chạm task.md/finding.md/project_preparation/**/design/**	một dòng task viết thế nào · "XONG" nghĩa là gì khi chưa có compiler · lệnh nào dò phiên trôi
task.md	40	khi đọc	làm gì tiếp, theo thứ tự nào
finding.md	94	khi đọc	cái gì đang sai ngay bây giờ
Chỗ tinh tế nhất là vì sao tách hai file đầu: CLAUDE.md tốn token ở mọi request nên phải ≤ 120 dòng; sổ tay 180 dòng kia chỉ nạp khi thật sự cần. Nhưng có một đánh đổi: rule có paths: không được tiêm lại sau /compact, nên luật nào mất giữa phiên là gây hỏng (cấm git add -A, việc thuộc quyền bạn) phải nằm ở CLAUDE.md gốc dù nó "hợp với sổ tay hơn".

Bước 3 — Đối chiếu 11 thành phần prompt
Đây là vế bạn yêu cầu: CLAUDE.md + một dòng task cộng lại phải phủ đủ 11 thành phần của một prompt tốt. Cơ chế: thành phần ổn định (vai trò, phạm vi, quy trình) nằm ở CLAUDE.md — phiên tự đọc mỗi lần; thành phần theo từng việc (nạp file nào, bẫy ở đâu, hỏng thì mất gì) nằm trong 9 cột của dòng task. Chép luật chung vào từng dòng task = nhân bản nó lên 11 lần, và bản thứ 11 sẽ khác bản gốc.

Bước 4 — Chạy 7 lệnh tự kiểm, dán output thật
Không phải "tôi đã kiểm tra kỹ" mà là wc -l < CLAUDE.md → 92. 6/7 lệnh đạt.

C. Ba vấn đề nó gặp
Đây là phần đáng giá nhất của session 1 — nó không giấu ba chỗ sai, kể cả chỗ do chính nó gây ra.

F-01 — Dự án có hai hệ tên cho cùng một trục chia việc ✅ đã đóng
reference/task.md chia 5 "Giai đoạn", prompt-fullstack.md §7 chia 6 "Pha". Hai hệ tên ⇒ mỗi phiên hiểu một kiểu, grep không ra chung.

Chốt: dùng 6 Pha, vì hệ đó mang ranh giới cứng (pha 0–1 không nhắc tên bảng, pha 2 không nhắc endpoint) — cơ chế duy nhất chặn một phiên làm việc của pha sau. Hệ 5 Giai đoạn không có ranh giới đó.

F-02 — prompt-fullstack.md trỏ tới 8 file không tồn tại 🔴 còn mở
00-scope.md, quality/05-checklist.md, 4 file design/*/01-thiet-ke.md, và ../CLAUDE.md (sai cả cấp thư mục).

Vì sao đây là lỗi chứ không phải việc chưa làm — đây là phép thử quan trọng nhất trong cả hệ thống: chạy hết mọi dòng trong task.md y như nó viết, dòng này còn không? Còn. Vì kế hoạch có tạo 00-scope.md và quality/05-checklist.md, nhưng 4 con trỏ design/*/01-thiet-ke.md vẫn hụt và ../CLAUDE.md vẫn sai cấp. ⇒ finding, đi sổ lỗi.

Hậu quả nếu bỏ qua: phiên nào đó đọc file này, đi tìm design/backend/01-thiet-ke.md, không thấy, rồi tự tạo một cấu trúc khác — im lặng, không lệnh nào đỏ.

F-03 — Lỗi trong chính bộ khung nó vừa dựng 🔴 còn mở
.claude/rules/quan-ly-du-an.md có paths: là task.md, finding.md, project_preparation/**, design/**. Nhưng quy trình mở một lane nằm trong chính rule đó lại yêu cầu sửa CLAUDE.md §1 và tạo .claude/rules/lane-*.md — hai file không nằm trong paths:.

Tức: đúng lúc cần sổ tay nhất thì nó không được nạp. Và cả 5 task mở lane (T-02, T-06, T-07, T-08, T-09) đều chạy trong tình trạng này.

Nó không tự sửa, vì paths: là kiến trúc bạn đã chốt — đúng luật van xả: thấy vấn đề khác thì ghi finding kèm cách sửa, rồi quay lại việc đang làm. Nó chỉ vá tạm bằng cách cho 5 task đó trỏ thẳng tới rule §6 — nhưng đó là 5 bản chép của cùng một con trỏ, và chính finding tự thừa nhận điều đó.

👉 Đây là việc đang chờ bạn quyết (T-11): có cho thêm "CLAUDE.md" + ".claude/rules/**" vào paths: không? Tôi đồng ý là nên — CLAUDE.md là file lane NON-CODE sở hữu và sửa thường xuyên nhất.

D. Session 2 (lượt 2) sẽ làm gì, và vì sao cần
Session 1 tự chấm bài mình. Đó là bài kiểm tra yếu nhất — nó biết mình định viết gì nên đọc gì cũng thấy đủ nghĩa.

Lượt 2 đổi góc: bắt nó đóng vai một phiên trí nhớ trắng, chỉ được đọc 4 file đó, nhận đúng dòng task mà lệnh "Task tiếp theo" dò ra (hiện là T-02 — mở lane BA), rồi diễn lại từng bước bằng lệnh cụ thể.

Nó phải tìm ra 3 loại lỗ hổng, xếp theo mức nguy hiểm tăng dần:

Chỗ phiên mới phải đoán
Chỗ phiên mới phải hỏi lại bạn — tức bộ khung chưa gánh được việc của nó
⚠️ Chỗ phiên mới làm sai được mà không lệnh nào đỏ — loại này chỉ lộ ra sau nhiều phiên, lúc đó sửa đã đắt
Tôi đã thêm một ngoại lệ vào luot-2.txt: lỗ hổng nào chỉ sửa được bằng cách đổi kiến trúc file thì nó không tự sửa, chỉ ghi finding — đúng như F-03 đã làm.

Vì sao đáng bỏ một phiên cho việc này: sửa bộ khung bây giờ tốn một phiên. Sửa nó sau khi 10 phiên đã xây trên nền sai thì phải sửa cả 10.

E. Sau lượt 2 thì đi đâu
Sổ hiện có 11 task, T-01 đã ✅. Hai task mang 🔺 (chặn task khác):

T-02 🔺 BA — tạo design/BA/ để pha 0 có nhà
T-03 🔺 DEVOPS — tạo Makefile, vì T-04/T-06/T-07 đều đợi nó
Đường đi: lượt 2 (vá bộ khung) → quyết T-11 → T-02 + T-03 → mở dần các lane (T-06 DEVOPS → T-07 DB → T-08 BE → T-09 FE) → lượt 4 vào Pha 0 BA, tức lúc đó mới bắt đầu thiết kế nghiệp vụ thật.

Code Go/SQL/React nằm ở tận Pha 2–4, còn xa.

Một lưu ý nhỏ cho lượt 2: M project_preparation/huong-dan-viet-task-md.md vẫn đang bẩn. Bước ĐIỂM LÙI trong CLAUDE.md §3 sẽ báo cây không sạch. Bạn commit hoặc git stash nó trước cho gọn, hoặc cứ nói với phiên đó rằng file này là việc dở của bạn, đừng đụng vào.
