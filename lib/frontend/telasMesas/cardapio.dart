import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comandas/backend/scopedModel/usuarioModel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

// ignore: must_be_immutable
class Cardapio extends StatefulWidget {

  String cliente;
  int mesa;
  Cardapio(this.cliente, this.mesa);

  @override
  _CardapioState createState() => _CardapioState();
}

class _CardapioState extends State<Cardapio> {

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UsuarioModel>(
      builder: (context, child, model){      
        return Scaffold(
          appBar: AppBar(
            title: Text('Cardapio'),
          ),
          body: Container(
            child: SingleChildScrollView(
               child: Container(
                 child: FutureBuilder(
                  future: FirebaseFirestore.instance.collection('restaurantes').doc(model.uid).collection('categoria').doc('categoria').get(),
                  builder: (context, snapshot){
                    if(!snapshot.hasData){
                      return Container();
                    }else{
                      List<dynamic> categorias = List();
                      categorias = snapshot.data['categorias'];
                      return Column(
                       children: categorias.map((e) => Column(
                           children: [
                             Padding(
                               padding: const EdgeInsets.all(16.0),
                               child: Text(e.toString(),
                                 style: TextStyle(
                                   fontSize: 18,
                                 ),
                               ),
                             ),
                             FutureBuilder(                           
                               future: FirebaseFirestore.instance.collection('restaurantes').doc(model.uid).collection('cardapio').get(),                       
                               builder: (context, snapshot){
                                 if(!snapshot.hasData){
                                   return Container();
                                 }else{
                                     QuerySnapshot querySnapshot = snapshot.data;
                                     List<DocumentSnapshot> cardapio = List();
                                     for(DocumentSnapshot documentSnapshot in querySnapshot.docs){
                                       if(documentSnapshot.data()['categoria'] == e.toString()){                                
                                         cardapio.add(documentSnapshot);
                                       }                  
                                     } 
                                   return Column(
                                     children: cardapio.map((c) => GestureDetector(
                                              child: Card(
                                                child: Padding(
                                                 padding: const EdgeInsets.all(16.0),
                                                 child: Row(
                                                   children: [
                                                     Expanded(
                                                        child: Column(
                                                         crossAxisAlignment: CrossAxisAlignment.start,
                                                         children: [
                                                           Text(c['nome'].toString(),
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                             ),
                                                            ),
                                                           SizedBox(
                                                             height: 8,
                                                           ),
                                                           Text(c['detalhe'].toString(),
                                                             style: TextStyle(
                                                               fontSize: 13,
                                                             ),
                                                           ),
                                                           SizedBox(
                                                             height: 8,
                                                           ),
                                                           Text('R\$ ' + c['valor'].toString(),
                                                             style: TextStyle(
                                                               fontSize: 14
                                                             ),
                                                           ),
                                                         ],
                                                       ),
                                                     ),
                                                   ],
                                                 ),
                                             ),
                                             ),
                                             onTap: (){
                                               model.inserirDetalhePedido(context: context , cliente: widget.cliente, mesa: widget.mesa, pedido: c['nome'], detalhe: c['detalhe'], valor: c['valor'], globalKey: globalKey);
                                             },
                                           )
                                         ).toList(),
                                   );
                                 }
                               }
                               )
                           ],
                         )
                         ).toList(),
                        );
                      
                    }
                  }
              ),
               ),
            ),
          )
        );
      } 
    );
  }
}