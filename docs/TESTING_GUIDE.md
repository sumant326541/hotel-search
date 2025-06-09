
# Flutter Testing Guide

## Test Tools and dependencies Used
- [`flutter_test`](https://docs.flutter.dev/cookbook/testing) — for unit and widget tests
- [`patrol`](https://patrol.leancode.co/) — for integration and end-to-end tests
   - patrol: ^3.15.2
   - patrol_finders: ^2.7.2
   - patrol_cli: ^3.6.0
- device - real-device/emulator/simulator/browserstack/Lambdatest

---

## Manual QA Testing Guide

### Step-by-Step:
Ensure initial setup has been complemented mentioned in README.md and an emulator or device is running.
1. Clean, install dependencies and Build & install the app:
   ```bash
   make clean
   make install
   make run
   ```
2. Perform manual testing on connected device/emulator
3. Record results in a test tracking system (e.g., Google Sheets, TestRail).
4. Take screenshots or logs of any bugs encountered.
5. Use logging or network proxy (like **Charles Proxy**) to inspect issues.
6. Create bug ticket with detailed logs,screenshot,expected & observed outcomes and step to reproduce in Jira


---

## ✅ Running Automation Tests Locally

Ensure initial setup has been complemented mentioned in README.md

### 1. Unit & Widget Tests
Added a sample widget test `test/features/account/presentation/pages/account_page_test.dart`
```bash
make flutter-test
# or manually
flutter test --coverage --test-randomize-ordering-seed random
```
## 2. Integration tests

The integration test suite can be found at `integration_test/` for e2e testing. The tests are ran by [Patrol](#running-patrol-tests).

### Running Patrol Tests
Firstly, [install](https://patrol.leancode.co/getting-started#install-patrol_cli) Patrol CLI.

Then make sure you have an Android emulator / iOS simulator set up and running, guide 
[Android-emulator-setup](https://developer.android.com/studio/run/emulator#get-started), 
[iOS-simulator-setup](https://developer.apple.com/documentation/xcode/running-your-app-in-simulator-or-on-a-device)

### Install patrol_cli:
```bash
make patrol-activate
```
### Run Test

```bash
make patrol-test
# or manually
patrol test --debug --no-release
# for development mode with hot reload
make patrol-develop
```

### 3. Run All Tests
```bash
make test
```

### 4. Run Specific Test
Ensure an emulator or device is running.
```bash
patrol test -t integration_test/hotels_test.dart --debug --no-release 
```

### 5. Run Test on specific android emulator/device
```bash
make test-android
# or manually
patrol test --device emulator-5554 --tags android --debug --no-release
```

### 6. Run Test on specific iOS simulator/device
```bash
make test-ios
# or manually
patrol test --device C19E2563-AC06-45FD-9BA7-D6AEE1CD9AAF --tags ios --debug --no-release
```

### 7. Run Test on all mentioned emulator/simulator/device
```bash
make test-all
```
### Detailed documentation can be found [here](https://patrol.leancode.co/cli-commands/test) or by executing `patrol test -help`.
---

### 8. Logs and Reporting

- [`Logs and test results`](https://patrol.leancode.co/logs) —  follow this link to check logs and test results.

### 9. Screenshots

- [`open issue`](https://github.com/leancodepl/patrol/issues/534) —  There is an open issue regarding the automatic capture of default screenshots on test failures in Patrol.
- We can wrap the test in a try/catch block and use Flutter’s screenshot method to capture a screenshot when a test fails.

### 10. Tips for Maintaining Test Suite

- Structure tests by feature or domain (e.g., `test/auth/`, `integration_test/hotel_test.dart`).
- Use tags or filters (`--tags`) if the test suite becomes large.
