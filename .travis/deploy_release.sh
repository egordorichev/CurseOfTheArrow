#!/bin/bash

echo ----------------------------------------------
echo ----==== Deploying To Github Releases ====----
echo ----------------------------------------------
echo - Creating the new release

gothub release \
  --user RexcellentGames \
  --repo CurseOfTheArrow \
  --tag $TRAVIS_TAG \
  --name "Draft Release" \
  --description "Please wait for @RexcellentGames/collaborators to write the release changelog." \
  --draft

echo ----==== Uploading the builds ====----

echo - Uploading win32 build

gothub upload \
  --user RexcellentGames \
  --repo CurseOfTheArrow \
  --tag $TRAVIS_TAG \
  --name "CurseOfTheArrow-V"$TRAVIS_TAG"-win32.zip" \
  --file ../BuildUtils/Builds/CurseOfTheArrow-win32.zip \
  --replace

echo - Uploading win64 build

gothub upload \
  --user RexcellentGames \
  --repo CurseOfTheArrow \
  --tag $TRAVIS_TAG \
  --name "CurseOfTheArrow-V"$TRAVIS_TAG"-win64.zip" \
  --file ../BuildUtils/Builds/CurseOfTheArrow-win64.zip \
  --replace

echo - Uploading linux-x86_64 build

gothub upload \
  --user RexcellentGames \
  --repo CurseOfTheArrow \
  --tag $TRAVIS_TAG \
  --name "CurseOfTheArrow-V"$TRAVIS_TAG"-linux-x86_64.zip" \
  --file ../BuildUtils/Builds/CurseOfTheArrow-linux-x86_64.zip \
  --replace

echo - Uploading linux-i686 build

gothub upload \
  --user RexcellentGames \
  --repo CurseOfTheArrow \
  --tag $TRAVIS_TAG \
  --name "CurseOfTheArrow-V"$TRAVIS_TAG"-linux-i686.zip" \
  --file ../BuildUtils/Builds/CurseOfTheArrow-linux-i686.zip \
  --replace

echo - Uploading macos build

gothub upload \
  --user RexcellentGames \
  --repo CurseOfTheArrow \
  --tag $TRAVIS_TAG \
  --name "CurseOfTheArrow-V"$TRAVIS_TAG"-macos.zip" \
  --file ../BuildUtils/Builds/CurseOfTheArrow-macos.zip \
  --replace

echo - Uploading universal build

gothub upload \
  --user RexcellentGames \
  --repo CurseOfTheArrow \
  --tag $TRAVIS_TAG \
  --name "CurseOfTheArrow-V"$TRAVIS_TAG"-universal.love" \
  --file ../BuildUtils/Builds/CurseOfTheArrow-universal.love \
  --replace

echo -----------------------------------------
echo ----==== Deploying To itch.io ====----
echo -----------------------------------------
echo 
echo ----==== Renaming the builds ====----

mv -v -f "../BuildUtils/Builds/CurseOfTheArrow-win32.zip" "../BuildUtils/Builds/CurseOfTheArrow-V"$TRAVIS_TAG"-win32.zip"
mv -v -f "../BuildUtils/Builds/CurseOfTheArrow-win64.zip" "../BuildUtils/Builds/CurseOfTheArrow-V"$TRAVIS_TAG"-win64.zip"
mv -v -f "../BuildUtils/Builds/CurseOfTheArrow-linux-x86_64.zip" "../BuildUtils/Builds/CurseOfTheArrow-V"$TRAVIS_TAG"-linux-x86_64.zip"
mv -v -f "../BuildUtils/Builds/CurseOfTheArrow-linux-i686.zip" "../BuildUtils/Builds/CurseOfTheArrow-V"$TRAVIS_TAG"-linux-i686.zip"
mv -v -f "../BuildUtils/Builds/CurseOfTheArrow-macos.zip" "../BuildUtils/Builds/CurseOfTheArrow-V"$TRAVIS_TAG"-macos.zip"
mv -v -f "../BuildUtils/Builds/CurseOfTheArrow-universal.love" "../BuildUtils/Builds/CurseOfTheArrow-V"$TRAVIS_TAG"-universal.love"

echo ----=== Uploading the builds ====----

butler push "../BuildUtils/Builds/CurseOfTheArrow-V"$TRAVIS_TAG"-win32.zip" egordorichev/curse-of-the-arrow:win32 --userversion $TRAVIS_TAG
butler push "../BuildUtils/Builds/CurseOfTheArrow-V"$TRAVIS_TAG"-win64.zip" egordorichev/curse-of-the-arrow:win64 --userversion $TRAVIS_TAG
butler push "../BuildUtils/Builds/CurseOfTheArrow-V"$TRAVIS_TAG"-linux-x86_64.zip" egordorichev/curse-of-the-arrow:linux-x86_64 --userversion $TRAVIS_TAG
butler push "../BuildUtils/Builds/CurseOfTheArrow-V"$TRAVIS_TAG"-linux-i686.zip" egordorichev/curse-of-the-arrow:linux-i686 --userversion $TRAVIS_TAG
butler push "../BuildUtils/Builds/CurseOfTheArrow-V"$TRAVIS_TAG"-macos.zip" egordorichev/curse-of-the-arrow:macos --userversion $TRAVIS_TAG
butler push "../BuildUtils/Builds/CurseOfTheArrow-V"$TRAVIS_TAG"-universal.love" egordorichev/curse-of-the-arrow:src --userversion $TRAVIS_TAG

echo ----==== Done ====----
