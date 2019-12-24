Aluno listAlunoFromJson(List<dynamic> str) => Aluno.fromJson(str.first);

class Aluno {
  String id;
  String nome;
  String token;
  String codAluno;
  String urlPerfil;
  double credito;
  DateTime criadoEm;
  int v;

  Aluno({
    this.id,
    this.nome,
    this.token,
    this.codAluno,
    this.urlPerfil,
    this.credito,
    this.criadoEm,
    this.v,
  });

  factory Aluno.fromJson(Map<String, dynamic> json) => new Aluno(
        id: json["id"] == null ? null : json["id"],
        nome: json["nome"] == null ? null : json["nome"],
        token: json["token"] == null ? null : json["token"],
        codAluno: json["codAluno"] == null ? null : json["codAluno"],
        urlPerfil: json["urlPerfil"] == null ? null : json["urlPerfil"],
        credito: json["credito"] == null ? null : json["credito"],
        criadoEm:
            json["criadoEm"] == null ? null : DateTime.parse(json["criadoEm"]),
        v: json["v"] == null ? null : json["v"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "nome": nome == null ? null : nome,
        "token": token == null ? null : token,
        "codAluno": codAluno == null ? null : codAluno,
        "urlPerfil": urlPerfil == null ? null : urlPerfil,
        "credito": credito == null ? null : credito,
        "criadoEm": criadoEm == null ? null : criadoEm.toIso8601String(),
        "v": v == null ? null : v,
      };
}
