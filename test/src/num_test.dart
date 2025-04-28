import 'package:from_json_to_json/from_json_to_json.dart';
import 'package:test/test.dart';

void main() {
  group('Number JSON Conversion Tests', () {
    group('jsonDecodeDouble', () {
      test('converts valid inputs to double', () {
        expect(jsonDecodeDouble(3.14), 3.14);
        expect(jsonDecodeDouble('3.14'), 3.14);
        expect(jsonDecodeDouble(42), 42.0);
      });

      test('returns 0 for invalid inputs', () {
        expect(jsonDecodeDouble(null), 0.0);
        expect(jsonDecodeDouble('invalid'), 0.0);
        expect(jsonDecodeDouble([]), 0.0);
      });
    });

    group('jsonDecodeNullableDouble', () {
      test('converts valid inputs to double', () {
        expect(jsonDecodeNullableDouble(3.14), 3.14);
        expect(jsonDecodeNullableDouble('3.14'), 3.14);
        expect(jsonDecodeNullableDouble(42), 42.0);
      });

      test('returns null for invalid inputs', () {
        expect(jsonDecodeNullableDouble(null), null);
        expect(jsonDecodeNullableDouble('invalid'), null);
        expect(jsonDecodeNullableDouble([]), null);
      });
    });

    group('jsonDecodeInt', () {
      test('converts valid inputs to int', () {
        expect(jsonDecodeInt(42), 42);
        expect(jsonDecodeInt('42'), 42);
        expect(jsonDecodeInt(3.14), 3);
      });

      test('returns 0 for invalid inputs', () {
        expect(jsonDecodeInt(null), 0);
        expect(jsonDecodeInt('invalid'), 0);
        expect(jsonDecodeInt([]), 0);
      });
    });

    group('jsonDecodeNullableInt', () {
      test('converts valid inputs to int', () {
        expect(jsonDecodeNullableInt(42), 42);
        expect(jsonDecodeNullableInt('42'), 42);
        expect(jsonDecodeNullableInt(3.14), 3);
      });

      test('returns null for invalid inputs', () {
        expect(jsonDecodeNullableInt(null), null);
        expect(jsonDecodeNullableInt('invalid'), null);
        expect(jsonDecodeNullableInt([]), null);
      });
    });

    group('extractIntFromString', () {
      test('extracts first integer from string', () {
        expect(extractIntFromString('Order #123'), 123);
        expect(extractIntFromString('42 is the answer'), 42);
        expect(extractIntFromString('No numbers here'), 0);
      });
    });
  });
}
