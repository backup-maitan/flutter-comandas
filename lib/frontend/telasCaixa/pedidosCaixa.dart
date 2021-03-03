import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comandas/backend/objetos/pedidoObjeto.dart';
import 'package:comandas/backend/scopedModel/usuarioModel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:comandas/frontend/widgets/cardPedido.dart';

// ignore: must_be_immutable
class PedidosCaixa extends StatefulWidget {

  String idCliente;
  String cliente;
  int mesa;
  String origem;
  PedidosCaixa(this.idCliente, this.cliente, this.mesa, this.origem);

  @override
  _PedidosCaixaState createState() => _PedidosCaixaState();
}

class _PedidosCaixaState extends State<PedidosCaixa> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UsuarioModel>(
      builder: (context, child, model){
        return Scaffold(
          appBar: AppBar(
            title: widget.origem == 'mesa' ?
                    Text(widget.cliente + ' - mesa : ' + widget.mesa.toString())
                    :
                    Text(widget.cliente + ' - Balcão')
          ),
          body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('restaurantes').doc(model.uid).collection('caixa').doc(widget.idCliente).collection('pedidos').orderBy('data').snapshots(),
            builder: (context, snapshot){
              if(!snapshot.hasData){
                return Container();
              }else{
                QuerySnapshot querySnapshot = snapshot.data;
                List<PedidoObjeto> pedidosListaObjetos = List<PedidoObjeto>();
                for(DocumentSnapshot documentSnapshot in querySnapshot.docs){
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
                      funcao: (){
                        model.deletarItemCaixa(idCliente: widget.idCliente, idPedido: pedidosListaObjetos[index].idPedido);
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
        floatingActionButton: FloatingActionButton.extended(       
          label: Text('Finalizar conta'),
          onPressed: (){
            model.fecharConta(idCliente: widget.idCliente, context: context);
          },
        ),
        );
      }
    );
  }
}