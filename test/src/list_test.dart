import 'package:from_json_to_json/from_json_to_json.dart';
import 'package:test/test.dart';

void main() {
  group('List JSON Conversion Tests', () {
    group('jsonDecodeList', () {
      test('decodes valid JSON arrays', () {
        expect(jsonDecodeList('[1, 2, 3]'), [1, 2, 3]);
        expect(jsonDecodeList('["a", "b", "c"]'), ['a', 'b', 'c']);
        expect(jsonDecodeList('[true, false]'), [true, false]);
        expect(jsonDecodeList('[]'), []);
      });

      test('handles dynamic inputs', () {
        expect(jsonDecodeList([1, 2, 3]), [1, 2, 3]);
        expect(jsonDecodeList(['a', 'b', 'c']), ['a', 'b', 'c']);
        expect(jsonDecodeList(null), []);
      });

      test('handles invalid inputs', () {
        expect(jsonDecodeList(''), []);
        expect(jsonDecodeList('{}'), []); // Object instead of array
        expect(
          () => jsonDecodeList('invalid'),
          throwsFormatException,
        ); // Invalid JSON
        expect(jsonDecodeList('null'), []); // JSON null
      });

      test('handles nested structures', () {
        expect(jsonDecodeList('[[1, 2], [3, 4]]'), [
          [1, 2],
          [3, 4],
        ]);
        expect(jsonDecodeList('[{"a": 1}, {"b": 2}]'), [
          {'a': 1},
          {'b': 2},
        ]);
      });
    });

    group('jsonDecodeListAs<T>', () {
      test('decodes typed lists correctly', () {
        expect(jsonDecodeListAs<int>('[1, 2, 3]'), [1, 2, 3]);
        expect(jsonDecodeListAs<String>('["a", "b", "c"]'), ['a', 'b', 'c']);
        expect(jsonDecodeListAs<bool>('[true, false]'), [true, false]);
        expect(jsonDecodeListAs<dynamic>('[]'), []);
      });

      test('handles dynamic inputs', () {
        expect(jsonDecodeListAs<int>([1, 2, 3]), [1, 2, 3]);
        expect(jsonDecodeListAs<String>(['a', 'b', 'c']), ['a', 'b', 'c']);
        expect(jsonDecodeListAs<dynamic>(null), []);
      });

      test('throws on type mismatch', () {
        expect(
          () => jsonDecodeListAs<int>('["a", "b", "c"]'),
          throwsA(isA<TypeError>()),
        );
        expect(
          () => jsonDecodeListAs<String>('[1, 2, 3]'),
          throwsA(isA<TypeError>()),
        );
      });

      test('handles nested typed structures', () {
        expect(jsonDecodeListAs<List<dynamic>>('[[1, 2], [3, 4]]'), [
          [1, 2],
          [3, 4],
        ]);
        expect(jsonDecodeListAs<Map<String, dynamic>>('[{"a": 1}, {"b": 2}]'), [
          {'a': 1},
          {'b': 2},
        ]);
      });
    });

    group('verifyListDecodability', () {
      test('identifies valid JSON array strings', () {
        expect(verifyListDecodability('[]'), true);
        expect(verifyListDecodability('[1,2,3]'), true);
        expect(verifyListDecodability('[ ]'), true);
      });

      test('handles dynamic inputs', () {
        expect(verifyListDecodability([]), true);
        expect(verifyListDecodability([1, 2, 3]), true);
        expect(verifyListDecodability(null), false);
      });

      test('identifies invalid JSON array strings', () {
        expect(verifyListDecodability(''), false);
        expect(verifyListDecodability('{}'), false);
        expect(verifyListDecodability('null'), false);
        expect(verifyListDecodability('[1,2,3'), false); // Unclosed bracket
        expect(verifyListDecodability('1,2,3]'), false); // No opening bracket
      });
    });
  });
}
