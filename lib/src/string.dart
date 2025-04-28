/// Converts a dynamic value to a [String].
///
/// Returns an empty string for null input.
String stringFromJson(final dynamic value) =>
    value == null ? '' : value.toString();

/// Identity function for [String] values in JSON encoding.
String stringToJson(final String value) => value;
