# ========= VARIABLES =========
file="./index.html"
OPEN=1

for arg in "$@"
do
  case $arg in
    -n|--no-open)
    OPEN=0
    shift # Remove argument name from processing
    shift # Remove argument value from processing
    ;;
  esac
done

# =========== CODE ============
echo "SUN - Website Tester\n"
if [ ${OPEN} -lt 1 ]; then
    echo Compiles the required files.
else 
    echo Compiles the required files and opens the webpage in a browser.
fi

./compile.sh css js
if [ ${OPEN} = 1 ]; then
    open ./index.html
fi