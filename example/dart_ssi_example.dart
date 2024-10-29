import 'dart:convert';

import 'package:did_key_dart/dart_ssi.dart';
import 'package:did_key_dart/src/model/key_algorithm.dart';
import 'package:jose/jose.dart';

void main() {
  const awesome = DIDGenerator();
  final jwk = JsonWebKey.generate('ES256');
  final did = awesome.generateDID(P256(), jsonEncode(jwk.toJson()));
  print('Sample DID: $did');
}
