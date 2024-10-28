import 'dart:convert';

import 'package:dart_ssi/dart_ssi.dart';
import 'package:dart_ssi/src/model/key_algorithm.dart';
import 'package:jose/jose.dart';

void main() {
  const awesome = DIDGenerator();
  final jwk = JsonWebKey.generate('ES256');
  final did = awesome.generateDID(P256(), jsonEncode(jwk.toJson()));
  print('Sample DID: $did');
}
