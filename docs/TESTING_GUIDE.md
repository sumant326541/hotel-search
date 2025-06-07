
# Flutter Testing Guide

## Test Tools Used
- [`flutter_test`](https://docs.flutter.dev/cookbook/testing) — for unit and widget tests
- [`patrol`](https://patrol.leancode.co/) — for integration and end-to-end tests
- Manual QA — device/emulator testing

---

## Test Structure and Strategy
How & Where to run tests

| Test Type        | Directory            | Tool          | Trigger Point         | Environment     |
|------------------|----------------------|---------------|------------------------|-----------------|
| Unit Tests        | `test/`              | `flutter_test`| Local & CI             | Any             |
| Widget Tests      | `test/`              | `flutter_test`| Local & CI             | Any             |
| Integration Tests | `integration_test/` | `patrol`      | Local & CI             | Emulator/device |
| Manual Testing    | N/A                  | Manual        | Local only             | Emulator/device |

---

## ✅ Running Tests Locally

### 1. **Unit & Widget Tests**
```bash
make test-flutter
# or manually
flutter test --coverage --test-randomize-ordering-seed random
```

### 2. **Integration Tests (Patrol)**
Ensure an emulator or device is running.
```bash
make patrol-test
# or development mode with hot reload
make patrol-develop
```

### 3. **Run All Tests**
```bash
make test
```

---

## Manual QA Testing Guide

### Step-by-Step:

1. Run the app:
   ```bash
   make run
   ```
2. Use real or mock credentials depending on QA mode.
3. Record results in a test tracking system (e.g., Google Sheets, TestRail).
4. Take screenshots or logs of any bugs encountered.
5. Use logging or network proxy (like **Charles Proxy**) to inspect issues.

---

## CI/CD: To add testing in any CI/CD pipeline


## Tips for Maintaining Test Suite

- Structure tests by feature or domain (e.g., `test/auth/`, `integration_test/profile_test.dart`).
- Use tags or filters (`--tags`) if the test suite becomes large.
- Maintain CI stability by using emulator snapshots or caching builds.
