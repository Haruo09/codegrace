import 'package:flutter/material.dart';

import '../models/questao_model.dart';
import '../models/usuario_model.dart';
import '../repositories/quiz_repository.dart';
import '../repositories/usuario_repository.dart';

// Mantido para compatibilidade com quiz_page.dart (badge de dificuldade)
enum QuestionDifficulty { easy, medium, hard, tutorial }

class QuizViewModel extends ChangeNotifier {
  final QuizRepository _quizRepository;
  final UsuarioRepository _usuarioRepository;

  QuizViewModel({
    QuizRepository? quizRepository,
    UsuarioRepository? usuarioRepository,
  }) : _quizRepository = quizRepository ?? QuizRepository(),
       _usuarioRepository = usuarioRepository ?? UsuarioRepository();

  // ── Estado da UI ────────────────────────────────────────────────────────────
  int _currentStepIndex = 0; // 0: Apresentação Ada, 1: Questões
  int _currentQuestionIndex = 0;
  int? _selectedOptionIndex;
  bool _isAnswered = false;
  bool _isCorrect = false;
  int _totalScore = 0;
  bool _isLessonCompleted = false;
  bool _isLoading = false;
  String? _errorMessage;

  // ── Dados do banco ──────────────────────────────────────────────────────────
  List<QuestaoModel> _questions = [];
  UsuarioModel? _usuario;

  // ── Diálogo da Ada ──────────────────────────────────────────────────────────
  String _adaDialogMessage =
      'Olá! Eu sou Ada Lovelace, considerada a primeira programadora da '
      'história! Vamos aprender Lógica de Programação juntos?';

  // ── Getters ─────────────────────────────────────────────────────────────────
  int get currentStepIndex => _currentStepIndex;
  int get currentQuestionIndex => _currentQuestionIndex;
  int? get selectedOptionIndex => _selectedOptionIndex;
  bool get isAnswered => _isAnswered;
  bool get isCorrect => _isCorrect;
  int get totalScore => _totalScore;
  bool get isLessonCompleted => _isLessonCompleted;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get adaDialogMessage => _adaDialogMessage;
  UsuarioModel? get usuario => _usuario;

  List<QuestaoModel> get questions => _questions;
  int get totalQuestions => _questions.length;

  QuestaoModel? get currentQuestion =>
      _questions.isNotEmpty ? _questions[_currentQuestionIndex] : null;

  // ── Helpers de compatibilidade com QuizPage ─────────────────────────────────
  QuestionDifficulty get currentDifficulty {
    final nome = currentQuestion?.nomeDificuldade ?? 'tutorial';
    switch (nome) {
      case 'facil':
        return QuestionDifficulty.easy;
      case 'medio':
        return QuestionDifficulty.medium;
      case 'dificil':
        return QuestionDifficulty.hard;
      default:
        return QuestionDifficulty.tutorial;
    }
  }

  bool get currentIsTutorial =>
      (currentQuestion?.nomeDificuldade ?? 'tutorial') == 'tutorial';

  int get currentPoints => currentQuestion?.pontuacaoDificuldade ?? 0;

  // ── Carregamento inicial ─────────────────────────────────────────────────────
  Future<void> carregarDados({int faseId = 1}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final results = await Future.wait([
        _quizRepository.getQuestoesByFase(faseId),
        _usuarioRepository.getUsuario(),
      ]);

      _questions = results[0] as List<QuestaoModel>;
      _usuario = results[1] as UsuarioModel?;
    } catch (e) {
      _errorMessage = 'Erro ao carregar dados: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ── Ações do quiz ────────────────────────────────────────────────────────────
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
    final question = currentQuestion;
    if (_selectedOptionIndex == null || _isAnswered || question == null) return;

    _isAnswered = true;
    _isCorrect = (_selectedOptionIndex == question.altCerta);

    if (_isCorrect) {
      _totalScore += question.pontuacaoDificuldade ?? 0;
      if (currentIsTutorial) {
        _adaDialogMessage =
            'Na MINHA ÉPOCA, eu tinha que furar cartões pra resolver problemas '
            'assim! Muito bem, você acertou!';
      } else {
        _adaDialogMessage =
            'Excelente raciocínio lógico! Você ganhou +${question.pontuacaoDificuldade} pontos!';
      }
    } else {
      _adaDialogMessage =
          'Mais sorte na próxima! Não desanime, o erro é uma etapa fundamental '
          'do aprendizado na computação.';
    }

    notifyListeners();
  }

  void nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
      _selectedOptionIndex = null;
      _isAnswered = false;
      _isCorrect = false;
      _adaDialogMessage = 'Próxima questão. Foco e atenção!';
      notifyListeners();
    } else {
      _completarLicao();
    }
  }

  Future<void> _completarLicao() async {
    _isLessonCompleted = true;
    _adaDialogMessage =
        'Parabéns! Você concluiu a lição com sucesso e acumulou $_totalScore pontos!';
    notifyListeners();

    // Persiste o progresso no banco
    if (_usuario != null) {
      final novoTotal = _usuario!.pontuacao + _totalScore;
      await _usuarioRepository.atualizarProgresso(
        id: _usuario!.id,
        pontuacao: novoTotal,
        faseAtual: _usuario!.faseAtual,
      );
      _usuario = _usuario!.copyWith(pontuacao: novoTotal);
      notifyListeners();
    }
  }

  Future<void> resetLesson() async {
    _currentStepIndex = 0;
    _currentQuestionIndex = 0;
    _selectedOptionIndex = null;
    _isAnswered = false;
    _isCorrect = false;
    _totalScore = 0;
    _isLessonCompleted = false;
    _adaDialogMessage =
        'Olá! Eu sou Ada Lovelace, considerada a primeira programadora da '
        'história! Vamos aprender Lógica de Programação juntos?';
    notifyListeners();

    // Recarrega dados atualizados do banco
    await carregarDados(faseId: _usuario?.faseAtual ?? 1);
  }
}
