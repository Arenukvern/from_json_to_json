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

    group('jsonDecodeDurationFromISO8601', () {
      test('parses years correctly', () {
        expect(jsonDecodeDurationFromISO8601('P1Y'), const Duration(days: 365));
        expect(jsonDecodeDurationFromISO8601('P2Y'), const Duration(days: 730));
        expect(jsonDecodeDurationFromISO8601('P0Y'), Duration.zero);
      });

      test('parses months correctly', () {
        expect(jsonDecodeDurationFromISO8601('P1M'), const Duration(days: 30));
        expect(jsonDecodeDurationFromISO8601('P6M'), const Duration(days: 180));
        expect(
          jsonDecodeDurationFromISO8601('P12M'),
          const Duration(days: 360),
        );
      });

      test('parses weeks correctly', () {
        expect(jsonDecodeDurationFromISO8601('P1W'), const Duration(days: 7));
        expect(jsonDecodeDurationFromISO8601('P2W'), const Duration(days: 14));
        expect(
          jsonDecodeDurationFromISO8601('P52W'),
          const Duration(days: 364),
        );
      });

      test('parses days correctly', () {
        expect(jsonDecodeDurationFromISO8601('P1D'), const Duration(days: 1));
        expect(jsonDecodeDurationFromISO8601('P30D'), const Duration(days: 30));
        expect(
          jsonDecodeDurationFromISO8601('P365D'),
          const Duration(days: 365),
        );
      });

      test('handles duration without P prefix', () {
        expect(jsonDecodeDurationFromISO8601('1Y'), const Duration(days: 365));
        expect(jsonDecodeDurationFromISO8601('6M'), const Duration(days: 180));
        expect(jsonDecodeDurationFromISO8601('2W'), const Duration(days: 14));
        expect(jsonDecodeDurationFromISO8601('30D'), const Duration(days: 30));
      });

      test('handles edge cases and invalid input', () {
        expect(jsonDecodeDurationFromISO8601(null), Duration.zero);
        expect(jsonDecodeDurationFromISO8601(''), Duration.zero);
        expect(jsonDecodeDurationFromISO8601('invalid'), Duration.zero);
        expect(jsonDecodeDurationFromISO8601('P'), Duration.zero);
        expect(jsonDecodeDurationFromISO8601('PX'), Duration.zero);
        expect(jsonDecodeDurationFromISO8601('P1'), Duration.zero);
        expect(jsonDecodeDurationFromISO8601('P1.5Y'), Duration.zero);
        expect(jsonDecodeDurationFromISO8601('P-1Y'), Duration.zero);
      });

      test('handles zero values', () {
        expect(jsonDecodeDurationFromISO8601('P0Y'), Duration.zero);
        expect(jsonDecodeDurationFromISO8601('P0M'), Duration.zero);
        expect(jsonDecodeDurationFromISO8601('P0W'), Duration.zero);
        expect(jsonDecodeDurationFromISO8601('P0D'), Duration.zero);
      });

      test('handles large values', () {
        expect(
          jsonDecodeDurationFromISO8601('P100Y'),
          const Duration(days: 36500),
        );
        expect(
          jsonDecodeDurationFromISO8601('P1200M'),
          const Duration(days: 36000),
        );
        expect(
          jsonDecodeDurationFromISO8601('P1000W'),
          const Duration(days: 7000),
        );
        expect(
          jsonDecodeDurationFromISO8601('P10000D'),
          const Duration(days: 10000),
        );
      });

      test('real-world usage examples', () {
        // Common business periods
        expect(
          jsonDecodeDurationFromISO8601('P1Y'), // 1 year
          const Duration(days: 365),
        );
        expect(
          jsonDecodeDurationFromISO8601('P6M'), // 6 months
          const Duration(days: 180),
        );
        expect(
          jsonDecodeDurationFromISO8601('P2W'), // 2 weeks
          const Duration(days: 14),
        );
        expect(
          jsonDecodeDurationFromISO8601('P30D'), // 30 days
          const Duration(days: 30),
        );
      });

      test('parses combined units correctly', () {
        expect(
          jsonDecodeDurationFromISO8601('P1Y6M'), // 1 year 6 months
          const Duration(days: 545), // 365 + 180 = 545 days
        );
        expect(
          jsonDecodeDurationFromISO8601('P1Y6M2W'), // 1 year 6 months 2 weeks
          const Duration(days: 559), // 365 + 180 + 14 = 559 days
        );
        expect(
          jsonDecodeDurationFromISO8601(
            'P1Y6M2W3D',
          ), // 1 year 6 months 2 weeks 3 days
          const Duration(days: 562), // 365 + 180 + 14 + 3 = 562 days
        );
        expect(
          jsonDecodeDurationFromISO8601('P6M2W3D'), // 6 months 2 weeks 3 days
          const Duration(days: 197), // 180 + 14 + 3 = 197 days
        );
        expect(
          jsonDecodeDurationFromISO8601('P2W3D'), // 2 weeks 3 days
          const Duration(days: 17), // 14 + 3 = 17 days
        );
      });

      test('handles combined units without P prefix', () {
        expect(
          jsonDecodeDurationFromISO8601('1Y6M'), // 1 year 6 months
          const Duration(days: 545),
        );
        expect(
          jsonDecodeDurationFromISO8601('6M2W3D'), // 6 months 2 weeks 3 days
          const Duration(days: 197),
        );
      });
    });

    group('jsonEncodeDurationToISO8601', () {
      test('encodes years correctly', () {
        expect(jsonEncodeDurationToISO8601(const Duration(days: 365)), 'P1Y');
        expect(jsonEncodeDurationToISO8601(const Duration(days: 730)), 'P2Y');
        expect(jsonEncodeDurationToISO8601(const Duration(days: 1095)), 'P3Y');
      });

      test('encodes months correctly', () {
        expect(jsonEncodeDurationToISO8601(const Duration(days: 30)), 'P1M');
        expect(jsonEncodeDurationToISO8601(const Duration(days: 180)), 'P6M');
        expect(jsonEncodeDurationToISO8601(const Duration(days: 360)), 'P12M');
      });

      test('encodes weeks correctly', () {
        expect(jsonEncodeDurationToISO8601(const Duration(days: 7)), 'P1W');
        expect(jsonEncodeDurationToISO8601(const Duration(days: 14)), 'P2W');
        expect(jsonEncodeDurationToISO8601(const Duration(days: 21)), 'P3W');
      });

      test('encodes days correctly', () {
        expect(jsonEncodeDurationToISO8601(const Duration(days: 1)), 'P1D');
        expect(jsonEncodeDurationToISO8601(const Duration(days: 5)), 'P5D');
        expect(jsonEncodeDurationToISO8601(const Duration(days: 29)), 'P4W1D');
      });

      test('encodes complex durations with multiple units', () {
        expect(
          jsonEncodeDurationToISO8601(const Duration(days: 395)), // 1Y + 1M
          'P1Y1M',
        );
        expect(
          jsonEncodeDurationToISO8601(
            const Duration(days: 540),
          ), // 1Y + 5M + 3W + 4D
          'P1Y5M3W4D',
        );
        expect(
          jsonEncodeDurationToISO8601(
            const Duration(days: 372),
          ), // 1Y + 7D = 1Y + 1W
          'P1Y1W',
        );
        expect(
          jsonEncodeDurationToISO8601(
            const Duration(days: 45),
          ), // 1M + 15D = 1M + 2W + 1D
          'P1M2W1D',
        );
      });

      test('handles edge cases', () {
        expect(jsonEncodeDurationToISO8601(Duration.zero), 'P0D');
        expect(jsonEncodeDurationToISO8601(const Duration(days: -1)), 'P0D');
        expect(jsonEncodeDurationToISO8601(const Duration(hours: 23)), 'P0D');
        expect(
          jsonEncodeDurationToISO8601(const Duration(minutes: 1440)),
          'P1D',
        );
        expect(jsonEncodeDurationToISO8601(const Duration(days: 1)), 'P1D');
      });

      test('handles large durations', () {
        expect(
          jsonEncodeDurationToISO8601(const Duration(days: 36500)), // 100 years
          'P100Y',
        );
        expect(
          jsonEncodeDurationToISO8601(
            const Duration(days: 36000),
          ), // 98Y + 7M + 2W + 6D
          'P98Y7M2W6D',
        );
        expect(
          jsonEncodeDurationToISO8601(
            const Duration(days: 7000),
          ), // 19Y + 2M + 5D
          'P19Y2M5D',
        );
      });

      test('round-trip compatibility with jsonDecodeDurationFromISO8601', () {
        final testDurations = [
          const Duration(days: 365), // 1 year
          const Duration(days: 180), // 6 months
          const Duration(days: 14), // 2 weeks
          const Duration(days: 30), // 1 month
          const Duration(days: 7), // 1 week
          const Duration(days: 1), // 1 day
        ];

        for (final duration in testDurations) {
          final isoString = jsonEncodeDurationToISO8601(duration);
          final decodedDuration = jsonDecodeDurationFromISO8601(isoString);
          expect(decodedDuration, duration);
        }
      });

      test('real-world usage examples', () {
        // Common business periods
        expect(
          jsonEncodeDurationToISO8601(const Duration(days: 365)), // 1 year
          'P1Y',
        );
        expect(
          jsonEncodeDurationToISO8601(const Duration(days: 180)), // 6 months
          'P6M',
        );
        expect(
          jsonEncodeDurationToISO8601(const Duration(days: 14)), // 2 weeks
          'P2W',
        );
        expect(
          jsonEncodeDurationToISO8601(const Duration(days: 30)), // 1 month
          'P1M',
        );
      });
    });
  });
}
