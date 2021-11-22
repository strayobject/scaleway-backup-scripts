#!/bin/bash

# This script is quite pointless at the moment.
if [ $# -lt 2 ]; then
  echo -e "Usage $0 <source_dir_path> <backup_dir_path>"
  echo -e "Exemple:"
  echo -e "$ $0 /var/lib/docker/volumes/taiga_taiga-media-data/_data /backups/media ## based on defaults from Taiga docker repo
  ";
  exit;
fi

SOURCE_DIR_PATH=$1
BACKUP_FILE_PATH=$2

cp -R "$SOURCE_DIR_PATH" "$BACKUP_FILE_PATH"
