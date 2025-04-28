publish-dry:
	flutter pub publish --dry-run

publish:
	flutter pub publish
gen-rewrite:
	fvm flutter pub run build_runner build --delete-conflicting-outputs
gen:
	fvm flutter pub run build_runner build

coverage:
	dart pub global activate coverage
	dart test --coverage="coverage"
	dart pub global run coverage:format_coverage --lcov --in=coverage --out=coverage/lcov.info --packages=.dart_tool/package_config.json --report-on=lib

coverage-open:
	genhtml coverage/lcov.info -o coverage/html
	open coverage/html/index.html