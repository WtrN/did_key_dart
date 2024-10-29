import 'dart:typed_data';
import 'package:crypto_keys/crypto_keys.dart';
import 'package:pointycastle/export.dart';

import '../utils/variant.dart';

/// A class that represents a key algorithm.
sealed class KeyAlgorithm {
  /// The name of the key algorithm.
  String get name => throw UnimplementedError();

  /// The domain parameters of the key algorithm.
  ECDomainParametersImpl get domainParameters => throw UnimplementedError();

  int get _hexadecimalValue => throw UnimplementedError();

  /// The hexadecimal value of the key algorithm.
  Uint8List get hexadecimal => _encodeVarInt(_hexadecimalValue);

  Uint8List _encodeVarInt(int value) {
    final varint = Varint();
    return varint.encode(value);
  }

  /// Returns the key algorithm from the key bytes.
  static KeyAlgorithm getKeyAlgorithm(Uint8List keyBytes) {
    final varint = Varint();
    final multicodecCode = varint.decode(keyBytes, 0);

    switch (multicodecCode) {
      case 0xed: // Ed25519
        return Ed25519();
      case 0x1200: // P-256
        return P256();
      case 0x1201: // P-384
        return P384();
      case 0x1202: // P-521
        return P521();
      default:
        throw UnsupportedError(
          // This error message is too long to fit in 80 characters.
          // ignore: lines_longer_than_80_chars
          'Unsupported key type with multicodec code: 0x${multicodecCode.toRadixString(16)}',
        );
    }
  }

  /// Returns the key algorithm from the key identifier.
  Identifier get identifier => switch (this) {
        P256() => curves.p256,
        P384() => curves.p384,
        P521() => curves.p521,
        Ed25519() => throw UnsupportedError('Ed25519 does not support'),
      };
}

/// A class that represents the P-256 key algorithm.
class P256 extends KeyAlgorithm {
  @override
  String get name => 'P-256';

  @override
  ECDomainParametersImpl get domainParameters => ECCurve_secp256r1();

  @override
  int get _hexadecimalValue => 0x1200;
}

/// A class that represents the P-384 key algorithm.
class P384 extends KeyAlgorithm {
  @override
  String get name => 'P-384';

  @override
  ECDomainParametersImpl get domainParameters => ECCurve_secp384r1();

  @override
  int get _hexadecimalValue => 0x1201;
}

/// A class that represents the P-521 key algorithm.
class P521 extends KeyAlgorithm {
  @override
  String get name => 'P-521';

  @override
  ECDomainParametersImpl get domainParameters => ECCurve_secp521r1();

  @override
  int get _hexadecimalValue => 0x1202;
}

/// A class that represents the Ed25519 key algorithm.
class Ed25519 extends KeyAlgorithm {
  @override
  String get name => 'Ed25519';

  @override
  ECDomainParametersImpl get domainParameters =>
      throw UnsupportedError('Ed25519 does not support');

  @override
  int get _hexadecimalValue => 0xed;
}
