import 'dart:typed_data';

import 'package:base_x/base_x.dart';

/// A class to encode and decode base58.
String base58Encode(Uint8List hex) {
  final codec =
      BaseXCodec('123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz');
  return 'z${codec.encode(hex)}';
}

/// A class to encode and decode base58.
Uint8List base58Decode(String base58) {
  final codec =
      BaseXCodec('123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz');
  return codec.decode(base58);
}
