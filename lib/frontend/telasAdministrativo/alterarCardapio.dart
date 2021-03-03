import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comandas/backend/scopedModel/usuarioModel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'novoItemCardapio.dart';

// ignore: must_be_immutable
class AlterarCardapio extends StatefulWidget {

  List<dynamic> categorias;
  AlterarCardapio(this.categorias);

  @override
  _AlterarCardapioState createState() => _AlterarCardapioState();
}

class _AlterarCardapioState extends State<AlterarCardapio> {
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
                 child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('restaurantes').doc(model.uid).collection('categoria').doc('categoria').snapshots(),
                  builder: (context, snapshot){
                    if(!snapshot.hasData){
                      return Container();
                    }else{
                      List<dynamic> categorias = List();
                      categorias = snapshot.data['categorias'];
                      return Column(
                            children: categorias.map(
                              (e) => Column(
                                children: [
                                  Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(e.toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              StreamBuilder(                           
                                stream: FirebaseFirestore.instance.collection('restaurantes').doc(model.uid).collection('cardapio').orderBy('nome').snapshots(),                       
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
                                              children: cardapio.map((c) => 
                                                Card(
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
                                                   IconButton(
                                                      icon: Icon(Icons.delete),
                                                      onPressed: (){
                                                        model.deletarItemCardapio(context: context, idItem: c.id);
                                                      }
                                                    )
                                                 ],
                                               ),
                                              ),
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
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: (){
               Navigator.of(context).push(
                  MaterialPageRoute(builder: (context)=> NovoItemCardapio(widget.categorias))
                );
            },
          ),
        );
      }
    );
  }
}