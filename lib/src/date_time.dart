/// Converts milliseconds since epoch to a [DateTime] object.
///
/// Returns null if the provided millisecondsSinceEpoch is null.
///
/// [millisecondsSinceEpoch] The milliseconds since epoch to convert.
/// returns A [DateTime] object or null if the input is null.
///
/// @ai Use this function to convert timestamps from external sources into
/// [DateTime] objects for easier manipulation.
DateTime? dateTimeFromMillisecondsSinceEpoch(
  final int? millisecondsSinceEpoch,
) {
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
int? dateTimeToMillisecondsSinceEpoch(final DateTime? dateTime) {
  if (dateTime == null) return null;

  return dateTime.millisecondsSinceEpoch;
}

/// Converts an ISO 8601 string to a [DateTime] object.
///
/// Returns null if the provided value is null.
///
/// [value] The ISO 8601 string to convert.
/// returns The [DateTime] object or null if the input is null.
DateTime? dateTimeFromIso8601String(final String? value) => switch (value) {
  null => null,
  '' => null,
  _ => DateTime.tryParse(value),
};

/// Converts a [DateTime] object to an ISO 8601 string.
///
/// Returns null if the provided dateTime is null.
///
/// @ai Use this function to serialize [DateTime] objects for storage or
/// transmission.
String? dateTimeToIso8601String(final DateTime? value) =>
    value?.toIso8601String();

/// Converts a custom formatted string to a [DateTime] object.
///
/// Parses strings in the format "YYYY-MM-DD H:MM:SS AM/PM" (e.g., "2025-08-17 7:44:54 AM").
/// Returns null if the provided value is null, empty, or cannot be parsed.
///
/// [value] The custom formatted string to convert.
/// returns The [DateTime] object or null if the input is invalid.
///
/// @ai Use this function to parse DateTime strings from external sources
/// that use the "YYYY-MM-DD H:MM:SS AM/PM" format.
DateTime? dateTimeFromYYYYMMDDHMMSSAM(final String? value) {
  if (value == null || value.isEmpty) return null;

  try {
    // Split the string into date and time parts
    final parts = value.split(' ');
    if (parts.length != 3) return null; // Expected: [date, time, period]

    final datePart = parts[0]; // YYYY-MM-DD
    final timePart = parts[1]; // H:MM:SS
    final period = parts[2]; // AM/PM

    // Parse date components
    final dateComponents = datePart.split('-');
    if (dateComponents.length != 3) return null;

    final year = int.tryParse(dateComponents[0]);
    final month = int.tryParse(dateComponents[1]);
    final day = int.tryParse(dateComponents[2]);

    if (year == null || month == null || day == null) return null;

    // Parse time components
    final timeComponents = timePart.split(':');
    if (timeComponents.length != 3) return null;

    final hour = int.tryParse(timeComponents[0]);
    final minute = int.tryParse(timeComponents[1]);
    final second = int.tryParse(timeComponents[2]);

    if (hour == null || minute == null || second == null) return null;

    // Validate time components
    if (hour < 1 ||
        hour > 12 ||
        minute < 0 ||
        minute > 59 ||
        second < 0 ||
        second > 59) {
      return null;
    }

    // Validate AM/PM
    if (period.toUpperCase() != 'AM' && period.toUpperCase() != 'PM') {
      return null;
    }

    // Convert 12-hour format to 24-hour format
    var adjustedHour = hour;
    if (period.toUpperCase() == 'PM' && hour != 12) {
      adjustedHour = hour + 12;
    } else if (period.toUpperCase() == 'AM' && hour == 12) {
      adjustedHour = 0;
    }

    return DateTime(year, month, day, adjustedHour, minute, second);
    // ignore: avoid_catches_without_on_clauses
  } catch (e) {
    return null;
  }
}

/// Converts a [DateTime] object to a custom formatted string.
///
/// Formats the DateTime as "YYYY-MM-DD H:MM:SS AM/PM" (e.g., "2025-08-17 7:44:54 AM").
/// Returns null if the provided dateTime is null.
///
/// [dateTime] The [DateTime] object to convert.
/// returns The custom formatted string or null if the input is null.
///
/// @ai Use this function to format DateTime objects for display or storage
/// in the "YYYY-MM-DD H:MM:SS AM/PM" format.
String? dateTimeToYYYYMMDDHMMSSAM(final DateTime? dateTime) {
  if (dateTime == null) return null;

  final year = dateTime.year.toString();
  final month = dateTime.month.toString().padLeft(2, '0');
  final day = dateTime.day.toString().padLeft(2, '0');

  var hour = dateTime.hour;
  final period = hour >= 12 ? 'PM' : 'AM';

  // Convert 24-hour format to 12-hour format
  if (hour == 0) {
    hour = 12;
  } else if (hour > 12) {
    hour = hour - 12;
  }

  final minute = dateTime.minute.toString().padLeft(2, '0');
  final second = dateTime.second.toString().padLeft(2, '0');

  return '$year-$month-$day $hour:$minute:$second $period';
}
