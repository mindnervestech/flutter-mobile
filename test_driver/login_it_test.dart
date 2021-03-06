// Import Flutter Driver API
import 'package:flutter_driver/flutter_driver.dart';
import 'package:invoiceninja/.env.dart';
import 'package:test/test.dart';
import 'package:invoiceninja/utils/keys.dart';

void main() {
  group('LOGIN TEST', () {
    
    FlutterDriver driver;
    String loginEmail, loginPassword, loginUrl, loginSecret;

    setUp(() async {
      driver = await FlutterDriver.connect();

      // read config file
      loginEmail = Config.LOGIN_EMAIL;
      loginPassword = Config.LOGIN_PASSWORD;
      loginUrl = Config.LOGIN_URL;
      loginSecret = Config.LOGIN_SECRET;
    });

    tearDown(() async {
      if(driver!=null) {
        driver.close();
      }
    });

    test('No input provided by user test', () async {

      await driver.tap(find.byValueKey(LoginKeys.emailKeyString));
      await driver.enterText('');

      await driver.tap(find.byValueKey(LoginKeys.passwordKeyString));
      await driver.enterText('');

      await driver.tap(find.byValueKey(LoginKeys.urlKeyString));
      await driver.enterText('');

      await driver.tap(find.byValueKey(LoginKeys.secretKeyString));
      await driver.enterText('');

      await driver.tap(find.text('LOGIN'));
      await driver.waitFor(find.text('Please enter your email'));
      await driver.waitFor(find.text('Please enter your password'));
    });

    test('Details filled by user and login', () async {

      await driver.tap(find.byValueKey(LoginKeys.emailKeyString));
      await driver.enterText(loginEmail);

      await driver.tap(find.byValueKey(LoginKeys.passwordKeyString));
      await driver.enterText(loginPassword);

      await driver.tap(find.byValueKey(LoginKeys.urlKeyString));
      await driver.enterText(loginUrl);

      await driver.tap(find.byValueKey(LoginKeys.secretKeyString));
      await driver.enterText(loginSecret);

      await driver.tap(find.text('LOGIN'));

      await driver.waitFor(find.byType('DashboardScreen'), timeout: new Duration(seconds: 60));
    });
  });
}