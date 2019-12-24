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
        codAluno: json["cod_aluno"] == null ? null : json["cod_aluno"],
        urlPerfil: json["url_perfil"] == null ? null : json["url_perfil"],
        credito: json["credito"] == null ? null : json["credito"],
        criadoEm: json["criado_em"] == null
            ? null
            : DateTime.parse(json["criado_em"]),
        v: json["v"] == null ? null : json["v"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "nome": nome == null ? null : nome,
        "token": token == null ? null : token,
        "cod_aluno": codAluno == null ? null : codAluno,
        "url_perfil": urlPerfil == null ? null : urlPerfil,
        "credito": credito == null ? null : credito,
        "criado_em": criadoEm == null ? null : criadoEm.toIso8601String(),
        "v": v == null ? null : v,
      };
}
