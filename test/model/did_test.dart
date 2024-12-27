// This is test file.
// ignore_for_file: lines_longer_than_80_chars
import 'package:did_key_dart/src/model/did.dart';
import 'package:test/test.dart';

void main() {
  group('Factory', () {
    test('識別子のみを保持するDIDから[DID]が生成できること', () {
      const did = 'did:key:zDnaegRBxYpS4pn1ZoB9Av1VqxqXSfEECfPrPYYteQ5mYdQ2w';

      final actual = DID.from(did);
      expect(actual, isA<DID>());
      expect(actual.multibasePublicKey, 'zDnaegRBxYpS4pn1ZoB9Av1VqxqXSfEECfPrPYYteQ5mYdQ2w');
    });
    test('Fragmentを保持するDIDから識別子とFragmentを分割して保持した状態で[DID]が生成できること', () {
      const did = 'did:key:zDnaegRBxYpS4pn1ZoB9Av1VqxqXSfEECfPrPYYteQ5mYdQ2w#key-1';

      final actual = DID.from(did);
      expect(actual, isA<DID>());
      expect(actual.multibasePublicKey, 'zDnaegRBxYpS4pn1ZoB9Av1VqxqXSfEECfPrPYYteQ5mYdQ2w');
      expect(actual.fragment, 'key-1');
    });
    test('Pathを保持するDIDから識別子とPathを分割して保持した状態で[DID]が生成できること', () {
      const did = 'did:key:zDnaegRBxYpS4pn1ZoB9Av1VqxqXSfEECfPrPYYteQ5mYdQ2w/keys';

      final actual = DID.from(did);
      expect(actual, isA<DID>());
      expect(actual.multibasePublicKey, 'zDnaegRBxYpS4pn1ZoB9Av1VqxqXSfEECfPrPYYteQ5mYdQ2w');
      expect(actual.path, ['keys']);
    });
    test('PathとFragmentを保持するDIDからそれぞれを保持した[DID]を生成できること', () {
      const did = 'did:key:zDnaegRBxYpS4pn1ZoB9Av1VqxqXSfEECfPrPYYteQ5mYdQ2w/keys#key-1';

      final actual = DID.from(did);
      expect(actual, isA<DID>());
      expect(actual.multibasePublicKey, 'zDnaegRBxYpS4pn1ZoB9Av1VqxqXSfEECfPrPYYteQ5mYdQ2w');
      expect(actual.path, ['keys']);
      expect(actual.fragment, 'key-1');
    });
  });
}
