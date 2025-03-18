#!/bin/bash

TELEGRAM_BOT_TOKEN=""
TELEGRAM_CHAT_ID=""
PARTITION="/dev/sda1"
SERVER="s1"
THRESHOLD=80 #порог в процентах при которых отправляется уведомление

send_telegram_message() {
    local message="$1"
    curl -s -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage" \
        -d chat_id="$TELEGRAM_CHAT_ID" \
        -d text="$message"
}

disk_usage=$(df -h | grep "$PARTITION" | awk '{print $5}' | sed 's/%//')
inode_usage=$(df -i | grep "$PARTITION" | awk '{print $5}' | sed 's/%//')

if [[ "$disk_usage" -ge "$THRESHOLD" ]]; then
    send_telegram_message "Диск $SERVER:$PARTITION заполнен на ${disk_usage}%"
fi

if [[ "$inode_usage" -ge "$THRESHOLD" ]]; then
    send_telegram_message "Количество inodes на $SERVER:$PARTITION достигло ${inode_usage}%"
fi
