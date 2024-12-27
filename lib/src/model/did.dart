/// Decentralized Identifier (DID) model
class DID {
  const DID._({
    required this.multibasePublicKey,
    this.fragment,
    this.path,
    this.queryParameters = const {},
  });

  /// Creates a [DID] from the given [did].
  factory DID.from(String did) {
    final identifier = did.split(':').last;
    final uri = Uri.parse(identifier);

    return DID._(
      multibasePublicKey: uri.pathSegments.first,
      fragment: uri.fragment,
      path: uri.pathSegments.sublist(1),
      queryParameters: uri.queryParameters,
    );
  }

  /// The multibase public key.
  final String multibasePublicKey;

  /// The did's fragment.
  final String? fragment;

  /// The did's path.
  final List<String>? path;

  /// The did's query parameters.
  final Map<String, String> queryParameters;
}
