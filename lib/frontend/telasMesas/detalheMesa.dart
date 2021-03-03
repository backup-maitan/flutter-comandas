import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comandas/backend/scopedModel/usuarioModel.dart';
import 'package:comandas/frontend/telasMesas/pedidos.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

// ignore: must_be_immutable
class DetalheMesa extends StatefulWidget {

  int mesa;
  DetalheMesa(this.mesa);

  @override
  _DetalheMesaState createState() => _DetalheMesaState();
}

class _DetalheMesaState extends State<DetalheMesa> {

  List<dynamic> clientes;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UsuarioModel>(
      builder: (context, child, model){
        return Scaffold(
          appBar: AppBar(
            title: Text('Mesa ' + widget.mesa.toString()),
          ),
          body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('restaurantes').doc(model.uid).collection('mesas').doc(widget.mesa.toString()).snapshots(),
          builder: (context, snapshot){
             if(!snapshot.hasData){
              return Container();
            }else{           
              clientes = snapshot.data['clientes'];    
             return ListView.builder(
               itemCount: clientes.length,
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
                               model.deletarCliente(mesa: widget.mesa, cliente: clientes[index], context: context, clientes: clientes);
                             }
                              )
                         ],
                       ),
                     ),
                     onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Pedidos(clientes[index], widget.mesa)));
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
            model.inserirNomeCliente(context: context, mesa: widget.mesa, clientes: clientes, globalKey: globalKey);
          },
        ),
        );
      }
     );
  }
}