import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comandas/backend/scopedModel/usuarioModel.dart';
import 'package:comandas/frontend/telas/contaBloqueada.dart';
import 'package:comandas/frontend/telas_drawer/administrativo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'frontend/telas/login.dart';

void main() {
  runApp(
    ScopedModel<UsuarioModel>(
        model: UsuarioModel(),
        child: MaterialApp(
          theme: ThemeData(
            primaryColor: Color.fromRGBO(153, 0, 0, 1),
            buttonColor: Color.fromRGBO(153, 0, 0, 1)
          ),
          debugShowCheckedModeBanner: false,
          title: 'Comandas',
          home: MyApp(),
        )
      )
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Future<FirebaseApp> _firebaseApp =  Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
   return ScopedModelDescendant<UsuarioModel>(
     builder: (context, child, model){
       return FutureBuilder(
          future: _firebaseApp,
          builder: (context, snapshot){
            switch(snapshot.connectionState){
              case ConnectionState.none:
              case ConnectionState.waiting:
                return
                  Container(
                    color:  Color(0xff0f1b1b),
                    child: Center(              
                      child: Text('Comandas',                  
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.white,
                          fontSize: 30
                        ),                  
                      ),
                    ),
                  );
                break;
              default:
               bool logado =  model.logado();
               if(logado == true){
                 return ContaAtiva();
               }else{
                 return Login();
               }
                 
            }
          }
        );
     }
   );
  }
}

class ContaAtiva extends StatefulWidget {
  @override
  _ContaAtivaState createState() => _ContaAtivaState();
}

class _ContaAtivaState extends State<ContaAtiva> {
  @override
  Widget build(BuildContext context) {
   return ScopedModelDescendant<UsuarioModel>(
     builder: (context, child, model){
       return StreamBuilder(
          stream: FirebaseFirestore.instance.collection('restaurantes').doc(model.uid).snapshots(),
          builder: (context, snapshot){
            switch(snapshot.connectionState){
              case ConnectionState.none:
              case ConnectionState.waiting:
                return
                  Container(
                    color:  Color(0xff0f1b1b),
                    child: Center(              
                      child: Text('Comandas',                  
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.white,
                          fontSize: 30
                        ),                  
                      ),
                    ),
                  );
                break;
              default:
               String conta = snapshot.data['conta'];
               if(conta == 'ativa'){
                 return Administrativo();
               }else{
                 return ContaBloqueada();
               }
                 
            }
          }
        );
     }
   );
  }
}
