
class MultipleChoiceQuestion {
  final String questionText;
  final String choiceA;
  final String choiceB;
  final String choiceC;
  final String choiceD;
  final String correctAnswer;

  MultipleChoiceQuestion(
      this.questionText,
      this.choiceA,
      this.choiceB,
      this.choiceC,
      this.choiceD,
      this.correctAnswer,
      );

  bool isAnswerCorrect(userAnswer) => userAnswer == correctAnswer;
}


class Checkpoint {
  final String name;
  final bool unlocked;
  final List<MultipleChoiceQuestion> questions;

  Checkpoint(this.name, this.unlocked, this.questions);
}


class Tower {
  final String name;
  final List<Checkpoint> checkpoints;

  Tower(this.name, this.checkpoints);
}


MultipleChoiceQuestion generateSampleQuestion(questionNumber)
=> MultipleChoiceQuestion(
  "Question-$questionNumber question text.",
  "Question-$questionNumber choice A",
  "Question-$questionNumber choice B",
  "Question-$questionNumber choice C",
  "Question-$questionNumber choice D",
  "A",
);

List<MultipleChoiceQuestion> questionsInCheckpoint =
[for (var i = 1; i <= 10; i++) generateSampleQuestion(i)];


Tower mockTower1 = new Tower("Python", [
  Checkpoint("Introduction", true, questionsInCheckpoint),
  Checkpoint("Basic Syntax", true, questionsInCheckpoint),
  Checkpoint("Advanced Syntax", false, questionsInCheckpoint),
  Checkpoint("Control logic", false, questionsInCheckpoint),
]);


Tower mockTower2 = new Tower("Algorithms", [
  Checkpoint("Introduction", true, questionsInCheckpoint),
  Checkpoint("Search", true, questionsInCheckpoint),
  Checkpoint("Sort", false, questionsInCheckpoint),
  Checkpoint("Graphs", false, questionsInCheckpoint),
]);



