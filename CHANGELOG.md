## 0.3.0

BREAKING:

- chore:
  dart 3.8.0
  is_dart_empty_or_not: ^0.2.3
  lints: ^6.0.0
  xsoulspace_lints: ^0.1.0

- feat: `dateTimeFromYYYYMMDDHMMSSAM`: Parse custom "YYYY-MM-DD H:MM:SS AM/PM" strings to `DateTime?`
- feat: `dateTimeToYYYYMMDDHMMSSAM`: Format `DateTime?` as "YYYY-MM-DD H:MM:SS AM/PM" string
- fix: typo in dateTimeToMillisecondsSinceEpoch and dateTimeFromMillisecondsSinceEpoch

## 0.2.1

- perf: dateTimeFromIso8601String added check for empty strings

## 0.2.0

### Added

- Type-safe decoding with `jsonDecodeListAs<T>` and `jsonDecodeMapAs<K,V>`
- More flexible input handling - all decode functions now accept `dynamic` input
- Enhanced string decoding with pattern matching in `jsonDecodeString`

## 0.1.0

initial version
