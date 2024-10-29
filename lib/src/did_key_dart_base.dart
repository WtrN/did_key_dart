import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto_keys/crypto_keys.dart' as crypto_keys;
import 'package:pointycastle/export.dart';

import 'model/key_algorithm.dart';
import 'utils/base58.dart';
import 'utils/variant.dart';

/// A class that generates a DID from a JWK or generates a DID and a key pair.
class DIDGenerator {
  /// Creates a new instance of [DIDGenerator].
  const DIDGenerator();

  /// Generates a DID from a JWK.
  String generateDIDFromJWK({
    required KeyAlgorithm keyAlgorithm,
    required String jwk,
  }) {
    final publicKey =
        crypto_keys.KeyPair.fromJwk(jsonDecode(jwk) as Map<String, dynamic>)
            .publicKey! as crypto_keys.EcPublicKey;
    // publicKeyとtargetCurveを用いて、ECpointを生成
    final ecPoint = keyAlgorithm.domainParameters.curve
        .createPoint(publicKey.xCoordinate, publicKey.yCoordinate);

    // ECpointを用いて、DIDを生成
    final publicKeyHex = ecPoint.getEncoded();

    final base58PublicKey = base58Encode(
      Uint8List.fromList(keyAlgorithm.hexadecimal + publicKeyHex),
    );

    return 'did:key:$base58PublicKey';
  }

  /// Generates a DID and a key pair.
  (String did, ECPrivateKey privateKey) generateDID({
    required KeyAlgorithm keyAlgorithm,
  }) {
    final generator = ECKeyGenerator()
      ..init(
        ParametersWithRandom(
          ECKeyGeneratorParameters(
            keyAlgorithm.domainParameters,
          ),
          SecureRandom(),
        ),
      );

    final keyPair = generator.generateKeyPair();

    final publicKey = keyPair.publicKey as ECPublicKey;

    final ecPoint = publicKey.Q!;

    final publicKeyHex = ecPoint.getEncoded();

    final base58PublicKey = base58Encode(
      Uint8List.fromList(keyAlgorithm.hexadecimal + publicKeyHex),
    );

    return ('did:key:$base58PublicKey', keyPair.privateKey as ECPrivateKey);
  }

  /// Resolves a DID to an [ECPublicKey].
  ECPublicKey resolveDID(String did) {
    // Extract the base58-encoded public key from the DID
    final base58PublicKey = did.substring('did:key:z'.length);

    // Decode the base58-encoded public key
    final keyBytes = base58Decode(base58PublicKey);

    final keyAlgorithm = KeyAlgorithm.getKeyAlgorithm(keyBytes);

    final varint = Varint();

    // Varintのバイト数を計算
    final prefixLength = varint.getPrefixLength(keyBytes, 0);

    // 公開鍵のバイト列を取得
    final publicKeyBytes = keyBytes.sublist(prefixLength);

    final ecPoint =
        keyAlgorithm.domainParameters.curve.decodePoint(publicKeyBytes);

    final publicKey = ECPublicKey(
      ecPoint,
      keyAlgorithm.domainParameters,
    );

    return publicKey;
  }
}
