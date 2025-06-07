
# Clean
.PHONY: clean
clean:
	flutter clean

# Fetch dependencies
.PHONY: get-dependencies
get-dependencies:
	 flutter pub get

# Run flutter app
.PHONY: run
run:
	flutter run

# Run all tests
.PHONY: test
test:
	make test-flutter
	make patrol-test

# Run unit & widget tests with coverage
.PHONY: test-flutter
test-flutter:
	flutter test --coverage --test-randomize-ordering-seed random

# Run integration tests with Patrol
.PHONY: patrol-test
patrol-test:
	patrol test -t integration_test/overview_test.dart --debug --no-release

# Run integration tests with Patrol development mode
.PHONY: patrol-develop
patrol-develop:
	patrol develop -t integration_test/overview_test.dart 