/// Converts a dynamic value to a [String].
///
/// Returns an empty string for null input.
String jsonDecodeString(final dynamic value) => switch (value) {
  null => '',
  final String string => string,
  _ => value.toString(),
};

/// Identity function for [String] values in JSON encoding.
dynamic jsonEncodeString(final String value) => value;
