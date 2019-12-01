#!/bin/zsh

dir="$1"
for file in $dir/*.scss; do
    filename=$(basename -- "$file")
    extension="${filename##*.}"
    filename="${filename%.*}"
        sass $file $dir/$filename.min.css --style compressed
    print "\e[32mSuccessfully compiled \e[33;1;4m$file\e[0;32m.\e[0m"
done