import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comandas/backend/scopedModel/usuarioModel.dart';
import 'package:comandas/frontend/telas_drawer/ajuda.dart';
import 'package:comandas/frontend/telas_drawer/balcao.dart';
import 'package:comandas/frontend/telas_drawer/caixa.dart';
import 'package:comandas/frontend/telas_drawer/cozinha.dart';
import 'package:comandas/frontend/telas_drawer/mesas.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ItensDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UsuarioModel>(
      builder: (context, child, model){
        return Container(
      width: MediaQuery.of(context).size.width * 0.80,
      child: Drawer(        
        child: Column(
          children: [
            Expanded(
            child: ListView(
                children: [
                    DrawerHeader(
                          child: Container(
                            height: 250.0,
                            child: Container(
                              child: StreamBuilder(
                            stream: FirebaseFirestore.instance.collection('restaurantes').doc(model.uid).snapshots(),
                            builder: (context, snapshot){
                              if(!snapshot.hasData){
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }else{
                                return  Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 16.0),
                                            child: Text(snapshot.data['nome'],
                                              style: TextStyle(
                                                fontSize: 18
                                              ),
                                            ),
                                          ),                                       
                                        ],
                                      );
                              }
                            }),
                            ),
                          )                  
                        ),                                     
                    ListTile(
                      title: Text('Mesas',
                        style: TextStyle(
                          
                        ),
                      ),
                       onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Mesas()));
                    },
                    ),
                    ListTile(
                      title: Text('Balcão',
                        style: TextStyle(
                          
                        ),
                      ),
                       onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Balcao()));
                    },
                    ),
                    ListTile(
                      title: Text('Cozinha',
                        style: TextStyle(
                          
                        ),
                      ),                   
                        onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Cozinha()));
                    },
                    ),
                    ListTile(
                      title: Text('Caixa',
                        style: TextStyle(
                         
                        ),
                      ),
                       onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Caixa()));
                    },
                    ),
                    Divider(
                      color: Colors.grey[210],
                    ),                  
                    ListTile(
                      title: Text('Ajuda',
                        style: TextStyle(
                         
                        ),
                      ),
                       onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Ajuda()));
                    },
                    ),                   
                    ListTile(
                      title: Text('Sair',
                        style: TextStyle(
                         
                        ),
                      ),
                       onTap: (){
                      model.logoutUsuario(context: context);
                    },
                    )
                ],
            ))
          ],
        ),
      ),
    );
   }
  );
 }
}