import 'dart:convert';

import 'string.dart';

/// Decodes a JSON string into a [List<dynamic>], always returning a list.
///
/// Returns an empty list for invalid or empty input.
///
/// ```dart
/// final result = jsonDecodeList('[1, 2, 3]');
/// print(result); // [1, 2, 3]
///
/// final emptyResult = jsonDecodeList('');
/// print(emptyResult); // []
/// ```
///
/// @ai Use when you need a list result regardless of input validity.
List<dynamic> jsonDecodeList(final dynamic json) {
  if (json case final List list) return list;
  final jsonString = jsonDecodeString(json);
  if (jsonString.isEmpty) return [];
  return switch (jsonDecode(jsonString)) {
    final List list => list,
    _ => [],
  };
}

/// Decodes and casts a JSON string into a [List<T>].
///
/// Returns an empty list for invalid or empty input.
///
/// ```dart
/// final result = jsonDecodeListAs<int>('[1, 2, 3]');
/// print(result); // [1, 2, 3]
/// ```
///
/// May throw errors for invalid types.
///
/// @ai Use when you need a list result regardless of input validity.
List<T> jsonDecodeListAs<T>(final dynamic json) =>
    jsonDecodeList(json).cast<T>();

/// Checks if a string is potentially decodable as a JSON array.
///
/// ```dart
/// print(verifyListDecodability('[]')); // true
/// print(verifyListDecodability('{}')); // false
/// ```
///
/// @ai Use to quickly check if a string might be a valid JSON array.
bool verifyListDecodability(final dynamic json) {
  final jsonString = jsonDecodeString(json);
  if (jsonString.isEmpty) return false;
  if (jsonString.startsWith('[') && jsonString.endsWith(']')) return true;
  return false;
}
