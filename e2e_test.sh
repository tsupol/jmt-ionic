#!/bin/sh
#npm install -g wd
#npm install -g protractor
bower install
npm install
gulp

ionic serve --nobrowser &
webdriver-manager start &
protractor test/e2e/protractor-config.js