class MultipleChoiceQuestion {
  MultipleChoiceQuestion({
    this.questionText,
    this.choiceA,
    this.choiceB,
    this.choiceC,
    this.choiceD,
    this.correctAnswer,
    this.difficulty,
  });

  MultipleChoiceQuestion.fromJson(Map<String, Object> json)
  : this(
      questionText: json['questionText'] as String,
      choiceA: json['choiceA'] as String,
      choiceB: json['choiceB'] as String,
      choiceC: json['choiceC'] as String,
      choiceD: json['choiceD'] as String,
      correctAnswer: json['correctAnswer'] as String,
      difficulty: json['difficulty'] as String,
  );

  final String questionText;
  final String choiceA;
  final String choiceB;
  final String choiceC;
  final String choiceD;
  final String correctAnswer;
  final String difficulty;

  Map<String, Object> toJson() {
    return {
      'questionText': questionText,
      'choiceA': choiceA,
      'choiceB': choiceB,
      'choiceC': choiceC,
      'choiceD': choiceD,
      'correctAnswer': correctAnswer,
      'difficulty': difficulty,
    };
  }

  bool isAnswerCorrect(userAnswer) => userAnswer == correctAnswer;
}