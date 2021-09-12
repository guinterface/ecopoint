import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'GeralAnuncio.dart';



class PainelSecundario extends StatefulWidget {
  @override
  _PainelSecundarioState createState() => _PainelSecundarioState();
}

class _PainelSecundarioState extends State<PainelSecundario> {


  final _controller = StreamController<QuerySnapshot>.broadcast();
  Firestore db = Firestore.instance;





  _adicionarListenerRequisicoes(){

    final stream = db.collection("anuncios")
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
          Text("Carregando requisições"),
          CircularProgressIndicator()
        ],
      ),
    );

    var mensagemNaoTemDados = Center(
      child: Text(
        "Não há nenhum desafio disponível ",
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
                                    child: Text("desafios atuais", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
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
                                        String r1 = item["item1"];
                                        String r2 = item["item2"];
                                        String r3 = item["item3"];
                                        String bonus = item["premio"];
                                        String id = item["id"];
                                        String status = item["status"];

                                        String fotoAnuncio = item["foto"];
                                        String local = item["local"];




                                        return GestureDetector(

                                            onTap: (){

                                              Navigator.push(context, MaterialPageRoute(
                                                  builder: (context) => GeralAnuncio(titulo, r1, r2,r3, local, bonus, fotoAnuncio,id, status )
                                              ));
                                            },
                                            child: Card(
                                                color: Colors.white,
                                                child: Padding(
                                                  padding: EdgeInsets.all(12),
                                                  child:
                                                  Column(

                                                    children: [


                                                      Row(children: [
                                                        CircleAvatar(
                                                            radius: 50,
                                                            backgroundColor: Colors.white70,
                                                            backgroundImage:
                                                            fotoAnuncio!= null
                                                                ? NetworkImage(fotoAnuncio)
                                                                : null
                                                        ),

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
                                                          Text("Primeiro Item: $r1 ", style: TextStyle(fontWeight: FontWeight.bold),),
                                                          Text("Segundo Item: $r2 ",style: TextStyle(fontWeight: FontWeight.bold),),
                                                          Text("Terceiro Item: $r3 ",style: TextStyle(fontWeight: FontWeight.bold),),
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
