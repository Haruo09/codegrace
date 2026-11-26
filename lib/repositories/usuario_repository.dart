import '../database/database_helper.dart';
import '../models/usuario_model.dart';

class UsuarioRepository {
  final DatabaseHelper _dbHelper;

  UsuarioRepository({DatabaseHelper? dbHelper})
    : _dbHelper = dbHelper ?? DatabaseHelper();

  /// Busca o usuário pelo [id] (padrão: 1).
  Future<UsuarioModel?> getUsuario({int id = 1}) async {
    final db = await _dbHelper.database;
    final rows = await db.query(
      'usuarios',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return UsuarioModel.fromMap(rows.first);
  }

  /// Atualiza a pontuação acumulada e a fase atual do usuário [id].
  Future<void> atualizarProgresso({
    required int id,
    required int pontuacao,
    required int faseAtual,
  }) async {
    final db = await _dbHelper.database;
    await db.update(
      'usuarios',
      {'pontuacao': pontuacao, 'fase_atual': faseAtual},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
