all: build

build:
	xcodebuild -scheme smenu -configuration Release

install: build
	cp -r ~/Library/Developer/Xcode/DerivedData/smenu-*/Build/Products/Release/smenu.app /Applications/
