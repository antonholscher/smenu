all:
	xcodebuild -scheme smenu -configuration Release

run: 
	./run.sh

install:
	cp -r ~/Library/Developer/Xcode/DerivedData/smenu-*/Build/Products/Release/smenu.app /Applications/
