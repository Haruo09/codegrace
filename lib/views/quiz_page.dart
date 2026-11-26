import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/questao_model.dart';
import '../theme/catppuccin_theme.dart';
import '../viewmodels/quiz_viewmodel.dart';
import 'widgets/ada_avatar_card.dart';
import 'widgets/quiz_feedback_panel.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizViewModel>(
      builder: (context, viewModel, child) {
        // ── Estado de carregamento ─────────────────────────────────────────
        if (viewModel.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (viewModel.errorMessage != null) {
          return Scaffold(
            body: Center(
              child: Text(
                viewModel.errorMessage!,
                style: const TextStyle(color: CatppuccinColors.red),
              ),
            ),
          );
        }

        if (viewModel.currentStepIndex == 0) {
          return _buildAdaIntroView(context, viewModel);
        }

        if (viewModel.isLessonCompleted) {
          return _buildLessonCompletedView(context, viewModel);
        }

        final question = viewModel.currentQuestion;
        if (question == null) {
          return const Scaffold(
            body: Center(child: Text('Nenhuma questão disponível.')),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Lição: Lógica com Ada '
              '(${viewModel.currentQuestionIndex + 1}/${viewModel.totalQuestions})',
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
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
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

                // Card do Avatar da Ada Lovelace
                AdaAvatarCard(message: viewModel.adaDialogMessage),
                const SizedBox(height: 16),

                // Badge de Dificuldade e Pontos
                Row(
                  children: [
                    _buildDifficultyBadge(viewModel.currentDifficulty),
                    const Spacer(),
                    if (!viewModel.currentIsTutorial)
                      Text(
                        'Valor: ${viewModel.currentPoints} pts',
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
                      question.enunciado,
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
                  question.alternativas.length,
                  (index) =>
                      _buildOptionCard(context, viewModel, question, index),
                ),
              ],
            ),
          ),
          // Painel Inferior Fixo estilo Duolingo
          bottomNavigationBar: QuizFeedbackPanel(
            viewModel: viewModel,
            question: question,
          ),
        );
      },
    );
  }

  Widget _buildOptionCard(
    BuildContext context,
    QuizViewModel viewModel,
    QuestaoModel question,
    int index,
  ) {
    final isSelected = viewModel.selectedOptionIndex == index;
    final isCorrectOption = index == question.altCerta;

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
                  question.alternativas[index],
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

  Widget _buildDifficultyBadge(QuestionDifficulty difficulty) {
    String label;
    Color color;

    switch (difficulty) {
      case QuestionDifficulty.tutorial:
        label = 'TUTORIAL';
        color = CatppuccinColors.lavender;
      case QuestionDifficulty.easy:
        label = 'FÁCIL';
        color = CatppuccinColors.green;
      case QuestionDifficulty.medium:
        label = 'MÉDIO';
        color = CatppuccinColors.yellow;
      case QuestionDifficulty.hard:
        label = 'DIFÍCIL';
        color = CatppuccinColors.red;
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
              child: ClipOval(
                child: Image.asset(
                  'assets/images/ada-icon.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.face_3,
                    color: CatppuccinColors.mauve,
                    size: 72,
                  ),
                ),
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

  Widget _buildLessonCompletedView(
    BuildContext context,
    QuizViewModel viewModel,
  ) {
    final totalAcumulado = viewModel.usuario?.pontuacao ?? viewModel.totalScore;

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
                'Você deu o primeiro passo na sua jornada em Lógica de '
                'Programação com a Ada Lovelace!',
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
                        'Pontos desta Lição',
                        style: TextStyle(color: CatppuccinColors.subtext0),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '+${viewModel.totalScore} pts',
                        style: const TextStyle(
                          color: CatppuccinColors.yellow,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(color: CatppuccinColors.surface1),
                      const Text(
                        'Total Acumulado',
                        style: TextStyle(color: CatppuccinColors.subtext0),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$totalAcumulado pts',
                        style: const TextStyle(
                          color: CatppuccinColors.mauve,
                          fontSize: 24,
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
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.map_outlined),
                  label: const Text('Voltar à Trilha'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
