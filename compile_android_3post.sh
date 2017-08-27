#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/lib/node_modules:./node_modules/.bin:/opt/android-sdk-linux/tools

export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

RED='\033[0;31m'
NC='\033[0m' # No Color

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

rvm use 2.3

APP_VERSION=`expr $BUILD_NUMBER + 100`
OS=$(uname -a|awk '{print $1}')
echo "OS = ${OS}"


#if [[ "$BRANCH_NAME" == "master" ]] ; then
#	TRACK=production
#fi
#if [[ "$BRANCH_NAME" == "release" ]] ; then
#	TRACK=beta
#fi
#if [[ "$BRANCH_NAME" == "develop" ]] ; then
#	TRACK=alpha
#fi


#if [[ -z "$TRACK" ]] ; then
#    echo -e "${RED}TRACK not set${NC}"
#    exit 1
#fi


if [[ "$MAX_SDK" == "19" ]] ; then
	cp -f ${WORKSPACE}/platforms/android/build/outputs/apk/android-armv7-release-unsigned.apk ${WORKSPACE}/app-release-unsigned.apk
else
	cp -f ${WORKSPACE}/platforms/android/build/outputs/apk/android-release-unsigned.apk ${WORKSPACE}/app-release-unsigned.apk
fi


aws s3 cp app-release-unsigned.apk s3://play2pay-public/mobile/${APP_ID}/${APP_VERSION}-unsigned.apk --acl public-read
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi


#echo "{\"version\":"${APP_VERSION}",\"url\":\"https://s3-ap-southeast-1.amazonaws.com/play2pay-public/mobile/app-"${APP_VERSION}"-unsigned.apk\"}" > latest.txt
#aws s3 cp latest.txt s3://play2pay-public/mobile/latest.txt --acl public-read

#keytool -genkey -v -keystore boost-release-key.keystore -alias boost -keyalg RSA -keysize 2048 -validity 10000
#/Users/Shared/Jenkins/Home/jobs/Boost-android/workspace/platforms/android/build/outputs/apk/android-release-unsigned.apk

jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore fastlane/jmt-key.keystore -storepass jfintech app-release-unsigned.apk jmt
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

zipalign -v 4 app-release-unsigned.apk app.apk
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

rm -f app-release-unsigned.apk

if [[ "$OS" == "Darwin" ]] ; then
    cp -f ${WORKSPACE}/app.apk /Users/Shared/Jenkins/Desktop/ios/${APP_ID}-${APP_VERSION}.apk
fi


aws s3 cp app.apk s3://play2pay-public/mobile/${APP_ID}/${APP_VERSION}-signed.apk --acl public-read
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

package_name=$APP_ID

fastlane supply --track beta --json_key ./fastlane/play_jventure.json --apk app.apk --package_name $package_name --skip_upload_metadata
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

