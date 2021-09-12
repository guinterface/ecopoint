import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecpoint/Classes/Usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class GeralAnuncio extends StatefulWidget {
  String _local;
  String _titulo;
  String _item1;
  String _item2;
  String _item3;
  String _saved;
  String _image;
  String _id;
  String _status;
  GeralAnuncio( this._titulo, this._item1, this._item2, this._item3, this._local,this._saved,this._image, this._id, this._status);
  @override
  _GeralAnuncioState createState() => _GeralAnuncioState();
}

class _GeralAnuncioState extends State<GeralAnuncio> {
  _salvarPrposta(){
    _aceitarProposta();
    setState(() {
      _buttonText = "Enviado!";
    });


  }
  String _buttonText = "Completei o desafio!";
  _aceitarProposta()async{
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser firebaseUser = await auth.currentUser();
    String idUsuario = firebaseUser.uid;
    Firestore db = Firestore.instance;
    DocumentSnapshot snapshot = await db.collection("usuarios")
        .document( idUsuario )
        .get();

    Map<String, dynamic> dados = snapshot.data;
    String nome = dados["nome"];


    String _idRequisicao = widget._id;


      db.collection("requisicoes").document(idUsuario).setData({
        "id_requisicao" : _idRequisicao,
        "idUsuario" : idUsuario,
        "nome" : nome,
        "titulo": widget._titulo,
        "premio":widget._saved,
        "status": widget._status
      }

      );



  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dados do Desafio"),),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("Imagens/bck1.png"), fit: BoxFit.cover),
        ),
        child: Expanded(
          child: Column(

            children: [

              Image.asset("Imagens/logo.png", height: 100,),
              Padding(padding: EdgeInsets.all(6)),
              Text(widget._titulo, style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 24),),
              Padding(padding: EdgeInsets.only(top: 15, bottom: 15), child: CircleAvatar(backgroundImage: widget._image != null ?  NetworkImage(widget._image) : null, backgroundColor: Colors.white70,) ),

              Row(children: [
                Icon(Icons.assistant_photo_sharp, color: Colors.teal,),
                Text("Primeiro Item: ${widget._item1}", style: TextStyle( fontSize: 18, color: Colors.black54),),

              ],),
              Row(children: [
                Icon(Icons.assistant_photo_sharp, color: Colors.teal,),
                Text("Segundo Item: ${widget._item2}", style: TextStyle( fontSize: 18, color: Colors.black54),),
              ],),
              Row(children: [
                Icon(Icons.assistant_photo_sharp, color: Colors.teal,),
                Text("Terceiro Item: ${widget._item3}", style: TextStyle(  fontSize: 18, color: Colors.black54),),

              ],),
              Row(children: [
                Icon(Icons.card_giftcard, color: Colors.teal,),
                Text("Prêmio: ${widget._saved}", style: TextStyle(color: Colors.teal,  fontSize: 19),),

              ],),
              Padding(padding: EdgeInsets.all(6)),
              Row(children: [
                Icon(Icons.place, color: Colors.teal,),
                Text("Local: ${widget._local}", style: TextStyle( fontSize: 18),),

              ],),
              RaisedButton(
                color: Colors.white,
                child: Text(_buttonText, style: TextStyle(color: Colors.teal, fontSize: 18),),
                onPressed: (){


                  //salvar anuncio
                  _salvarPrposta();


                },
              ),


            ],
          ),
        )

      ),
    );
  }
}
