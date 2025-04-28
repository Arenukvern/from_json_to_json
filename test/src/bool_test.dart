import 'package:from_json_to_json/from_json_to_json.dart';
import 'package:test/test.dart';

void main() {
  group('Boolean JSON Conversion Tests', () {
    group('jsonDecodeBool', () {
      test('converts string representations to bool', () {
        expect(jsonDecodeBool('true'), true);
        expect(jsonDecodeBool('false'), false);
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
  });
}
