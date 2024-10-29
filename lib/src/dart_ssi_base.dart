import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto_keys/crypto_keys.dart' as crypto_keys;
import 'package:pointycastle/export.dart';

import 'model/key_algorithm.dart';
import 'utils/base58.dart';
import 'utils/variant.dart';

/// Checks if you are awesome. Spoiler: you are.
class DIDGenerator {
  const DIDGenerator();

  String generateDID(KeyAlgorithm keyAlgorithm, String jwk) {
    final publicKey =
        crypto_keys.KeyPair.fromJwk(jsonDecode(jwk) as Map<String, dynamic>)
            .publicKey! as crypto_keys.EcPublicKey;

    // publicKeyとtargetCurveを用いて、ECpointを生成
    final ecPoint = keyAlgorithm.domainParameters.curve
        .createPoint(publicKey.xCoordinate, publicKey.yCoordinate);

    // ECpointを用いて、DIDを生成
    final publicKeyHex = ecPoint.getEncoded();

    final base58PublicKey = base58Encode(
        Uint8List.fromList(keyAlgorithm.hexadecimal + publicKeyHex));

    return 'did:key:$base58PublicKey';
  }

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
