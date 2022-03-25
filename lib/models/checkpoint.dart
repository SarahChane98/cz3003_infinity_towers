
class Checkpoint {
  Checkpoint({this.name, this.questionIds});

  Checkpoint.fromJson(Map<String, Object> json):
    this(
      name: json['name'] as String,
      questionIds: (json['questionIds'] as List<dynamic>).cast<String>(),
    );

  final String name;
  final List<String> questionIds;

  Map<String, Object> toJson() {
    return {
      'name': name,
      'questionIds': questionIds,
    };
  }
}