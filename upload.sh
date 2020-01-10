#!/bin/bash

VersionString=`grep -E 's.version.*=' HYMusic_Login_Category.podspec`
VersionNumber=`tr -cd 0-9 <<<"$VersionString"`

NewVersionNumber=$(($VersionNumber + 1))
LineNumber=`grep -nE 's.version.*=' HYMusic_Login_Category.podspec | cut -d : -f1`
sed -i "" "${LineNumber}s/${VersionNumber}/${NewVersionNumber}/g" HYMusic_Login_Category.podspec

echo "current version is ${VersionNumber}, new version is ${NewVersionNumber}"

git add .
git commit -am ${NewVersionNumber}
git tag ${NewVersionNumber}
git push origin master --tags
pod repo push HYMusicPrivatePods HYMusic_Login_Category.podspec --verbose --allow-warnings --use-libraries --use-modular-headers

