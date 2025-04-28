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

    group('verifyListDecodability', () {
      test('identifies valid JSON array strings', () {
        expect(verifyListDecodability('[]'), true);
        expect(verifyListDecodability('[1,2,3]'), true);
        expect(verifyListDecodability('[ ]'), true);
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
