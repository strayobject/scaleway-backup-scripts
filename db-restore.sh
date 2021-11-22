#!/bin/bash

if [ $# -lt 4 ]; then
  echo -e "Usage $0 <container_name> <db_user_name> <db_name> <backup_file_path>"
  echo -e "Exemple:"
  echo -e "$ $0 taiga_taiga-db_1 taiga taiga /backups/db/db.pgdata ## based on defaults from Taiga docker repo
  ";
  exit;
fi

CONTAINER_NAME=$1
DB_USER=$2
DB_NAME=$3
BACKUP_FILE_PATH=$4

docker exec -i "$CONTAINER_NAME" pg_restore --username="$DB_USER" --dbname="$DB_NAME" --verbose --clean < "$BACKUP_FILE_PATH"
