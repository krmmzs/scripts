#!/bin/bash

# 指定文件夹路径
folder="."

# 遍历文件夹下的每个文件
for file in "$folder"/*.pdf; do
  # 检查文件是否存在
  if [ -f "$file" ]; then
    # 执行 pdfjam 命令并覆盖原文件
    pdfjam --papersize '{29.7cm,21cm}' --landscape --offset '0cm 8.7cm' "$file" --outfile "$file"
  fi
done
