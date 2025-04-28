import 'package:from_json_to_json/from_json_to_json.dart';
import 'package:test/test.dart';

void main() {
  group('DateTime Conversion Tests', () {
    final testDateTime = DateTime(2024, 3, 14, 15, 9, 26);
    final testMilliseconds = testDateTime.millisecondsSinceEpoch;
    final testIso8601 = testDateTime.toIso8601String();

    group('dateTimeFromMilisecondsSinceEpoch', () {
      test('converts valid milliseconds to DateTime', () {
        final result = dateTimeFromMilisecondsSinceEpoch(testMilliseconds);
        expect(result, testDateTime);
      });

      test('returns null for null input', () {
        expect(dateTimeFromMilisecondsSinceEpoch(null), null);
      });
    });

    group('dateTimeToMilisecondsSinceEpoch', () {
      test('converts DateTime to milliseconds', () {
        final result = dateTimeToMilisecondsSinceEpoch(testDateTime);
        expect(result, testMilliseconds);
      });

      test('returns null for null input', () {
        expect(dateTimeToMilisecondsSinceEpoch(null), null);
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
  });
}
