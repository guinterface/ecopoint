import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecpoint/CadLog/Home.dart';
import 'package:ecpoint/CadLog/Novo.dart';
import 'package:ecpoint/Classes/Usuario.dart';
import 'package:ecpoint/Company/LoginEmpresa.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController _controllerEmail = TextEditingController(text: "");
  TextEditingController _controllerSenha = TextEditingController(text: "");

  bool _cadastrar = false;
  String _mensagemErro = "";
  String _textoBotao = "Entrar";

  _cadastrarUsuario(Usuario usuario){

    FirebaseAuth auth = FirebaseAuth.instance;
    Firestore db = Firestore.instance;

    auth.createUserWithEmailAndPassword(
        email: usuario.email,
        password: usuario.senha
    ).then((firebaseUser){
      usuario.idUsuario = firebaseUser.user.uid;
      db.collection("usuarios")
          .document( firebaseUser.user.uid )
          .setData( usuario.toMap() );
      //redireciona para tela principal
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Home()
          )
      );



    });

  }

  _logarUsuario(Usuario usuario){

    FirebaseAuth auth = FirebaseAuth.instance;

    auth.signInWithEmailAndPassword(
        email: usuario.email,
        password: usuario.senha
    ).then((firebaseUser){

      //redireciona para tela principal
      MaterialPageRoute(
          builder: (context) => Home()
      );

    });

  }

  _validarCampos() {

    //Recupera dados dos campos
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if (email.isNotEmpty && email.contains("@")) {
      if (senha.isNotEmpty && senha.length > 6) {

        //Configura usuario
        Usuario usuario = Usuario();
        usuario.email = email;
        usuario.senha = senha;

        //cadastrar ou logar
        if( _cadastrar ){
          //Cadastrar
          _cadastrarUsuario(usuario);
        }else{
          //Logar
          _logarUsuario(usuario);
        }

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

        padding: EdgeInsets.all(8),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 16),
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
                             Text("Bem vindo,", style: TextStyle(color: Colors.teal, fontSize: 22),),
                             Text("faça login ou cadastre-se", style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 24),),
                             Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
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


                 Padding(padding: EdgeInsets.only(top:6 )),
                GestureDetector(
                  child: Text("É empresa? Clique aqui!", style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold), ),


                 onTap: (){
                   Navigator.pushReplacement(
                       context,
                       MaterialPageRoute(
                           builder: (context) => LoginEmpresa()
                       )
                   );
                 },),

                 Text(_mensagemErro, style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red
                  ),),

              ],),
          ),
        ),
      ),
    );
  }
}
