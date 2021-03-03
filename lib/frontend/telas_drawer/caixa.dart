import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comandas/backend/scopedModel/usuarioModel.dart';
import 'package:comandas/frontend/telasCaixa/pedidosCaixa.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class Caixa extends StatefulWidget {
  @override
  _CaixaState createState() => _CaixaState();
}

class _CaixaState extends State<Caixa> {
  @override
  Widget build(BuildContext context) {
   return ScopedModelDescendant<UsuarioModel>(
      builder: (context, child, model){
        return Scaffold(
          appBar: AppBar(
            title: Text('Caixa'),
          ),
          body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('restaurantes').doc(model.uid).collection('caixa').orderBy('data').snapshots(),
          builder: (context, snapshot){
             if(!snapshot.hasData){
              return Container();
            }else{           
              QuerySnapshot querySnapshot = snapshot.data;
              List<DocumentSnapshot> clientes = List();

              for(DocumentSnapshot documentSnapshot in querySnapshot.docs){
                clientes.add(documentSnapshot);
                print( 'cliente ' + documentSnapshot.data()['cliente']);
              }
                 
             return ListView.builder(
               itemCount: querySnapshot.docs.length,
               itemBuilder: (context, index){
                 return Padding(
                   padding: const EdgeInsets.all(1.0),
                   child: GestureDetector(
                     child: Card(                     
                       child: Row(
                         children: [
                           Expanded(
                              child: Padding(
                               padding: const EdgeInsets.all(16.0),
                               child: Text(querySnapshot.docs[index].data()['cliente'],
                                style: TextStyle(
                                  fontSize: 24
                                ),
                               ),
                             ),
                           ),
                          querySnapshot.docs[index].data()['origem'] == 'mesa' ?
                            Padding(
                               padding: const EdgeInsets.all(16.0),
                               child: Text('mesa ' + querySnapshot.docs[index].data()['mesa'].toString(),
                                style: TextStyle(
                                  fontSize: 24
                                ),
                               ),
                             )
                             : Container(),
                           querySnapshot.docs[index].data()['origem'] == 'balcao' ?
                            Padding(
                               padding: const EdgeInsets.all(16.0),
                               child: Text('Balcão',
                                style: TextStyle(
                                  fontSize: 24
                                ),
                               ),
                             )
                             : Container(),  
                         ],
                       ),
                     ),
                     onTap: (){
                       Navigator.of(context).push(MaterialPageRoute(builder: (context)=> PedidosCaixa( querySnapshot.docs[index].id, querySnapshot.docs[index].data()['cliente'], querySnapshot.docs[index].data()['mesa'], querySnapshot.docs[index].data()['origem'] )));
                     },
                   ),
                 );
                 }
              ); 
            } 
          },
         ),       
        );
      }
     );
  }
}