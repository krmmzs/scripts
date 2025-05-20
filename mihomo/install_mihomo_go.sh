#!/bin/bash

# 使用 GitHub API 获取最新预发布版本信息（go120版本）

latest_release=$(curl -s https://api.github.com/repos/MetaCubeX/mihomo/releases | grep -m 1 "browser_download_url.*mihomo-linux-amd64-go120-alpha.*gz" | cut -d '"' -f 4)

if [ -z "$latest_release" ]; then
    echo "无法获取最新版本链接"
    exit 1
fi

echo "Downloading: $latest_release"

# Download file
wget "$latest_release"

# Get the name of the downloaded file
filename=$(basename "$latest_release")

# Unzip the file
gunzip -c "$filename" > mihomo

# Add execution privileges
chmod +x ./mihomo

echo "Download and decompression complete! File name: mihomo"
