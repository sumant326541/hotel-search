
## Test Structure and Strategy
How & Where to run tests

| Test Type        | Directory            | Tool          | Trigger Point         | Environment     |
|------------------|----------------------|---------------|------------------------|-----------------|
| Unit Tests        | `test/`              | `flutter_test`| Local & CI             | Any             |
| Widget Tests      | `test/`              | `flutter_test`| Local & CI             | Any             |
| Integration Tests | `integration_test/` | `patrol`      | Local & CI             | Emulator/device |
| Manual Testing    | N/A                  | Manual        | Local only             | Emulator/device |

---

## CI/CD: To add testing in any CI/CD pipeline

To add testing in existing or any pipeline just need to add following jobs for pipeline

1. Setup Flutter & Install Dependencies
2. Install Patrol CLI in CI
3. Start a Testing Device (Emulator/Simulator)
4. Run Patrol Tests
5. Save Artifacts & Send Notifications (Slack, Teams, etc.)



### Example of Github action Job (job name -> integration-test)
```
name: Integration Tests

on:
  pull_request:
    branches: [ main ]
  push:
    branches: [ main ]

jobs:
  integration-test:
    name: Run Patrol Integration Tests
    runs-on: macos-latest
    needs: build-and-test

    strategy:
      matrix:
        device: [ "pixel_3a", "pixel_5" ]

    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Set up Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.19.0'
          channel: stable

      - name: Install dependencies
        run: flutter pub get

      - name: Install Patrol CLI
        run: dart pub global activate patrol_cli

      - name: Run Android Emulator and Execute Patrol Tests
        uses: reactivecircus/android-emulator-runner@v2
        with:
          api-level: 33
          target: google_apis
          arch: x86_64
          profile: ${{ matrix.device }}
          script: |
            echo "Running Patrol integration tests on ${{ matrix.device }}"
            make patrol-test

      - name: Upload test results (optional)
        if: always()
        uses: actions/upload-artifact@v3
        with:
          name: patrol-test-results
          path: build/

      # Optional: Notify Slack/Teams
      # - name: Notify team
      #   uses: some-notification-action
```

