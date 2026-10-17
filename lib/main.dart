import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'theme/catppuccin_theme.dart';
import 'viewmodels/quiz_viewmodel.dart';
import 'views/home_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => QuizViewModel())],
      child: const CodeGraceApp(),
    ),
  );
}

class CodeGraceApp extends StatelessWidget {
  const CodeGraceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CodeGrace',
      debugShowCheckedModeBanner: false,
      theme: CatppuccinTheme.mochaTheme,
      home: const HomePage(),
    );
  }
}
