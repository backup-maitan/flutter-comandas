import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comandas/backend/objetos/pedidoObjeto.dart';
import 'package:comandas/backend/scopedModel/usuarioModel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:comandas/frontend/widgets/cardPedido.dart';

class ProntosBalcao extends StatefulWidget {
  @override
  _ProntosBalcaoState createState() => _ProntosBalcaoState();
}

class _ProntosBalcaoState extends State<ProntosBalcao> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UsuarioModel>(
      builder: (context, child, model){
        return Scaffold(
          appBar: AppBar(
            title: Text('Aguardando entrega'),
          ),
          body: StreamBuilder(
            stream:  FirebaseFirestore.instance.collection('restaurantes').doc(model.uid).collection('pedidos').orderBy('data').snapshots(),
            builder: (context, snapshot){
              if(!snapshot.hasData){
                return Container();
              }else{
                QuerySnapshot querySnapshot = snapshot.data;
                List<PedidoObjeto> pedidosListaObjetos = List<PedidoObjeto>();
                List<DocumentSnapshot> pedidos = List();
                for(DocumentSnapshot documentSnapshot in querySnapshot.docs){
                 if(documentSnapshot.data()['origem'] == 'balcao'){
                    if((documentSnapshot.data()['local'] == 'cozinha' && documentSnapshot.data()['situacao'] == 'pronto') || (documentSnapshot.data()['local'] == 'cozinha' && (documentSnapshot.data()['situacao'] == 'indo buscar'))){
                    pedidos.add(documentSnapshot);
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
                }                            
                if(pedidosListaObjetos.length > 0){
                  return ListView.builder(
                  itemCount: pedidosListaObjetos.length,
                  itemBuilder: (context, index){
                    return pedidosListaObjetos[index].situacao== 'indo buscar' ? 
                     CardPedido(
                      pedidoObjeto: pedidosListaObjetos[index],
                      context: context,
                      mostrarIcone: true,
                      corCard: Colors.yellow,
                      corLetra: Colors.black,
                      corLetraDestaque: Colors.blue,
                      icone: Icon(Icons.send),
                      funcao: (){
                         model.entregue(uidPedido: pedidosListaObjetos[index].idPedido, origem: pedidosListaObjetos[index].origem);
                      } 
                    ) :

                    CardPedido(
                      pedidoObjeto: pedidosListaObjetos[index],
                      context: context,
                      mostrarIcone: true,
                      corCard: Colors.white,
                      corLetra: Colors.black,
                      corLetraDestaque: Colors.grey,
                      icone: Icon(Icons.visibility),
                      funcao: (){
                         model.vistoMesas(uidPedido: pedidosListaObjetos[index].idPedido);
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
        );
      }
    );
  }
}