class TowerParticipation {
  TowerParticipation({
    this.studentId,
    this.towerId,
    this.score=1000,
    this.checkpointsUnlocked=0
  });

  TowerParticipation.fromJson(Map<String, Object> json):
    this(
      studentId: json['studentId'] as String,
      towerId: json['towerId'] as String,
      score: json['score'] as int,
      checkpointsUnlocked: json['checkpointsUnlocked'] as int,
  );

  final String studentId;
  final String towerId;
  int score;
  int checkpointsUnlocked;

  Map<String, Object> toJson() {
    return {
      'studentId': studentId,
      'towerId': towerId,
      'score': score,
      'checkpointsUnlocked':checkpointsUnlocked,
    };
  }
}