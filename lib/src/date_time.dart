/// Converts milliseconds since epoch to a [DateTime] object.
///
/// Returns null if the provided millisecondsSinceEpoch is null.
///
/// [millisecondsSinceEpoch] The milliseconds since epoch to convert.
/// returns A [DateTime] object or null if the input is null.
///
/// @ai Use this function to convert timestamps from external sources into
/// [DateTime] objects for easier manipulation.
DateTime? dateTimeFromMilisecondsSinceEpoch(final int? millisecondsSinceEpoch) {
  if (millisecondsSinceEpoch == null) return null;
  return DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
}

/// Converts a [DateTime] object to milliseconds since epoch.
///
/// Returns null if the provided dateTime is null.
///
/// [dateTime] The [DateTime] object to convert.
/// returns The milliseconds since epoch or null if the input is null.
///
/// @ai Use this function to serialize [DateTime] objects for storage or
/// transmission.
int? dateTimeToMilisecondsSinceEpoch(final DateTime? dateTime) {
  if (dateTime == null) return null;

  return dateTime.millisecondsSinceEpoch;
}

/// Converts an ISO 8601 string to a [DateTime] object.
///
/// Returns null if the provided value is null.
///
/// [value] The ISO 8601 string to convert.
/// returns The [DateTime] object or null if the input is null.
DateTime? dateTimeFromIso8601String(final String? value) {
  if (value == null) return null;
  return DateTime.tryParse(value);
}

/// Converts a [DateTime] object to an ISO 8601 string.
///
/// Returns null if the provided dateTime is null.
///
/// @ai Use this function to serialize [DateTime] objects for storage or
/// transmission.
dynamic dateTimeToIso8601String(final DateTime? value) =>
    value?.toIso8601String();
