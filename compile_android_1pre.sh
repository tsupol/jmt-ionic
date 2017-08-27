#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/lib/node_modules:./node_modules/.bin:/opt/android-sdk-linux/tools

export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
APP_VERSION=`expr $BUILD_NUMBER + 100`

RED='\033[0;31m'
NC='\033[0m' # No Color

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

rvm use 2.3

rm -f *.apk


find ./plugins ! -name 'fetch.json' -delete


OS=$(uname -a|awk '{print $1}')
echo "OS = ${OS}"

if [[ -z "$APP_ID" ]] ; then
    echo -e "${RED}APP_ID not set ${NC}ie. me.play2pay.boost123"
    exit 1
fi

if [[ -z "$APP_NAME" ]] ; then
    echo -e "${RED}APP_NAME not set ie. boost by VGI${NC}"
    exit 1
fi

if [[ -z "$CONFIG_ENV" ]] ; then
    echo -e "${RED}CONFIG_ENV not set ie. CONFIG_ENV=develop/production"
    exit 1
fi







echo $APP_NAME > fastlane/metadata/android/th/title.txt


echo "------------- cat config.xml --------------"
cat config.xml
echo "----------------------------------------------------"

cp -f resources/icon.android.png  resources/icon.png
ionic resources android

echo "------------- remove android start --------------"
cordova platform remove ios
cordova platform remove android
echo "------------- remove android finish --------------"
echo "------------- add android start --------------"
cordova platform add android
ionic platform update android@6.1.0
echo "------------- add android finish --------------"

cordova requirements

npm install





