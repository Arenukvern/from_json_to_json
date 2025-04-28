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
  });
}
