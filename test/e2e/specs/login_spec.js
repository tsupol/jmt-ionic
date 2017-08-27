
describe('Login with OTP', () => {
  beforeEach(() => {
    browser.get('/#/otp/verify');
  });

  it('should be show error if input is not filled', () => {
    expect(element(by.model('otp_number')).isPresent()).toBe(true);
    element(by.css('#button-otp-verify')).click();
    expect(element(by.css('.assertive')).isPresent()).toBe(true);
  });

  it('should be show error if otp is invalid', () => {
    expect(element(by.model('otp_number')).isPresent()).toBe(true);
    element(by.model('otp_number')).sendKeys('123456');
    element(by.css('#button-otp-verify')).click();
    expect(element(by.css('.assertive')).isPresent()).toBe(true);
  });

  it('should be show login page after submit valid otp', () => {
    expect(element(by.model('otp_number')).isPresent()).toBe(true);
    element(by.model('otp_number')).sendKeys('123456789');
    element(by.css('#button-otp-verify')).click();
    expect(browser.getCurrentUrl()).toEqual("http://localhost:8100/#/otp/pwd_setup");
  });
});
