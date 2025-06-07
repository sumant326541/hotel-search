## 🤖 CI/CD: 

To add testing in existing or any pipeline just need to add following jobs for pipeline

1. Setup Flutter & Get Dependecies
2. Install patrol in ci
3. Set testing Device
4. Run test



### Example of Github action Job (job name -> integration-test)
```
integration-test:
    runs-on: macos-latest
    needs: build-and-test

    strategy:
      matrix:
        device: [ "Pixel_3a_API_33" ]

    steps:
    - uses: actions/checkout@v3

    - name: Set up Flutter
      uses: subosito/flutter-action@v2
      with:
        flutter-version: '3.19.0'
        channel: stable

    - name: Install dependencies
      run: flutter pub get

    - name: Install Patrol
      run: dart pub global activate patrol_cli

    - name: Run emulator
      uses: reactivecircus/android-emulator-runner@v2
      with:
        api-level: 33
        target: google_apis
        arch: x86_64
        profile: pixel_3a
        script: |
          make patrol-test
```

