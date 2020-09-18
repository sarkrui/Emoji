#!/bin/bash
cd "$(dirname "$0")"

if [ $# -eq 2 ] || [ $# -eq 3 ]  || [ $# -eq 4 ] 
then
    fullname=$1
    filename=${fullname%.*}
    nullpath=${filepath%.*}
else
    echo "拖拽文件"
    read filepath

        fullname=$(basename $filepath)
        filename=${fullname%.*}
        nullpath=${filepath%.*}
    #echo $filename

    echo "要添加什么文字?"
    read textSRT
    genname=$(echo $nullpath | sed "s/$filename/$textSRT/g")

    echo $genname

    PS3='请输入你的选项:'
    options=("乐喵体" "普惠体" "null" "Quit")
    select opt in "${options[@]}"
    do
        case $opt in
            "乐喵体")
                echo "你选择了乐喵体"
                fontOpt=/Users/p.xing/Library/Fonts/HYLeMiaoTiW.ttf
                outputname=$genname"_Lemiao.gif"
                break
                ;;
            "普惠体")
                echo "你选择了阿里巴巴普惠体"
                fontOpt=/Users/p.xing/Library/Fonts/Alibaba-PuHuiTi-Medium.ttf
                outputname=$genname"_Puhui.gif"

                break
                ;;
            "null")
                echo "待补充..."
                break
                ;;
            "Quit")
                echo ""    
                break
                ;;
            *) echo "不规范的输入";;
        esac
    done


    ffmpeg -y -i $filepath \
        -vf "drawtext=\
            fontfile=$fontOpt:\
            text=$textSRT:\
            x=(w-tw)/2:\
            y=(h-text_h*1.4):\
            bordercolor=white:\
            borderw=4:\ 
            fontsize=h*0.15:\
            fontcolor=black:\
            "\
        $outputname
fi

open "$dirpath"