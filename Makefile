# Makefile — biên nhận đọc lại của repo. Nhà của luật: CLAUDE.md §7 + .claude/rules/quan-ly-du-an.md §5.
#
# Giai đoạn này chưa có một dòng code ứng dụng nào, nên KHÔNG đích nào ở đây gọi `go` hay `npm`:
# hai thứ đó chưa cài, một đích đỏ ngay lần chạy đầu làm cả file này mất tin cậy và ba lane
# DB/BE/FE mất nền biên nhận. Đích ở đây chỉ dùng: wc -l · awk · grep -c · sed -n · test -e · git log -1.
#
# Mỗi đích khai "đỏ khi" ngay trên đầu nó. Đích nào không nói nổi mình đỏ khi nào là đích rỗng ruột.
# Ngưỡng KHÔNG chép vào đây: check-tran đọc trần thẳng từ CLAUDE.md §8 bằng sed -n, nên đổi trần
# ở nhà thật là đích này đi theo, không phải sửa hai chỗ.

SHELL := /bin/sh

SO   := CLAUDE.md task.md finding.md
LUAT := .claude/rules/quan-ly-du-an.md .claude/rules/bao-cao-thay-doi.md \
        .claude/rules/chat-luong-finding.md .claude/rules/lane-ba.md
HDAN := quality/00-guideline-chat-luong.md project_preparation/huong-dan-viet-task-md.md \
        design/BA/04-yeu-cau.md

NHA  := $(SO) $(LUAT) $(HDAN)

# QUET = tập file mà MỌI con trỏ phải giải được ngay hôm nay.
# project_preparation/prompt-fullstack.md cố tình đứng ngoài: 8 con trỏ hụt của nó là F-02 đang MỞ.
# Đóng F-02 rồi thì thêm file đó vào đây — đừng nới lệnh, hãy thu danh sách ngoại lệ.
QUET := $(NHA)

.DEFAULT_GOAL := check
.PHONY: check check-nha check-tran check-contro check-so check-lane

## check — cổng xanh/đỏ của phiên. Đỏ khi bất kỳ đích con nào đỏ.
check: check-nha check-tran check-contro check-so check-lane
		@echo "make check: XANH — 5 đích, 0 vi phạm"

## check-nha — mỗi "nhà" ở CLAUDE.md §2 phải có thật VÀ đã vào git.
## Đỏ khi: một file trong $(NHA) không tồn tại, hoặc tồn tại mà chưa có commit nào chạm nó
## (file chỉ nằm trên đĩa một máy thì phiên sau không nạp được — nó không phải nhà).
check-nha:
		@rc=0; for f in $(NHA); do \
		   test -e "$$f" || { echo "  ĐỎ nhà hụt: $$f không có trên đĩa"; rc=1; continue; }; \
		   [ -n "$$(git log -1 --format=%h -- $$f)" ] || { echo "  ĐỎ nhà chưa vào git: $$f"; rc=1; }; \
		 done; \
		 [ $$rc -eq 0 ] && echo "  nhà: $(words $(NHA)) file có thật + đã vào git"; \
		 exit $$rc

## check-tran — trần của CLAUDE.md, đọc ngưỡng từ chính §8 của nó.
## Đỏ khi: CLAUDE.md vượt số dòng §8 khai, hoặc có dòng dài hơn số byte §8 khai,
## hoặc §8 bị viết lại tới mức không sed ra được ngưỡng (mất ngưỡng cũng là đỏ, không phải bỏ qua).
check-tran:
		@tran=$$(sed -n 's/^Trần: \*\*\([0-9]*\) dòng\*\*.*/\1/p' CLAUDE.md | head -1); \
		 byte=$$(sed -n 's/.*mỗi dòng ≤ \([0-9]*\) byte.*/\1/p' CLAUDE.md | head -1); \
		 { [ -n "$$tran" ] && [ -n "$$byte" ]; } || { echo "  ĐỎ: không sed ra được trần ở CLAUDE.md §8"; exit 1; }; \
		 n=$$(wc -l < CLAUDE.md | tr -d ' '); rc=0; \
		 [ "$$n" -le "$$tran" ] || { echo "  ĐỎ trần dòng: CLAUDE.md $$n dòng > $$tran"; rc=1; }; \
		 dai=$$(LC_ALL=C awk -v m=$$byte 'length > m {printf "%s(%s byte) ", FNR, length}' CLAUDE.md); \
		 [ -z "$$dai" ] || { echo "  ĐỎ trần byte: CLAUDE.md dòng $$dai vượt $$byte byte"; rc=1; }; \
		 [ $$rc -eq 0 ] && echo "  trần: CLAUDE.md $$n/$$tran dòng, không dòng nào > $$byte byte"; \
		 exit $$rc

## check-contro — vòng lặp §5.1, bản đã vá theo F-11 (bỏ khối ``` và mã inline trước khi tìm con trỏ).
## Đỏ khi: một link ](đường-dẫn) nằm ngoài khối mã mà test -e không thấy file.
check-contro:
		@out=$$(for f in $(QUET); do d=$$(dirname $$f); \
		   awk '/^```/{k=!k; next} !k' $$f | sed 's/`[^`]*`//g' \
		     | grep -o '](\([^)#]*\)' | sed 's/](//' | grep -v '^http' | grep -v '^$$' | sort -u \
		     | while read p; do [ -e "$$d/$$p" ] || [ -e "$$p" ] || echo "  ĐỎ con trỏ hụt: $$f -> $$p"; done; \
		 done); \
		 [ -z "$$out" ] || { echo "$$out"; exit 1; }; \
		 echo "  con trỏ: $(words $(QUET)) file, mọi ](đường-dẫn) ngoài khối mã đều ra file thật"

## check-so — 12 phép tự rà task.md/finding.md ở rule §5.2, gom vào một cổng.
## Đỏ khi: một dòng task thiếu ô bắt buộc, một bảng soi mồ côi hay thiếu, mã task trùng,
## task đánh xong trước phụ thuộc của nó, hoặc một finding không mã task nào nhận.
## Mã finding lấy ĐẦU DÒNG — bảng đầu `| [F-xx]` và mục `### F-xx`; mã trích trong thân một mục
## khác (F-67 trong thân F-38) là trích dẫn, không phải finding của sổ, vét vào là báo nhầm (F-05).
check-so:
		@out=$$( \
		   grep '^| \*\*T-' task.md | awk -F'|' 'length($$(NF-5)) < 12 {print "  ĐỎ thiếu ô Đầu ra kiểm chứng được:" $$2}'; \
		   grep '^| \*\*T-' task.md | grep '⚠️+' | awk -F'|' '{print "  ĐỎ chạm 2 lane, phải chẻ:" $$2}'; \
		   grep '^| \*\*T-' task.md | awk -F'|' '$$(NF-4) !~ /👤|🤖/ {print "  ĐỎ thiếu ô Owner kiểm tra:" $$2}'; \
		   grep '^| ~*\*\*T-' task.md | grep -v '\[soi ↓\](#cl-t-' | awk -F'|' '{print "  ĐỎ thiếu ô Chất lượng:" $$2}'; \
		   for t in $$(grep -o '^| ~*\*\*T-[0-9]*' task.md | grep -o 'T-[0-9]*'); do \
		     grep -q "^### cl-$$t$$" task.md || echo "  ĐỎ thiếu bảng soi chất lượng: $$t"; \
		     grep -q "^### owner-$$t$$" task.md || echo "  ĐỎ thiếu bảng soi owner: $$t"; done; \
		   for c in $$(grep -o '^### cl-T-[0-9]*' task.md | grep -o 'T-[0-9]*'); do \
		     grep -q "^| ~*\*\*$$c\*\*" task.md || echo "  ĐỎ bảng soi chất lượng mồ côi: $$c"; done; \
		   for o in $$(grep -o '^### owner-T-[0-9]*' task.md | grep -o 'T-[0-9]*'); do \
		     grep -q "^| ~*\*\*$$o\*\*" task.md || echo "  ĐỎ bảng soi owner mồ côi: $$o"; done; \
		   grep -o '\*\*T-[0-9]*\*\*' task.md | sort | uniq -d | sed 's/^/  ĐỎ mã task trùng: /'; \
		   grep -n '^| \*\*T-[0-9]*\*\*[^|]*✅' task.md | cut -d: -f1 | sed 's/^/  ĐỎ đánh ✅ mà quên gạch ~~, dòng /'; \
		   grep '^| ~~\*\*T-' task.md \
		     | awk -F'|' 'NF==13 {t=substr($$2,index($$2,"T-"),4); n=split($$6,d,/[ ,]+/); \
		         for(i=1;i<=n;i++) if (d[i]~/^T-[0-9]+$$/) print t, d[i]}' \
		     | while read t dep; do grep -q "^| ~~\*\*$$dep\*\*" task.md \
		         || echo "  ĐỎ sai thứ tự: $$t đánh xong nhưng $$dep chưa"; done; \
		   for f in $$(grep -oE '^\| \[F-[0-9]{2}\]|^### F-[0-9]{2}' finding.md \
		                | grep -oE 'F-[0-9]{2}' | sort -u); do \
		     grep -q "^| \[$$f\].*⚠️" finding.md && continue; \
		     grep -q "$$f" task.md || echo "  ĐỎ finding bỏ rơi: $$f"; done; \
		 ); \
		 [ -z "$$out" ] || { echo "$$out"; exit 1; }; \
		 echo "  sổ: $$(grep -c '^| ~*\*\*T-' task.md) dòng task, 12 phép rà §5.2 sạch"

## check-lane — lệnh §5.2b: lane khai đã mở ở CLAUDE.md §1 thì phải mở đủ vế 3 và vế 5 của rule §6.
## Đỏ khi: một lane hết ⚠️ ở §1 mà thiếu .claude/rules/lane-<tên>.md, hoặc không dòng task nào mang lane đó.
check-lane:
		@out=$$(for L in ba db be fe devops; do \
		   U=$$(echo $$L | tr a-z A-Z); \
		   grep -qi "^| \*\*$$U\*\*.*⚠️ chưa" CLAUDE.md && continue; \
		   test -e ".claude/rules/lane-$$L.md" || echo "  ĐỎ lane nửa vời: $$L thiếu rule riêng"; \
		   grep -qi "^| \*\*T-[0-9]*\*\* *[^|]*| *$$U " task.md || echo "  ĐỎ lane nửa vời: $$L không dòng task nào"; \
		 done); \
		 [ -z "$$out" ] || { echo "$$out"; exit 1; }; \
		 echo "  lane: mọi lane hết ⚠️ ở CLAUDE.md §1 đều có rule riêng + dòng task"
