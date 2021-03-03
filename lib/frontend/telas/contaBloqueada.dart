import 'package:comandas/backend/scopedModel/usuarioModel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ContaBloqueada extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UsuarioModel>(
      builder: (context, child, model){
        return Scaffold(
          body: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Conta bloqueada',
                    style: TextStyle(
                      fontSize: 24
                    ),
                  ),
                RaisedButton(
                  child: Text('sair',
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                  onPressed: (){
                    model.logoutUsuario(context: context);
                  }
                )
              ],
            ),
          ),
        );
    });
  }
}