import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comandas/backend/scopedModel/usuarioModel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class NovaCategoria extends StatefulWidget {
  @override
  _NovaCategoriaState createState() => _NovaCategoriaState();
}

class _NovaCategoriaState extends State<NovaCategoria> {

  final categoria = TextEditingController();
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UsuarioModel>(
     builder: (context, child, model){
       return Scaffold(
          appBar: AppBar(
            title: Text('Nova categoria'),
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
                return Form(
                  key: _globalKey,
                  child: Container(
                  padding: EdgeInsets.all(16.0),
                    child: TextFormField(
                      autofocus: true,
                      keyboardType: TextInputType.text,
                      controller: categoria,               
                      decoration: InputDecoration(                   
                        labelText: 'categoria',
                      ),
                      validator: (value){
                        if(value.isEmpty){
                          return 'insira o nome da categoria';
                        }
                      },
                      onFieldSubmitted: (_){
                        if(_globalKey.currentState.validate()){
                          model.novaCategoria(context: context, categorias: categorias, categoria: categoria.text);
                        }
                      },
                    ),
                  ),
                );
              }
            }
          )
        );
       },
    );
  }
}