import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/catppuccin_theme.dart';
import '../viewmodels/quiz_viewmodel.dart';
import '../models/quiz_question.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.currentStepIndex == 0) {
          return _buildAdaIntroView(context, viewModel);
        }

        if (viewModel.isLessonCompleted) {
          return _buildLessonCompletedView(context, viewModel);
        }

        final question = viewModel.currentQuestion;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Lição: Lógica com Ada (${viewModel.currentQuestionIndex + 1}/${viewModel.totalQuestions})',
            ),
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 16),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: CatppuccinColors.surface0,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: CatppuccinColors.yellow),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: CatppuccinColors.yellow,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${viewModel.totalScore} pts',
                      style: const TextStyle(
                        color: CatppuccinColors.text,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Barra de Progresso
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value:
                        (viewModel.currentQuestionIndex + 1) /
                        viewModel.totalQuestions,
                    backgroundColor: CatppuccinColors.surface0,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      CatppuccinColors.mauve,
                    ),
                    minHeight: 8,
                  ),
                ),
                const SizedBox(height: 16),

                // Card do Avatar da Ada Lovelace (Toon)
                _buildAdaAvatarCard(viewModel.adaDialogMessage),
                const SizedBox(height: 16),

                // Badge de Dificuldade e Pontos
                Row(
                  children: [
                    _buildDifficultyBadge(question.difficulty),
                    const Spacer(),
                    if (!question.isTutorial)
                      Text(
                        'Valor: ${question.points} pts',
                        style: const TextStyle(
                          color: CatppuccinColors.subtext0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),

                // Card da Pergunta
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      question.questionText,
                      style: const TextStyle(
                        color: CatppuccinColors.text,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Opções de Resposta
                ...List.generate(
                  question.options.length,
                  (index) =>
                      _buildOptionCard(context, viewModel, question, index),
                ),

                const SizedBox(height: 16),

                // Card de Explicação após responder
                if (viewModel.isAnswered)
                  Card(
                    color: viewModel.isCorrect
                        ? CatppuccinColors.green.withValues(alpha: 0.15)
                        : CatppuccinColors.red.withValues(alpha: 0.15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: viewModel.isCorrect
                            ? CatppuccinColors.green
                            : CatppuccinColors.red,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                viewModel.isCorrect
                                    ? Icons.check_circle
                                    : Icons.cancel,
                                color: viewModel.isCorrect
                                    ? CatppuccinColors.green
                                    : CatppuccinColors.red,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                viewModel.isCorrect ? 'Correto!' : 'Incorreto!',
                                style: TextStyle(
                                  color: viewModel.isCorrect
                                      ? CatppuccinColors.green
                                      : CatppuccinColors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            question.explanation,
                            style: const TextStyle(
                              color: CatppuccinColors.text,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(16),
            color: CatppuccinColors.mantle,
            child: ElevatedButton(
              onPressed: viewModel.selectedOptionIndex == null
                  ? null
                  : () {
                      if (!viewModel.isAnswered) {
                        viewModel.checkAnswer();
                      } else {
                        viewModel.nextQuestion();
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: viewModel.isAnswered
                    ? (viewModel.isCorrect
                          ? CatppuccinColors.green
                          : CatppuccinColors.mauve)
                    : CatppuccinColors.mauve,
              ),
              child: Text(
                !viewModel.isAnswered
                    ? 'Checar Resposta'
                    : (viewModel.currentQuestionIndex <
                              viewModel.totalQuestions - 1
                          ? 'Próxima Questão'
                          : 'Ver Resultado'),
                style: const TextStyle(
                  color: CatppuccinColors.base,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Card do Avatar Toon da Ada Lovelace
  Widget _buildAdaAvatarCard(String message) {
    return Card(
      color: CatppuccinColors.surface0,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Avatar Ilustrado / Ícone da Ada
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: CatppuccinColors.lavender.withValues(alpha: 0.2),
                shape: BoxShape.circle,
                border: Border.all(color: CatppuccinColors.lavender, width: 2),
              ),
              child: const Icon(
                Icons.face_3,
                color: CatppuccinColors.lavender,
                size: 32,
              ),
            ),
            const SizedBox(width: 12),
            // Balão de fala
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: CatppuccinColors.mantle,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: CatppuccinColors.surface1),
                ),
                child: Text(
                  message,
                  style: const TextStyle(
                    color: CatppuccinColors.text,
                    fontSize: 13,
                    height: 1.3,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Card de Opção de Resposta
  Widget _buildOptionCard(
    BuildContext context,
    QuizViewModel viewModel,
    QuizQuestion question,
    int index,
  ) {
    final isSelected = viewModel.selectedOptionIndex == index;
    final isCorrectOption = index == question.correctOptionIndex;

    Color backgroundColor = CatppuccinColors.surface0;
    Color borderColor = CatppuccinColors.surface1;
    Color textColor = CatppuccinColors.text;

    if (viewModel.isAnswered) {
      if (isCorrectOption) {
        backgroundColor = CatppuccinColors.green.withValues(alpha: 0.2);
        borderColor = CatppuccinColors.green;
        textColor = CatppuccinColors.green;
      } else if (isSelected && !viewModel.isCorrect) {
        backgroundColor = CatppuccinColors.red.withValues(alpha: 0.2);
        borderColor = CatppuccinColors.red;
        textColor = CatppuccinColors.red;
      }
    } else if (isSelected) {
      backgroundColor = CatppuccinColors.mauve.withValues(alpha: 0.2);
      borderColor = CatppuccinColors.mauve;
      textColor = CatppuccinColors.mauve;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: InkWell(
        onTap: () => viewModel.selectOption(index),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor, width: isSelected ? 2 : 1),
          ),
          child: Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? borderColor : Colors.transparent,
                  border: Border.all(color: borderColor),
                ),
                child: Center(
                  child: Text(
                    String.fromCharCode(65 + index), // A, B, C, D
                    style: TextStyle(
                      color: isSelected ? CatppuccinColors.base : textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  question.options[index],
                  style: TextStyle(
                    color: textColor,
                    fontSize: 15,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Badge de Dificuldade
  Widget _buildDifficultyBadge(QuestionDifficulty difficulty) {
    String label;
    Color color;

    switch (difficulty) {
      case QuestionDifficulty.tutorial:
        label = 'TUTORIAL';
        color = CatppuccinColors.lavender;
        break;
      case QuestionDifficulty.easy:
        label = 'FÁCIL';
        color = CatppuccinColors.green;
        break;
      case QuestionDifficulty.medium:
        label = 'MÉDIO';
        color = CatppuccinColors.yellow;
        break;
      case QuestionDifficulty.hard:
        label = 'DIFÍCIL';
        color = CatppuccinColors.red;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Tela Inicial da Ada (Apresentação)
  Widget _buildAdaIntroView(BuildContext context, QuizViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(title: const Text('CodeGrace - Módulo Inicial')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: CatppuccinColors.mauve.withValues(alpha: 0.2),
                shape: BoxShape.circle,
                border: Border.all(color: CatppuccinColors.mauve, width: 3),
              ),
              child: const Icon(
                Icons.face_3,
                color: CatppuccinColors.mauve,
                size: 72,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Conheça Ada Lovelace',
              style: TextStyle(
                color: CatppuccinColors.text,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: CatppuccinColors.surface0,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: CatppuccinColors.surface1),
              ),
              child: Text(
                viewModel.adaDialogMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: CatppuccinColors.text,
                  fontSize: 16,
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => viewModel.startLesson(),
                icon: const Icon(Icons.play_arrow),
                label: const Text('Iniciar Lição de Lógica'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Tela de Conclusão da Lição
  Widget _buildLessonCompletedView(
    BuildContext context,
    QuizViewModel viewModel,
  ) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.emoji_events,
                color: CatppuccinColors.yellow,
                size: 80,
              ),
              const SizedBox(height: 16),
              const Text(
                'Lição Concluída!',
                style: TextStyle(
                  color: CatppuccinColors.text,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Você deu o primeiro passo na sua jornada em Lógica de Programação com a Ada Lovelace!',
                textAlign: TextAlign.center,
                style: TextStyle(color: CatppuccinColors.subtext0),
              ),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Text(
                        'Pontuação Total Conquistada',
                        style: TextStyle(color: CatppuccinColors.subtext0),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${viewModel.totalScore} Pontos',
                        style: const TextStyle(
                          color: CatppuccinColors.yellow,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => viewModel.resetLesson(),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Refazer Lição'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
