class UsuarioModel {
  final int id;
  final int faseAtual;
  final int pontuacao;

  const UsuarioModel({
    required this.id,
    required this.faseAtual,
    required this.pontuacao,
  });

  factory UsuarioModel.fromMap(Map<String, dynamic> map) {
    return UsuarioModel(
      id: map['id'] as int,
      faseAtual: map['fase_atual'] as int,
      pontuacao: map['pontuacao'] as int,
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'fase_atual': faseAtual,
    'pontuacao': pontuacao,
  };

  UsuarioModel copyWith({int? faseAtual, int? pontuacao}) {
    return UsuarioModel(
      id: id,
      faseAtual: faseAtual ?? this.faseAtual,
      pontuacao: pontuacao ?? this.pontuacao,
    );
  }
}
