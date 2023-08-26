#!/bin/bash

#
# for file in *.rar
# do
# {
#     unrar x -pcosplaytele "$file"; 
# }&
# done

tmp_fifofile="/tmp/$$.fifo"
mkfifo $tmp_fifofile   # 新建一个FIFO类型的文件
exec 6<>$tmp_fifofile  # 将FD6指向FIFO类型
rm $tmp_fifofile  #删也可以，

thread_num=10 # 定义最大线程数

#根据线程总数量设置令牌个数
#事实上就是在fd6中放置了$thread_num个回车符
for ((i=0;i<${thread_num};i++));do
    echo
done >&6

for file in *.rar
do
read -u6
{
    unrar x -pcosplaytele "$file"; 
    echo >&6 # 当进程结束以后，再向FD6中加上一个回车符，即补上了read -u6减去的那个
}&
done

wait
