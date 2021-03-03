import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comandas/backend/scopedModel/usuarioModel.dart';
import 'package:comandas/frontend/telasMesas/detalheMesa.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

// ignore: must_be_immutable
class Mesa extends StatefulWidget {

  int mesa;
  Mesa(this.mesa);

  @override
  _MesaState createState() => _MesaState();
}

class _MesaState extends State<Mesa> {
  @override
  Widget build(BuildContext context) {
     return ScopedModelDescendant<UsuarioModel>(
      builder: (context, child, model){
        return StreamBuilder(
          stream: FirebaseFirestore.instance.collection('restaurantes').doc(model.uid).collection('mesas').doc(widget.mesa.toString()).snapshots(),
          builder: (context, snapshot){
             if(!snapshot.hasData){
              return Container();
            }else{
              String situacao = snapshot.data['situacao'];    
             return GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: CircleAvatar(
                    backgroundColor: situacao == 'ocupada' ? Color.fromRGBO(153, 0, 0, 1) : Color.fromRGBO(0, 102, 0, 1),
                    radius: 15,
                    child: Text(widget.mesa.toString(),
                      style: TextStyle(
                        fontSize: 30
                      ),
                    ),
                  ),
                ),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> DetalheMesa(widget.mesa)));
                },
                onDoubleTap: (){
                  model.fecharMesa(context: context, mesa: widget.mesa);
                },
               );
              }            
          },
        );
      }
     );
  }
}