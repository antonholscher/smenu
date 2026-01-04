#!/bin/zsh


#db="anton\nbanton\n"
printf "$db" | ~/Library/Developer/Xcode/DerivedData/smenu-*/Build/Products/Release/smenu.app/Contents/MacOS/smenu \
    -e -t "enter pw with suggestion"
