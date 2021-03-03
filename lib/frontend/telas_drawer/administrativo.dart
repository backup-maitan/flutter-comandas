import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comandas/backend/scopedModel/usuarioModel.dart';
import 'package:comandas/frontend/telasAdministrativo/alterarCardapio.dart';
import 'package:comandas/frontend/telasAdministrativo/alterarCategorias.dart';
import 'package:comandas/frontend/telasAdministrativo/numeroDeMesas.dart';
import 'package:comandas/frontend/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class Administrativo extends StatefulWidget {
  @override
  _AdministrativoState createState() => _AdministrativoState();
}

class _AdministrativoState extends State<Administrativo> {
  @override
  Widget build(BuildContext context) {
     return ScopedModelDescendant<UsuarioModel>(
       builder: (context, child, model){
         return Scaffold(
          appBar: AppBar(
            title: Text('Administrativo'),
          ),
          drawer: ItensDrawer(),
          body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('restaurantes').doc(model.uid).collection('categoria').doc('categoria').snapshots(),
            builder: (context, snapshot){
            if(!snapshot.hasData){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
              }else{
                List<dynamic> categorias = snapshot.data['categorias'];
                return Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context)=> NumeroDeMesas())
                          );
                        },
                        child: Card(
                        child: Padding(padding: EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Text('Numero de mesas',
                                style: TextStyle(
                                  fontSize: 18
                                ),
                              ),
                            ],
                          ),
                        ),
                          ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context)=> AlterarCategoria())
                          );
                        },
                        child: Card(
                          child: Padding(padding: EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Text('categorias do cardapio',
                                  style: TextStyle(
                                  fontSize: 18
                                ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context)=> AlterarCardapio(categorias))
                          );
                        },
                        child: Card(
                          child: Padding(padding: EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Text('itens do cardapio',
                                  style: TextStyle(
                                  fontSize: 18
                                ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),                     
                    ],
                  ),
                );
              }
          })
        );
     });
  }
}