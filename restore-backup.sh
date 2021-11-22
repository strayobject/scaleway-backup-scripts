#!/bin/bash

# Based on https://www.scaleway.com/en/docs/tutorials/backup-dedicated-server-s3-duplicity/

if [ $# -lt 3 ]; then
  echo -e "Usage $0 <config_dir> <time or delta> [file to restore] <restore to>
Exemple:
\t$ $0 2018-7-21 recovery/  ## recovers * from closest backup to date
\t$ $0 0D secret data/  ## recovers most recent file nammed 'secret'";
exit; fi

CONFIG_DIR=$1

source "$CONFIG_DIR"/.scw-configrc

if [ $# -eq 3 ]; then
  duplicity -v 9 -t $2 ${SCW_BUCKET} $3
fi

if [ $# -eq 4 ]; then
  duplicity -v 9 -t $2 -r $3 ${SCW_BUCKET} $4
fi
