
# Clean
.PHONY: clean
clean:
	flutter clean

# Fetch dependencies
.PHONY: install
install:
	 flutter pub get

# Run flutter app
.PHONY: run
run:
	flutter run

# Run all tests
.PHONY: test
test:
	make flutter-test
	make patrol-test

# Run unit & widget tests with coverage
.PHONY: flutter-test
flutter-test:
	flutter test --coverage --test-randomize-ordering-seed random

# Activate patrol CLI tool
.PHONY: patrol-activate
patrol-activate:
	flutter pub global activate patrol_cli

# Run integration tests with Patrol
.PHONY: patrol-test
patrol-test:
	patrol test --debug --no-release 
## Run integration tests with Patrol for specific target test file
# patrol test -t integration_test/hotels_test.dart --debug --no-release 

# Run integration tests with Patrol for Android specific device
.PHONY: test-android
test-android:
	patrol test --device emulator-5554 --tags android --debug --no-release

#Run integration tests with Patrol for iOS specific device
.PHONY: test-ios
test-ios:
	patrol test --device C19E2563-AC06-45FD-9BA7-D6AEE1CD9AAF --tags ios --debug --no-release

# Run integration tests with Patrol for all devices
.PHONY: test-all
test-all:
	make test-android &
	make test-ios &
	wait

# Run integration tests with Patrol development mode
.PHONY: patrol-develop
patrol-develop:
	patrol develop -t integration_test/hotels_test.dart