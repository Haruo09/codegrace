import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'codegrace.db');

    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    // Criação das tabelas conforme o DER
    await db.execute('''
      CREATE TABLE dificuldades (
        id        INTEGER PRIMARY KEY,
        dificuldade TEXT NOT NULL,
        pontuacao INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE fases (
        id   INTEGER PRIMARY KEY,
        nome TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE questoes (
        id             INTEGER PRIMARY KEY,
        enunciado      TEXT NOT NULL,
        alt1           TEXT NOT NULL,
        alt2           TEXT NOT NULL,
        alt3           TEXT NOT NULL,
        alt4           TEXT NOT NULL,
        alt_certa      INTEGER NOT NULL,
        fase_id        INTEGER NOT NULL,
        dificuldade_id INTEGER NOT NULL,
        FOREIGN KEY (fase_id)        REFERENCES fases(id),
        FOREIGN KEY (dificuldade_id) REFERENCES dificuldades(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE usuarios (
        id         INTEGER PRIMARY KEY,
        fase_atual INTEGER NOT NULL,
        pontuacao  INTEGER NOT NULL
      )
    ''');

    await _seedData(db);
  }

  Future<void> _seedData(Database db) async {
    // ── Dificuldades ──────────────────────────────────────────────────────────
    // id 1 = tutorial (0 pts), 2 = fácil (10 pts),
    // id 3 = médio (15 pts),   4 = difícil (30 pts)
    final dificuldades = [
      {'id': 1, 'dificuldade': 'tutorial', 'pontuacao': 0},
      {'id': 2, 'dificuldade': 'facil', 'pontuacao': 10},
      {'id': 3, 'dificuldade': 'medio', 'pontuacao': 15},
      {'id': 4, 'dificuldade': 'dificil', 'pontuacao': 30},
    ];
    for (final d in dificuldades) {
      await db.insert('dificuldades', d);
    }

    // ── Fases ─────────────────────────────────────────────────────────────────
    final fases = [
      {'id': 1, 'nome': 'Ada Lovelace & Lógica'},
      {'id': 2, 'nome': 'Grace Hopper & Compiladores'},
      {'id': 3, 'nome': 'Estruturas Condicionais em C'},
    ];
    for (final f in fases) {
      await db.insert('fases', f);
    }

    // ── Questões (Fase 1 — Ada Lovelace & Lógica) ────────────────────────────
    // alt_certa usa índice 0-based para manter consistência com o app Flutter
    final questoes = [
      {
        'id': 1,
        'enunciado':
            'Em Lógica de Programação, para guardar uma informação na memória '
            'que pode mudar durante a execução do código, usamos uma...',
        'alt1': 'Instrução Fixa',
        'alt2': 'Variável',
        'alt3': 'Constante Mágica',
        'alt4': 'Ficha Perfurada',
        'alt_certa': 1, // índice 0-based → "Variável"
        'fase_id': 1,
        'dificuldade_id': 1,
      },
      {
        'id': 2,
        'enunciado':
            'Qual das opções abaixo é usada para tomar decisões em um '
            'algoritmo com base em uma condição (Se / Senão)?',
        'alt1': 'Estrutura Condicional (if / else)',
        'alt2': 'Laço de Repetição (loop)',
        'alt3': 'Declaração de Biblioteca',
        'alt4': 'Comentário de Código',
        'alt_certa': 0,
        'fase_id': 1,
        'dificuldade_id': 2,
      },
      {
        'id': 3,
        'enunciado':
            'Se declararmos uma variável x = 5 e logo em seguida executarmos '
            'x = x + 3, qual será o novo valor armazenado em x?',
        'alt1': '5',
        'alt2': '3',
        'alt3': '8',
        'alt4': '53',
        'alt_certa': 2,
        'fase_id': 1,
        'dificuldade_id': 2,
      },
      {
        'id': 4,
        'enunciado':
            'Qual estrutura é ideal para executar um mesmo conjunto de '
            'instruções repetidamente enquanto uma condição for satisfeita?',
        'alt1': 'Estrutura de Repetição (Enquanto / Para)',
        'alt2': 'Estrutura de Seleção Múltipla',
        'alt3': 'Atribuição de Valor',
        'alt4': 'Finalização de Algoritmo',
        'alt_certa': 0,
        'fase_id': 1,
        'dificuldade_id': 3,
      },
      {
        'id': 5,
        'enunciado':
            'Considerando a lógica booleana, qual das expressões abaixo '
            'resulta em um valor VERDADEIRO?',
        'alt1': '(10 < 2) E (5 == 5)',
        'alt2': '(10 < 2) OU (5 == 5)',
        'alt3': 'NÃO (5 == 5)',
        'alt4': '(8 > 20) OU (3 != 3)',
        'alt_certa': 1,
        'fase_id': 1,
        'dificuldade_id': 3,
      },
      {
        'id': 6,
        'enunciado':
            'Analise o algoritmo:\n a = 10; b = 20; \ntemp = a;\n a = b;\n '
            'b = temp;\n O que essa sequência realizou?',
        'alt1': 'Somou o valor de a e b',
        'alt2':
            'Inverteu/trocou os valores armazenados entre as variáveis a e b',
        'alt3': 'Apagou as variáveis da memória',
        'alt4': 'Multiplicou os valores por 2',
        'alt_certa': 1,
        'fase_id': 1,
        'dificuldade_id': 4,
      },
    ];
    for (final q in questoes) {
      await db.insert('questoes', q);
    }

    // ── Usuário padrão ────────────────────────────────────────────────────────
    await db.insert('usuarios', {'id': 1, 'fase_atual': 1, 'pontuacao': 0});
  }
}
