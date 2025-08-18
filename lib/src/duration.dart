/// Converts a dynamic value to a [Duration] in seconds.
///
/// Handles double values with milliseconds precision.
/// Returns [Duration.zero] for invalid or null input.
///
/// ```dart
/// durationInSecondsFromJson('1.5'); // 0:00:01.500000
/// durationInSecondsFromJson(1.5); // 0:00:01.500000
/// durationInSecondsFromJson(1); // 0:00:01.000000
/// durationInSecondsFromJson(null); // 0:00:00.000000
/// ```
Duration jsonDecodeDurationInSeconds(final dynamic value) {
  if (value == null) return Duration.zero;
  Duration handleDouble(final double value) {
    final seconds = value.floorToDouble().toInt();
    return Duration(
      seconds: seconds,
      milliseconds: ((value - seconds) * 1000).toInt(),
    );
  }

  return switch (value) {
    final double value => handleDouble(value),
    final int value => Duration(seconds: value),
    final String value => () {
      final doubleSeconds = double.tryParse(value);
      if (doubleSeconds != null) return handleDouble(doubleSeconds);

      final intSeconds = int.tryParse(value);
      if (intSeconds != null) return Duration(seconds: intSeconds);

      return Duration.zero;
    }(),
    _ => Duration.zero,
  };
}

/// Converts a dynamic value to a [Duration] in microseconds.
///
/// Returns [Duration.zero] for invalid or null input.
///
/// ```dart
/// durationInMicrosecondsFromJson('1000000'); // 0:00:01.000000
/// durationInMicrosecondsFromJson(1000000); // 0:00:01.000000
/// durationInMicrosecondsFromJson(null); // 0:00:00.000000
/// ```
Duration jsonDecodeDurationInMicroseconds(final dynamic value) {
  if (value == null) return Duration.zero;
  Duration handleDouble(final double value) {
    final microseconds = value.toInt();
    return Duration(microseconds: microseconds);
  }

  return switch (value) {
    final double value => handleDouble(value),
    final int value => Duration(microseconds: value),
    final String value => () {
      final doubleMicroseconds = double.tryParse(value);
      if (doubleMicroseconds != null) return handleDouble(doubleMicroseconds);

      final intMicroseconds = int.tryParse(value);
      if (intMicroseconds != null) {
        return Duration(microseconds: intMicroseconds);
      }
      return Duration.zero;
    }(),
    _ => Duration.zero,
  };
}

/// Converts a dynamic value to a [Duration] in minutes.
///
/// Returns [Duration.zero] for invalid or null input.
///
/// ```dart
/// durationInMinutesFromJson('2.5'); // 0:02:30.000000
/// durationInMinutesFromJson('2'); // 0:02:00.000000
/// durationInMinutesFromJson(2); // 0:02:00.000000
/// durationInMinutesFromJson(null); // 0:00:00.000000
/// ```
Duration jsonDecodeDurationInMinutes(final dynamic value) {
  if (value == null) return Duration.zero;
  Duration handleDouble(final double value) {
    final minutes = value.floor();
    final remainingSeconds = ((value - minutes) * 60).round();
    return Duration(minutes: minutes, seconds: remainingSeconds);
  }

  return switch (value) {
    final double value => handleDouble(value),
    final int value => Duration(minutes: value),
    final String value => () {
      final doubleMinutes = double.tryParse(value);
      if (doubleMinutes != null) return handleDouble(doubleMinutes);

      final intMinutes = int.tryParse(value);
      if (intMinutes != null) return Duration(minutes: intMinutes);

      return Duration.zero;
    }(),
    _ => Duration.zero,
  };
}

/// Converts a [Duration] to seconds for JSON encoding.
int jsonEncodeDurationInSeconds(final Duration duration) => duration.inSeconds;

/// Converts a [Duration] to microseconds for JSON encoding.
int jsonEncodeDurationInMicroseconds(final Duration duration) =>
    duration.inMicroseconds;

/// Converts a [Duration] to minutes for JSON encoding.
int jsonEncodeDurationInMinutes(final Duration duration) => duration.inMinutes;

/// Parses ISO 8601 duration format to a [Duration].
///
/// ISO 8601 duration format is a standardized way to represent time periods
/// using the format "PnYnMnWnDTnHnMnS" where:
/// - P: Period designator (required)
/// - Y: Years
/// - M: Months (when before T) or Minutes (when after T)
/// - W: Weeks
/// - D: Days
/// - T: Time designator (separates date and time components)
/// - H: Hours
/// - M: Minutes (when after T)
/// - S: Seconds
///
/// This function currently supports basic date components (Y, M, W, D) without
/// the time portion for simplicity. It's commonly used in:
/// - API specifications (OpenAPI, GraphQL)
/// - Configuration files
/// - Data serialization formats
/// - Calendar applications
/// - Business process modeling
/// - Legal documents and contracts
///
/// Examples:
/// - "P1Y" = 1 year (365 days)
/// - "P6M" = 6 months (180 days)
/// - "P2W" = 2 weeks (14 days)
/// - "P30D" = 30 days
/// - "P1Y6M" = 1 year 6 months (540 days)
///
/// Note: This implementation uses approximate conversions:
/// - 1 year = 365 days
/// - 1 month = 30 days
/// - 1 week = 7 days
///
/// Returns [Duration.zero] for null, empty, or invalid input.
///
/// ```dart
/// durationFromISO8601('P1Y'); // 365 days
/// durationFromISO8601('P6M'); // 180 days
/// durationFromISO8601('P2W'); // 14 days
/// durationFromISO8601('P30D'); // 30 days
/// durationFromISO8601(null); // Duration.zero
/// ```
Duration jsonDecodeDurationFromISO8601(final String? iso8601Duration) {
  if (iso8601Duration == null || iso8601Duration.isEmpty) {
    return Duration.zero;
  }

  // Remove 'P' prefix if present
  final duration = iso8601Duration.startsWith('P')
      ? iso8601Duration.substring(1)
      : iso8601Duration;

  // Parse different units
  if (duration.endsWith('Y')) {
    final years = int.tryParse(duration.substring(0, duration.length - 1)) ?? 0;
    // Handle negative values by returning zero
    if (years < 0) return Duration.zero;
    return Duration(days: years * 365);
  } else if (duration.endsWith('M')) {
    final months =
        int.tryParse(duration.substring(0, duration.length - 1)) ?? 0;
    // Handle negative values by returning zero
    if (months < 0) return Duration.zero;
    return Duration(days: months * 30);
  } else if (duration.endsWith('W')) {
    final weeks = int.tryParse(duration.substring(0, duration.length - 1)) ?? 0;
    // Handle negative values by returning zero
    if (weeks < 0) return Duration.zero;
    return Duration(days: weeks * 7);
  } else if (duration.endsWith('D')) {
    final days = int.tryParse(duration.substring(0, duration.length - 1)) ?? 0;
    // Handle negative values by returning zero
    if (days < 0) return Duration.zero;
    return Duration(days: days);
  }

  return Duration.zero;
}
