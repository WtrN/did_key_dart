import 'dart:convert';

import 'package:crypto_keys/crypto_keys.dart';
import 'package:did_key_dart/did_key_dart.dart';
import 'package:jose/jose.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    const awesome = DIDKeyDriver();

    setUp(() {
      // Additional setup goes here.
    });

    test('First Test', () {
      final jwk = JsonWebKey.generate('ES256');
      final did = awesome.generateDIDFromJWK(
        keyAlgorithm: P256(),
        jwk: jsonEncode(jwk.toJson()),
      );

      final ecPublicKey = awesome.getPublicKeyFromDID(did);
      expect(
        ecPublicKey.Q?.x?.toBigInteger(),
        (jwk.cryptoKeyPair.publicKey! as EcPublicKey).xCoordinate,
      );
    });
  });
}
