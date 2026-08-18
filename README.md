# 🚀 Thực hành Docker Chương 2 - Tự Động Hóa 1 Lệnh (One-Click)

Kho mã nguồn này chứa toàn bộ cấu hình, mã nguồn và script tự động hóa để triển khai và kiểm tra **Bài 1** và **Bài 2** môn học theo giáo trình.

---

## 📂 Cấu trúc Repository

```text
docker-chapter02-practice/
├── data/
│   └── init.sql          # Khởi tạo bảng và dữ liệu mẫu
├── src/
│   └── index.php         # Ứng dụng PHP kết nối MySQL
├── .dockerignore         # Loại trừ file rác khi build
├── .gitignore            # Loại trừ file git
├── Dockerfile            # Dockerfile dùng PHP mới nhất (php:apache)
├── setup.sh              # Script chạy tự động toàn bộ bài thực hành
├── clean.sh              # Script dọn dẹp sạch sẽ môi trường
└── README.md             # Hướng dẫn chi tiết
```

---

## ⚡ Hướng Dẫn Chạy Nhanh (Chỉ 1 Lệnh)

### 1. Clone repository về máy ảo:
```bash
git clone <URL_REPO_GITHUB_CỦA_BẠN>
cd docker-chapter2-practice
```

### 2. Cấp quyền và chạy script setup:
```bash
chmod +x setup.sh clean.sh
./setup.sh
```

Hệ thống sẽ tự động:
1. Tạo Docker network `php-network`
2. Khởi chạy MySQL với volume `mysql_data` và nạp dữ liệu từ `init.sql`
3. Build image PHP mới nhất với tag `php-web-app:2.0`
4. Khởi chạy Web container ánh xạ cổng `8889:80`

### 3. Kiểm tra kết quả:
* **Từ terminal máy ảo:**
  ```bash
  curl http://localhost:8889
  ```
* **Từ trình duyệt:** Truy cập `http://localhost:8889` hoặc `http://<IP_MÁY_ẢO>:8889`.

---

## 📋 Lệnh Show Quá Trình & Kết Quả Cho Giảng Viên

```bash
# 1. Show cấu hình Dockerfile (dùng PHP Apache mới nhất)
cat Dockerfile

# 2. Show image với tag mới (php-web-app:2.0)
docker images | grep php-web-app

# 3. Show trạng thái các container đang chạy trên cổng 8889
docker ps

# 4. Show log Web & Database
docker logs php-web
docker logs mysql-db

# 5. Show kết nối mạng nội bộ giữa 2 container
docker exec -it php-web ping -c 3 mysql-db
```

---

## 🧹 Dọn dẹp môi trường khi muốn chạy lại từ đầu:
```bash
./clean.sh
```
