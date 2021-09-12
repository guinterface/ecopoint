import 'package:ecpoint/CadLog/CriarProposta.dart';
import 'package:ecpoint/CadLog/Desafios.dart';
import 'package:ecpoint/CadLog/Login.dart';
import 'package:ecpoint/CadLog/Novo.dart';
import 'package:ecpoint/Company/CriarAnuncio.dart';
import 'package:ecpoint/Company/DesafiosCOmpletos.dart';
import 'package:ecpoint/Company/Vido.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Home2 extends StatefulWidget {
  @override
  _Home2State createState() => _Home2State();
}

class _Home2State extends State<Home2> with SingleTickerProviderStateMixin {

  late TabController _tabController;

  String _emailUsuario= "";

  Future _recuperarDadosUsuario() async {

    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();

    setState(() {
      _emailUsuario = usuarioLogado.email;
    });

  }

  @override
  void initState() {
    super.initState();

    _recuperarDadosUsuario();

    _tabController = TabController(
        length: 4,
        vsync: this
    );

  }
  List<String> itensMenu = [
    "Configurações", "Deslogar"
  ];
  _escolhaMenuItem( String escolha ){

    switch( escolha ){
      case "Deslogar" :
        _deslogarUsuario();
        break;
      case "Configurações" :

        break;
    }

  }_deslogarUsuario() async {

    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.signOut();
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => Login()
    ));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EcoPoint"),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: _escolhaMenuItem,
            itemBuilder: (context){

              return itensMenu.map((String item){

                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );

              }).toList();

            },
          )
        ],
        bottom: TabBar(
          indicatorWeight: 4,
          labelStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
          ),
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: <Widget>[
            Tab(text: "Home",),
            Tab(text: "Criados",),
            Tab(text: "Completos",),
            Tab(text: "Criar",)

          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Vido(),
          CriarAnuncio(),
          DesafiosCompletos(),
          NovoAnuncio2()
        ],
      ),
    );
  }
}
