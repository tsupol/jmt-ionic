#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/lib/node_modules:./node_modules/.bin:./platforms/ios/build/device/include/Cordova

export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

RED='\033[0;31m'
NC='\033[0m' # No Color

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

rvm use 2.3

#pod install

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



file="fastlane/is_produce"
if [ -f "$file" ]
then
	echo "------------- fastlane/is_produce found skip produce --------------"

	UUID=$(match appstore --readonly yes | grep UUID)
	# | awk '{print $7}'
    echo "[X]------------ Provision >>> $UUID --------------"

    if [[ -z "$UUID" ]] ; then
        echo -e "${RED}UUID not set ${NC} check with match appstore --readonly yes | grep UUID | awk '{print ???}'"
        fastlane match appstore --readonly yes
        exit 1
    fi

else
	fastlane produce --app_name ${APP_NAME}
	rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

	fastlane match appstore
	rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

	touch fastlane/is_produce
fi

cp -f resources/icon.ios.png  resources/icon.png

ionic resources ios
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi


echo " >> REINSTALLING PLUGINS"
cordova platform remove android
cordova platform remove ios && cordova platform add ios
#second time run to trigger custom config
echo " >> FORMAL PLATFORM BUILD"
cordova platform remove ios && cordova platform add ios


cordova requirements
ionic resources

#cp -f prototypes/ios/* platforms/ios/${APP_NAME}/Classes/
#cp -rf prototypes/ios/* platforms/ios/${APP_NAME}/
#cp -rf prototypes/ios/CordovaLib/* platforms/ios/CordovaLib/
#replace file(s)
cp -avR prototypes/ios/* platforms/ios/


echo "------------- start config.xml --------------"

php ./patch_config.php
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

sed 's|version="0.0.1"|version="2.'"${BUILD_NUMBER}"'"|g' config.xml > tmpconfig.txt
cat tmpconfig.txt > config.xml
cat config.xml
echo "------------- end config.xml --------------"

CHECK_INVALID_CONFIG=$(cat config.xml |tr -d '\n'|tr -d ' '|grep '<true/><false/>')
if [[ "$CHECK_INVALID_CONFIG" ]] ; then
    echo "********** Invalid config.xml **************"
    echo "CHECK_INVALID_CONFIG[$CHECK_INVALID_CONFIG]"
    exit 1
fi

CHECK_INVALID_CONFIG=$(grep ITSAppUsesNonExemptEncryption config.xml)
if [[ -z "$CHECK_INVALID_CONFIG" ]] ; then
	echo "CHECK_INVALID_CONFIG[$CHECK_INVALID_CONFIG]"
    echo "********** Invalid config.xml no ITSAppUsesNonExemptEncryption **************"
    exit 1
fi
CHECK_INVALID_CONFIG=$(grep UINewsstandApp config.xml)
if [[ -z "$CHECK_INVALID_CONFIG" ]] ; then
	echo "CHECK_INVALID_CONFIG[$CHECK_INVALID_CONFIG]"
    echo "********** Invalid config.xml no UINewsstandApp **************"
    exit 1
fi

