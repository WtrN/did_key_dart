import 'dart:convert';

import 'package:did_key_dart/did_key_dart.dart';
import 'package:jose/jose.dart';

void main() {
  const awesome = DIDKeyDriver();
  final jwk = JsonWebKey.generate('ES256');
  final did = awesome.generateDIDFromJWK(
    keyAlgorithm: P256(),
    jwk: jsonEncode(jwk.toJson()),
  );

  // This is a sample DID generated by the DIDGenerator
  // ignore: avoid_print
  print('Sample DID: $did');
}
