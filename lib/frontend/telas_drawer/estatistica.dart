import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comandas/backend/scopedModel/usuarioModel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class Estatistica extends StatefulWidget {
  @override
  _EstatisticaState createState() => _EstatisticaState();
}

class _EstatisticaState extends State<Estatistica> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UsuarioModel>(
      builder: (context, child, model){
        return Scaffold(
          appBar: AppBar(
            title: Text('Estatisticas'),
          ),
          body: Container(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('restaurantes').doc(model.uid).collection('cardapio').snapshots(),
              builder: (context, snapshot){
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                     );                   
                    break;
                  default:
                    if(!snapshot.hasData){
                      return Center(
                        child: Text('Não existe estatistica'),
                      );
                      }else{
                        QuerySnapshot cardapio = snapshot.data;                       
                        return ListView.builder(
                        itemCount: cardapio.docs.length,
                        itemBuilder: (context, index){
                          String nomePedido = cardapio.docs[index].data()['nome'];
                          double valorPedido = cardapio.docs[index].data()['valor'];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(cardapio.docs[index].data()['nome'],
                                  style: TextStyle(
                                    fontSize: 18
                                  ),
                                ),
                                StreamBuilder(
                                  stream: FirebaseFirestore.instance.collection('restaurantes').doc(model.uid).collection('estatistica').snapshots(),
                                  builder: (context, snapshot){
                                    switch (snapshot.connectionState) {
                                      case ConnectionState.none:
                                      case ConnectionState.waiting:
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );                   
                                        break;
                                      default:
                                        if(!snapshot.hasData){
                                          print('não existe dados');                                        
                                          return Text(' 0');                                          
                                          }else{
                                            print('existe dados');
                                            QuerySnapshot estatistica = snapshot.data;
                                            int pedidos = 0;
                                            double media = 0;
                                            double valorTotal =0;
                                            for(DocumentSnapshot documentSnapshot in estatistica.docs){


                                              for(Map pedido in documentSnapshot.data()['pedidos']){
                                                print(pedido.keys);
                                                 if(pedido.keys.contains(nomePedido)){
                                                   print('somado + 1');
                                                   pedidos = pedidos + pedido[nomePedido];
                                                   media = pedidos / estatistica.docs.length;
                                                   valorTotal = pedidos * valorPedido;
                                               }
                                              }                                            
                                            }
                                            return Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(' total de pedidos: ' + pedidos.toString(),
                                                      style: TextStyle(
                                                        fontSize: 14
                                                  ),
                                                ),
                                                Text(' media de pedidos por dia: ' + media.toStringAsFixed(1),
                                                      style: TextStyle(
                                                        fontSize: 14
                                                  ),
                                                ),
                                                Text(' rentabilidade total R\$: ' + valorTotal.toStringAsFixed(2),
                                                      style: TextStyle(
                                                        fontSize: 14
                                                  ),
                                                ),


                                               


                                            ],
                                          ),
                                        );
                                      }
                                    }
                                  }
                                ),

                              ],
                            ),
                          );
                        }
                    );
                  }
                }
              }
            ),
          ),
        );
      }
    );
  }
}