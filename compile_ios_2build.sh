#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/lib/node_modules:./node_modules/.bin:./platforms/ios/build/device/include/Cordova:/Users/Shared/Jenkins/.rvm/gems/ruby-2.3.0/bin

export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

RED='\033[0;31m'
NC='\033[0m' # No Color

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

rvm use 2.3

#rvm --default use system


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

UUID=$(match appstore --readonly yes | grep UUID | awk '{print $7}')

echo "[X]------------ Provision >>> $UUID --------------"

if [[ -z "$UUID" ]] ; then
    echo -e "${RED}UUID not set ${NC} check with match appstore --readonly yes | grep UUID | awk '{print ???}'"
    fastlane match appstore --readonly yes | grep UUID
    exit 1
fi


chmod +x hooks/after_prepare/010_add_platform_class.js


#"8ba8fddf-2143-4d19-b284-3e0a1a0475b3"

echo "[X]----------- Start Build ----------- "
#cordova build ios --device
#cordova build --release --device ios --codeSignIdentity="iPhone Distribution: Big Data Agency Company Limited (YG7X8EC59V)" --provisioningProfile="59a2fb97-9287-4d2d-8321-c712b9e80d7e"
cordova build --release --device ios --codeSignIdentity="iPhone Distribution: J VENTURES COMPANY LIMITED (NU2H4M2HQD)" --provisioningProfile=$UUID --verbose
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi
#cordova build --debug --device ios --codeSignIdentity="iPhone Developer: Natdanai Homkong (NPZ3W28D4G)" --provisioningProfile="ae4a7677-72a7-476f-b463-f2a0c627caf1"

echo "[X]----------- Build success ----------- "