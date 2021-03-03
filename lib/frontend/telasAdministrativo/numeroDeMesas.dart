import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comandas/backend/scopedModel/usuarioModel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class NumeroDeMesas extends StatefulWidget {
  @override
  _NumeroDeMesasState createState() => _NumeroDeMesasState();
}

class _NumeroDeMesasState extends State<NumeroDeMesas> {

   final mesas = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UsuarioModel>(
     builder: (context, child, model){
      return Scaffold(
          appBar: AppBar(
            title: Text('Número de mesas'),
          ),
          body:StreamBuilder(
              stream: FirebaseFirestore.instance.collection('restaurantes').doc(model.uid).snapshots(),
              builder: (context, snapshot){
                if(!snapshot.hasData){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }else{
                  mesas.text = snapshot.data['mesas'].toString();
                  return Container(
                    padding: EdgeInsets.all(16.0),
                      child: TextField(
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        controller: mesas,               
                        decoration: InputDecoration(                   
                          labelText: 'numero de mesas',
                        ),
                        onSubmitted: (_){
                          model.alterarNumeroDeMesas(numero: int.parse(mesas.text), context: context);
                        },
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