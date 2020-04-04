#!/bin/bash

MYDATE=$(date +%Y-%m-%d-%H.%M.%S)

if [ -z "${DELETE_BACKUP_AFTER_DAYS}" ]; then
  DELETE_BACKUP_AFTER_DAYS=7
fi

echo "Backup file /backup/nfc-${MYDATE}.gz"
pg_dumpall -h localhost -U ${POSTGRES_USER} | gzip > /backup/nfc-${MYDATE}.gz

echo "Delete file older than ${DELETE_BACKUP_AFTER_DAYS} days"
find /backup/ -mindepth 1 -mtime +${DELETE_BACKUP_AFTER_DAYS} -delete