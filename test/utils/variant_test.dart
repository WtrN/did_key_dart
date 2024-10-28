import 'dart:typed_data';

import 'package:dart_ssi/src/utils/variant.dart';
import 'package:test/test.dart';

void main() {
  group('description', () {
    test('Encode Variant', () {
      final variant = Varint();

      final encoded = variant.encode(0x1200);
      expect(encoded, Uint8List.fromList([0x80, 0x24]));
    });

    test('Encode Variant', () {
      final variant = Varint();

      final encoded = variant.encode(0xed);
      expect(encoded, Uint8List.fromList([0xed, 0x01]));
    });

    test('Decode variant', () {
      final variant = Varint();
      final decoded = variant.decode(Uint8List.fromList([0x80, 0x24]), 0);
      expect(decoded, 0x1200);
    });

    test('Decode variant', () {
      final variant = Varint();
      final decoded = variant.decode(Uint8List.fromList([0xed, 0x01]), 0);
      expect(decoded, 0xed);
    });
  });
}
