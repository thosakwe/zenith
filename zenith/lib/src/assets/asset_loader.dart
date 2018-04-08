import 'dart:async';

/// An interface for asynchronously loading assets.
abstract class AssetLoader {
  /// Loads a byte array.
  Future<List<int>> loadBytes();

  /// Loads a string.
  Future<String> loadString();

  /// Loads a JSON document.
  Future<T> loadJSON<T>();
}