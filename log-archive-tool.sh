#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: log-archive <log-directory>"
    exit 1
fi

LOG_DIR="$1"

if [ ! -d "$LOG_DIR" ]; then
    echo "Error: Directory '$LOG_DIR' does not exist."
    exit 1
fi

ARCHIVE_DIR="archives"
mkdir -p "$ARCHIVE_DIR"

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
ARCHIVE_NAME="logs_archive_${TIMESTAMP}.tar.gz"
ARCHIVE_PATH="${ARCHIVE_DIR}/${ARCHIVE_NAME}"

tar -czf "$ARCHIVE_PATH" -C "$(dirname "$LOG_DIR")" "$(basename "$LOG_DIR")" 2>/dev/null

if [ $? -eq 0 ]; then
    echo "Archive created: $ARCHIVE_PATH"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Archived $LOG_DIR to $ARCHIVE_PATH" >> archive.log
else
    echo "Error: Failed to create archive."
    exit 1
fi