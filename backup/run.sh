#!/bin/bash

if [ -z "${BACKUP_EVERY_HOURS}" ]; then
  BACKUP_EVERY_HOURS="10"
fi

if [ -z "${BACKUP_AT_TIME}" ]; then
  BACKUP_AT_TIME="-1"
fi

if [ "${BACKUP_AT_TIME}" != "-1" ] ; then
  while true; do
    currenttime=$(date +%H:%M)
    if [ "$currenttime" == "${BACKUP_AT_TIME}" ] ; then
      echo "Backup file at $currenttime"
      docker exec postgresql bash -c 'bash backup.sh'
      echo "See you next time....."
      sleep 2h
    fi
    sleep 15
  done
else
  while true; do
    echo "Backup file every ${BACKUP_EVERY_HOURS} hour(s)"
    docker exec postgresql bash -c 'bash backup.sh'
    echo "See you next time....."
    sleep ${BACKUP_EVERY_HOURS}h
  done
fi
