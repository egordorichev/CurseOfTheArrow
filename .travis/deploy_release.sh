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
  --name "CurseOfTheArrow-V"$TRAVIS_TAG"-Universal.love" \
  --file ../BuildUtils/Builds/CurseOfTheArrow-Universal.love \
  --replace

#echo -----------------------------------------
#echo ----==== Deploying To itch.io ====----
#echo -----------------------------------------
#echo 
#echo ----==== Renaming the builds ====----

#mv -v -f "../BuildUtils/Builds/CurseOfTheArrow_Nightly_Windows.zip" "../BuildUtils/Builds/CurseOfTheArrow_V"$TRAVIS_TAG"_Windows.zip"
#mv -v -f "../BuildUtils/Builds/CurseOfTheArrow_Nightly_Linux_x86_64.AppImage" "../BuildUtils/Builds/CurseOfTheArrow_V"$TRAVIS_TAG"_Linux_x86_64.AppImage"
#mv -v -f "../BuildUtils/Builds/CurseOfTheArrow_Nightly_Mac.zip" "../BuildUtils/Builds/CurseOfTheArrow_V"$TRAVIS_TAG"_Mac.zip"
#mv -v -f "../BuildUtils/Builds/CurseOfTheArrow_Nightly_Universal.love" "../BuildUtils/Builds/CurseOfTheArrow_V"$TRAVIS_TAG"_Universal.love"

#echo ----=== Uploading the builds ====----

#butler push "../BuildUtils/Builds/CurseOfTheArrow_V"$TRAVIS_TAG"_Windows.zip" ramilego4game/liko12:windows
#butler push "../BuildUtils/Builds/CurseOfTheArrow_V"$TRAVIS_TAG"_Linux_x86_64.AppImage" ramilego4game/liko12:linux
#butler push "../BuildUtils/Builds/CurseOfTheArrow_V"$TRAVIS_TAG"_Mac.zip" ramilego4game/liko12:osx
#butler push "../BuildUtils/Builds/CurseOfTheArrow_V"$TRAVIS_TAG"_Universal.love" ramilego4game/liko12:src

echo ----==== Done ====----
