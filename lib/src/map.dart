import 'dart:convert';

import 'string.dart';

/// Decodes a JSON string into a non-empty [Map<String, dynamic>] or null.
///
/// Returns null if the input is empty or decodes to an empty map.
///
/// ```dart
/// final result = jsonDecodeNullableMap('{"key": "value"}');
/// print(result); // {key: value}
///
/// final emptyResult = jsonDecodeNullableMap('{}');
/// print(emptyResult); // null
/// ```
///
/// @ai Use when you need to distinguish between empty and non-empty maps.
/// Handle errors externally.
Map<String, dynamic>? jsonDecodeNullableMap(final dynamic json) {
  final jsonString = jsonDecodeString(json);
  if (jsonString.isEmpty) return null;
  return switch (jsonDecode(jsonString)) {
    final Map<String, dynamic> map => map.isEmpty ? null : map,
    _ => null,
  };
}

/// Decodes a JSON string into a [Map<String, dynamic>], always returning a map.
///
/// Returns an empty map for invalid or empty input.
///
/// ```dart
/// final result = jsonDecodeMap('{"key": "value"}');
/// print(result); // {key: value}
///
/// final emptyResult = jsonDecodeMap('');
/// print(emptyResult); // {}
/// ```
///
/// @ai Use when you need a map result regardless of input validity.
/// Handle errors externally.
Map<String, dynamic> jsonDecodeMap(final dynamic json) {
  final jsonString = jsonDecodeString(json);
  if (jsonString.isEmpty) return {};
  return switch (jsonDecode(jsonString)) {
    final Map<String, dynamic> map => map,
    _ => {},
  };
}

/// Decodes a JSON string into a [Map<K, V>],
/// throwing errors for invalid types.
///
/// ```dart
/// try {
///   final result = jsonDecodeMapAs<String, int>('{"key": 1}');
///   print(result); // {key: 1}
/// } catch (e) {
///   print('Error: $e');
/// }
/// ```
///
/// @ai Use when you need a map result regardless of input validity.
/// Handle errors externally.
Map<K, V> jsonDecodeMapAs<K, V>(final dynamic json) =>
    jsonDecodeMap(json) as Map<K, V>;

/// Decodes a JSON string into a [Map<String, dynamic>],
///  throwing errors for invalid input.
///
/// ```dart
/// try {
///   final result = jsonDecodeThrowableMap('{"key": "value"}');
///   print(result); // {key: value}
/// } catch (e) {
///   print('Error: $e');
/// }
/// ```
///
/// @ai Use only when you need to handle errors explicitly.
/// PREFER [jsonDecodeMap] or [jsonDecodeNullableMap] for safer parsing.
Map<String, dynamic> jsonDecodeThrowableMap(final String jsonString) =>
    jsonDecode(jsonString);

/// Checks if a string is potentially decodable as a JSON object.
///
/// ```dart
/// print(verifyMapDecodability('{}')); // true
/// print(verifyMapDecodability('[]')); // false
/// ```
///
/// @ai Use to quickly check if a string might be a valid JSON object.
bool verifyMapDecodability(final String jsonString) {
  if (jsonString.isEmpty) return false;
  if (jsonString.startsWith('{') && jsonString.endsWith('}')) return true;
  return false;
}
