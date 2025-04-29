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

      test('handles dynamic inputs', () {
        expect(jsonDecodeNullableMap({'name': 'John'}), {'name': 'John'});
        expect(jsonDecodeNullableMap(null), null);
      });

      test('returns null for empty or invalid inputs', () {
        expect(jsonDecodeNullableMap(''), null);
        expect(jsonDecodeNullableMap('{}'), null);
        expect(jsonDecodeNullableMap('[]'), null);
        expect(() => jsonDecodeNullableMap('invalid'), throwsFormatException);
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

      test('handles dynamic inputs', () {
        expect(jsonDecodeMap({'name': 'John'}), {'name': 'John'});
        expect(jsonDecodeMap(null), {});
      });

      test('returns empty map for empty or invalid inputs', () {
        expect(jsonDecodeMap(''), {});
        expect(jsonDecodeMap('[]'), {});
        expect(() => jsonDecodeMap('invalid'), throwsFormatException);
      });
    });

    group('jsonDecodeMapAs<K,V>', () {
      test('decodes typed maps correctly', () {
        expect(jsonDecodeMapAs<String, int>('{"a": 1, "b": 2}'), {
          'a': 1,
          'b': 2,
        });
        expect(jsonDecodeMapAs<String, String>('{"x": "1", "y": "2"}'), {
          'x': '1',
          'y': '2',
        });
        expect(jsonDecodeMapAs<String, bool>('{"t": true, "f": false}'), {
          't': true,
          'f': false,
        });
      });

      test('handles dynamic inputs', () {
        expect(jsonDecodeMapAs<String, int>({'a': 1, 'b': 2}), {
          'a': 1,
          'b': 2,
        });
        expect(jsonDecodeMapAs<String, dynamic>(null), {});
      });

      test('throws on type mismatch', () {
        expect(
          () => jsonDecodeMapAs<String, int>('{"a": "1", "b": "2"}'),
          throwsA(isA<TypeError>()),
        );
        expect(
          () => jsonDecodeMapAs<int, String>('{"1": "a"}'),
          throwsA(isA<TypeError>()),
        );
      });

      test('throws on nested typed structures', () {
        expect(
          () => jsonDecodeMapAs<String, Map<String, int>>(
            '{"x": {"a": 1}, "y": {"b": 2}}',
          ),
          throwsA(isA<TypeError>()),
        );
        expect(
          () =>
              jsonDecodeMapAs<String, List<int>>('{"x": [1, 2], "y": [3, 4]}'),
          throwsA(isA<TypeError>()),
        );
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

      test('handles dynamic inputs', () {
        expect(jsonDecodeThrowableMap({'name': 'John'}), {'name': 'John'});
        expect(() => jsonDecodeThrowableMap(null), throwsFormatException);
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

      test('handles dynamic inputs', () {
        expect(verifyMapDecodability({}), true);
        expect(verifyMapDecodability({'key': 'value'}), true);
        expect(verifyMapDecodability(null), false);
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
