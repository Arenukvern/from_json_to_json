import 'package:from_json_to_json/from_json_to_json.dart';
import 'package:test/test.dart';

void main() {
  group('String JSON Conversion Tests', () {
    group('jsonDecodeString', () {
      test('converts various types to string', () {
        expect(jsonDecodeString('hello'), 'hello');
        expect(jsonDecodeString(123), '123');
        expect(jsonDecodeString(3.14), '3.14');
        expect(jsonDecodeString(true), 'true');
        expect(jsonDecodeString([1, 2, 3]), '[1, 2, 3]');
        expect(jsonDecodeString({'key': 'value'}), '{key: value}');
      });

      test('handles null input', () {
        expect(jsonDecodeString(null), '');
      });
    });

    group('jsonEncodeString', () {
      test('preserves string values', () {
        expect(jsonEncodeString('hello'), 'hello');
        expect(jsonEncodeString(''), '');
        expect(jsonEncodeString('123'), '123');
      });
    });

    group('jsonDecodeNullableString', () {
      test('returns string values unchanged', () {
        expect(jsonDecodeNullableString('hello'), 'hello');
        expect(jsonDecodeNullableString(''), '');
      });

      test('returns null for null input', () {
        expect(jsonDecodeNullableString(null), null);
      });

      test('returns null instead of coercing non-strings', () {
        expect(jsonDecodeNullableString(123), null);
        expect(jsonDecodeNullableString(3.14), null);
        expect(jsonDecodeNullableString(true), null);
        expect(jsonDecodeNullableString([1, 2, 3]), null);
        expect(jsonDecodeNullableString({'key': 'value'}), null);
      });
    });
  });
}
