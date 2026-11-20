import 'package:from_json_to_json/from_json_to_json.dart';
import 'package:test/test.dart';

void main() {
  group('Boolean JSON Conversion Tests', () {
    group('jsonDecodeBool', () {
      test('converts string representations to bool', () {
        expect(jsonDecodeBool('true'), true);
        expect(jsonDecodeBool('false'), false);
        expect(jsonDecodeBool('yes'), true);
        expect(jsonDecodeBool('no'), false);
        expect(jsonDecodeBool('TRUE'), true);
        expect(jsonDecodeBool(' No '), false);
        expect(jsonDecodeBool('1'), true);
        expect(jsonDecodeBool('0'), false);
        expect(jsonDecodeBool('1.0'), true);
        expect(jsonDecodeBool('0.0'), false);
      });

      test('converts numeric values to bool', () {
        expect(jsonDecodeBool(1), true);
        expect(jsonDecodeBool(0), false);
        expect(jsonDecodeBool(1.0), true);
        expect(jsonDecodeBool(0.0), false);
        expect(jsonDecodeBool(2), false); // Only 1 is true
        expect(jsonDecodeBool(2.0), false); // Only 1.0 is true
      });

      test('handles boolean inputs', () {
        expect(jsonDecodeBool(true), true);
        expect(jsonDecodeBool(false), false);
      });

      test('handles invalid or null inputs', () {
        expect(jsonDecodeBool(null), false);
        expect(jsonDecodeBool(''), false);
        expect(jsonDecodeBool('invalid'), false);
        expect(jsonDecodeBool([]), false);
        expect(jsonDecodeBool({}), false);
      });
    });

    group('jsonEncodeBool', () {
      test('encodes boolean values', () {
        expect(jsonEncodeBool(true), true);
        expect(jsonEncodeBool(false), false);
      });
    });

    group('jsonDecodeNullableBool', () {
      test('returns bool values unchanged', () {
        expect(jsonDecodeNullableBool(true), true);
        expect(jsonDecodeNullableBool(false), false);
      });

      test('returns null for null input', () {
        expect(jsonDecodeNullableBool(null), null);
      });

      test('converts string representations, null when unknown', () {
        expect(jsonDecodeNullableBool('true'), true);
        expect(jsonDecodeNullableBool('false'), false);
        expect(jsonDecodeNullableBool('1'), true);
        expect(jsonDecodeNullableBool('0'), false);
        expect(jsonDecodeNullableBool('1.0'), true);
        expect(jsonDecodeNullableBool('0.0'), false);
        expect(jsonDecodeNullableBool('invalid'), null);
        expect(jsonDecodeNullableBool(''), null);
        expect(jsonDecodeNullableBool('YES'), true);
        expect(jsonDecodeNullableBool('No'), false);
      });

      test('converts numeric values, null when unknown', () {
        expect(jsonDecodeNullableBool(1), true);
        expect(jsonDecodeNullableBool(0), false);
        expect(jsonDecodeNullableBool(1.0), true);
        expect(jsonDecodeNullableBool(0.0), false);
        expect(jsonDecodeNullableBool(2), false); // Only 1 is true
        expect(jsonDecodeNullableBool(2.0), false); // Only 1.0 is true
        expect(jsonDecodeNullableBool([]), null);
        expect(jsonDecodeNullableBool({}), null);
      });
    });
  });

  group('jsonDecodeNullableThrowableBool', () {
    test('converts strings and bools, null for absent', () {
      expect(jsonDecodeNullableThrowableBool('true'), true);
      expect(jsonDecodeNullableThrowableBool('no'), false);
      expect(jsonDecodeNullableThrowableBool(false), false);
      expect(jsonDecodeNullableThrowableBool(null), null);
    });

    test('throws ArgumentError for uninterpretable shapes', () {
      expect(() => jsonDecodeNullableThrowableBool([]), throwsArgumentError);
      expect(
        () => jsonDecodeNullableThrowableBool({'a': 1}),
        throwsArgumentError,
      );
    });
  });
}
