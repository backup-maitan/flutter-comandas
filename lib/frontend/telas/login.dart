import 'package:comandas/backend/scopedModel/usuarioModel.dart';
import 'package:comandas/frontend/telas/cadastro.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {


  final email  = TextEditingController();
  final senha  = TextEditingController();
  String erro = 'erro ao tentar entrar';
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UsuarioModel>(
      builder: (context, child, model){
        return Scaffold(
        body: Form(
          key: globalKey,
           child: Container(
            margin: EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    autofocus: false,
                    keyboardType: TextInputType.emailAddress,
                    controller: email,               
                    decoration: InputDecoration(                   
                      labelText: 'email'
                    ),
                     validator: (value){
                      if(value.isEmpty || !value.contains('@')){
                        return 'insira um email valido';
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: senha,
                    decoration: InputDecoration(
                      labelText: 'senha'
                    ),
                     validator: (value){
                      if(value.isEmpty || value.length < 6){
                        return 'insira a senha com o minino de 6 digitos';
                      }
                    },
                  ),
                  RaisedButton(
                    child: Text('entrar',
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                    onPressed: (){
                      if(globalKey.currentState.validate())
                         model.loginUsuario(email: email.text, senha: senha.text, context: context);
                      }
                    ),
                  SizedBox(
                    height: 12,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Cadastro() ));
                    },
                    child: Text('Criar conta'),
                  ),
                  model.estaCarregando ?
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator()
                          ],
                        ),
                      ],
                    ) : Container(),
                  model.erroLogin ?
                    Column(
                      children: [
                         SizedBox(
                          height: 8.0,
                        ),
                        Text(erro,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.red
                          ),
                        ),
                      ],
                    )
                  : Container()  
                ],
              ),
            ),
          ),
        ),
      );
      }
    );
  }
}