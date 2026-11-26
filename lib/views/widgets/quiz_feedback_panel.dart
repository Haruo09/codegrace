import 'package:flutter/material.dart';

import '../../models/questao_model.dart';
import '../../theme/catppuccin_theme.dart';
import '../../viewmodels/quiz_viewmodel.dart';

/// Painel inferior fixo estilo Duolingo que sobe imediatamente ao responder a
/// questão. Exibe indicador de acerto/erro, texto explicativo e botão
/// "Continuar" para avançar à próxima pergunta.
class QuizFeedbackPanel extends StatelessWidget {
  final QuizViewModel viewModel;
  final QuestaoModel question;

  const QuizFeedbackPanel({
    super.key,
    required this.viewModel,
    required this.question,
  });

  @override
  Widget build(BuildContext context) {
    final isAnswered = viewModel.isAnswered;
    final isCorrect = viewModel.isCorrect;
    final isLastQuestion =
        viewModel.currentQuestionIndex >= viewModel.totalQuestions - 1;

    final Color statusColor = isCorrect
        ? CatppuccinColors.green
        : CatppuccinColors.red;
    final Color panelBgColor = isAnswered
        ? (isCorrect ? const Color(0xFF1B2A22) : const Color(0xFF2D1B22))
        : CatppuccinColors.mantle;
    final Color borderColor = isAnswered
        ? statusColor
        : CatppuccinColors.surface1;

    return Container(
      decoration: BoxDecoration(
        color: panelBgColor,
        border: Border(
          top: BorderSide(color: borderColor, width: isAnswered ? 2.5 : 1.0),
        ),
        boxShadow: isAnswered
            ? [
                BoxShadow(
                  color: statusColor.withValues(alpha: 0.18),
                  blurRadius: 16,
                  offset: const Offset(0, -4),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
      ),
      child: SafeArea(
        top: false,
        child: AnimatedSize(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (isAnswered) ...[
                  // Indicador de Acerto / Erro estilo Duolingo
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: statusColor.withValues(alpha: 0.2),
                        ),
                        child: Icon(
                          isCorrect
                              ? Icons.check_circle_rounded
                              : Icons.cancel_rounded,
                          color: statusColor,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        isCorrect ? 'Correto!' : 'Incorreto!',
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Resposta correta destacada
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: CatppuccinColors.base.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: statusColor.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Text(
                      'Resposta certa: ${question.alternativas[question.altCerta]}',
                      style: const TextStyle(
                        color: CatppuccinColors.text,
                        fontSize: 14.5,
                        height: 1.35,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                ],

                // Botão de Ação: "Checar Resposta" ou "Continuar"
                SizedBox(
                  height: 48,
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
                      backgroundColor: isAnswered
                          ? statusColor
                          : CatppuccinColors.mauve,
                      foregroundColor: CatppuccinColors.base,
                      disabledBackgroundColor: CatppuccinColors.surface0,
                      disabledForegroundColor: CatppuccinColors.subtext0,
                      elevation: isAnswered ? 4 : 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      !isAnswered
                          ? 'Checar Resposta'
                          : (isLastQuestion ? 'Ver Resultado' : 'Continuar'),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
