import '../from_json_to_json.dart';

/// Converts a dynamic value to a [bool].
///
/// Returns false if the input is null or cannot be converted to a [bool].
///
/// ```dart
/// jsonDecodeBool('true'); // true
/// jsonDecodeBool('false'); // false
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
bool jsonDecodeBool(final dynamic value) {
  if (value == null) return false;
  if (value case final String string) {
    if (string == 'true') return true;
    if (string == 'false') return false;
    final int intValue = jsonDecodeInt(string);
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
dynamic jsonEncodeBool(final bool value) => value;
