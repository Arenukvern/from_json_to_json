import '../from_json_to_json.dart';

/// Converts a dynamic value to a [bool].
///
/// Returns false if the input is null or cannot be converted to a [bool].
///
/// ```dart
/// boolFromJson('true'); // true
/// boolFromJson('false'); // false
/// boolFromJson('1'); // true
/// boolFromJson('0'); // false
/// boolFromJson('1.0'); // true
/// boolFromJson('0.0'); // false
/// boolFromJson(1); // true
/// boolFromJson(0); // false
/// boolFromJson(null); // false
/// ```
///
/// @ai Use this method when you need to convert a dynamic value to a [bool].
bool boolFromJson(final dynamic value) {
  if (value == null) return false;
  if (value case final String string) {
    if (string == 'true') return true;
    if (string == 'false') return false;
    final int intValue = intFromJson(string);
    return intValue == 1;
  }
  return switch (value) {
    final bool value => value,
    final int value => value == 1,
    final double value => value == 1.0,
    _ => false,
  };
}

/// Safe conversion of a [bool] to a JSON
// ignore: avoid_positional_boolean_parameters
bool boolToJson(final bool value) => value;
