#!/bin/bash
# put your create extension and database here
# Thêm cài đặt bảng, database cho FDW tại đây. ${} là môi trường trong file .env

echo "Create extensions"

psql -h localhost -U ${POSTGRES_USER} << EOF

CREATE DATABASE ${APPLICATION_DATABASE};

\c ${APPLICATION_DATABASE};

CREATE EXTENSION tds_fdw;

EOF

echo "Create tables"

psql -h localhost -U ${POSTGRES_USER} ${APPLICATION_DATABASE} -a -f script.sql