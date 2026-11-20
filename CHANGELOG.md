## 0.6.0

ADDED:

- `jsonDecodeNullableNotEmptyString` — dynamic → String?, null unless a non-empty String (absorbs intentcall_schema's deprecated stopgap)
- `jsonDecodeNullableThrowableBool` — dynamic → bool?, throws ArgumentError for uninterpretable non-null shapes (absorbs intentcall_schema's deprecated stopgap)
- `jsonDecodeNullableMapAs<K,V>` — dynamic → Map<K,V>?, null when absent/empty, throws on entry-type mismatch (absorbs intentcall_schema's deprecated stopgap)

FIXED:

- `jsonDecodeMap` / `jsonDecodeNullableMap` / `jsonDecodeThrowableMap` (and the `As<K,V>` variants that delegate to them) now accept maps with non-String keys — e.g. yaml-decoded `YamlMap`/`Map<dynamic, dynamic>` — by stringifying the keys. Previously these fell into the `toString()`→`jsonDecode` roundtrip and threw `FormatException` on the unquoted-key output.

CHANGED:

- `is_dart_empty_or_not` widened to `^0.6.0` (0.6.0 is additive: `whenEmptyOrNull`, `whenZeroOrNull`, `isNullOrBlank`).

## 0.5.2

CHANGED:

- Widen `is_dart_empty_or_not` to `^0.5.0` (0.5.0 is additive: nullable-aware empty checks). No API changes.

## 0.5.1

ADDED:

- `jsonDecodeNullableString` — dynamic → String?, null unless the value is already a String (no `toString()` coercion; pairs with `jsonDecodeString` like `jsonDecodeNullableInt` pairs with `jsonDecodeInt`)
- `jsonDecodeNullableBool` — dynamic → bool?, null when absent or unconvertible; string inputs are trimmed, lowercased and accept `true`/`false`, `yes`/`no`, `1`/`0`
- `jsonDecodeBool` now also accepts the `yes`/`no` and case-insensitive string literals (previously only `true`/`false` and numeric strings); delegates to `jsonDecodeNullableBool` like `jsonDecodeInt` does

## 0.5.0

BREAKING:
dependencies update

```yaml
environment:
  sdk: ">=3.11.0 <4.0.0"

dependencies:
  is_dart_empty_or_not: ^0.4.0
dev_dependencies:
  test: ^1.31.0
```

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
