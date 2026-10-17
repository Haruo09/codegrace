import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:codegrace/main.dart';
import 'package:codegrace/viewmodels/quiz_viewmodel.dart';

void main() {
  testWidgets('CodeGraceApp smoke test', (WidgetTester tester) async {
    // Carrega o aplicativo com o Provider configurado
    await tester.pumpWidget(
      MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => QuizViewModel())],
        child: const CodeGraceApp(),
      ),
    );

    // Verifica se o título da tela principal é exibido no app
    expect(find.text('CodeGrace - Trilha de Aprendizado'), findsOneWidget);
  });
}
