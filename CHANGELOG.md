## 0.4.0

BREAKING:
dependencies update

```yaml
environment:
  sdk: ">=3.10.0 <4.0.0"

dependencies:
  collection: ^1.19.1
  is_dart_empty_or_not: ^0.3.0
dev_dependencies:
  coverage: ^1.15.0
  test: ^1.29.0
```

## 0.3.0

BREAKING:

- fixed typos.
  Migration: rename call sites to the corrected names.

  - dateTimeFromMilisecondsSinceEpoch -> dateTimeFromMillisecondsSinceEpoch
  - dateTimeToMilisecondsSinceEpoch -> dateTimeToMillisecondsSinceEpoch

- chore:
  dart 3.8.0
  is_dart_empty_or_not: ^0.2.3
  lints: ^6.0.0
  xsoulspace_lints: ^0.1.2

- feat: `dateTimeFromYYYYMMDDHMMSSAM`: Parse custom "YYYY-MM-DD H:MM:SS AM/PM" strings to `DateTime?`
- feat: `dateTimeToYYYYMMDDHMMSSAM`: Format `DateTime?` as "YYYY-MM-DD H:MM:SS AM/PM" string

- feat: `jsonDecodeDurationFromISO8601`: Parse ISO 8601 duration format strings to `Duration`
  - Supports years (Y), months (M), weeks (W), and days (D)
  - Handles formats like "P1Y", "P6M", "P2W", "P30D"
  - Graceful handling of null, empty, and invalid input
  - Returns `Duration.zero` for negative values or parsing errors
  - Commonly used in API specifications, configuration files, and calendar applications
- feat: `jsonEncodeDurationToISO8601`: Convert `Duration` to ISO 8601 duration format string

  - Converts Duration objects to standardized ISO 8601 format
  - Prioritizes larger units (years, months, weeks, days) for readability
  - Supports complex durations with multiple units (e.g., "P1Y6M2W3D")
  - Returns "P0D" for zero or negative durations
  - Perfect for API responses, configuration serialization, and data exchange

## 0.2.1

- perf: dateTimeFromIso8601String added check for empty strings

## 0.2.0

### Added

- Type-safe decoding with `jsonDecodeListAs<T>` and `jsonDecodeMapAs<K,V>`
- More flexible input handling - all decode functions now accept `dynamic` input
- Enhanced string decoding with pattern matching in `jsonDecodeString`

## 0.1.0

initial version
