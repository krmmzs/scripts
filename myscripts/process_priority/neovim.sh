#!/bin/bash
# 替换APPLICATION_NAME为你的应用名称关键字
APPLICATION_NAME="nvim"
# 设置想要的nice值（-20到19，越小优先级越高）
NICE_VALUE=-10

# 找出所有匹配的进程并修改优先级
for PID in $(pgrep -f $APPLICATION_NAME); do
    echo "正在修改PID为 $PID 的进程优先级"
    sudo renice -n $NICE_VALUE -p "$PID"
done
ps -eo pid,ppid,ni,comm | pgrep $APPLICATION_NAME
