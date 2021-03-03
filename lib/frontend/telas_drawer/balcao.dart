import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comandas/backend/scopedModel/usuarioModel.dart';
import 'package:comandas/frontend/telasBalcao/pedidosBalcao.dart';
import 'package:comandas/frontend/telasBalcao/prontosBalcao.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class Balcao extends StatefulWidget {
  @override
  _BalcaoState createState() => _BalcaoState();
}

class _BalcaoState extends State<Balcao> {

  List<dynamic> clientes;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UsuarioModel>(
      builder: (context, child, model){
        return Scaffold(
          appBar: AppBar(
              title: Text('Balcão'),
              actions: [
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                    child: Row(
                      children: [
                        Text('Prontos : '),
                        StreamBuilder(
                          stream:  FirebaseFirestore.instance.collection('restaurantes').doc(model.uid).collection('pedidos').orderBy('data').snapshots(),
                          builder: (context, snapshot){
                            if(!snapshot.hasData){
                              return CircleAvatar(
                                backgroundColor: Colors.black26,
                                 child: Text('0',
                                  style: TextStyle(                                 
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              );
                            }else{
                              QuerySnapshot querySnapshot = snapshot.data;
                               List<DocumentSnapshot> pedidos = List();
                                for(DocumentSnapshot documentSnapshot in querySnapshot.docs){
                                  if(documentSnapshot.data()['origem'] == 'balcao'){
                                    if((documentSnapshot.data()['local'] == 'cozinha' && documentSnapshot.data()['situacao'] == 'pronto') || (documentSnapshot.data()['local'] == 'cozinha' && (documentSnapshot.data()['situacao'] == 'indo buscar'))){
                                    pedidos.add(documentSnapshot);
                                  }
                                  }
                                }  
                              return CircleAvatar(
                                backgroundColor: Colors.black26,
                                 child: Text(pedidos.length.toString(),
                                  style: TextStyle(                                 
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ProntosBalcao()));
                  },
                )
              ],
            ),
          body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('restaurantes').doc(model.uid).collection('balcao').doc('balcao').snapshots(),
          builder: (context, snapshot){
             if(!snapshot.hasData){
              return Container();
            }else{           
              clientes = snapshot.data['clientes'];    
             return ListView.builder(
               itemCount: clientes.length,
               itemBuilder: (context, index){
                 return Padding(
                   padding: const EdgeInsets.all(4.0),
                   child: GestureDetector(
                     child: Card(                   
                       child: Row(
                         children: [
                           Expanded(
                              child: Padding(
                               padding: const EdgeInsets.all(16.0),
                               child: Text(clientes[index],
                                style: TextStyle(
                                  fontSize: 24
                                ),
                               ),
                             ),
                           ),
                           IconButton(
                             icon: Icon(Icons.delete),
                             onPressed: (){
                               model.deletarClienteBalcao(cliente: clientes[index], context: context, clientes: clientes);
                             }
                              )
                         ],
                       ),              
                     ),
                     onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> PedidosBalcao(clientes[index])));
                     },
                     onDoubleTap: (){
                       model.fecharContaBalcao(context: context, cliente: clientes[index], clientes: clientes);
                     },
                   ),
                 );
                 }
               );    
             }            
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
            model.inserirNomeClienteBalcao(context: context, clientes: clientes, globalKey: globalKey);
          },
        ),
        );
      }
     );
  }
}