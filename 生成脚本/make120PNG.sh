#!/bin/bash

# 改变工作路径至脚本运行文件夹
cd "$(dirname "$0")"

# 创建解压 GIF 的文件夹
mkdir temp/

# 120x120 尺寸的 PNG 文件夹
mkdir 120PNG/

# 提前创建 PNG 文件夹
mkdir temp/temp_0{1..9} && mkdir temp/temp_{10..16}

# 安装微信表情包命名规则创建文件(夹)
for dir in 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16
do 	
	ffmpeg -i 240GIF/$dir.gif -vf scale=120:120 -vsync 0 temp/temp_$dir/temp_%d.png

	# 复制第 5 张作为关键缩略图
	cp temp/temp_$dir/temp_5.png 120PNG/$dir.png
done




