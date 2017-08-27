#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/lib/node_modules:./node_modules/.bin:./platforms/ios/build/device/include/Cordova:/Users/Shared/Jenkins/.rvm/gems/ruby-2.3.0/bin

export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

RED='\033[0;31m'
NC='\033[0m' # No Color

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

rvm use 2.3



if [[ -z "$APP_ID" ]] ; then
    echo -e "${RED}APP_ID not set ${NC}ie. me.play2pay.app123"
    exit 1
fi

if [[ -z "$APP_NAME" ]] ; then
    echo -e "${RED}APP_NAME not set ie. app ${NC}"
    exit 1
fi

if [[ -z "$CONFIG_ENV" ]] ; then
    echo -e "${RED}CONFIG_ENV not set ie. CONFIG_ENV=develop/production"
    exit 1
fi

if [[ -z "$FASTLANE_PASSWORD" ]] ; then
    FASTLANE_PASSWORD=$(cat ~/ios.txt)
fi


cat platforms/ios/${APP_NAME}/${APP_NAME}-Info.plist
CHECK_INVALID_PLIST=$(cat platforms/ios/${APP_NAME}/${APP_NAME}-Info.plist | grep '<key>true</key>')

if [[ "$CHECK_INVALID_PLIST" ]] ; then
    echo "********** Invalid pList **************"
    echo "CHECK_INVALID_CONFIG[$CHECK_INVALID_PLIST]"
    exit 1
fi

#CHECK_INVALID_PLIST=$(cat platforms/ios/${APP_NAME}/${APP_NAME}-Info.plist | grep '<key>play2pay.me</key>')

#if [[ -z "$CHECK_INVALID_PLIST" ]] ; then
#    echo "********** Invalid pList **************"
#    echo "CHECK_INVALID_CONFIG[$CHECK_INVALID_PLIST]"
#    exit 1
#fi



#xcodebuild -project ${WORKSPACE}/ios/Unity-iPhone.xcodeproj -target "Unity-iPhone" -configuration Release clean build DEPLOYMENT_POSTPROCESSING=YES CODE_SIGN_IDENTITY="iPhone Developer: Natdanai Homkong"

#xcrun -sdk iphoneos PackageApplication -v ${WORKSPACE}/ios/build/Release-iphoneos/appcore.app -o ${WORKSPACE}/ios/build/game.ipa

#export FASTLANE_PASSWORD
#export PATH="$PATH:$HOME/.rvm/bin:$HOME/.rvm/rubies/ruby-2.3.0/bin"
#rvm use 2.3

# -- Make 167 icon
#rm -f ios/Unity-iPhone/Images.xcassets/AppIcon.appiconset/Contents.json
#rm -f ios/Unity-iPhone/Images.xcassets/AppIcon.appiconset/Icon-167.png
#cp fastlane/Contents.json ios/Unity-iPhone/Images.xcassets/AppIcon.appiconset/Contents.json
#sips -Z 167 ios/Unity-iPhone/Images.xcassets/AppIcon.appiconset/Icon-180.png --out ios/Unity-iPhone/Images.xcassets/AppIcon.appiconset/Icon-167.png

#sed 's|^</dict>|%<key>ITSAppUsesNonExemptEncryption</key>=%<false/>=</dict>|g' ios/Info.plist | tr = '\n' | tr % '\t' > tmp2.txt
#cat tmp2.txt > ios/Info.plist


# --- match cert and provision
#MATCH_PASSWORD=aabbccddee
#FASTLANE_XCODE_LIST_TIMEOUT
#fastlane match --force_for_new_devices true

# --- Load provision
#fastlane  sigh

# --- build xcode



#(cd ./platforms/ios; agvtool new-version -all ${BUILD_NUMBER})
#fastlane  gym -p platforms/ios/${APP_NAME}-demo.xcodeproj --provisioning_profile_path ./AppStore_me.play2pay.${APP_NAME}-demo.mobileprovision

cp -f ${WORKSPACE}/platforms/ios/build/device/${APP_NAME}.ipa /Users/Shared/Jenkins/Desktop/ios/${APP_NAME}-${BUILD_NUMBER}.ipa
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi
cp -f ${WORKSPACE}/platforms/ios/build/device/${APP_NAME}.ipa ${WORKSPACE}/${APP_NAME}.ipa
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

echo "[X]----------- Start Upload ----------- "
fastlane pilot upload
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi
echo "[X]----------- Upload Success ----------- "