import 'package:from_json_to_json/from_json_to_json.dart';
import 'package:test/test.dart';

void main() {
  group('DateTime Conversion Tests', () {
    final testDateTime = DateTime(2024, 3, 14, 15, 9, 26);
    final testMilliseconds = testDateTime.millisecondsSinceEpoch;
    final testIso8601 = testDateTime.toIso8601String();

    group('dateTimeFromMillisecondsSinceEpoch', () {
      test('converts valid milliseconds to DateTime', () {
        final result = dateTimeFromMillisecondsSinceEpoch(testMilliseconds);
        expect(result, testDateTime);
      });

      test('returns null for null input', () {
        expect(dateTimeFromMillisecondsSinceEpoch(null), null);
      });
    });

    group('dateTimeToMillisecondsSinceEpoch', () {
      test('converts DateTime to milliseconds', () {
        final result = dateTimeToMillisecondsSinceEpoch(testDateTime);
        expect(result, testMilliseconds);
      });

      test('returns null for null input', () {
        expect(dateTimeToMillisecondsSinceEpoch(null), null);
      });
    });

    group('dateTimeFromIso8601String', () {
      test('converts valid ISO 8601 string to DateTime', () {
        final result = dateTimeFromIso8601String(testIso8601);
        expect(result, testDateTime);
      });

      test('returns null for invalid ISO 8601 string', () {
        expect(dateTimeFromIso8601String('invalid date'), null);
      });

      test('returns null for null input', () {
        expect(dateTimeFromIso8601String(null), null);
      });
    });

    group('dateTimeToIso8601String', () {
      test('converts DateTime to ISO 8601 string', () {
        final result = dateTimeToIso8601String(testDateTime);
        expect(result, testIso8601);
      });

      test('returns null for null input', () {
        expect(dateTimeToIso8601String(null), null);
      });
    });

    group('dateTimeFromYYYYMMDDHMMSSAM', () {
      test('converts valid custom format string to DateTime (AM)', () {
        const customString = '2025-08-17 7:44:54 AM';
        final expected = DateTime(2025, 8, 17, 7, 44, 54);
        final result = dateTimeFromYYYYMMDDHMMSSAM(customString);
        expect(result, expected);
      });

      test('converts valid custom format string to DateTime (PM)', () {
        const customString = '2025-08-17 7:44:54 PM';
        final expected = DateTime(2025, 8, 17, 19, 44, 54);
        final result = dateTimeFromYYYYMMDDHMMSSAM(customString);
        expect(result, expected);
      });

      test('converts 12:00:00 AM to midnight', () {
        const customString = '2025-08-17 12:00:00 AM';
        final expected = DateTime(2025, 8, 17);
        final result = dateTimeFromYYYYMMDDHMMSSAM(customString);
        expect(result, expected);
      });

      test('converts 12:00:00 PM to noon', () {
        const customString = '2025-08-17 12:00:00 PM';
        final expected = DateTime(2025, 8, 17, 12);
        final result = dateTimeFromYYYYMMDDHMMSSAM(customString);
        expect(result, expected);
      });

      test('handles single digit hours', () {
        const customString = '2025-08-17 1:05:30 AM';
        final expected = DateTime(2025, 8, 17, 1, 5, 30);
        final result = dateTimeFromYYYYMMDDHMMSSAM(customString);
        expect(result, expected);
      });

      test('returns null for invalid format', () {
        expect(dateTimeFromYYYYMMDDHMMSSAM('invalid date'), null);
        expect(dateTimeFromYYYYMMDDHMMSSAM('2025-08-17'), null);
        expect(dateTimeFromYYYYMMDDHMMSSAM('2025-08-17 7:44:54'), null);
        expect(dateTimeFromYYYYMMDDHMMSSAM('2025/08/17 7:44:54 AM'), null);
      });

      test('returns null for null input', () {
        expect(dateTimeFromYYYYMMDDHMMSSAM(null), null);
      });

      test('returns null for empty string', () {
        expect(dateTimeFromYYYYMMDDHMMSSAM(''), null);
      });

      test('returns null for invalid time components', () {
        expect(dateTimeFromYYYYMMDDHMMSSAM('2025-08-17 25:44:54 AM'), null);
        expect(dateTimeFromYYYYMMDDHMMSSAM('2025-08-17 7:60:54 AM'), null);
        expect(dateTimeFromYYYYMMDDHMMSSAM('2025-08-17 7:44:60 AM'), null);
      });
    });

    group('dateTimeToYYYYMMDDHMMSSAM', () {
      test('converts DateTime to custom format string (AM)', () {
        final dateTime = DateTime(2025, 8, 17, 7, 44, 54);
        const expected = '2025-08-17 7:44:54 AM';
        final result = dateTimeToYYYYMMDDHMMSSAM(dateTime);
        expect(result, expected);
      });

      test('converts DateTime to custom format string (PM)', () {
        final dateTime = DateTime(2025, 8, 17, 19, 44, 54);
        const expected = '2025-08-17 7:44:54 PM';
        final result = dateTimeToYYYYMMDDHMMSSAM(dateTime);
        expect(result, expected);
      });

      test('converts midnight to 12:00:00 AM', () {
        final dateTime = DateTime(2025, 8, 17);
        const expected = '2025-08-17 12:00:00 AM';
        final result = dateTimeToYYYYMMDDHMMSSAM(dateTime);
        expect(result, expected);
      });

      test('converts noon to 12:00:00 PM', () {
        final dateTime = DateTime(2025, 8, 17, 12);
        const expected = '2025-08-17 12:00:00 PM';
        final result = dateTimeToYYYYMMDDHMMSSAM(dateTime);
        expect(result, expected);
      });

      test('pads single digit months and days with zeros', () {
        final dateTime = DateTime(2025, 1, 5, 9, 3, 7);
        const expected = '2025-01-05 9:03:07 AM';
        final result = dateTimeToYYYYMMDDHMMSSAM(dateTime);
        expect(result, expected);
      });

      test('returns null for null input', () {
        expect(dateTimeToYYYYMMDDHMMSSAM(null), null);
      });
    });
  });
}
