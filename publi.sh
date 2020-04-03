#!/bin/zsh

f() {
    echo '[BUILD]'
    rm css/*.min.css css/*.min.css.map
    ./compile.sh css
    ./compile.sh js

    echo
    echo '[COMMIT]'
    git add -A
    git add -f css/*.min.css
    git commit -m "Commit @ `date +"%d/%m/%y %T"`"

    echo
    echo '[PUSH]'
    git push
}

f
