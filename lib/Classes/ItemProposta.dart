import 'package:ecpoint/Classes/Proposta.dart';
import 'package:flutter/material.dart';


class ItemProposta extends StatelessWidget {

  VoidCallback onTapItem;
  VoidCallback onPressedRemover;
  String titulo;
  String premio;

  ItemProposta({
    required this.titulo,
    required this.premio,
    required this.onTapItem,
    required this.onPressedRemover
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTapItem,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(children: <Widget>[


            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      titulo,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      "Premio: $premio",
                      style: TextStyle(
                          fontSize: 16,

                      ),
                    ),


                  ],),
              ),
            ),
            if( this.onPressedRemover != null ) Expanded(
              flex: 1,
              child: FlatButton(
                color: Colors.red,
                padding: EdgeInsets.all(10),
                onPressed: this.onPressedRemover,
                child: Icon(Icons.delete, color: Colors.white,),
              ),
            )
            //botao remover

          ],),
        ),
      ),
    );
  }
}
