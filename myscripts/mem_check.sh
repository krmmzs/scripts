#!/bin/bash

# 设定内存阈值，以MB为单位
MEMORY_THRESHOLD=3000

# 获取当前系统内存使用情况
FREE_MEMORY=$(free -m | awk '/^Mem:/{print $4}')
CACHE_MEMORY=$(free -m | awk '/^Mem:/{print $6}')

# 计算空闲内存 + 缓存内存
AVAILABLE_MEMORY=$((FREE_MEMORY + CACHE_MEMORY))

# 判断可用内存是否小于阈值
if [ "$AVAILABLE_MEMORY" -lt "$MEMORY_THRESHOLD" ]; then
    # 可用内存小于阈值，发送桌面通知
    MESSAGE="警告：系统可用内存低于 ${MEMORY_THRESHOLD}MB！"
    echo "fuck"
    notify-send "内存提醒" "$MESSAGE"
fi
