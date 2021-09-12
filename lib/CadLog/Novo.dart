
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecpoint/Classes/Input.dart';
import 'package:ecpoint/Classes/Proposta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class NovoAnuncio2 extends StatefulWidget {
  @override
  _NovoAnuncio2State createState() => _NovoAnuncio2State();
}

class _NovoAnuncio2State extends State<NovoAnuncio2> {

  final _formKey = GlobalKey<FormState>();
  Proposta _anuncio = Proposta();
  TextEditingController _textEditingController1 = TextEditingController();
  TextEditingController _textEditingController2 = TextEditingController();
  TextEditingController _textEditingController3 = TextEditingController();
  TextEditingController _textEditingController4 = TextEditingController();
  TextEditingController _textEditingController5 = TextEditingController();
  TextEditingController _textEditingController6 = TextEditingController();



  late BuildContext _dialogContext;
  _abrirDialog(BuildContext context){

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(height: 20,),
                Text("Salvando anúncio...")
              ],),
          );
        }
    );

  }

  _salvarAnuncio() async {

    _abrirDialog( _dialogContext );

    //Upload imagens no Storage


    //Salvar anuncio no Firestore
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();
    String idUsuarioLogado = usuarioLogado.uid;
    _anuncio.titulo = _textEditingController1.text;
    _anuncio.item1 = _textEditingController2.text;
    _anuncio.item2 = _textEditingController3.text;
    _anuncio.premio = _textEditingController5.text;
    _anuncio.item3 = _textEditingController4.text;
    _anuncio.status = idUsuarioLogado;
    _anuncio.local = _textEditingController6.text;

    Firestore db = Firestore.instance;
    db.collection("meus_anuncios")
        .document( idUsuarioLogado )
        .collection("anuncios")
        .document( _anuncio.id )
        .setData( _anuncio.toMap() ).then((_){

      //salvar anúncio público
      db.collection("anuncios")
          .document( _anuncio.id )
          .setData( _anuncio.toMap() ).then((_){

        Navigator.pop(_dialogContext);
        setState(() {
          ola = "Seu Desafio foi Criado!";
        });

      });

    });


  }



  @override
  void initState() {
    super.initState();


    _anuncio = Proposta.gerarId();

  }
String ola = "Crie um Desafio Ecológico";

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("Imagens/bck1.png"), fit: BoxFit.cover),
          ),
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[


                Row(children: <Widget>[


                ],),
                Text("Crie um desafio", style: TextStyle(fontSize: 20, color: Colors.teal, fontWeight: FontWeight.bold),),
                Text("Crie aqui um desafio aos usuários, adicionando itens a serem completados para um prêmio", style: TextStyle(fontSize: 15, color: Colors.teal),),
                Padding(
                  padding: EdgeInsets.only(bottom: 15, top: 15),
                  child:
                  TextField(
                    controller: _textEditingController1,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: "Título",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32))),
                  ),
                ),
                Text("Item 1 a ser concluído:", style: TextStyle(fontSize: 15, color: Colors.teal),),

                Padding(
                  padding: EdgeInsets.only(bottom: 15, top: 15),
                  child: TextField(
                    controller: _textEditingController2,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: "Exemplo: 20 garrafas PET",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32))),
                  ),
                ),
                Text("Item 2 a ser concluído: (Opcional) ", style: TextStyle(fontSize: 15, color: Colors.teal),),
                Padding(
                  padding: EdgeInsets.only(bottom: 15, top: 15),
                  child: TextField(
                    controller: _textEditingController3,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: "Exemplo: 5 latas de tinta",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32))),
                  ),
                ),
                Text("Item 3 a ser concluído: (Opcional)", style: TextStyle(fontSize: 15, color: Colors.teal),),
                Padding(
                  padding: EdgeInsets.only(bottom: 15, top: 15),
                  child: TextField(
                    controller: _textEditingController4,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: "Exemplo: 10 tampinhas de garrafa",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32))),
                  ),
                ),
                Text("Agora, o prêmio: " , style: TextStyle(fontSize: 15, color: Colors.teal),),
                TextField(
                  controller: _textEditingController5,
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Prêmio ( Ex: Cupom de 20% de desconto)",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32))),
                ),
                Text("Em que local devem ser entregues os itens?" , style: TextStyle(fontSize: 15, color: Colors.white),),
                TextField(
                  controller: _textEditingController6,
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Ex: Rua X,1234",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32))),
                ),




                RaisedButton(
                  child: Text(ola),
                  onPressed: (){
                    if( _textEditingController1.text != null &&_textEditingController2.text != null ){


                      //Configura dialog context
                      _dialogContext = context;

                      //salvar anuncio
                      _salvarAnuncio();

                    }
                  },
                ),
              ],),
          ),
        ),
      ),
    );
  }
}
