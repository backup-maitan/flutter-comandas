import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comandas/backend/scopedModel/usuarioModel.dart';
import 'package:comandas/frontend/telasAdministrativo/novaCategoria.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class AlterarCategoria extends StatefulWidget {
  @override
  _AlterarCategoriaState createState() => _AlterarCategoriaState();
}

class _AlterarCategoriaState extends State<AlterarCategoria> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UsuarioModel>(
      builder: (context, child, model){
        return Scaffold(
          appBar: AppBar(
            title: Text('Categorias'),
          ),
          body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('restaurantes').doc(model.uid).collection('categoria').doc('categoria').snapshots(),
            builder: (context, snapshot){
              if(!snapshot.hasData){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }else{
               List<dynamic> categorias = snapshot.data['categorias'];
                return ListView.builder(
                  itemCount: categorias.length,
                  itemBuilder: (context, index){
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(categorias[index],
                                style: TextStyle(
                                  fontSize: 18
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: (){
                                model.deletarCategoria(context: context, categorias: categorias, categoria: categorias[index]);
                              }
                            )
                          ],
                        ),
                      ),
                    );
                  }
                
                );
              }
            }
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: (){
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context)=> NovaCategoria())
                );
            },
          ),
        );
      }
    );
  }
}