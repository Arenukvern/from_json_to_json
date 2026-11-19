/// Converts a dynamic value to a [String].
///
/// Returns an empty string for null input.
String jsonDecodeString(final dynamic value) => switch (value) {
  null => '',
  final String string => string,
  _ => value.toString(),
};

/// Converts a dynamic value to a nullable [String].
///
/// Returns the value when it is already a [String], null otherwise —
/// unlike [jsonDecodeString] this never coerces non-string values.
///
/// ```dart
/// jsonDecodeNullableString('value'); // 'value'
/// jsonDecodeNullableString(null); // null
/// jsonDecodeNullableString(42); // null
/// ```
///
/// @ai Use when a field must carry a real string, e.g.
/// `jsonDecodeNullableString(json['name']) ?? 'fallback'`.
String? jsonDecodeNullableString(final dynamic value) => switch (value) {
  final String value => value,
  _ => null,
};

/// Identity function for [String] values in JSON encoding.
dynamic jsonEncodeString(final String value) => value;
