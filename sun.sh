echo "SUN - Website Tester\n"
# 
echo Compiles the required files and opens the webpage in a browser

# ========= VARIABLES =========
file="./index.html"

# =========== CODE ============
./compile.sh css js
open $file