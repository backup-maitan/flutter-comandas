import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comandas/backend/objetos/pedidoObjeto.dart';
import 'package:comandas/backend/scopedModel/usuarioModel.dart';
import 'package:comandas/frontend/telasMesas/cardapio.dart';
import 'package:comandas/frontend/widgets/cardPedido.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

// ignore: must_be_immutable
class Pedidos extends StatefulWidget {

  String cliente;
  int mesa;
  Pedidos(this.cliente, this.mesa);

  @override
  _PedidosState createState() => _PedidosState();
}

class _PedidosState extends State<Pedidos> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UsuarioModel>(
      builder: (context, child, model){
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.cliente + ' - mesa : ' + widget.mesa.toString()),
          ),
          body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('restaurantes').doc(model.uid).collection('pedidos').orderBy('data').snapshots(),
            builder: (context, snapshot){
              if(!snapshot.hasData){
                return Container();
              }else{
                QuerySnapshot querySnapshot = snapshot.data;
                List<PedidoObjeto> pedidosListaObjetos = List<PedidoObjeto>();
                for(DocumentSnapshot documentSnapshot in querySnapshot.docs){
                  if(documentSnapshot.data()['mesa'] == widget.mesa && documentSnapshot.data()['cliente'] == widget.cliente && documentSnapshot.data()['situacao'] != 'cancelado'){
                    PedidoObjeto pedidoObjeto = PedidoObjeto(
                      documentSnapshot.data()['cliente'],
                      documentSnapshot.data()['data'],
                      documentSnapshot.data()['detalhe'],
                      documentSnapshot.data()['local'],
                      documentSnapshot.data()['mesa'],
                      documentSnapshot.data()['observacao'],
                      documentSnapshot.data()['origem'],
                      documentSnapshot.data()['pedido'],
                      documentSnapshot.data()['quantidade'],
                      documentSnapshot.data()['situacao'],
                      documentSnapshot.data()['valor'],
                      documentSnapshot.id
                    );

                    pedidosListaObjetos.add(pedidoObjeto);
                  }                  
                }  
                                         
                if(pedidosListaObjetos.length > 0){
                  return ListView.builder(
                  itemCount: pedidosListaObjetos.length,
                  itemBuilder: (context, index){              
                    return CardPedido(
                      pedidoObjeto: pedidosListaObjetos[index],
                      context: context,
                      mostrarIcone: true,
                      corCard: Colors.white,
                      corLetra: Colors.black,
                      corLetraDestaque: Colors.grey,
                      icone: Icon(Icons.delete),
                      funcao: pedidosListaObjetos[index].local == 'cozinha' ?
                      (){
                         model.cancelarPedido(context: context, idPedido: pedidosListaObjetos[index].idPedido);
                      } : 
                      (){
                        model.deletarPedido(context: context, idPedido: pedidosListaObjetos[index].idPedido);
                      } 
                    );
                   }
                  );
                }else{
                  return Container();
                }
              }
            },
          ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
           Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Cardapio(widget.cliente, widget.mesa)));
          },
        ),
        );
      }
    );
  }
}                   