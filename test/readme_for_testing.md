**Requirement**
* Run `npm install -g wd`
* Run `npm install -g appium`
* Run `npm install -g protractor`

**Before testing**

*For browser*
* Run `ionic serve --nobrowser` or `ionic serve -p 8100 --nobrowser`
* Run `webdriver-manager start`

*For emulator*
* Run `ionic run android`
* Run `appium`

#

**Testing**
* Run `protractor test/e2e/protractor.config.js` , it will run test script in test/e2e/specs/*_spec.js
