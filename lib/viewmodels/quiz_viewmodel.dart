import 'package:flutter/material.dart';

import 'package:codegrace/models/quiz_question.dart';

class QuizViewModel extends ChangeNotifier {
  int _currentStepIndex = 0; // 0: Tela de Apresentação da Ada, 1: Questões
  int _currentQuestionIndex = 0;
  int? _selectedOptionIndex;
  bool _isAnswered = false;
  bool _isCorrect = false;
  int _totalScore = 0;
  bool _isLessonCompleted = false;

  // Diálogo dinâmico do Avatar Ada Lovelace
  String _adaDialogMessage =
      'Olá! Eu sou Ada Lovelace, considerada a primeira programadora da história! Vamos aprender Lógica de Programação juntos?';

  // Getters
  int get currentStepIndex => _currentStepIndex;
  int get currentQuestionIndex => _currentQuestionIndex;
  int? get selectedOptionIndex => _selectedOptionIndex;
  bool get isAnswered => _isAnswered;
  bool get isCorrect => _isCorrect;
  int get totalScore => _totalScore;
  bool get isLessonCompleted => _isLessonCompleted;
  String get adaDialogMessage => _adaDialogMessage;

  final List<QuizQuestion> _questions = const [
    // Questão 0: Tutorial
    QuizQuestion(
      id: 'q_tutorial',
      questionText: 'Em Lógica de Programação, para guardar uma informação na memória que pode mudar durante a execução do código, usamos uma...',
      options: [
        'Instrução Fixa',
        'Variável',
        'Constante Mágica',
        'Ficha Perfurada',
      ],
      correctOptionIndex: 1,
      explanation: 'Uma variável é um espaço nomeado na memória que armazena dados que podem ser alterados.',
      difficulty: QuestionDifficulty.tutorial,
      points: 0,
      isTutorial: true,
    ),
    // Questões Fáceis (10 pts cada)
    QuizQuestion(
      id: 'q_easy_1',
      questionText: 'Qual das opções abaixo é usada para tomar decisões em um algoritmo com base em uma condição (Se / Senão)?',
      options: [
        'Estrutura Condicional (if / else)',
        'Laço de Repetição (loop)',
        'Declaração de Biblioteca',
        'Comentário de Código',
      ],
      correctOptionIndex: 0,
      explanation: 'A estrutura condicional avalia se uma expressão é verdadeira para decidir qual caminho seguir.',
      difficulty: QuestionDifficulty.easy,
      points: 10,
    ),
    QuizQuestion(
      id: 'q_easy_2',
      questionText: 'Se declararmos uma variável x = 5 e logo em seguida executarmos x = x + 3, qual será o novo valor armazenado em x?',
      options: ['5', '3', '8', '53'],
      correctOptionIndex: 2,
      explanation: 'O valor anterior (5) é somado a 3 e o resultado (8) passa a ser guardado na variável x.',
      difficulty: QuestionDifficulty.easy,
      points: 10,
    ),
    // Questões Médias (15 pts cada)
    QuizQuestion(
      id: 'q_medium_1',
      questionText: 'Qual estrutura é ideal para executar um mesmo conjunto de instruções repetidamente enquanto uma condição for satisfeita?',
      options: [
        'Estrutura de Repetição (Enquanto / Para)',
        'Estrutura de Seleção Múltipla',
        'Atribuição de Valor',
        'Finalização de Algoritmo',
      ],
      correctOptionIndex: 0,
      explanation: 'Os laços de repetição (como while ou for) evitam a duplicação manual de código repetitivo.',
      difficulty: QuestionDifficulty.medium,
      points: 15,
    ),
    QuizQuestion(
      id: 'q_medium_2',
      questionText: 'Considerando a lógica booleana, qual das expressões abaixo resulta em um valor VERDADEIRO?',
      options: [
        '(10 < 2) E (5 == 5)',
        '(10 < 2) OU (5 == 5)',
        'NÃO (5 == 5)',
        '(8 > 20) OU (3 != 3)',
      ],
      correctOptionIndex: 1,
      explanation: 'No operador OU, basta que pelo menos UMA das condições seja verdadeira para a expressão toda ser verdadeira.',
      difficulty: QuestionDifficulty.medium,
      points: 15,
    ),
    // Questão Difícil (30 pts)
    QuizQuestion(
      id: 'q_hard_1',
      questionText: 'Analise o algoritmo:\n a = 10; b = 20; \ntemp = a;\n a = b;\n b = temp;\n O que essa sequência realizou?',
      options: [
        'Somou o valor de a e b',
        'Inverteu/trocou os valores armazenados entre as variáveis a e b',
        'Apagou as variáveis da memória',
        'Multiplicou os valores por 2',
      ],
      correctOptionIndex: 1,
      explanation: 'A variável temporária (temp) permite trocar o conteúdo de duas variáveis sem perder a informação original.',
      difficulty: QuestionDifficulty.hard,
      points: 30,
    ),
  ];

  List<QuizQuestion> get questions => _questions;
  QuizQuestion get currentQuestion => _questions[_currentQuestionIndex];
  int get totalQuestions => _questions.length;

  void startLesson() {
    _currentStepIndex = 1;
    _currentQuestionIndex = 0;
    _selectedOptionIndex = null;
    _isAnswered = false;
    _isCorrect = false;
    _totalScore = 0;
    _isLessonCompleted = false;
    _adaDialogMessage = 'Vamos começar com uma questão tutorial! Responda quando estiver pronta.';
    notifyListeners();
  }

  void selectOption(int index) {
    if (_isAnswered) return;
    _selectedOptionIndex = index;
    notifyListeners();
  }

  void checkAnswer() {
    if (_selectedOptionIndex == null || _isAnswered) return;

    _isAnswered = true;
    _isCorrect = (_selectedOptionIndex == currentQuestion.correctOptionIndex);

    if (_isCorrect) {
      _totalScore += currentQuestion.points;
      if (currentQuestion.isTutorial) {
        _adaDialogMessage = 'Na MINHA ÉPOCA, eu tinha que furar cartões pra resolver problemas assim! Muito bem, você acertou!';
      } else {
        _adaDialogMessage =
            'Excelente raciocínio lógico! Você ganhou +${currentQuestion.points} pontos!';
      }
    } else {
      _adaDialogMessage = 'Mais sorte na próxima! Não desanime, o erro é uma etapa fundamental do aprendizado na computação.';
    }

    notifyListeners();
  }

  void nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
      _selectedOptionIndex = null;
      _isAnswered = false;
      _isCorrect = false;
      _adaDialogMessage =
          'Próxima questão. Foco e atenção!';
    } else {
      _isLessonCompleted = true;
      _adaDialogMessage =
          'Parabéns! Você concluiu a lição com sucesso e acumulou $_totalScore pontos!';
    }
    notifyListeners();
  }

  void resetLesson() {
    _currentStepIndex = 0;
    _currentQuestionIndex = 0;
    _selectedOptionIndex = null;
    _isAnswered = false;
    _isCorrect = false;
    _totalScore = 0;
    _isLessonCompleted = false;
    _adaDialogMessage = 'Olá! Eu sou Ada Lovelace, considerada a primeira programadora da história! Vamos aprender Lógica de Programação juntos?';
    notifyListeners();
  }
}
