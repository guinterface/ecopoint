import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecpoint/CadLog/Home.dart';
import 'package:ecpoint/CadLog/Novo.dart';
import 'package:ecpoint/Classes/Empresa.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Home2.dart';

class LoginEmpresa extends StatefulWidget {
  @override
  _LoginEmpresaState createState() => _LoginEmpresaState();
}

class _LoginEmpresaState extends State<LoginEmpresa> {

  TextEditingController _controllerEmail = TextEditingController(text: "");
  TextEditingController _controllerSenha = TextEditingController(text: "");
  TextEditingController _controllerCod = TextEditingController(text: "");

  bool _cadastrar = false;
  String _mensagemErro = "";
  String _textoBotao = "Entrar";

  _cadastrarEmpresa(Empresa empresa){

    FirebaseAuth auth = FirebaseAuth.instance;
    Firestore db = Firestore.instance;

    auth.createUserWithEmailAndPassword(
        email: empresa.email,
        password: empresa.senha
    ).then((firebaseUser){
      empresa.idUsuario = firebaseUser.user.uid;
      db.collection("empresas")
          .document( firebaseUser.user.uid )
          .setData( empresa.toMap() );
      //redireciona para tela principal
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Home2()
          )
      );



    });

  }

  _logarEmpresa(Empresa empresa){

    FirebaseAuth auth = FirebaseAuth.instance;

    auth.signInWithEmailAndPassword(
        email: empresa.email,
        password: empresa.senha
    ).then((firebaseUser){

      //redireciona para tela principal
      MaterialPageRoute(
          builder: (context) => Home2()
      );

    });

  }

  _validarCampos() {

    //Recupera dados dos campos
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if (email.isNotEmpty && email.contains("@")) {
      if (senha.isNotEmpty && senha.length > 6) {
        if(_controllerCod.text == "1234"){
          Empresa empresa = Empresa();
          empresa.nome ="";
          empresa.email = email;
          empresa.senha = senha;
          empresa.foto = "";

          //cadastrar ou logar
          if( _cadastrar ){
            //Cadastrar
            _cadastrarEmpresa(empresa);
          }else{
            //Logar
            _logarEmpresa(empresa);
          }
        }else{
          setState(() {
            _mensagemErro = "Código Incorreto";
          });
        }

        //Configura empresa


      } else {
        setState(() {
          _mensagemErro = "Preencha a senha! digite mais de 6 caracteres";
        });
      }
    } else {
      setState(() {
        _mensagemErro = "Preencha o E-mail válido";
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Início"),
      ),
      body: Container(

        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("Imagens/bck1.png"), fit: BoxFit.cover),
        ),

        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: Image.asset(
                    "Imagens/logo.png",
                    width: 300,
                    height: 250,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Container(

                        height: MediaQuery.of(context).size.height*0.6,
                        width: MediaQuery.of(context).size.width*0.8,
                        decoration: BoxDecoration(color: Colors.white),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Aqui, protegemos", style: TextStyle(color: Colors.teal, fontSize: 22),),
                            Text("a natureza", style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 24),),
                            Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
                            TextField(
                              controller: _controllerCod,
                              autofocus: true,
                              keyboardType: TextInputType.text,
                              style: TextStyle(fontSize: 20),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                                  hintText: "Código Empresarial",
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(32))),
                            ),
                            TextField(
                              controller: _controllerEmail,
                              autofocus: true,
                              keyboardType: TextInputType.text,
                              style: TextStyle(fontSize: 20),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                                  hintText: "E-mail",
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(32))),
                            ),
                            TextField(
                              controller: _controllerSenha,
                              autofocus: true,
                              keyboardType: TextInputType.text,
                              style: TextStyle(fontSize: 20),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                                  hintText: "Senha",
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(32))),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Fazer Login"),
                                Switch(
                                  activeColor: Colors.tealAccent,
                                  value: _cadastrar,
                                  onChanged: (bool valor){
                                    setState(() {
                                      _cadastrar = valor;
                                      _textoBotao = "Entrar";
                                      if( _cadastrar ){
                                        _textoBotao = "Cadastrar";
                                      }
                                    });
                                  },
                                ),
                                Text("Cadastrar"),
                              ],
                            ),

                          ],
                        ),
                      ),
                    )
                  ],
                ),


                RaisedButton(

                  padding: EdgeInsets.fromLTRB(96, 16, 96, 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)
                  ),
                  color: Colors.teal,
                  child: Text(_textoBotao, style: TextStyle(color: Colors.white, fontSize: 24),),
                  onPressed: (){
                    _validarCampos();
                  },
                ),


                Padding(
                  padding: EdgeInsets.only(top: 20),

                  child: Text(_mensagemErro, style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red
                  ),),
                )
              ],),
          ),
        ),
      ),
    );
  }
}
