class QuestaoModel {
  final int id;
  final String enunciado;
  final String alt1;
  final String alt2;
  final String alt3;
  final String alt4;
  final int altCerta;
  final int faseId;
  final int dificuldadeId;

  // Campos desnormalizados carregados via JOIN
  final String? nomeDificuldade;
  final int? pontuacaoDificuldade;

  const QuestaoModel({
    required this.id,
    required this.enunciado,
    required this.alt1,
    required this.alt2,
    required this.alt3,
    required this.alt4,
    required this.altCerta,
    required this.faseId,
    required this.dificuldadeId,
    this.nomeDificuldade,
    this.pontuacaoDificuldade,
  });

  /// Lista de alternativas na ordem A-B-C-D.
  List<String> get alternativas => [alt1, alt2, alt3, alt4];

  factory QuestaoModel.fromMap(Map<String, dynamic> map) {
    return QuestaoModel(
      id: map['id'] as int,
      enunciado: map['enunciado'] as String,
      alt1: map['alt1'] as String,
      alt2: map['alt2'] as String,
      alt3: map['alt3'] as String,
      alt4: map['alt4'] as String,
      altCerta: map['alt_certa'] as int,
      faseId: map['fase_id'] as int,
      dificuldadeId: map['dificuldade_id'] as int,
      nomeDificuldade: map['dificuldade'] as String?,
      pontuacaoDificuldade: map['pontuacao'] as int?,
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'enunciado': enunciado,
    'alt1': alt1,
    'alt2': alt2,
    'alt3': alt3,
    'alt4': alt4,
    'alt_certa': altCerta,
    'fase_id': faseId,
    'dificuldade_id': dificuldadeId,
  };
}
