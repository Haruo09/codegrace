class FaseModel {
  final int id;
  final String nome;

  const FaseModel({required this.id, required this.nome});

  factory FaseModel.fromMap(Map<String, dynamic> map) {
    return FaseModel(id: map['id'] as int, nome: map['nome'] as String);
  }

  Map<String, dynamic> toMap() => {'id': id, 'nome': nome};
}
