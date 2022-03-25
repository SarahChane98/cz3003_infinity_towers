class Tower {
  Tower({
    this.name,
    this.checkpointIds,
    this.uniqueJoiningId,
    this.passcode,
    this.ownerId,
  });

  Tower.fromJson(Map<String, Object> json):
    this(
    name: json['name'] as String,
    checkpointIds: (json['checkpointIds'] as List<dynamic>).cast<String>(),
    uniqueJoiningId: json['uniqueJoiningID'] as String,
    passcode: json['passcode'] as String,
    ownerId: json['ownderId'] as String,
  );

  final String name;
  final List<String> checkpointIds;
  final String uniqueJoiningId;
  final String passcode;
  final String ownerId;

  Map<String, Object> toJson() {
    return {
      'name': name,
      'checkpointIds': checkpointIds,
      'uniqueJoiningID': uniqueJoiningId,
      'passcode': passcode,
      'ownerId': ownerId,
    };
  }
}
