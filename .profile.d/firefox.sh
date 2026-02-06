# Firefox
#
# Install path: /Applications/Firefox.app/Contents/MacOS/firefox
# Profile path: ~/Library/Application\ Support/Firefox/Profiles/
#
# Add Firefox to PATH on macOS if it's not already available
if [ ! -x "$(command -v firefox)" ]; then
    export FIREFOXBIN="/Applications/Firefox.app/Contents/MacOS"
    PATH="${FIREFOXBIN}:${PATH}"
fi;
