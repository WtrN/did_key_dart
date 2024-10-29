import 'package:crypto_keys/crypto_keys.dart' as crypto_keys;
import 'package:jose/jose.dart';
import 'package:pointycastle/export.dart';

/// Extension methods for [ECPublicKey].
extension ECPublicKeyExtension on ECPublicKey {

  /// Converts the [ECPublicKey] to a JWK.
  Map<String, dynamic> toJwk() {
    final cryptoKeysPublicKey = crypto_keys.EcPublicKey(
      xCoordinate: Q!.x!.toBigInteger()!,
      yCoordinate: Q!.y!.toBigInteger()!,
      curve: switch (parameters?.curve) {
        ECCurve_secp256r1() => crypto_keys.curves.p256,
        ECCurve_secp384r1() => crypto_keys.curves.p384,
        ECCurve_secp521r1() => crypto_keys.curves.p521,
        _ => throw UnsupportedError('Unsupported curve: ${parameters?.curve}'),
      },
    );
    final jwk =
        JsonWebKey.fromCryptoKeys(publicKey: cryptoKeysPublicKey).toJson();
    return jwk;
  }
}
