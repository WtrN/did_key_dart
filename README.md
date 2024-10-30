# did_key_dart

A Dart package for generating and resolving Decentralized Identifiers (DIDs) using various cryptographic algorithms.

## Features

- Generate DIDs using P-256 and P-384, P-521 key algorithms.
- Resolve DIDs to obtain public keys.

## Getting started

To use this package, add `did_key_dart` as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  did_key_dart: ^0.1.0
```

## Usage

### Generate a DID

```dart
import 'package:did_key_dart/did_key_dart.dart';

void main() {
  final driver = DIDKeyDriver();
  final result = driver.generateDID(keyAlgorithm: P256());
  print('DID: ${result.did}');
  print('Private Key: ${result.privateKey}');
}
```

### Resolve a DID

```dart
import 'package:did_key_dart/did_key_dart.dart';

void main() {
  final driver = DIDKeyDriver();
  final publicKey = driver.getPublicKeyFromDID('did:key:z...');
  print('Public Key: $publicKey');
}
```

## Additional information

For more information, visit the documentation.  To contribute to this package, please submit a pull request or file an issue on GitHub. We welcome contributions and feedback from the commun
