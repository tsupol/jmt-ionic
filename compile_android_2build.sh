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

if [[ -z "$MIN_SDK" ]] ; then
    echo -e "${RED}MIN_SDK not set${NC}"
    exit 1
fi
if [[ -z "$TARGET_SDK" ]] ; then
    echo -e "${RED}TARGET_SDK not set${NC}"
    exit 1
fi
if [[ -z "$MAX_SDK" ]] ; then
    echo -e "${RED}MAX_SDK not set${NC}"
    exit 1
fi

if [[ -z "$APP_VERSION" ]] ; then
    APP_VERSION=$BUILD_NUMBER
fi

if [[ -z "$BILLING_KEY" ]] ; then
    echo -e "${RED}BILLING_KEY not set${NC}"
    exit 1
fi

if [[ "$MAX_SDK" == "19" ]] ; then
	sed 's|version="0.0.1"|version="2.0.'"${APP_VERSION}0"'" android-versionCode="'"${TARGET_SDK}0${APP_VERSION}0"'"|g' config.xml > tmpconfig.txt
else
	sed 's|version="0.0.1"|version="2.0.'"${APP_VERSION}0"'" android-versionCode="'"${TARGET_SDK}0${APP_VERSION}0"'"|g' config.xml > tmpconfig.txt
fi
cat tmpconfig.txt > config.xml


if [[ "$MAX_SDK" == "19" ]] ; then
	sed 's|com.jfintech.loan|com.jfintech.loan19|g' config.xml > tmpconfig.txt
	cat tmpconfig.txt > config.xml

	sed 's|com.jfintech.loan|com.jfintech.loan19|g' fastlane/Appfile > tmpconfig.txt
	cat tmpconfig.txt > fastlane/Appfile

	sed 's|com.jfintech.loan|com.jfintech.loan19|g' fastlane/Matchfile > tmpconfig.txt
	cat tmpconfig.txt > fastlane/Matchfile

fi

sed 's|<preference name="android\-minSdkVersion" value="[0-9]*" */>|<preference name="android-minSdkVersion" value="'"$MIN_SDK"'"/>|g' config.xml > tmpconfig.txt
cat tmpconfig.txt > config.xml

sed 's|<preference name="android\-targetSdkVersion" value="[0-9]*" */>|<preference name="android-targetSdkVersion" value="'"$TARGET_SDK"'"/>|g' config.xml > tmpconfig.txt
cat tmpconfig.txt > config.xml

sed 's|<preference name="android\-maxSdkVersion" value="[0-9]*" */>|<preference name="android-maxSdkVersion" value="'"$MAX_SDK"'"/>|g' config.xml > tmpconfig.txt
cat tmpconfig.txt > config.xml

sed 's|\\|\/|g' config.xml > tmpconfig.txt
cat tmpconfig.txt > config.xml

cat config.xml

CHECK_INVALID_CONFIG=$(grep '<preference name="android-minSdkVersion" value="'"$MIN_SDK"'"/>' config.xml)
if [[ -z "$CHECK_INVALID_CONFIG" ]] ; then
    echo "********** Invalid config.xml **************"
    echo "min sdk not correct"
    exit 1
fi

CHECK_INVALID_CONFIG=$(grep '<preference name="android-targetSdkVersion" value="'"$TARGET_SDK"'"/>' config.xml)
if [[ -z "$CHECK_INVALID_CONFIG" ]] ; then
    echo "********** Invalid config.xml **************"
    echo "target sdk not correct"
    exit 1
fi

CHECK_INVALID_CONFIG=$(grep '<preference name="android-maxSdkVersion" value="'"$MAX_SDK"'"/>' config.xml)
if [[ -z "$CHECK_INVALID_CONFIG" ]] ; then
    echo "********** Invalid config.xml **************"
    echo "max sdk not correct"
    exit 1
fi


if [[ "$MAX_SDK" == "19" ]] ; then
	echo "------------- add crosswalk start --------------"
#	if [[ "$OS" == "Linux" ]] ; then
        ionic plugin add cordova-plugin-crosswalk-webview
#    else
#        ionic browser add crosswalk
#	fi
    echo "------------- add crosswalk finish --------------"
fi

ionic resources

cat config.xml


#if [[ "$OS" == "Linux" ]] ; then
#ANDROID_HOME=/opt/android-sdk-linux
#	ionic build android --debug
#else
#	ionic build android --debug
#fi

sed 's|maps:9.8.0|maps:+|g' platforms/android/project.properties > tmpconfig.txt
cat tmpconfig.txt > platforms/android/project.properties

sed 's|location:9.8.0|location:+|g' platforms/android/project.properties > tmpconfig.txt
cat tmpconfig.txt > platforms/android/project.properties

echo "--------- project.properties Start-------------"
cat  platforms/android/project.properties
echo "--------- project.properties Finish -------------"
#if [[ "$MAX_SDK" == "19" ]] ; then
#	cp -f ${WORKSPACE}/platforms/android/build/outputs/apk/android-armv7-debug.apk ${WORKSPACE}/app-debug.apk
#else
#	cp -f ${WORKSPACE}/platforms/android/build/outputs/apk/android-debug.apk ${WORKSPACE}/app-debug.apk
#fi
#aws s3 cp app-debug.apk s3://play2pay-public/mobile/${APP_ID}/${APP_VERSION}-debug.apk --acl public-read
#rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi



ionic resources


cat config.xml



if [[ "$OS" == "Linux" ]] ; then
ANDROID_HOME=/opt/android-sdk-linux
	ionic build android --release
else
#ionic build --release android
	ionic build android --release
fi

rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi
