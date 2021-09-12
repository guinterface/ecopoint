class Empresa {

  String _idUsuario = "";
  String _nome ="";
  String _email = "";
  String _urlImagem ="";
  String _descricao ="";
  String _senha ="";
  String _foto ="";


  Empresa();



  Map<String, dynamic> toMap() {


    Map<String, dynamic> map = {
      "nome": this.nome,
      "email": this.email,
      "foto": this.foto,
      "foto": this.urlImagem,
      "descricao": this.descricao,
      "idUsuario": this.idUsuario,



    };
    return map;

  }


  String get foto => _foto;

  set foto(String value) {
    _foto = value;
  }

  String get idUsuario => _idUsuario;

  set idUsuario(String value) {
    _idUsuario = value;
  }

  String get senha => _senha;

  set senha(String value) {
    _senha = value;
  }

  String get urlImagem => _urlImagem;

  set urlImagem(String value) {
    _urlImagem = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get descricao => _descricao;

  set descricao(String value) {
    _descricao = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }
}