#!/bin/bash

echo ----==== Installing 7zip ====----

sudo apt-get -qq update
sudo apt-get install -qq p7zip-full

echo ----==== Installing luacheck ====----

sudo apt-get install -qq luarocks
sudo luarocks install luacheck

echo ----==== Creating build utilities directory ====----

mkdir "../BuildUtils/"

echo ----==== Downloading build templates ====----

wget -O "../BuildUtils/CurseOfTheArrow-win32.zip" "https://github.com/RexcellentGames/CurseOfTheArrow-Binaries/releases/download/"$BINVER"/CurseOfTheArrow-win32.zip"
wget -O "../BuildUtils/CurseOfTheArrow-win64.zip" "https://github.com/RexcellentGames/CurseOfTheArrow-Binaries/releases/download/"$BINVER"/CurseOfTheArrow-win64.zip"
wget -O "../BuildUtils/CurseOfTheArrow-linux-i686.zip" "https://github.com/RexcellentGames/CurseOfTheArrow-Binaries/releases/download/"$BINVER"/CurseOfTheArrow-linux-i686.zip"
wget -O "../BuildUtils/CurseOfTheArrow-linux-x86_64.zip" "https://github.com/RexcellentGames/CurseOfTheArrow-Binaries/releases/download/"$BINVER"/CurseOfTheArrow-linux-x86_64.zip"
wget -O "../BuildUtils/CurseOfTheArrow-macos.zip" "https://github.com/RexcellentGames/CurseOfTheArrow-Binaries/releases/download/"$BINVER"/CurseOfTheArrow-linux-macos.zip"

echo ----==== Downloading ApkTool ====---

wget -O "../BuildUtils/apktool.jar" "https://bitbucket.org/iBotPeaches/apktool/downloads/apktool_2.3.4.jar"
chmod a+x ../BuildUtils/apktool.jar

