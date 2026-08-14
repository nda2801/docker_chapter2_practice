#!/bin/bash
set -e

echo "=================================================="
echo "  [BÀI 1 & BÀI 2] BẮT ĐẦU QUY TRÌNH SETUP TỰ ĐỘNG "
echo "=================================================="

# 1. Tạo network
echo "[1/4] Tạo Docker Network: php-network..."
docker network inspect php-network >/dev/null 2>&1 || docker network create php-network

# 2. Chạy MySQL container
echo "[2/4] Khởi chạy container MySQL (Database)..."
if [ "$(docker ps -aq -f name=mysql-db)" ]; then
    echo "Đang gỡ bỏ container mysql-db cũ..."
    docker rm -f mysql-db
fi

docker run -d \
  --name mysql-db \
  --network php-network \
  -e MYSQL_ROOT_PASSWORD=Password123 \
  -e MYSQL_DATABASE=university \
  -v mysql_data:/var/lib/mysql \
  -v "$(pwd)/data/init.sql":/docker-entrypoint-initdb.d/init.sql \
  mysql:8.0

# 3. Build Docker Image cho PHP
echo "[3/4] Build PHP Image với tag php-web-app:2.0..."
docker build -t php-web-app:2.0 .

# 4. Chạy container PHP Web
echo "[4/4] Khởi chạy container Web (PHP Latest - Port 8889)..."
if [ "$(docker ps -aq -f name=php-web)" ]; then
    echo "Đang gỡ bỏ container php-web cũ..."
    docker rm -f php-web
fi

docker run -d \
  --name php-web \
  --network php-network \
  -p 8889:80 \
  php-web-app:2.0

echo "=================================================="
echo "  TRIỂN KHAI THÀNH CÔNG!"
echo "  - Cổng truy cập: http://localhost:8889"
echo "  - Kiểm tra trạng thái: docker ps"
echo "=================================================="
