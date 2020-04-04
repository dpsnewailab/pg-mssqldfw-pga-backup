#!/bin/bash

if [ -z "${BACKUP_EVERY_HOURS}" ]; then
  BACKUP_EVERY_HOURS=10
fi

while true; do
  echo "Backup file every ${BACKUP_EVERY_HOURS} hour(s)"
  docker exec postgresql bash -c 'bash backup.sh'
  echo "See you next time"
sleep ${BACKUP_EVERY_HOURS}h
done
