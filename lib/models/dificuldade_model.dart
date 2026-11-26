class DificuldadeModel {
  final int id;
  final String dificuldade;
  final int pontuacao;

  const DificuldadeModel({
    required this.id,
    required this.dificuldade,
    required this.pontuacao,
  });

  factory DificuldadeModel.fromMap(Map<String, dynamic> map) {
    return DificuldadeModel(
      id: map['id'] as int,
      dificuldade: map['dificuldade'] as String,
      pontuacao: map['pontuacao'] as int,
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'dificuldade': dificuldade,
    'pontuacao': pontuacao,
  };
}
