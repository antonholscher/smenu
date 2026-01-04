#!/bin/zsh


flags=-e
db="anton\nbanton\n"
printf "$db" | ~/Library/Developer/Xcode/DerivedData/smenu-*/Build/Products/Release/smenu.app/Contents/MacOS/smenu $flags
