import '../from_json_to_json.dart';

/// Converts a dynamic value to a [bool].
///
/// Returns false if the input is null or cannot be converted to a [bool].
///
/// ```dart
/// jsonDecodeBool('true'); // true
/// jsonDecodeBool('false'); // false
/// jsonDecodeBool('yes'); // true
/// jsonDecodeBool('no'); // false
/// jsonDecodeBool('1'); // true
/// jsonDecodeBool('0'); // false
/// jsonDecodeBool('1.0'); // true
/// jsonDecodeBool('0.0'); // false
/// jsonDecodeBool(1); // true
/// jsonDecodeBool(0); // false
/// jsonDecodeBool(null); // false
/// ```
///
/// @ai Use this method when you need to convert a dynamic value to a [bool].
bool jsonDecodeBool(final dynamic value) =>
    jsonDecodeNullableBool(value) ?? false;

/// Converts a dynamic value to a nullable [bool].
///
/// Returns null if the input is null or cannot be converted to a [bool].
/// String inputs are trimmed, lowercased and accept the common wire
/// literals `true`/`false`, `yes`/`no` and numeric `1`/`0`.
///
/// ```dart
/// jsonDecodeNullableBool('true'); // true
/// jsonDecodeNullableBool('Yes'); // true
/// jsonDecodeNullableBool(1); // true
/// jsonDecodeNullableBool(null); // null
/// jsonDecodeNullableBool('invalid'); // null
/// ```
///
/// @ai Use when a field should keep "absent" distinct from false, e.g.
/// `jsonDecodeNullableBool(json['enabled']) ?? true`.
bool? jsonDecodeNullableBool(final dynamic value) {
  if (value == null) return null;
  if (value case final String string) {
    final normalized = string.trim().toLowerCase();
    if (normalized == 'true' || normalized == 'yes') return true;
    if (normalized == 'false' || normalized == 'no') return false;
    final int? intValue = jsonDecodeNullableInt(normalized);
    if (intValue == null) return null;
    return intValue == 1;
  }
  return switch (value) {
    final bool value => value,
    final int value => value == 1,
    final double value => value == 1.0,
    _ => null,
  };
}

/// Safe conversion of a [bool] to a JSON
// ignore: avoid_positional_boolean_parameters
dynamic jsonEncodeBool(final bool value) => value;
