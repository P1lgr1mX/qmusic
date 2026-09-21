#!/bin/bash

# Kiểm tra xem người dùng có truyền link vào không
if [ -z "$1" ]; then
    echo "Lỗi: Bạn chưa nhập link YouTube!"
    echo "Cách dùng: ./ezmusic.sh <LINK_YOUTUBE>"
    exit 1
fi

link_yt="$1"

echo "Đang lấy luồng âm thanh từ YouTube..."
echo "Mẹo điều khiển: [Space] Dừng/Phát | [9]/[0] Giảm/Tăng âm lượng | [q] Thoát"
echo "------------------------------------------------------------------------"

# Chạy mpv lấy audio trực tiếp thông qua yt-dlp 
# Sử dụng cú pháp $(...) thay cho cặp ngoặc đơn của Fish
mpv --no-video --vo=null "$(yt-dlp -g -f bestaudio "$link_yt")"
