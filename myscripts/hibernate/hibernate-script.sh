#!/bin/bash
# 尝试休眠，如果失败则重试
times=5
for i in $(seq 1 $times); do
    echo "尝试休眠 ($i/$times)..."
    systemctl hibernate
    sleep 5
    # 如果成功休眠，脚本会停止执行
done
