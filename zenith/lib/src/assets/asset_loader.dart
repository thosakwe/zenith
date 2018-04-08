import 'package:async/async.dart';

/// An interface for asynchronously loading assets.
abstract class AssetLoader {
  /// Loads a byte array.
  CancelableOperation<List<int>> loadBytes();

  /// Loads a string.
  CancelableOperation<String> loadString();

  /// Loads a JSON document.
  CancelableOperation<T> loadJSON<T>();
}