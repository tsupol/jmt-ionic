describe('Sample testing', () => {

  beforeEach(() => {
    browser.get('/#/app/application/add/step1'); // for ionic serve test
  });

  it('should be able to fill pre-application', () => {
    //step 1
    expect(element(by.xpath('.//*[.="Step 1 : ข้อมูลผู้ขอสินเชื่อ"]')).isPresent()).toBe(true);
    element(by.model('register.idens[1]')).sendKeys('1');
    element(by.model('register.idens[2]')).sendKeys('2');
    element(by.model('register.idens[3]')).sendKeys('3');
    element(by.model('register.idens[4]')).sendKeys('4');
    element(by.model('register.idens[5]')).sendKeys('5');
    element(by.model('register.idens[6]')).sendKeys('6');
    element(by.model('register.idens[7]')).sendKeys('7');
    element(by.model('register.idens[8]')).sendKeys('8');
    element(by.model('register.idens[9]')).sendKeys('9');
    element(by.model('register.idens[10]')).sendKeys('0');
    element(by.model('register.idens[11]')).sendKeys('1');
    element(by.model('register.idens[12]')).sendKeys('2');
    element(by.model('register.idens[13]')).sendKeys('3');
    element(By.model('register.prefix')).$('[value="miss"]').click();
    element(by.model('register.name_th')).sendKeys('จอร์น');
    element(by.model('register.nickname_th')).sendKeys('จอร์นนี่');
    element(by.model('register.surname_th')).sendKeys('โด');
    element(by.model('register.name_en')).sendKeys('John');
    element(by.model('register.surname_en')).sendKeys('Doe');
    element(By.model('register.bday_date')).$('[value="number:1"]').click();
    element(By.model('register.bday_month')).$('[value="number:1"]').click();
    element(By.model('register.bday_year')).$('[value="number:1999"]').click();
    element(By.model('register.marital_status')).$('[value="married"]').click();
    element(by.model('register.mobile_1')).sendKeys('0912345678');
    browser.executeScript("arguments[0].scrollIntoView();", element(by.css('#button-step-1')).getWebElement());
    element(by.model('register.mobile_2')).sendKeys('0812345678');
    element(by.model('register.mobile_2')).sendKeys('0812345678');
    element(By.model('register.contact_time_range')).$('[value="17.00-22.00"]').click();
    element(By.model('register.document_address')).$('[value="2"]').click();
    element(by.model('register.email')).sendKeys('customer@mail.com');
    element(by.css('#button-step-1')).click();

    //step 2
    expect(element(by.xpath('.//*[.="Step 2 : ที่อยู่ปัจจุบัน"]')).isPresent()).toBe(true);
    element(by.model('register.tel')).sendKeys('012345678');
    element(by.model('register.tel_link')).sendKeys('');
    element(by.model('register.address_number')).sendKeys('123');
    element(by.model('register.address_moo')).sendKeys('1');
    element(by.model('register.address_village')).sendKeys('');
    element(by.model('register.address_floor')).sendKeys('');
    element(by.model('register.address_room')).sendKeys('');
    element(by.model('register.address_soi')).sendKeys('');
    element(by.model('register.address_road')).sendKeys('red road');
    element(by.model('register.address_tumbon')).sendKeys('tumbon');
    element(by.model('register.address_amphur')).sendKeys('amphur');
    element(by.model('register.address_province')).sendKeys('province');
    element(by.model('register.address_postcode[1]')).sendKeys('1');
    element(by.model('register.address_postcode[2]')).sendKeys('0');
    element(by.model('register.address_postcode[3]')).sendKeys('0');
    element(by.model('register.address_postcode[4]')).sendKeys('0');
    element(by.model('register.address_postcode[5]')).sendKeys('0');
    browser.executeScript("arguments[0].scrollIntoView();", element(by.css('#button-step-2')).getWebElement());
    element(By.model('register.residence_type')).$('[value="house"]').click();
    element(by.model('register.dweller_count')).sendKeys('2');
    element(by.model('register.dweller_range_year')).sendKeys('5');
    element(by.model('register.dweller_range_month')).sendKeys('2');
    element(by.css('#button-step-2')).click();

    //step 3
    expect(element(by.xpath('.//*[.="Step 3 : สถานที่ทำงาน"]')).isPresent()).toBe(true);
    element(By.model('register.office_tel')).sendKeys('012345678');
    element(By.model('register.office_tel_link')).sendKeys('');
    element(By.model('register.office_headquarters_tel')).sendKeys('');
    element(By.model('register.office_headquarters_tel_link')).sendKeys('');
    element(By.model('register.office_address_number')).sendKeys('1234');
    element(By.model('register.office_address_moo')).sendKeys('');
    element(By.model('register.office_address_village')).sendKeys('');
    element(By.model('register.office_address_floor')).sendKeys('');
    element(By.model('register.office_address_room')).sendKeys('');
    element(By.model('register.office_address_soi')).sendKeys('');
    element(By.model('register.office_address_road')).sendKeys('test road');
    element(By.model('register.office_address_tumbon')).sendKeys('tumbon');
    element(By.model('register.office_address_amphur')).sendKeys('amphur');
    element(By.model('register.office_address_province')).sendKeys('province');
    element(By.model('register.office_address_postcode[1]')).sendKeys('1');
    element(By.model('register.office_address_postcode[2]')).sendKeys('0');
    element(By.model('register.office_address_postcode[3]')).sendKeys('0');
    element(By.model('register.office_address_postcode[4]')).sendKeys('0');
    element(By.model('register.office_address_postcode[5]')).sendKeys('0');
    browser.executeScript("arguments[0].scrollIntoView();", element(by.css('#button-step-3')).getWebElement());
    element(By.model('register.work_duration.year')).sendKeys('10');
    element(By.model('register.work_duration.month')).sendKeys('2');
    element(By.model('register.work_salary')).sendKeys('100000');
    element(By.model('register.business_type')).$('[value="limited_company"]').click();
    element(By.model('register.work_type')).$('[value="saler"]').click();
    element(By.model('register.work_appointment')).sendKeys('Labor');
    element(By.model('register.work_status')).sendKeys('Salary');
    element(By.model('register.work_salary_pay')).sendKeys('Bank Transfer');
    element(by.css('#button-step-3')).click();

    //step 4
    expect(element(by.xpath('.//*[.="Step 4 : บุคคลอ้างอิง"]')).isPresent()).toBe(true);
    element(By.model('register.reference1_name')).sendKeys('Peter');
    element(By.model('register.reference1_surname')).sendKeys('Sho');
    element(By.model('register.reference1_tel')).sendKeys('0123456789');
    element(By.model('register.reference1_relation')).sendKeys('10');
    element(By.model('register.reference2_name')).sendKeys('Mark');
    element(By.model('register.reference2_surname')).sendKeys('Zuck');
    element(By.model('register.reference2_tel')).sendKeys('0123456789');
    element(By.model('register.reference2_relation')).sendKeys('10');
    element(by.css('#button-step-4')).click();

    //step 5
    expect(element(by.xpath('.//*[.="Step 5 : การรับสินเชื่อ"]')).isPresent()).toBe(true);
    element(By.model('register.loan_receive_bank_name')).sendKeys('Kasikorn');
    element(By.model('register.loan_receive_bank_branch')).sendKeys('Bangkok');
    element(By.model('register.loan_receive_bank_account_name')).sendKeys('John Doe');
    element(By.model('register.loan_receive_bank_account_number[1]')).sendKeys('1');
    element(By.model('register.loan_receive_bank_account_number[2]')).sendKeys('2');
    element(By.model('register.loan_receive_bank_account_number[3]')).sendKeys('3');
    element(By.model('register.loan_receive_bank_account_number[4]')).sendKeys('4');
    element(By.model('register.loan_receive_bank_account_number[5]')).sendKeys('5');
    element(By.model('register.loan_receive_bank_account_number[6]')).sendKeys('6');
    element(By.model('register.loan_receive_bank_account_number[7]')).sendKeys('7');
    element(By.model('register.loan_receive_bank_account_number[8]')).sendKeys('8');
    element(By.model('register.loan_receive_bank_account_number[9]')).sendKeys('9');
    element(By.model('register.loan_receive_bank_account_number[10]')).sendKeys('0');
    element(By.model('register.loan_receive_limit')).sendKeys('100000');
    element(by.css('#button-step-5')).click();

    //step 6
    expect(element(by.xpath('.//*[.="Step 6 : ..."]')).isPresent()).toBe(true);
    element(by.css('#button-step-6')).click();
  });

});
