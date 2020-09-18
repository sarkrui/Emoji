#! /bin/bash

# 检查是否存在源文件夹
if [ -d "$PWD/240PNG" ]; then
    echo "文件夹存在!"
	    # 新建 120PNG 120GIF 240GIF 文件夹
	cd 240PNG && mkdir {240GIF,120PNG,120GIF}

	# 批量导出 240 规格 GIFs
	# 批量导出 120 规格 PNGs
	for i in *.png; do
		
		# 导出 240*240 GIFs
		sips -s format gif $i --out 240GIF/$i.gif > /dev/null; 

		# 导出 120*120 GIFs
		sips -s format gif $i --out 120GIF/$i.gif > /dev/null;
		
		ffmpeg -hide_banner -loglevel panic -i $i -vf scale=120:120 -vsync 0 120PNG/$i; 

		printf "导出$i 成功!\n";

	done

	# 移出文件夹至上一级
	mv 240GIF/ .. && mv 120PNG/ .. && mv 120GIF/ ..


	cd ../240GIF 
	# 修改 GIFs 文件名
	#（删除原本 .png 文件后缀，使其符合微信表情包命名规范）
	for f in *.gif; do 
		mv "$f" "${f/.*./.}"; 
	done

	cd ../120GIF
	for f in *.gif; do 
		mv "$f" "${f/.*./.}"; 
	done

	cd .. && open ./

	if [ -d "$PWD/240GIF" ] && [ -d "$PWD/120PNG" ] ; then
	    echo "大功告成！"
	else
	    echo "输出失败！"
	fi

else
    echo "未找到源文件！退出！"
fi

exit 0 