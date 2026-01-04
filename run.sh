#!/bin/zsh


db="anton\nbanton\n"
printf "$db" | ~/Library/Developer/Xcode/DerivedData/smenu-*/Build/Products/Release/smenu.app/Contents/MacOS/smenu \
    -t "select something" -i "lightningbolt" | xargs echo "SELECTED"
