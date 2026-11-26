import '../database/database_helper.dart';
import '../models/questao_model.dart';

class QuizRepository {
  final DatabaseHelper _dbHelper;

  QuizRepository({DatabaseHelper? dbHelper})
    : _dbHelper = dbHelper ?? DatabaseHelper();

  /// Retorna todas as questões de uma [faseId] com dados de dificuldade
  /// já resolvidos via JOIN.
  Future<List<QuestaoModel>> getQuestoesByFase(int faseId) async {
    final db = await _dbHelper.database;
    final rows = await db.rawQuery(
      '''
      SELECT q.*, d.dificuldade, d.pontuacao
      FROM   questoes      q
      JOIN   dificuldades  d ON d.id = q.dificuldade_id
      WHERE  q.fase_id = ?
      ORDER  BY q.id
      ''',
      [faseId],
    );
    return rows.map(QuestaoModel.fromMap).toList();
  }
}
