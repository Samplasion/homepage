#!/bin/zsh

me="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
dir="$1"

print "\e[34mWelcome to \e[1;4;7m$me\e[0;34m!\e[0m"

css() {
    print "\e[34mUsing \e[1mDart Sass\e[0;34m: \e[33;1;4m`sass --version`\e[0m\n"

    for file in $dir/*.scss; do
        filename=$(basename -- "$file")
        extension="${filename##*.}"
        filename="${filename%.*}"
        result=`sass $file $dir/$filename.min.css --style compressed -c 2>&1`
        if [[ $result == "" ]]; then
            print " - \e[32mSuccessfully compiled \e[33;1;4m$file\e[0;32m.\e[0m"
        else
            print "\n - \e[31mCouldn't compile \e[33;1;4m$file\e[0;31m because:\e[0m\n$result\n"
        fi
    done
}

js() {
    cd $dir
    for file in *.coffee; do
        filename=$(basename -- "$file")
        extension="${filename##*.}"
        filename="${filename%.*}"
        result=`coffee -c $filename.coffee 2>&1`
        if [[ $result == "" ]]; then
            print " - \e[32mSuccessfully compiled \e[33;1;4m$file\e[0;32m.\e[0m"
        else
            print "\n - \e[31mCouldn't compile \e[33;1;4m$file\e[0;31m because:\e[0m\n$result\n"
        fi
    done
    mv *.js ..
    cd ..
}

case $dir in 
    css)
        css
        ;;
    js)
        dir="$dir/coffee"
        js
        ;;
    *)
        print "\e[31mInvalid subcommand \e[33;1;4m$dir\e[0;31m.\e[0m"
        ;;
esac