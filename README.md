#### Cài đặt postgresql + data wrapper + backup agent + pgadmin  

#####1. Lệnh khởi tạo database và extension
Khởi tạo database và dữ liệu mẫu nằm tại `psql/script.sql`

Khởi tạo foreign wrapper và database tại `psql/init_script.sh` (từ dòng `7` đến dòng `15`)

#####2. Các tham số cài đặt

Các cài đặt server được cấu hình trong `.env` gồm 

|Variable|Description|Default value (production)|
|--------|------------|--------------------------|
|`POSTGRES_VERSION`|Phiên bản psql|`11`|
|`POSTGRES_USER`|Khởi tạo supper user của psql|`admin`|
|`POSTGRES_PASSWORD`|Mật khẩu mặc định của supper user|`defaultPassworD`|
|`PGDATA`|Thư mục lưu trữ dữ liệu psql|`/var/lib/postgresql/data`|
|`TZ`|Time zone|`Asia/Ho_Chi_Minh`|
|`TDS_FDW_VERSION`|Version data foreign wrapper MSSQL|`2.0.0-alpha.3`|
|`APPLICATION_DATABASE`|Database khởi tạo cho ứng dụng|`nfc_in_lowercase`|
|`MSSQL_HOST`|Microsoft SQL host|`localhost`|
|`MSSQL_USER`|Microsoft SQL user|`sa`|
|`MSSQL_PASSWORD`|Microsoft SQL password|`MSSQL_PASSWORD`|
|`BACKUP_EVERY_HOURS`|Thời gian chạy backup theo giờ|`10`|
|`DELETE_BACKUP_AFTER_DAYS`|Dữ liệu backup được lưu lâu nhất bao nhiêu ngày|`7`|


#####3. Cài đặt

** Lấy quyền supper user trước khi cài đặt và sau đó chạy lệnh:

```bash install.sh```

-- Support: Ubuntu, Debian, Fedora, CentOS 


** Nếu dùng platform khác chạy lệnh cài `docker` và `docker-compose` và chạy các lệnh 

```
source .env

docker-compose build

docker-compose up -d

docker-compose exec postgresql bash -c 'bash init_script.sh'
```

