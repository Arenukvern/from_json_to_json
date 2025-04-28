import 'package:from_json_to_json/from_json_to_json.dart';
import 'package:test/test.dart';

void main() {
  group('Map JSON Conversion Tests', () {
    const validJson = '{"name": "John", "age": 30}';
    const validNestedJson =
        '{"person": {"name": "John", "address": {"city": "New York"}}}';

    group('jsonDecodeNullableMap', () {
      test('decodes valid JSON objects', () {
        expect(jsonDecodeNullableMap(validJson), {'name': 'John', 'age': 30});
        expect(jsonDecodeNullableMap(validNestedJson), {
          'person': {
            'name': 'John',
            'address': {'city': 'New York'},
          },
        });
      });

      test('returns null for empty or invalid inputs', () {
        expect(jsonDecodeNullableMap(''), null);
        expect(jsonDecodeNullableMap('{}'), null);
        expect(jsonDecodeNullableMap('[]'), null);
        expect(jsonDecodeNullableMap('invalid'), null);
      });
    });

    group('jsonDecodeMap', () {
      test('decodes valid JSON objects', () {
        expect(jsonDecodeMap(validJson), {'name': 'John', 'age': 30});
        expect(jsonDecodeMap(validNestedJson), {
          'person': {
            'name': 'John',
            'address': {'city': 'New York'},
          },
        });
      });

      test('returns empty map for empty or invalid inputs', () {
        expect(jsonDecodeMap(''), {});
        expect(jsonDecodeMap('[]'), {});
        expect(jsonDecodeMap('invalid'), {});
      });
    });

    group('jsonDecodeThrowableMap', () {
      test('decodes valid JSON objects', () {
        expect(jsonDecodeThrowableMap(validJson), {'name': 'John', 'age': 30});
        expect(jsonDecodeThrowableMap(validNestedJson), {
          'person': {
            'name': 'John',
            'address': {'city': 'New York'},
          },
        });
      });

      test('throws FormatException for invalid JSON', () {
        expect(() => jsonDecodeThrowableMap(''), throwsFormatException);
        expect(() => jsonDecodeThrowableMap('invalid'), throwsFormatException);
      });

      test('throws TypeError for non-map JSON', () {
        expect(() => jsonDecodeThrowableMap('[]'), throwsA(isA<TypeError>()));
        expect(
          () => jsonDecodeThrowableMap('"string"'),
          throwsA(isA<TypeError>()),
        );
      });
    });

    group('verifyMapDecodability', () {
      test('identifies valid JSON object strings', () {
        expect(verifyMapDecodability('{}'), true);
        expect(verifyMapDecodability('{"key": "value"}'), true);
        expect(verifyMapDecodability('{ }'), true);
      });

      test('identifies invalid JSON object strings', () {
        expect(verifyMapDecodability(''), false);
        expect(verifyMapDecodability('[]'), false);
        expect(verifyMapDecodability('null'), false);
        expect(verifyMapDecodability('{key: value'), false); // Unclosed brace
        expect(verifyMapDecodability('key: value}'), false); // No opening brace
      });
    });
  });
}
