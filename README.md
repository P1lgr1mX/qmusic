# qmusic (yt) - Minimalist YouTube Music CLI

Trình phát nhạc YouTube cực nhẹ, chạy ngầm dưới nền và điều khiển tức thì ngay trong terminal thông qua IPC socket.

## ✨ Tính năng nổi bật

1. **Tự bắt link từ Clipboard:**
   * Chỉ cần gõ `yt` và Enter — script tự động đọc clipboard (hỗ trợ cả Wayland với `wl-paste` và X11 với `xclip`/`xsel`) để phát ngay lập tức.
2. **Tìm kiếm bằng từ khóa:**
   * Không cần mở trình duyệt lấy link. Gõ từ khóa tìm kiếm (ví dụ: `yt "nhac remix vinahouse"` hoặc `yt lofi chill`), script tự động lấy kết quả đầu tiên và phát.
3. **Chạy ngầm & Điều khiển qua IPC Socket:**
   * Nhạc chạy hoàn toàn dưới nền, giải phóng cửa sổ terminal ngay lập tức.
   * Điều khiển nhanh chóng bằng các lệnh cực ngắn:
     * `yt p` : Tạm dừng / Tiếp tục phát (Pause / Resume)
     * `yt stop` : Tắt nhạc và dừng tiến trình
     * `yt v +5` / `yt v -5` / `yt v 80` : Tăng, giảm hoặc đặt mức âm lượng
     * `yt status` : Xem bài hát đang phát và thông số hiện tại
4. **Lưu bài tủ (Favorites / Bookmark):**
   * `yt --save` : Lưu link bài đang nghe vào file `~/.config/qmusic/fav.txt`.
   * `yt --fav` : Chọn ngẫu nhiên một bài trong danh sách tủ để phát khi bí bài.
   * `yt --fav list` : Xem danh sách bài tủ đã lưu.

---

## 🛠 Yêu cầu hệ thống (Dependencies)

* **Bash** (>= 4.0)
* **mpv**
* **yt-dlp**
* **socat** hoặc **nc** (dùng cho IPC socket)
* **wl-clipboard** (Wayland) hoặc **xclip** / **xsel** (X11)

Cài đặt trên Linux:
```bash
# Ubuntu / Debian
sudo apt update && sudo apt install mpv yt-dlp socat wl-clipboard xsel -y

# Fedora / RHEL
sudo dnf install mpv yt-dlp socat wl-clipboard xsel -y

# Arch Linux
sudo pacman -S mpv yt-dlp socat wl-clipboard xsel
```

---

## 🚀 Cài đặt & Sử dụng

Cấp quyền thực thi và tạo shortcut vào `~/.local/bin` (nếu chưa có):
```bash
chmod +x yt
ln -sf $(pwd)/yt ~/.local/bin/yt
```

### Các lệnh thông dụng:

| Lệnh | Chức năng |
| :--- | :--- |
| `yt` | Tự động đọc link YouTube từ clipboard và phát ngay |
| `yt <từ khóa>` | Tìm kiếm YouTube và phát bài đầu tiên |
| `yt <link>` | Phát trực tiếp từ đường link URL |
| `yt p` | Tạm dừng / Tiếp tục phát |
| `yt stop` | Tắt nhạc |
| `yt v +5` / `yt v -5` | Tăng / giảm âm lượng 5% |
| `yt v 80` | Đặt âm lượng ở mức 80% |
| `yt --save` | Lưu bài đang phát vào danh sách bài tủ |
| `yt --fav` | Phát ngẫu nhiên một bài trong danh sách tủ |
| `yt --fav list` | Xem toàn bộ danh sách bài tủ |
| `yt status` | Xem tiêu đề bài đang phát, link và trạng thái |
