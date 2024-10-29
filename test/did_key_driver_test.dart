import 'dart:convert';

import 'package:did_key_dart/did_key_dart.dart';
import 'package:jose/jose.dart';
import 'package:pointycastle/export.dart';
import 'package:test/test.dart';

void main() {
  group('Generate DID', () {
    const driver = DIDKeyDriver();

    test('The DID generated with the P-256 key starts with zDn.', () {
      final jwk = JsonWebKey.generate('ES256');
      final did = driver.generateDIDFromJWK(
        keyAlgorithm: P256(),
        jwk: jsonEncode(jwk.toJson()),
      );

      expect(did, startsWith('did:key:zDn'));
    });

    test('The DID generated with the P-384 key starts with z82.', () {
      final jwk = JsonWebKey.generate('ES384');
      final did = driver.generateDIDFromJWK(
        keyAlgorithm: P384(),
        jwk: jsonEncode(jwk.toJson()),
      );

      expect(did, startsWith('did:key:z82'));
    });

    test('The DID generated with the P-521 key starts with z2J9.', () {
      final jwk = JsonWebKey.generate('ES512');
      final did = driver.generateDIDFromJWK(
        keyAlgorithm: P521(),
        jwk: jsonEncode(jwk.toJson()),
      );

      expect(did, startsWith('did:key:z2J9'));
    });

    test(
        // This is test code.
        // ignore: lines_longer_than_80_chars
        'The DID generated with the P-256 key starts with zDn, and the private key can be obtained.',
        () {
      final did = driver.generateDID(
        keyAlgorithm: P256(),
      );

      expect(did.did, startsWith('did:key:zDn'));
      expect(did.privateKey, isA<ECPrivateKey>());
    });
  });
}
