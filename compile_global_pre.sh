#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/lib/node_modules:./node_modules/.bin:/opt/android-sdk-linux/tools:./platforms/ios/build/device/include/Cordova

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

#rm -f *.ipa

git checkout -- config.xml

echo "------------- start config.xml --------------"

sed 's|<name>[a-zA-Z ]*</name>|<name>'"$APP_NAME"'</name>|g' config.xml > tmpconfig.txt
cat tmpconfig.txt > config.xml

sed 's|me.play2pay.[a-z]*|'"$APP_ID"'|g' config.xml > tmpconfig.txt
cat tmpconfig.txt > config.xml

sed 's|me.play2pay.[a-z]*|'"$APP_ID"'|g' fastlane/Appfile > tmpconfig.txt
cat tmpconfig.txt > fastlane/Appfile

sed 's|me.play2pay.[a-z]*|'"$APP_ID"'|g' fastlane/Matchfile > tmpconfig.txt
cat tmpconfig.txt > fastlane/Matchfile





echo "------------- end config.xml --------------"

CHECK_INVALID_CONFIG=$(cat config.xml |tr -d '\n'|tr -d ' '|grep '<true/><false/>')

if [[ "$CHECK_INVALID_CONFIG" ]] ; then
    echo "********** Invalid config.xml **************"
    echo "CHECK_INVALID_CONFIG[$CHECK_INVALID_CONFIG]"
    exit 1
fi

cat config.xml
CHECK_INVALID_CONFIG=$(grep $APP_ID config.xml)
if [[ -z "$CHECK_INVALID_CONFIG" ]] ; then
    echo "********** Invalid config.xml **************"
    exit 1
fi

cat fastlane/Appfile
CHECK_INVALID_CONFIG=$(grep $APP_ID fastlane/Appfile)
if [[ -z "$CHECK_INVALID_CONFIG" ]] ; then
    echo "********** Invalid fastlane/Appfile **************"
    exit 1
fi

cat fastlane/Matchfile
CHECK_INVALID_CONFIG=$(grep $APP_ID fastlane/Matchfile)
if [[ -z "$CHECK_INVALID_CONFIG" ]] ; then
    echo "********** Invalid fastlane/Matchfile **************"
    exit 1
fi


chmod +x hooks/after_prepare/010_add_platform_class.js

echo "------------- start clear fetch --------------"
find ${WORKSPACE}/plugins ! -name 'fetch.json' -delete
echo "------------- end clear fetch --------------"
#file="www/js/constants.js"
#if [ -f "$file" ]
#then
#	echo "------------- cat www/js/constants.js --------------"
#	cat www/js/constants.js
#	echo "----------------------------------------------------"
#else
#	echo "constants.js not found. skip"
#fi
#


ionic resources
#rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi
