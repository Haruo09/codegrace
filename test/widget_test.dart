import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:codegrace/main.dart';
import 'package:codegrace/viewmodels/quiz_viewmodel.dart';
import 'package:codegrace/views/quiz_page.dart';
import 'package:codegrace/views/widgets/trail_node.dart';
import 'package:codegrace/views/widgets/quiz_feedback_panel.dart';

void main() {
  testWidgets('CodeGraceApp smoke test e exibição da tela inicial', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => QuizViewModel())],
        child: const CodeGraceApp(),
      ),
    );

    // Verifica se o título da tela principal é exibido no app
    expect(find.text('CodeGrace - Trilha de Aprendizado'), findsOneWidget);

    // Verifica se os nós de trilha estão presentes
    expect(find.byType(TrailNode), findsNWidgets(3));
    expect(find.text('FASE 1'), findsOneWidget);
  });

  testWidgets(
    'QuizFeedbackPanel estilo Duolingo exibe feedback e explicação imediatamente',
    (WidgetTester tester) async {
      final viewModel = QuizViewModel();
      viewModel.startLesson();

      await tester.pumpWidget(
        MultiProvider(
          providers: [ChangeNotifierProvider.value(value: viewModel)],
          child: const MaterialApp(home: QuizPage()),
        ),
      );

      // Na primeira questão (tutorial), o botão inicial do painel é "Checar Resposta"
      expect(find.byType(QuizFeedbackPanel), findsOneWidget);
      expect(find.text('Checar Resposta'), findsOneWidget);

      // Seleciona a opção correta: "Variável" (índice 1 da questão tutorial)
      await tester.tap(find.text('Variável'));
      await tester.pumpAndSettle();

      // Clica no botão "Checar Resposta"
      await tester.tap(find.text('Checar Resposta'));
      await tester.pumpAndSettle();

      // O painel estilo Duolingo deve subir exibindo o indicador "Correto!"
      expect(find.text('Correto!'), findsOneWidget);

      // A explicação detalhada deve estar visível no painel
      expect(
        find.text(
          'Uma variável é um espaço nomeado na memória que armazena dados que podem ser alterados.',
        ),
        findsOneWidget,
      );

      // O botão deve ter mudado para "Continuar"
      expect(find.text('Continuar'), findsOneWidget);

      // Clica em "Continuar" para avançar à próxima pergunta
      await tester.tap(find.text('Continuar'));
      await tester.pumpAndSettle();

      // Deve ter avançado para a questão 1 (fácil) e o painel voltou ao estado "Checar Resposta"
      expect(viewModel.currentQuestionIndex, 1);
      expect(find.text('Checar Resposta'), findsOneWidget);
    },
  );
}
