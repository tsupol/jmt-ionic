var mock = require('protractor-http-mock');

describe('Login with OTP', () => {
  beforeEach(() => {
    browser.addMockModule('httpMocker', function() {
      angular.module('httpMocker', ['jmt.application','ngMockE2E'])
        .run(function ($httpBackend) {
          console.log('Test platform bootstrapping');
          $httpBackend.whenPOST('https://jmt.play2pay.me/api/jmt/otp/request')
            .respond(function(method, url, data) {
              data.otp = 123456789;
              return [200, angular.toJson(data), {}];
            });

          $httpBackend.whenPOST('https://jmt.play2pay.me/api/jmt/otp/verify')
            .respond([
              {
                token: '123456',
                customer_id: '123456'
              }
            ]);

          // $httpBackend.whenGET('/login').passThrough();

          console.log('Test platform bootstrapping ... done');
        })
    });

    mock([{
      request: {
        path: 'https://jmt.play2pay.me/api/jmt/otp/request',
        method: 'POST'
      },
      response: {
        data: {
          otp: '123456789'
        }
      }
    }, {
      request: {
        path: 'https://jmt.play2pay.me/api/jmt/otp/verify',
        method: 'POST'
      },
      response: {
        data: {
          token: '123456789',
          customer_id: '123456789'
        }
      }
    }]);

    browser.get('/#/starter'); // for ionic serve test
  });

  afterEach(function(){
    mock.teardown();
  });

  it('should be able to see login page after click on the login button', () => {
    expect(element(by.css('.button-login')).isPresent()).toBe(true);
    // use for wait element is visible
    // var EC = protractor.ExpectedConditions;
    // browser.wait(EC.visibilityOf(element(by.css('[type="submit"]'))), 5000).then(function(){
    //  make something
    // });
  });
});
