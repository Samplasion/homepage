#!/bin/zsh

me="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
dir="$1"
cwd="$PWD"
type=""

print "\e[34mWelcome to \e[1;4;7m$me\e[0;34m!\e[0m"

printver() {
    echo "\n\e[33;1;4m$type\e[0;34m Compiler\e[0m"
    echo "\n\e[34mUsing \e[1m$1\e[0;34m: \e[33;1;4m$2\e[0m\n"
}

compiler() {
    name="$1"
    ver="$2"
    d="$3"
    cmd="$4"
    ty="$5"

    cd "$cwd/$dir"
    printver $name $ver

    for file in $dir/*.$ty; do
        filename=$(basename -- "$file")
        extension="${filename##*.}"
        filename="${filename%.*}"
        result=`eval $cmd`
        if [[ $result == "" ]]; then
            print " - \e[32mSuccessfully compiled \e[33;1;4m$file\e[0;32m.\e[0m"
        else
            print "\n - \e[31mCouldn't compile \e[33;1;4m$file\e[0;31m because:\e[0m\n$result\n"
        fi
    done

}

css() {
    cd "$cwd"
    printver "Dart Sass" `sass --version`

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
    cd "$cwd/$dir"
    ver=`coffee -v`
    ver=${ver#"CoffeeScript version "}
    printver "CoffeeScript" $ver

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

for d in "$@"
do
    dir="$d"
    case $d in 
        css)
            type="CSS"
            css
            #compiler "Dart Sass" `sass --version` "$cwd" 'sass $file $dir/$filename.min.css --style compressed -c 2>&1' "scss"
            ;;
        js)
            type="JS"
            dir="$dir/coffee"
            #ver=`coffee -v`
            #ver=${ver#"CoffeeScript version "}
            #compiler "CoffeeScript" $ver "$cwd/$dir" 'coffee -c coffee/$filename.coffee 2>&1' "coffee"
            js
            ;;
        *)
            print "\n\e[31mInvalid subcommand \e[33;1;4m$dir\e[0;31m.\e[0m"
            ;;
    esac
done