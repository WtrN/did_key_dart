import 'dart:convert';

import 'package:crypto_keys/crypto_keys.dart';
import 'package:did_key_dart/dart_ssi.dart';
import 'package:did_key_dart/src/model/key_algorithm.dart';
import 'package:jose/jose.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    final awesome = DIDGenerator();

    setUp(() {
      // Additional setup goes here.
    });

    test('First Test', () {
      final jwk = JsonWebKey.generate('ES256');
      final did = awesome.generateDID(P256(), jsonEncode(jwk.toJson()));
      print(did);

      final ecPublicKey = awesome.resolveDID(did);
      expect(
        ecPublicKey.Q?.x?.toBigInteger(),
        (jwk.cryptoKeyPair.publicKey! as EcPublicKey).xCoordinate,
      );
    });
  });
}
