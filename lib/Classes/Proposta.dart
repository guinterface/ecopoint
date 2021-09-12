



import 'package:cloud_firestore/cloud_firestore.dart';

class Proposta{

  String _id = "";
  String _titulo="";
  String _item1="";
  String _item2="";
  String _item3="";
  String _premio = "";
  String _local = "";
  String _status = "";

  Proposta();

  Proposta.fromDocumentSnapshot(DocumentSnapshot documentSnapshot){

    this.id = documentSnapshot.documentID;
    this.titulo     = documentSnapshot["titulo"];
    this.item1 = documentSnapshot["item1"];
    this.item2 = documentSnapshot["item2"];
    this.item3 = documentSnapshot["item3"];
    this.premio = documentSnapshot["premio"];




  }

  Proposta.gerarId(){

    Firestore db = Firestore.instance;
    CollectionReference anuncios = db.collection("meus_anuncios");
    this.id = anuncios.document().documentID;

  }

  Map<String, dynamic> toMap(){

    Map<String, dynamic> map = {
      "id" : this.id,
      "titulo" : this.titulo,
      "item1" : this.item1,
      "item2" : this.item2,
      "item3" : this.item3,
      "premio": this.premio,
      "local": this.local,
      "status": this.status
    };

    return map;

  }


  String get item1 => _item1;

  set item1(String value) {
    _item1 = value;
  }

  String get titulo => _titulo;

  set titulo(String value) {
    _titulo = value;
  }


  String get status => _status;

  set status(String value) {
    _status = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get item2 => _item2;

  set item2(String value) {
    _item2 = value;
  }

  String get premio => _premio;

  set premio(String value) {
    _premio = value;
  }

  String get item3 => _item3;

  set item3(String value) {
    _item3 = value;
  }

  String get local => _local;

  set local(String value) {
    _local = value;
  }
}