
describe('Password setup at first time', () => {
  beforeEach(() => {
    browser.get('/#/otp/pwd_setup');
  });

  it('should be show error if input is not filled', () => {
    expect(element(by.model('new_password')).isPresent()).toBe(true);
    expect(element(by.model('retype_password')).isPresent()).toBe(true);
    element(by.css('#button-password-setup')).click();
    expect(browser.getCurrentUrl()).toEqual("http://localhost:8100/#/otp/pwd_setup");
  });

  it('should be show error if password is invalid', () => {
    expect(element(by.model('new_password')).isPresent()).toBe(true);
    expect(element(by.model('retype_password')).isPresent()).toBe(true);
    element(by.model('new_password')).sendKeys('123456');
    element(by.model('retype_password')).sendKeys('654321');
    element(by.css('#button-password-setup')).click();
    expect(element(by.css('.popup-body span')).getText()).toEqual('New Password and Re-type Password is not match. Please check them again.');
  });

  it('should be show login page after submit valid otp', () => {
    expect(element(by.model('new_password')).isPresent()).toBe(true);
    expect(element(by.model('retype_password')).isPresent()).toBe(true);
    element(by.model('new_password')).sendKeys('123456');
    element(by.model('retype_password')).sendKeys('123456');
    element(by.css('#button-password-setup')).click();
    expect(browser.getCurrentUrl()).toEqual("http://localhost:8100/#/app/pincode");
  });
});
