import 'dart:async';
import 'dart:html' show Blob, FileReader, HttpRequest;
import 'package:async/async.dart';
import 'package:zenith/zenith.dart';

/// An [AssetLoader] that loads assets via XMLHttpRequest.
class XHRAssetLoader extends AssetLoader {
  CancelableOperation<HttpRequest> _xhr(String url, String responseType) {
    var xhr = new HttpRequest();
    var c =
        new CancelableCompleter<HttpRequest>(onCancel: () async => xhr.abort());
    xhr
      ..open('GET', url)
      ..responseType = responseType;

    xhr.onError.listen((e) {
      if (!c.isCanceled && !c.isCompleted)
        c.completeError(new AssetLoadException(url, 'XMLHttpRequest error.'));
    });

    xhr.onLoadEnd.listen((e) {
      if (c.isCanceled || c.isCompleted) return;
      if (xhr.status < 200 && xhr.status >= 400)
        c.completeError(new AssetLoadException(
            url, 'Server responded with ${xhr.status}.'));
      c.complete(xhr);
    });

    xhr.send();
    return c.operation;
  }

  @override
  CancelableOperation<T> loadJSON<T>(String url) {
    var xhr = _xhr(url, 'json');
    var c = new CancelableCompleter<T>(onCancel: xhr.cancel);
    c.complete(xhr.value.then((xhr) => xhr.response));
    return c.operation;
  }

  @override
  CancelableOperation<String> loadString(String url) {
    var xhr = _xhr(url, 'text');
    var c = new CancelableCompleter<String>(onCancel: xhr.cancel);
    c.complete(xhr.value.then((xhr) => xhr.responseText));
    return c.operation;
  }

  @override
  CancelableOperation<List<int>> loadBytes(String url) {
    var xhr = _xhr(url, 'blob');
    var c = new CancelableCompleter<List<int>>(onCancel: xhr.cancel);
    c.complete(xhr.value.then((xhr) {
      if (!c.isCanceled) {
        var cc = new Completer<List<int>>();
        var blob = xhr.response as Blob;
        var reader = new FileReader();

        reader.onError.listen((e) {
          if (!cc.isCompleted)
            cc.completeError(reader.error);
        });

        reader.onLoadEnd.first.then((_) {
          if (!cc.isCompleted)
          cc.complete(reader.result);
        });

        reader.readAsArrayBuffer(blob);
        return cc.future;
      }
    }));
    return c.operation;
  }
}
