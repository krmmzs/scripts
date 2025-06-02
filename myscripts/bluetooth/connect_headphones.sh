#!/bin/bash

# 设置您的耳机名称（请替换为实际名称）
HEADPHONES_NAME=$HEADPHONES_SET

echo "开始连接 $HEADPHONES_NAME..."

# 启动蓝牙（如果尚未启动）
if ! systemctl is-active --quiet bluetooth; then
    echo "启动蓝牙服务..."
    sudo systemctl start bluetooth
    sleep 2
fi

# 尝试从已配对设备中查找并连接
echo "查找已配对设备..."
DEVICE_MAC=$(bluetoothctl devices | grep "$HEADPHONES_NAME" | head -n 1 | cut -d ' ' -f 2)

if [ -n "$DEVICE_MAC" ]; then
    echo "找到已配对的 \"$HEADPHONES_NAME\" ($DEVICE_MAC)，尝试连接..."

    # 尝试连接已配对设备
    bluetoothctl -- connect "$DEVICE_MAC"

    # 立即检查连接状态
    if bluetoothctl -- info "$DEVICE_MAC" | grep -q "Connected: yes"; then
        echo "成功连接到 \"$HEADPHONES_NAME\"!"
        exit 0
    else
        # 如果未立即连接，等待一段时间再次检查
        echo "等待连接完成 (最多10秒)..."
        for i in {1..10}; do
            sleep 1
            if bluetoothctl -- info "$DEVICE_MAC" | grep -q "Connected: yes"; then
                echo "成功连接到 \"$HEADPHONES_NAME\"!"
                exit 0
            fi
        done
        echo "连接已配对设备失败，尝试重新扫描..."
    fi
else
    echo "未找到已配对的 \"$HEADPHONES_NAME\"，开始扫描..."
fi
# 如果已配对设备连接失败或未找到，则扫描新设备
echo "正在扫描蓝牙设备..."
# 先停止任何可能正在进行的扫描
bluetoothctl -- scan off
sleep 1
# 开始新的扫描
bluetoothctl -- scan on &
SCAN_PID=$!
sleep 10
kill $SCAN_PID 2>/dev/null
bluetoothctl -- scan off
echo "扫描完成"
# 再次查找设备，使用精确匹配
DEVICE_MAC=$(bluetoothctl devices | awk -v name="$HEADPHONES_NAME" '$0 ~ name"$" {print $2}')
# 如果找不到精确匹配，再尝试部分匹配
if [ -z "$DEVICE_MAC" ]; then
    echo "尝试使用部分匹配..."
    DEVICE_MAC=$(bluetoothctl devices | grep -F "$HEADPHONES_NAME" | head -n 1 | grep -o -E "([0-9A-F]{2}:){5}[0-9A-F]{2}")
    bluetoothctl -- pair "$DEVICE_MAC"
    bluetoothctl -- trust "$DEVICE_MAC"
    bluetoothctl -- connect "$DEVICE_MAC"

    # 立即检查连接状态
    if bluetoothctl -- info "$DEVICE_MAC" | grep -q "Connected: yes"; then
        echo "成功连接到 \"$HEADPHONES_NAME\"!"
        exit 0
    else
        # 如果未立即连接，等待一段时间再次检查
        echo "等待连接完成 (最多10秒)..."
        for i in {1..10}; do
            sleep 1
            if bluetoothctl -- info "$DEVICE_MAC" | grep -q "Connected: yes"; then
                echo "成功连接到 \"$HEADPHONES_NAME\"!"
                exit 0
            fi
        done
        echo "无法连接到 \"$HEADPHONES_NAME\"，请检查设备是否处于配对模式。"
        exit 1
    fi
        exit 0
    else
        echo "无法连接到 \"$HEADPHONES_NAME\"，请检查设备是否处于配对模式。"
        exit 1
    fi
else
    echo "未找到 \"$HEADPHONES_NAME\"，请确保设备已打开并处于可发现状态。"
    exit 1
fi
