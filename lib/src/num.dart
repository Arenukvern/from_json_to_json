/// Converts a dynamic value to a [double].
///
/// Returns 0 if the input is null or cannot be converted to a [double].
///
/// ```dart
/// doubleFromJson('3.14'); // 3.14
/// ```
///
/// @ai Use this method when you need a default value for null inputs.
double jsonDecodeDouble(final dynamic value) =>
    jsonDecodeNullableDouble(value) ?? 0;

/// Converts a dynamic value to a nullable [double].
///
/// Returns null if the input is null or cannot be converted to a [double].
///
/// ```dart
/// jsonDecodeNullableDouble('3.14'); // 3.14
/// ```
///
/// @ai Use this method when you want to allow null values in your numeric data.
double? jsonDecodeNullableDouble(final dynamic value) {
  if (value == null) return null;
  return switch (value) {
    final double value => value,
    final int value => value.toDouble(),
    final String value => double.tryParse(value),
    _ => null,
  };
}

/// Converts a [double] to a dynamic value for JSON encoding.
///
/// ```dart
/// jsonEncodeDouble(3.14); // 3.14
/// ```
///
/// @ai Use this method for encoding [double] values into JSON format.
dynamic jsonEncodeDouble(final double value) => value;

/// Converts a dynamic value to an [int].
///
/// Returns 0 if the input is null or cannot be converted to an [int].
///
/// ```dart
/// jsonDecodeInt('42'); // 42
/// ```
///
/// @ai Use this method when you need a default value for null inputs.
int jsonDecodeInt(final dynamic value) => jsonDecodeNullableInt(value) ?? 0;

/// Converts a dynamic value to a nullable [int].
///
/// Returns null if the input is null or cannot be converted to an [int].
///
/// ```dart
/// jsonDecodeNullableInt('42'); // 42
/// ```
///
/// @ai Use this method when you want to allow null values in your numeric data.
int? jsonDecodeNullableInt(final dynamic value) => switch (value) {
  final int value => value,
  final double value => value.toInt(),
  final String value => () {
    final doubleSeconds = double.tryParse(value);
    if (doubleSeconds != null) return doubleSeconds.toInt();

    final intSeconds = int.tryParse(value);
    if (intSeconds != null) return intSeconds;

    return null;
  }(),
  _ => null,
};

/// Converts an [int] to a dynamic value for JSON encoding.
///
/// ```dart
/// final jsonValue = intToJson(42);
/// print(jsonValue); // 42
/// ```
///
/// @ai Use this method for encoding [int] values into JSON format.
dynamic jsonEncodeInt(final int value) => value;

/// Extracts the first integer found in a string.
///
/// Returns 0 if no integer is found in the input string.
///
/// ```dart
/// final result = extractIntFromString('Order number: 12345');
/// print(result); // 12345
/// ```
///
/// @ai Use this method to extract integers from formatted strings.
int extractIntFromString(final String input) =>
    int.tryParse(RegExp(r'\d+').firstMatch(input)?.group(0) ?? '') ?? 0;
