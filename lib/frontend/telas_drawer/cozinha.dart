import 'package:audioplayers/audio_cache.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comandas/backend/objetos/pedidoObjeto.dart';
import 'package:comandas/backend/scopedModel/usuarioModel.dart';
import 'package:comandas/frontend/widgets/cardPedido.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:audioplayers/audioplayers.dart';

class Cozinha extends StatefulWidget {
  @override
  _CozinhaState createState() => _CozinhaState();
}

class _CozinhaState extends State<Cozinha> {

  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache(prefix: "audios/");

  executar()async{
    audioPlayer = await audioCache.play("som.mp3");
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   return ScopedModelDescendant<UsuarioModel>(
      builder: (context, child, model){
        return Scaffold(
          appBar: AppBar(
            title: Text('Cozinha'),
          ),
          body: StreamBuilder(
            stream:  FirebaseFirestore.instance.collection('restaurantes').doc(model.uid).collection('pedidos').orderBy('data').snapshots(),
            builder: (context, snapshot){
              if(!snapshot.hasData){
                return Container();
              }else{
                executar();
                QuerySnapshot querySnapshot = snapshot.data;
                List<PedidoObjeto> pedidosListaObjetos = List<PedidoObjeto>();
                for(DocumentSnapshot documentSnapshot in querySnapshot.docs){
                  if(documentSnapshot.data()['local'] == 'cozinha'){
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
                    return 
                    pedidosListaObjetos[index].situacao == 'cancelado' ?
                      CardPedido(
                      pedidoObjeto: pedidosListaObjetos[index],
                      context: context,
                      mostrarIcone: true,
                      corCard: Colors.red,
                      corLetra: Colors.black,
                      corLetraDestaque: Colors.white,
                      icone: Icon(Icons.delete),
                      funcao: (){
                        model.deletarPedido(context: context, idPedido: pedidosListaObjetos[index].idPedido);
                      } 
                    ) :
                    pedidosListaObjetos[index].situacao == 'enviado' ?
                      CardPedido(
                        pedidoObjeto: pedidosListaObjetos[index],
                        context: context,
                        mostrarIcone: true,
                        corCard: Colors.white,
                        corLetra: Colors.black,
                        corLetraDestaque: Colors.grey,
                        icone: Icon(Icons.visibility),
                        funcao: (){
                           model.vistoCozinha(uidPedido: pedidosListaObjetos[index].idPedido);
                        } 
                    ) :
                    pedidosListaObjetos[index].situacao == 'em preparo' ?
                      CardPedido(
                        pedidoObjeto: pedidosListaObjetos[index],
                        context: context,
                        mostrarIcone: true,
                        corCard: Colors.yellow,
                        corLetra: Colors.black,
                        corLetraDestaque: Colors.blue,
                        icone: Icon(Icons.send),
                        funcao: (){
                           model.prontoCozinha(uidPedido: pedidosListaObjetos[index].idPedido);
                        } 
                    ) :

                      CardPedido(
                        pedidoObjeto: pedidosListaObjetos[index],
                        context: context,
                        mostrarIcone: false,
                        corCard: Colors.blue,
                        corLetra: Colors.black,
                        corLetraDestaque: Colors.white,
                        icone: Icon(Icons.send),
                        funcao: (){
                          
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