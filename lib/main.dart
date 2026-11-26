import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'theme/catppuccin_theme.dart';
import 'viewmodels/quiz_viewmodel.dart';
import 'views/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // No Linux desktop o sqflite precisa do backend FFI.
  // No Android/iOS o sqflite já usa o backend nativo.
  if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  final viewModel = QuizViewModel();
  await viewModel.carregarDados();

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider.value(value: viewModel)],
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
