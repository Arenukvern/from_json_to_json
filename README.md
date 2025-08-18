<!-- PROMPT for doc
Add detailed documentation comments to the following classes, focusing on their purpose and usage. -->

# from_json_to_json

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Coverage Status](https://coveralls.io/repos/github/Arenukvern/from_json_to_json/badge.svg?branch=main)](https://coveralls.io/github/Arenukvern/from_json_to_json?branch=main)
[![Pub Version](https://img.shields.io/badge/version-0.2.0-blue)](https://pub.dev/packages/from_json_to_json)

A robust Dart package for safe, predictable, and ergonomic conversion between JSON and Dart core types. Handles edge cases, nulls, and type mismatches gracefully—making your serialization and deserialization code cleaner and more reliable.

## Features

- **Type-safe decoding**: Convert dynamic JSON values to Dart types (`String`, `int`, `double`, `bool`, `List<T>`, `Map<K,V>`, `DateTime`, `Duration`) with sensible defaults.
- **Graceful fallback**: Never crash on nulls or invalid input—get empty, zero, or null values as appropriate.
- **Consistent encoding**: Convert Dart types back to JSON-ready primitives.
- **Utility checks**: Quickly verify if a string is decodable as a list or map.
- **Pure Dart**: use in server or client.

## Quick Start

```yaml
dependencies:
  from_json_to_json: ^0.3.0
```

```dart
import 'package:from_json_to_json/from_json_to_json.dart';

final list = jsonDecodeList('[1,2,3]'); // [1, 2, 3]
final map = jsonDecodeMap('{"a":1}');
final typedList = jsonDecodeListAs<int>('[1,2,3]'); // List<int> [1, 2, 3]
final typedMap = jsonDecodeMapAs<String, int>('{"a":1}'); // Map<String, int>
final dt = dateTimeFromIso8601String('2024-01-01T12:00:00Z');
final duration = jsonDecodeDurationInSeconds('1.5'); // 1.5 seconds
final n = jsonDecodeInt('42'); // 42
final b = jsonDecodeBool('true'); // true
```

## API Overview

| Type     | Function                             | Description                                                                                                                                                             |
| -------- | ------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| bool     | `jsonDecodeBool`                     | Convert dynamic to bool, false if invalid                                                                                                                               |
| bool     | `jsonEncodeBool`                     | Identity for bool encoding                                                                                                                                              |
| DateTime | `dateTimeFromIso8601String`          | String? → DateTime?                                                                                                                                                     |
| DateTime | `dateTimeFromMillisecondsSinceEpoch` | int? → DateTime?                                                                                                                                                        |
| DateTime | `dateTimeFromYYYYMMDDHMMSSAM`        | String? → DateTime? (YYYY-MM-DD H:MM:SS AM/PM)                                                                                                                          |
| DateTime | `dateTimeToIso8601String`            | DateTime? → String?                                                                                                                                                     |
| DateTime | `dateTimeToMillisecondsSinceEpoch`   | DateTime? → int?                                                                                                                                                        |
| DateTime | `dateTimeToYYYYMMDDHMMSSAM`          | DateTime? → String? (YYYY-MM-DD H:MM:SS AM/PM)                                                                                                                          |
| double   | `jsonDecodeDouble`                   | Convert dynamic to double, 0 if invalid                                                                                                                                 |
| double   | `jsonDecodeNullableDouble`           | Convert dynamic to double, null if invalid                                                                                                                              |
| double   | `jsonEncodeDouble`                   | Identity for double encoding                                                                                                                                            |
| Duration | `jsonDecodeDurationFromISO8601`      | String? → Duration (ISO 8601 format: P1Y, P6M, P2W, P30D; shorthand like "1Y", "6M", "2W", "30D" supported with approximate conversions: 1Y=365d, 1M=30d, 1W=7d, 1D=1d) |
| Duration | `jsonDecodeDurationInMicroseconds`   | dynamic → Duration (microseconds)                                                                                                                                       |
| Duration | `jsonDecodeDurationInMinutes`        | dynamic → Duration (minutes, supports double)                                                                                                                           |
| Duration | `jsonDecodeDurationInSeconds`        | dynamic → Duration (seconds, supports double)                                                                                                                           |
| Duration | `jsonEncodeDurationInMicroseconds`   | Duration → int (microseconds)                                                                                                                                           |
| Duration | `jsonEncodeDurationInMinutes`        | Duration → int (minutes)                                                                                                                                                |
| Duration | `jsonEncodeDurationInSeconds`        | Duration → int (seconds)                                                                                                                                                |
| Duration | `jsonEncodeDurationToISO8601`        | Duration → String (ISO 8601 format)                                                                                                                                     |
| int      | `jsonDecodeInt`                      | Convert dynamic to int, 0 if invalid                                                                                                                                    |
| int      | `jsonDecodeNullableInt`              | Convert dynamic to int, null if invalid                                                                                                                                 |
| int      | `jsonEncodeInt`                      | Identity for int encoding                                                                                                                                               |
| List     | `jsonDecodeList`                     | Decode JSON to list, always returns a list                                                                                                                              |
| List     | `jsonDecodeListAs<T>`                | Decode JSON to typed List<T>, may throw on type mismatch                                                                                                                |
| List     | `verifyListDecodability`             | Check if input is a JSON array                                                                                                                                          |
| Map      | `jsonDecodeMap`                      | Decode JSON to map, always returns a map                                                                                                                                |
| Map      | `jsonDecodeMapAs<K,V>`               | Decode JSON to typed Map<K,V>, may throw on type mismatch                                                                                                               |
| Map      | `jsonDecodeNullableMap`              | Decode JSON to map, returns null if empty/invalid                                                                                                                       |
| Map      | `jsonDecodeThrowableMap`             | Decode JSON to map, throws on error                                                                                                                                     |
| Map      | `verifyMapDecodability`              | Check if input is a JSON object                                                                                                                                         |
| String   | `jsonDecodeString`                   | Convert dynamic to string, empty if null                                                                                                                                |
| String   | `jsonEncodeString`                   | Identity for string encoding                                                                                                                                            |

## Examples

### List

```dart
jsonDecodeList('[1,2,3]'); // [1, 2, 3]
jsonDecodeListAs<int>('[1,2,3]'); // List<int> [1, 2, 3]
jsonDecodeList(''); // []
jsonDecodeList('invalid'); // throws FormatException
verifyListDecodability('[1,2]'); // true
```

### Map

```dart
jsonDecodeMap('{"a":1}'); // {a: 1}
jsonDecodeMapAs<String, int>('{"a":1}'); // Map<String, int> {a: 1}
jsonDecodeMap(''); // {}
jsonDecodeMap('invalid'); // throws FormatException
jsonDecodeNullableMap('{}'); // null
verifyMapDecodability('{}'); // true
```

### Numbers

```dart
jsonDecodeInt('42'); // 42
jsonDecodeDouble('3.14'); // 3.14
jsonDecodeNullableInt('foo'); // null
```

### Bool

```dart
jsonDecodeBool('true'); // true
jsonDecodeBool('0'); // false
```

### DateTime

```dart
dateTimeFromMillisecondsSinceEpoch(1700000000000); // DateTime
dateTimeFromIso8601String('2024-01-01T12:00:00Z'); // DateTime
```

### Duration

```dart
jsonDecodeDurationInSeconds('1.5'); // 1.5 seconds
jsonDecodeDurationInMicroseconds('1000000'); // 1 second
jsonDecodeDurationInMinutes('2.5'); // 2 min 30 sec
jsonDecodeDurationFromISO8601('P1Y'); // 365 days
jsonDecodeDurationFromISO8601('P6M'); // 180 days
jsonDecodeDurationFromISO8601('P2W'); // 14 days
jsonDecodeDurationFromISO8601('P30D'); // 30 days
jsonDecodeDurationFromISO8601('1Y'); // 365 days (shorthand)
jsonDecodeDurationFromISO8601('6M'); // 180 days (shorthand)
jsonDecodeDurationFromISO8601('2W'); // 14 days (shorthand)
jsonDecodeDurationFromISO8601('30D'); // 30 days (shorthand)
jsonEncodeDurationToISO8601(Duration(days: 365)); // "P1Y"
jsonEncodeDurationToISO8601(Duration(days: 180)); // "P6M"
jsonEncodeDurationToISO8601(Duration(days: 14)); // "P2W"
jsonEncodeDurationToISO8601(Duration(days: 30)); // "P1M"
```

## Development

### Code Coverage

To generate and view code coverage:

1. Generate coverage report:

```bash
make coverage
```

2. View coverage report in browser (requires `lcov`):

```bash
make coverage-open
```

Note: If you don't have `lcov` installed, you can install it with:

- macOS: `brew install lcov`
- Linux: `sudo apt-get install lcov`
- Windows: Download from http://ltp.sourceforge.net/coverage/lcov.php

## Changelog

See [CHANGELOG.md](CHANGELOG.md)

## License

This package is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
