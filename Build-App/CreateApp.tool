#!/bin/bash
# PartEFIMount
# By chris1111
# Dependencies: platypus
# Declare some VARS
APP_NAME="PartEFIMount.app"
SCRIPT_NAME="PartEFIMount.sh"
PARENTDIR=$(dirname "$0")
cd "$PARENTDIR"
CLI=/usr/local/share/platypus/ScriptExec
if [ -e "$CLI" ]; then
    echo "$CLI exists"
else 
    echo "$CLI does not exist"
    echo "Binaries for building platypus are not installed you must install them"
    echo "Insert Your Password To Procceed"
    sudo mkdir -p /usr/local/bin
    sudo mkdir -p /usr/local/share/platypus
    sudo mkdir -p /usr/local/share/man/man1
    sudo cp -rp ./Share/share/platypus/* /usr/local/share/platypus/
    sudo cp -rp ./Share/share/man/man1/platypus.1.gz /usr/local/share/man/man1/
    sudo cp -rp ./Share/platypus /usr/local/bin/
fi 
rm -rf ./"$APP_NAME"
Sleep 2
# platypus CLI
platypus -o 'Status Menu' -i ./'AppIcon.icns' --background --quit-after-execution --status-item-icon ./'AppIcon.png' -f ./'Credits.rtf' -f ./'PartEFIMount' -f ./'MainMenu.nib' ./"$SCRIPT_NAME" -u chris1111 -I com.chris1111.PartEFIMount -y ./"$APP_NAME"
# Add Copyright and custom Icon status menu
/usr/libexec/PlistBuddy -c "Set :StatusItemDisplayType 'Icon'" ./"PartEFIMount.app"/Contents/Resources/AppSettings.plist
/usr/libexec/PlistBuddy -c "Set :Creator 'chris1111'" ./"PartEFIMount.app"/Contents/Resources/AppSettings.plist
/usr/libexec/PlistBuddy -c "Set :NSHumanReadableCopyright 'Copyright (c) 2024 chris1111 All rights reserved.'" ./"PartEFIMount.app"/Contents/Info.plist


# Remove if exist
if [ -d "/Applications/$APP_NAME" ]; then
    echo "$APP_NAME exists. Delete app"
    osascript -e 'tell application "System Events" to delete login item "PartEFIMount"'
    killall -c PartEFIMount
    Sleep 1
    rm -rf /Applications/$APP_NAME
fi
# Install PartEFIMount
echo Install "$APP_NAME"
cp -Rp ./PartEFIMount.app /Applications/PartEFIMount.app
osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/PartEFIMount.app", hidden:false}'
Sleep 1
Open -a /Applications/PartEFIMount.app
rm -rf ./"$APP_NAME"
echo "= = = = = = = = = = = = = = = = = = = = = = = = =  "
echo "Create PartEFIMount.app Done.
App is ready on Status Bar"
echo "= = = = = = = = = = = = = = = = = = = = = = = = =  "
