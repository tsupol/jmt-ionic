exports.config = {
  // seleniumAddress: 'http://localhost:4723/wd/hub',
  seleniumAddress: 'http://localhost:4444/wd/hub',

  // specs: ['./specs/*_spec.js'],
  specs: [
    // './specs/request_otp_spec.js',
    // './specs/login_spec.js',
    // './specs/password_setup_spec.js',
    './specs/signup_spec.js',
  ],

  // Reference: https://github.com/appium/sample-code/blob/master/sample-code/examples/node/helpers/caps.js
  // capabilities: {
  //   platformName: 'android',
  //   platformVersion: '5.0',
  //   deviceName: 'lg g3',
  //   browserName: "",
  //   autoWebview: true,
  //   //CHANGE THIS TO YOUR ABSOLUTE PATH
  //   app: 'platforms/android/build/outputs/apk/android-debug.apk'
  //   //newCommandTimeout: 60
  // },

  capabilities: {
    browserName: "chrome",
    chromeOptions: {
      args: ["--disable-web-security"]
    }
  },

  // capabilities: {
  //   'browserName': "phantomjs",
  //   'phantomjs.binary.path': '/workspace/phantomjs/bin/phantomjs.exe',
  //   'phantomjs.ghostdriver.cli.args': ['--loglevel=DEBUG']
  // },

  jasmineNodeOpts: {
    isVerbose: true,
  },

  // baseUrl: 'http://10.0.2.2:8000',
  baseUrl: 'http://localhost:8100',

  mocks: {
    dir: 'mocks',
    // default: ['default']
  },

  // configuring wd in onPrepare
  // wdBridge helps to bridge wd driver with other selenium clients
  // See https://github.com/sebv/wd-bridge/blob/master/README.md
  onPrepare: function () {
    var wd = require('wd'),
      protractor = require('protractor'),
      wdBridge = require('wd-bridge')(protractor, wd);
    wdBridge.initFromProtractor(exports.config);
    require('protractor-http-mock').config = {
      rootDirectory: __dirname, // default value: process.cwd()
      protractorConfig: '/protractor-config.js' // default value: 'protractor-conf.js'
    };
    browser.manage().timeouts().setScriptTimeout(30000);
  }
};
