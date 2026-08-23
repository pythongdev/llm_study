# 04 · Yêu cầu của pha 0 — nhà của lane BA

> Cập nhật **2026-08-23**. File này là **hợp đồng nghiệm thu của pha 0**: pha 0 phải đẻ ra cái gì, và
> mỗi cái đó chứng minh bằng lệnh nào. Nó **không** chứa nội dung pha 0 — chưa một dòng luồng nghiệp vụ
> nào được viết ra ở đây, đó là việc của phiên sau.
>
> Luật viết một dòng yêu cầu, ranh giới cứng, và lệnh bắt vi phạm: `.claude/rules/lane-ba.md` §2 §3 —
> file này **không chép lại**, chỉ trỏ. Đường dẫn viết trong backtick tính từ gốc repo: phần lớn file
> đích **chưa tồn tại**, và link markdown tới file chưa có sẽ báo `TRỎ HỤT` ở vòng lặp con trỏ §5.1.

## §1 Pha 0 phải đẻ ra bốn thứ

Nguồn: `project_preparation/prompt-fullstack.md` §7, ô *Đầu ra bắt buộc* của dòng `**0 · BA**`. Bảng
dưới **không** chép lại nội dung bốn thứ đó — nó cấp cho mỗi thứ đúng hai cái mà §7 không cấp: **một
nhà** và **một điều kiện đạt đo được**.

| # | Đầu ra bắt buộc | Nhà của nó | Đạt khi |
|---|---|---|---|
| Đ1 | 4 kênh bán, mỗi kênh nói rõ: ai bấm · có gắn số bàn không · tiền thu ở khâu nào | ⚠️ `design/BA/01-kenh-ban.md` — chưa có | bảng ra **đúng 4** dòng kênh, mỗi dòng đủ ba ô trên, không ô nào bỏ trống |
| Đ2 | 2 sơ đồ luồng: ăn tại bàn, và ship | ⚠️ `design/BA/02-luong.md` — chưa có | **2** khối sơ đồ, mỗi khối đi đủ ba mốc *mở → xác nhận → đóng*, và khối ship nêu rõ nó khác khối tại bàn ở mấy điểm |
| Đ3 | Danh sách quy tắc nghiệp vụ, mỗi quy tắc **một** dòng mang mã `QT-xx` | ⚠️ `design/BA/03-quy-tac.md` — chưa có | `>= 12` dòng `QT-`, không mã trùng, mỗi dòng qua **cả bốn** phép thử ở `lane-ba.md` §3 |
| Đ4 | 3 câu từng treo ở §3.2 | **đã chốt rồi** — `prompt-fullstack.md` §3.2, owner chốt 2026-08-19; nhà thật ⚠️ `project_preparation/00-scope.md` §4.4 (T-05 tạo) | pha 0 **trỏ** tới chỗ đã chốt và dừng lại — xem cảnh báo dưới bảng |

**Đ4 là một cái bẫy, đọc trước khi làm.** §7 viết *"trả lời 3 câu chưa rõ ở §3.2"*, nhưng §3.2 hôm nay
ghi rõ ba câu đó **owner đã chốt ngày 2026-08-19**. Phiên nào đọc §7 rồi đi tìm "ba câu chưa rõ" sẽ
không thấy câu nào, và rủi ro thật là nó **tự nghĩ ra ba câu khác** rồi tự trả lời — im lặng, không
lệnh nào đỏ. Đ4 vì vậy đạt bằng **một dòng trỏ**, không bằng ba câu trả lời mới. Câu chữ ở §7 là chỗ
cần sửa, không phải chỗ cần tuân theo: xem §4 dưới.

**Vì sao Đ1 dùng hằng số `4` còn Đ3 dùng ngưỡng `>= 12`.** `.claude/rules/quan-ly-du-an.md` §1.1 bắt
viết kỳ vọng bằng **ngưỡng** cho thứ còn được sửa tiếp. Số kênh bán là **4** vì §3.1 chốt đúng bốn kênh
— thêm kênh thứ năm là đổi phạm vi, việc của owner, và lúc đó dòng này phải đỏ. Ngược lại số quy tắc
nghiệp vụ chỉ tăng, nên nó là ngưỡng. Sàn `12` không bịa: đếm các quy tắc đã nằm rải rác trong §3.1–§3.3
(giờ bán · nút tạm dừng nhận đơn đè lên giờ bán · hai kênh gắn bàn gộp một phiên tính tiền một lần ·
quầy xác nhận chống đơn ảo · ship cần số điện thoại · ship không có phiên bàn · phí ship · đơn tối
thiểu · công thức giá · phụ thu combo ×4 · lượng nhân chỉ hiện khi nhân khác chay · mặc định nhân thịt
lượng thường · dọn bàn xong bàn mới trống) đã ra hơn mười hai. Pha 0 **gom** chúng lại, không phát minh
thêm; đẻ ra quy tắc mới mà §3 không nói là đã tự chốt hộ owner.

## §2 Biên nhận của lane BA — lệnh đọc lại, chạy từ gốc repo

Lane BA chưa có compiler (`CLAUDE.md` §7), nên biên nhận là **lệnh đọc lại**. Bốn lệnh dưới là **cổng**:
đỏ một lệnh thì lane chưa xanh, và không có ô nào tên "đọc lại thấy ổn".

- `test -e design/BA/04-yeu-cau.md` — nhà của lane có thật. Không kêu là đạt.
- `grep -c '^| Đ[0-9]' design/BA/04-yeu-cau.md` — ra `4`. Bốn đầu ra bắt buộc còn đủ; ai bớt lặng lẽ một dòng thì lệnh này đỏ ngay, chứ không đợi tới lúc pha 0 giao thiếu.
- `head -6 .claude/rules/lane-ba.md` — in ra frontmatter `paths:` trỏ `design/BA/**`. Lệnh này chứng minh **file rule có thật**, nó **không** chứng minh rule được nạp vào phiên — chỗ hụt đó là `finding.md` F-12, đừng đọc nó rộng hơn thế.
- `grep -n 'design/BA' CLAUDE.md` — ra `>= 1`. Bảng lane ở `CLAUDE.md` §1 đã biết lane này tồn tại và trỏ đúng thư mục.

Hai lệnh của `lane-ba.md` §2 §3 — bắt vi phạm ranh giới, và soi câu chữ mơ hồ — **chưa** nằm trong bốn
cổng trên vì `design/BA/` mới có mỗi file này. Chúng thành cổng ngay khi Đ1 hoặc Đ2 hoặc Đ3 có file đầu tiên.

Khi pha 0 đã viết ra nội dung, thêm đúng **ba** lệnh nữa — Đ1 Đ2 Đ3 mỗi đầu ra một lệnh, lấy nguyên cột
*Đạt khi* ở §1 làm kỳ vọng. Chưa viết thì **chưa thêm**: một lệnh trỏ vào file chưa có là biên nhận đỏ
vĩnh viễn, và biên nhận đỏ vĩnh viễn thì phiên sau học cách bỏ qua nó.

## §3 Trạng thái hôm nay — lane vừa mở, nội dung chưa viết

| Vế của quy trình mở lane (`quan-ly-du-an.md` §6) | Hôm nay |
|---|---|
| 1 · nhà của lane tồn tại | ✅ `design/BA/` |
| 2 · biên nhận chạy được | ✅ bốn lệnh ở §2 |
| 3 · rule riêng có `paths:` | ✅ `.claude/rules/lane-ba.md` |
| 4 · đúng một dòng `CLAUDE.md` §1 hết ⚠️ | ✅ |
| 5 · dòng task đầu tiên của lane có mặt | ✅ dòng **T-02** — nhưng xem cảnh báo ở §4 |

Đ1 Đ2 Đ3 **chưa có một dòng nội dung nào**. Đó là đúng kế hoạch, không phải thiếu sót: T-02 mở lane và
dừng ở đó, để phiên sau vào với context sạch.

## §4 Hai chỗ hụt đã biết — đọc trước khi mở phiên pha 0

1. **§7 nói ba câu chưa rõ, §3.2 nói đã chốt.** Chi tiết ở cảnh báo dưới bảng §1. Cách sửa gọn nhất:
   sửa ô *Đầu ra bắt buộc* của dòng `**0 · BA**` thành *"trỏ tới chỗ owner đã chốt ở §3.2"*. Việc này
   chạm `project_preparation/prompt-fullstack.md` — **lane NON-CODE**, không phải lane BA, nên nó là
   một dòng task riêng, chưa có ai mở.
2. **Đóng T-02 xong thì vế 5 tự đỏ.** Lệnh §5.2b dò dòng task bằng mẫu `^| \*\*T-`; task xong bị bọc
   `~~**T-02**~~` nên không còn khớp. T-02 là dòng task **BA duy nhất**, nên ngay khi nó được đánh xong,
   lệnh in ra `LANE NỬA VỜI: ba không dòng task nào`. Muốn vế 5 xanh thật thì `task.md` phải có sẵn dòng
   task pha 0 **trước khi** T-02 bị gạch. T-02 bị cấm chạm `task.md` nên phiên này không tự làm được —
   đây là việc owner chốt. Cùng cái bẫy sẽ lặp lại nguyên xi ở T-07 · T-08 · T-09, mỗi lane cũng chỉ có
   đúng một dòng task mở lane.
