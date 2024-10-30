import 'dart:typed_data';

/// A class to encode and decode varint.
class Varint {
  /// Encodes the target integer to varint.
  Uint8List encode(int target) {
    var value = target;
    final bytes = <int>[];
    while (value > 127) {
      bytes.add((value & 0x7F) | 0x80);
      value >>= 7;
    }
    bytes.add(value & 0x7F);
    return Uint8List.fromList(bytes);
  }

  /// Decodes the target bytes to integer.
  int decode(Uint8List bytes, int start, [int? end]) {
    var value = 0;
    var shift = 0;
    var i = start;
    end ??= bytes.length;
    while (i < end) {
      final byte = bytes[i++];
      value |= (byte & 0x7F) << shift;
      if ((byte & 0x80) == 0) {
        return value;
      }
      shift += 7;
    }
    throw const FormatException('Varint decoding failed');
  }

  /// Returns the length of the varint prefix.
  int getPrefixLength(Uint8List bytes, int start) {
    var prefixLength = 0;
    var tempCode = decode(bytes, start);
    do {
      prefixLength += 1;
      tempCode >>= 7;
    } while (tempCode > 0);
    return prefixLength;
  }
}
