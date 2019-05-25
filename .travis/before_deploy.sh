#!/bin/bash

echo ----==== Copying files into other directory ====----

mkdir ../BuildUtils/Builds
mkdir ../BuildUtils/CurseOfTheArrow
cp -v -f -r ./* ../BuildUtils/CurseOfTheArrow/
cd ../BuildUtils/CurseOfTheArrow/

echo ----==== Removing unnecessary files... ====----

rm -v -f README.md .travis.yml
rm -v -f -r .git .travis

echo ----==== Packing .love file ====----

7z A -r -y -tzip -bd "../CurseOfTheArrow.love" .
cd ..

echo ----==== Building Windows 32bit ====----

7z X -r -y -tzip -bd CurseOfTheArrow-win32.zip  -o./win32
mv -v -f "./win32/CurseOfTheArrow.exe" "./win32/love.exe"
cat win32/love.exe CurseOfTheArrow.love > win32/CurseOfTheArrow.exe
rm -v -f win32/love.exe
7z A -r -y -tzip -bd Builds/CurseOfTheArrow_win32.zip win32/*

echo ----==== Building Windows 64bit ====----

7z X -r -y -tzip -bd CurseOfTheArrow-win64.zip  -o./win64
mv -v -f "./win64/CurseOfTheArrow.exe" "./win64/love.exe"
cat win64/love.exe CurseOfTheArrow.love > win64/CurseOfTheArrow.exe
rm -v -f win64/love.exe
7z A -r -y -tzip -bd Builds/CurseOfTheArrow_win64.zip win64/*

echo ----==== Building Linux x86_64 ====----

7z X -r -y -tzip -bd CurseOfTheArrow-linux-x86_64.zip  -o./linux-x86_64
cp -v -f -r ./CurseOfTheArrow/* ./linux-x86_64/
chmod a+x ./linux-x86_64/run.sh
7z A -r -y -tzip -bd Builds/CurseOfTheArrow_linux-x86_64.zip linux-x86_64/*

echo ----==== Building Linux i686 ====----

7z X -r -y -tzip -bd CurseOfTheArrow-linux-i686.zip  -o./linux-i686
cp -v -f -r ./CurseOfTheArrow/* ./linux-i686/
chmod a+x ./linux-i686/run.sh
7z A -r -y -tzip -bd Builds/CurseOfTheArrow_linux-i686.zip linux-i686/*

echo ----==== Building OS_X ====----

7z X -r -y -tzip -bd CurseOfTheArrow-macos.zip  -o./macos
cp -v -f CurseOfTheArrow.love macos/CurseOfTheArrow.app/Contents/Resources/CurseOfTheArrow.love
7z A -r -y -tzip -bd Builds/CurseOfTheArrow_macos.zip macos/*

echo ----==== Copying Universal... ====----
  
cp -v -f CurseOfTheArrow.love Builds/CurseOfTheArrow_Universal.love

echo ----==== Downloading Deployment Tools ====----

echo Downloading gothub
go get github.com/itchio/gothub

echo Downloading butler

curl https://dl.itch.ovh/butler/linux-amd64/head/butler --output ~/bin/butler && \
chmod 755 ~/bin/butler

echo ----==== Done ====----

cd ../CurseOfTheArrow/
