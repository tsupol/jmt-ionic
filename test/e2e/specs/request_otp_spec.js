describe('Request OTP', () => {
  beforeEach(() => {
    browser.get('/#/otp/request');
  });

  it('should be show error if input is not filled', () => {
    expect(element(by.model('phone_number')).isPresent()).toBe(true);
    expect(element(by.model('account_id')).isPresent()).toBe(true);
    element(by.css('[type="submit"]')).click();
    expect(element(by.css('.assertive')).isPresent()).toBe(true);
  });

  it('should be show otp verify page after submit valid data', () => {
    expect(element(by.model('phone_number')).isPresent()).toBe(true);
    expect(element(by.model('account_id')).isPresent()).toBe(true);
    element(by.model('phone_number')).sendKeys('0812345678');
    element(by.model('account_id')).sendKeys('123456789');
    element(by.css('[type="submit"]')).click();
    expect(element(by.model('otp_number')).isPresent()).toBe(true);
  });
});
