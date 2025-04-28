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
