#!/bin/zsh

MESSAGE="Commit"

for arg in "$@"
do
  case $arg in
    -m|--message)
    MESSAGE="$2"
    shift # Remove argument name from processing
    shift # Remove argument value from processing
    ;;
  esac
done

f() {
    echo '[BUILD]'
    rm css/*.min.css css/*.min.css.map
    ./compile.sh css
    ./compile.sh js

    echo
    echo "[COMMIT]"
    git add -A
    git add -f css/*.min.css
    git commit -m "$MESSAGE @ `date +"%d/%m/%y %T"`"

    echo
    echo '[PUSH]'
    git push
}

f
