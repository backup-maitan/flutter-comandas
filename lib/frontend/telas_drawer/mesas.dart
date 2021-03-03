import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comandas/backend/scopedModel/usuarioModel.dart';
import 'package:comandas/frontend/telasMesas/prontos.dart';
import 'package:comandas/frontend/widgets/mesa.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class Mesas extends StatefulWidget {
  @override
  _MesasState createState() => _MesasState();
}

class _MesasState extends State<Mesas> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UsuarioModel>(
        builder: (context, child, model){
          return Scaffold(
            appBar: AppBar(
              title: Text('Mesas'),
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
                                  if(documentSnapshot.data()['origem'] == 'mesa'){
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
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Prontos()));
                  },
                )
              ],
            ),
            body: StreamBuilder(
              stream:  FirebaseFirestore.instance.collection('restaurantes').doc(model.uid).collection('mesas').orderBy('mesa').snapshots(),
              builder: (context, snapshot){
                if(!snapshot.hasData){
                  return Container();
                }else{
                  QuerySnapshot querySnapshot = snapshot.data;
                  return GridView.count(
                    padding: EdgeInsets.all(8),
                    crossAxisCount: 3,
                    children: 
                    querySnapshot.docs.map((mesa) => Mesa(int.parse(mesa.id))).toList()
                  );
                }
              },
            ),
          );
        });
  }
}