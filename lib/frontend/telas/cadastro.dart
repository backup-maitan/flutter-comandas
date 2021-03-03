import 'package:comandas/backend/scopedModel/usuarioModel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {

  final email  = TextEditingController();
  final nome  = TextEditingController();
  final senha  = TextEditingController();
  String erro = 'erro ao tentar cadastrar';
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
                    keyboardType: TextInputType.emailAddress,
                    controller: nome,               
                    decoration: InputDecoration(                   
                      labelText: 'nome'
                    ),
                    validator: (value){
                      if(value.isEmpty){
                        return 'insira o nome do restaurante';
                      }
                    },
                  ),
                  TextFormField(
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
                    child: Text('cadastrar',
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                    onPressed: (){
                      if(globalKey.currentState.validate())
                        model.cadastrarUsuario(email: email.text, senha: senha.text, context: context, nome: nome.text);
                    }
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
                  model.erroCadastro ?
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