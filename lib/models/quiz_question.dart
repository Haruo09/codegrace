enum QuestionDifficulty { easy, medium, hard, tutorial }

class QuizQuestion {
  final String id;
  final String questionText;
  final List<String> options;
  final int correctOptionIndex;
  final String explanation;
  final QuestionDifficulty difficulty;
  final int points;
  final bool isTutorial;

  const QuizQuestion({
    required this.id,
    required this.questionText,
    required this.options,
    required this.correctOptionIndex,
    required this.explanation,
    required this.difficulty,
    required this.points,
    this.isTutorial = false,
  });
}
