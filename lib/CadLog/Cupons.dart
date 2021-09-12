import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'GeralAnuncio.dart';



class Cupons extends StatefulWidget {
  @override
  _CuponsState createState() => _CuponsState();
}

class _CuponsState extends State<Cupons> {


  final _controller = StreamController<QuerySnapshot>.broadcast();
  Firestore db = Firestore.instance;





  _adicionarListenerRequisicoes()async{
    Firestore db = Firestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();
    String _idUsuarioLogado = usuarioLogado.uid;

    final stream = db.collection("meus_cupons")
        .document( _idUsuarioLogado )
        .collection("cupons")
        .snapshots();

    stream.listen((dados){
      _controller.add( dados );
    });



  }

  @override
  void initState() {
    super.initState();

    //adiciona listener para recuperar requisições
    _adicionarListenerRequisicoes();

  }

  @override
  Widget build(BuildContext context) {

    var mensagemCarregando = Center(
      child: Column(
        children: <Widget>[
          Text("Carregando cupons"),
          CircularProgressIndicator()
        ],
      ),
    );

    var mensagemNaoTemDados = Center(
      child: Text(
        "Não há nenhum cupom disponível ",
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold
        ),
      ),
    );

    return Scaffold(


        body:
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("Imagens/bck1.png"), fit: BoxFit.cover),
          ),
          child: Expanded(
            child:  StreamBuilder<QuerySnapshot>(


                stream: _controller.stream,
                builder: (context, snapshot){
                  switch( snapshot.connectionState ){
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return mensagemCarregando;
                      break;
                    case ConnectionState.active:
                    case ConnectionState.done:

                      if( snapshot.hasError ){
                        return Text("Erro ao carregar os dados!");
                      }else {

                        QuerySnapshot? querySnapshot = snapshot.data;
                        if( querySnapshot!.documents.length == 0 ){
                          return mensagemNaoTemDados;
                        }else{

                          return
                            Column(

                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(padding: EdgeInsets.only(top: 20, left: 10),
                                  child:Text("Aqui estão os", style: TextStyle(fontSize: 18),),
                                ),
                                Padding(padding: EdgeInsets.only(top: 0, left: 10),
                                  child: Text("cupons disponíveis", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
                                ),


                                Flexible(child:
                                ListView.separated(

                                    itemCount: querySnapshot.documents.length,
                                    separatorBuilder: (context, indice) => Divider(
                                      height: 2,

                                      color: Colors.grey,
                                    ),
                                    itemBuilder: (context, indice){

                                      List<DocumentSnapshot> requisicoes = querySnapshot.documents.toList();
                                      DocumentSnapshot item = requisicoes[ indice ];

                                      String titulo = item["titulo"];
                                      String bonus = item["premio"];





                                      return GestureDetector(

                                          onTap: (){
                                          },
                                          child: Card(
                                              color: Colors.white,
                                              child: Padding(
                                                padding: EdgeInsets.all(12),
                                                child:
                                                Column(

                                                  children: [


                                                    Row(children: [


                                                      Padding(padding: EdgeInsets.only(left: 32, right: 32, ), child:

                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [


                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [Text(
                                                              titulo,
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  color: Colors.white,
                                                                  fontWeight: FontWeight.bold
                                                              ),
                                                            )

                                                              ,
                                                              Icon(Icons.arrow_forward, color: Colors.white,)],),
                                                          Text(titulo,style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal), ),
                                                          Text("Prêmio: $bonus ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),),
                                                        ],)

                                                      ),],


                                                    )
                                                    ,


                                                  ],

                                                )
                                                ,

                                              )
                                          )
                                      );

                                    }
                                )
                                )
                              ],
                            );


                        }

                      }

                      break;
                  }
                }
            ),
          ),
        )


    );
  }
}
