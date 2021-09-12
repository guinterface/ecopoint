import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecpoint/CadLog/Novo.dart';
import 'package:ecpoint/Classes/ItemProposta.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';




class CriarAnuncio extends StatefulWidget {
  @override
  _CriarAnuncioState createState() => _CriarAnuncioState();
}

class _CriarAnuncioState extends State<CriarAnuncio> {


  final _controller = StreamController<QuerySnapshot>.broadcast();
  Firestore db = Firestore.instance;





  _adicionarListenerRequisicoes()async{
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();
    String idUsuarioLogado = usuarioLogado.uid;
    final stream = db.collection("meus_anuncios")
        .document( idUsuarioLogado )
        .collection("anuncios")
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
        "Você não criou nenhum desafio ",
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
                                  child: Text("seus desafios", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
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

                                      String fotoAnuncio = "";
                                      String local = item["local"];
                                      _removerAnuncio(String idAnuncio)async{
                                        FirebaseAuth auth = FirebaseAuth.instance;
                                        FirebaseUser usuarioLogado = await auth.currentUser();
                                        String idUsuarioLogado = usuarioLogado.uid;

                                        Firestore db = Firestore.instance;
                                        db.collection("meus_anuncios")
                                            .document( idUsuarioLogado )
                                            .collection("anuncios")
                                            .document( idAnuncio )
                                            .delete().then((_){

                                          db.collection("anuncios")
                                              .document(idAnuncio)
                                              .delete();

                                        });

                                      }




                                      return ItemProposta(

                                        premio: bonus, titulo: titulo, onTapItem: () { },      onPressedRemover: (){
                                        showDialog(
                                            context: context,
                                            builder: (context){
                                              return AlertDialog(
                                                title: Text("Confirmar"),
                                                content: Text("Deseja realmente excluir o anúncio?"),
                                                actions: <Widget>[

                                                  FlatButton(
                                                    child: Text(
                                                      "Cancelar",
                                                      style: TextStyle(
                                                          color: Colors.white
                                                      ),
                                                    ),
                                                    onPressed: (){
                                                      Navigator.of(context).pop();
                                                    },
                                                  ),

                                                  FlatButton(
                                                    color: Colors.red,
                                                    child: Text(
                                                      "Remover",
                                                      style: TextStyle(
                                                          color: Colors.grey
                                                      ),
                                                    ),
                                                    onPressed: (){
                                                      _removerAnuncio( id );
                                                      Navigator.of(context).pop();
                                                    },
                                                  ),


                                                ],
                                              );
                                            }
                                        );
                                      },

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
        ),



    );
  }
}
