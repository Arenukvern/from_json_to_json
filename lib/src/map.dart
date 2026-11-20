import 'dart:convert';

import 'string.dart';

/// Converts a map with non-[String] keys to a string-keyed map by
/// stringifying each key.
///
/// Accepts e.g. yaml-decoded `Map<dynamic, dynamic>` values, which would
/// otherwise fall into the [jsonDecodeString]→[jsonDecode] roundtrip and
/// throw a [FormatException] on their unquoted-key `toString()`.
Map<String, dynamic> _stringKeyed(final Map<dynamic, dynamic> map) => {
      for (final entry in map.entries) '${entry.key}': entry.value,
    };

/// Decodes a JSON string into a non-empty [Map<String, dynamic>] or null.
///
/// Returns null if the input is empty or decodes to an empty map.
/// Maps with non-[String] keys (e.g. yaml-decoded values) are accepted;
/// their keys are stringified.
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
  if (json case final Map<String, dynamic> map) return map.isEmpty ? null : map;
  if (json case final Map<dynamic, dynamic> map) {
    return map.isEmpty ? null : _stringKeyed(map);
  }
  final jsonString = jsonDecodeString(json);
  if (jsonString.isEmpty) return null;
  return switch (jsonDecode(jsonString)) {
    final Map<String, dynamic> map => map.isEmpty ? null : map,
    _ => null,
  };
}

/// Decodes a JSON string into a [Map<String, dynamic>], always returning a map.
///
/// Returns an empty map for invalid or empty input. Maps with non-[String]
/// keys (e.g. yaml-decoded values) are accepted; their keys are stringified.
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
  if (json case final Map<String, dynamic> map) return map.isEmpty ? {} : map;
  if (json case final Map<dynamic, dynamic> map) {
    return map.isEmpty ? {} : _stringKeyed(map);
  }
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
    jsonDecodeMap(json).cast<K, V>();

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
Map<String, dynamic> jsonDecodeThrowableMap(final dynamic json) {
  if (json case final Map<String, dynamic> map) return map;
  if (json case final Map<dynamic, dynamic> map) return _stringKeyed(map);
  final jsonString = jsonDecodeString(json);
  return jsonDecode(jsonString);
}

/// Decodes a JSON value into a nullable [Map<K, V>], casting the entries.
///
/// Returns null when the input is absent or decodes to an empty map;
/// throws when the entry types do not match [K] and [V].
///
/// ```dart
/// jsonDecodeNullableMapAs<String, int>('{"a": 1}'); // {a: 1}
/// jsonDecodeNullableMapAs<String, int>({}); // null
/// jsonDecodeNullableMapAs<String, int>(null); // null
/// ```
///
/// @ai Use when a map field may be absent but must be correctly typed when
/// present; pairs [jsonDecodeNullableMap] with [jsonDecodeMapAs].
Map<K, V>? jsonDecodeNullableMapAs<K, V>(final dynamic json) =>
    jsonDecodeNullableMap(json)?.cast<K, V>();

/// Checks if a string is potentially decodable as a JSON object.
///
/// ```dart
/// print(verifyMapDecodability('{}')); // true
/// print(verifyMapDecodability('[]')); // false
/// ```
///
/// @ai Use to quickly check if a string might be a valid JSON object.
bool verifyMapDecodability(final dynamic json) {
  final jsonString = jsonDecodeString(json);
  if (jsonString.isEmpty) return false;
  if (jsonString.startsWith('{') && jsonString.endsWith('}')) return true;
  return false;
}
