import 'package:from_json_to_json/from_json_to_json.dart';
import 'package:test/test.dart';

void main() {
  group('Duration Conversion Tests', () {
    group('jsonDecodeDurationInSeconds', () {
      test('converts valid numeric inputs to Duration', () {
        expect(
          jsonDecodeDurationInSeconds(1.5),
          const Duration(seconds: 1, milliseconds: 500),
        );
        expect(jsonDecodeDurationInSeconds(2), const Duration(seconds: 2));
        expect(
          jsonDecodeDurationInSeconds('1.5'),
          const Duration(seconds: 1, milliseconds: 500),
        );
        expect(jsonDecodeDurationInSeconds('2'), const Duration(seconds: 2));
      });

      test('handles edge cases', () {
        expect(jsonDecodeDurationInSeconds(null), Duration.zero);
        expect(jsonDecodeDurationInSeconds('invalid'), Duration.zero);
        expect(jsonDecodeDurationInSeconds([]), Duration.zero);
      });
    });

    group('jsonDecodeDurationInMicroseconds', () {
      test('converts valid numeric inputs to Duration', () {
        expect(
          jsonDecodeDurationInMicroseconds(1000000),
          const Duration(seconds: 1),
        );
        expect(
          jsonDecodeDurationInMicroseconds(1500000),
          const Duration(milliseconds: 1500),
        );
        expect(
          jsonDecodeDurationInMicroseconds('1000000'),
          const Duration(seconds: 1),
        );
      });

      test('handles edge cases', () {
        expect(jsonDecodeDurationInMicroseconds(null), Duration.zero);
        expect(jsonDecodeDurationInMicroseconds('invalid'), Duration.zero);
        expect(jsonDecodeDurationInMicroseconds([]), Duration.zero);
      });
    });

    group('jsonDecodeDurationInMinutes', () {
      test('converts valid numeric inputs to Duration', () {
        expect(
          jsonDecodeDurationInMinutes(2.5),
          const Duration(minutes: 2, seconds: 30),
        );
        expect(jsonDecodeDurationInMinutes(2), const Duration(minutes: 2));
        expect(
          jsonDecodeDurationInMinutes('2.5'),
          const Duration(minutes: 2, seconds: 30),
        );
        expect(jsonDecodeDurationInMinutes('2'), const Duration(minutes: 2));
      });

      test('handles edge cases', () {
        expect(jsonDecodeDurationInMinutes(null), Duration.zero);
        expect(jsonDecodeDurationInMinutes('invalid'), Duration.zero);
        expect(jsonDecodeDurationInMinutes([]), Duration.zero);
      });
    });

    group('jsonEncode Duration Tests', () {
      const testDuration = Duration(minutes: 2, seconds: 30, milliseconds: 500);

      test('encodes Duration to different time units', () {
        expect(jsonEncodeDurationInSeconds(testDuration), 150);
        expect(jsonEncodeDurationInMicroseconds(testDuration), 150500000);
        expect(jsonEncodeDurationInMinutes(testDuration), 2);
      });
    });
  });
}
