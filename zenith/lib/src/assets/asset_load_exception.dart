/// An exception that occurs while loading assets.
class AssetLoadException implements Exception {
  final String url, message;

  AssetLoadException(this.url, this.message);

  @override
  String toString() {
    return 'Failed loading $url: $message';
  }
}