<img width="64" height="64" alt="image" src="https://github.com/user-attachments/assets/fd96edad-e369-45a1-af0c-08ecf881e5ca" />

# Smenu - A 'suckless dmenu' remake for macOS

Smenu (Swift menu) is a remake of the suckless tool *dmenu*, tailored for the macOS ecosystem.
It aims to be a minimalistic tool reading a list of options and serving the user a stylish prompt for selecting one of those options, forwarding that to the next command in the pipeline.

If no input is forwarded to smenu on launch, it will serve as a simple text prompt, accepting any text input whatsoever.


## Usage
```
printf "apple\npear\nlemon\n" | smenu
```
<img width="600" height="200" alt="image" src="https://github.com/user-attachments/assets/d79e5e91-1f2a-4889-836f-c3e980cdd126" />

When you start typing, the options get filtered out, and selecting an option simply prints that out, making it easy to perform user selections in all kinds of scripts without requiring a dedicated terminal to be open.

## Install 
To install, simply clone it, navigate to the project repo and run the following:

```make install```

If you don't have make installed, you can run the make commands manually:
```
xcodebuild -scheme smenu -configuration Release;
cp -r ~/Library/Developer/Xcode/DerivedData/smenu-*/Build/Products/Release/smenu.app /Applications/;
```

Then launch smenu by either using the `smenu.sh` script or by launching it directly from within the app:
```
/Applications/smenu.app/Contents/MacOS/smenu
```


### Example - Downloads file opener
If you have a bunch of files in the downloads folder, it can be daunting to open finder, navigating to downloads and look for the file with a name you vaguely remember. With smenu, that's easy:
```
ls -1 ~/Downloads | smenu | xargs -I{} open ~/Downloads/{}
```

All of the files:<br>
<img width="600" height="700" alt="image" src="https://github.com/user-attachments/assets/0990ee46-3962-4552-8858-94eae71256c5" />

Found it!<br>
<img width="600" height="100" alt="image" src="https://github.com/user-attachments/assets/d0a8098a-0118-4407-80e1-d4bff07928df" />


## Manual

```
Usage: smenu [-e] [-t TEXT_PROMPT] [-i ICON]

-e              Use encrypted input. Replaces all input characters with dots.
-t TEXT_PROMPT  Use custom text prompt instead of the default "Select something" prompt.
-i ICON         Use a custom icon instead of the lightning bolt. Replace with any SF Symbols icon identifier (e.g. "binoculars.fill"). 
```
