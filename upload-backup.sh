#!/bin/bash

# Based on https://www.scaleway.com/en/docs/tutorials/backup-dedicated-server-s3-duplicity/

if [ $# -lt 2 ]; then
  echo -e "Usage $0 <config_dir>
Exemple:
\t$ $0 /root";
exit; fi

CONFIG_DIR=$1

source "$CONFIG_DIR"/.scw-configrc

currently_backingup=$(ps -ef | grep duplicity  | grep python | wc -l)

if [ $currently_backingup -eq 0 ]; then
  # Clear the recent log file
  cat /dev/null > ${LOGFILE_RECENT}

  log ">>> removing old backups"
  duplicity remove-older-than ${KEEP_BACKUP_TIME} ${SCW_BUCKET} >> ${LOGFILE_RECENT} 2>&1

  log ">>> creating and uploading backup to c14 cold storage"
  duplicity \
  incr --full-if-older-than ${FULL_BACKUP_TIME} \
  --asynchronous-upload \
  --s3-use-glacier \
  --encrypt-key=${GPG_FINGERPRINT} \
  --sign-key=${GPG_FINGERPRINT} \
  ${SOURCE} ${SCW_BUCKET} >> ${LOGFILE_RECENT} 2>&1

  cat ${LOGFILE_RECENT} >> ${LOGFILE}
fi
