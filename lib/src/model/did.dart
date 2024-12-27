class DID {
  const DID._({
    required this.multibasePublicKey,
    this.fragment,
    this.path,
    this.queryParameters = const {},
  });

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
  final String multibasePublicKey;

  final String? fragment;

  final List<String>? path;

  final Map<String, String> queryParameters;
}
