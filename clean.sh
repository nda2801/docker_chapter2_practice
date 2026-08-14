#!/bin/bash
echo "Đang dọn dẹp môi trường Docker..."
docker rm -f php-web mysql-db 2>/dev/null || true
docker network rm php-network 2>/dev/null || true
docker volume rm mysql_data 2>/dev/null || true
echo "Dọn dẹp hoàn tất!"
